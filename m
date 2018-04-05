Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDEOTr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:19:47 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:25782 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeDEOTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:19:45 -0400
Date: Thu, 5 Apr 2018 16:19:26 +0200
From: Christian Brauner <christian.brauner@getenv.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alban Crequy <alban.crequy@gmail.com>,
        Iago Lopez Galeiras <iago@kinvolk.io>,
        containers@lists.linux-foundation.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org, Michael Crosby <crosbymichael@gmail.com>,
        Stephen J Day <stephen.day@docker.com>,
        Alban Crequy <alban@kinvolk.io>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jess Frazelle <acidburn@microsoft.com>
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180405141926.GA15202@mailbox.org>
References: <20180404115311.725-1-alban@kinvolk.io>
 <87tvsrjai0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvsrjai0.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:45:43AM -0500, Eric W. Biederman wrote:
> Alban Crequy <alban.crequy@gmail.com> writes:
> 
> > Since Linux v4.2 with commit 1b852bceb0d1 ("mnt: Refactor the logic for
> > mounting sysfs and proc in a user namespace"), new mounts of proc or
> > sysfs in non init userns are only allowed when there is at least one
> > fully-visible proc or sysfs mount.
> >
> > This is to enforce that proc/sysfs files masked by a mount are still
> > masked in a new mount in a unprivileged userns. The locked mount logic
> > for bind mounts (has_locked_children()) was not enough in the case of
> > proc/sysfs new mounts because some files in proc (/proc/kcore) exist as
> > a singleton rather than being owned by a specific proc mount.
> >
> > Unfortunately, this blocks me from using userns from within a Docker
> > container because Docker containers mask entries such as /proc/kcore. My

I honestly wonder what the benefit of this is supposed to be. If the
container retains CAP_SYS_ADMIN (privileged or unprivileged) these
mounts can all be unmounted. If the container drops CAP_SYS_ADMIN
you won't be able to {u}mount anymore but you also won't be able to use
any CLONE_* flags anymore. So clone(), setns(), unshare() are useless
too. If you're unprivileged overmounting e.g. /proc/kcore won't give
you any additional security benefits since you can't read it anyway. So
this only seems useful when the container is privileged and some form of
LSM is protecting those mount points. But for these cases the only thing
I have to say is: it's 2018 that is 5 years past CLONE_NEWUSER so don't
run privileged containers and pretend that it can be done securely in
any way.
But I might be missing cases where this would be really really useful
involving unprivileged containers too.
This is really not directed at you Ablan, I'm just wondering about this
in general and I seem to have a polemic day. :)

Christian

> > use case is to build container images with arbitrary commands (such as
> > using "RUN" commands in Dockerfiles) without privileges and from within
> > a Docker container. Those arbitrary commands could be shell scripts that
> > require /proc.
> 
> This is an understandable problem.  /proc/kcore is a file that policy
> has a very reasonable right to make inaccessible.  Allowing unprivileged
> users to bypass the policy setup by root is not ok, and is the whole
> point of the restrictions.
> 
> 
> I need to hear why you can't fix Docker.  Why your subcommand needs to
> mount proc in the first place.  Neither have been mentioned.  So far
> this looks like ``my sysadmin told me no, can I have a kernel patch to
> get around that''.  Not something I support at all.
> 
> 
> 
> Before we get a kernel change for something like this there need to be
> clear evidence this raises to the point of something that is really
> going to be used and will have multiple users, and the proposal will
> be simple and maintainble.
> 
> Hiding files in /proc simply because they were mounted over in the
> parent proc does not qualify as simple or maintainble by any means.
> Way too much mixing of the layers.  Needing to read from the parent
> proc to find which files were already hidden makes this doubly complex.
> 
> Files like /proc/kcore can not be hidden always and automatically
> because their attributes can change so they may reasonably be made
> available to users who are not the global root.
> 
> The only option I have seen proposed that might qualify as something
> general purpose and simple is a new filesystem that is just the process
> directories of proc.  As there would in essence be no files that would
> need restrictions it would be safe to allow anyone to mount without
> restriction.
> 
> > The following commands show my problem:
> >
> > $ sudo docker run -ti --rm --cap-add=SYS_ADMIN busybox sh -c 'unshare -U -r -p -m -f mount -t proc proc /home && echo ok'
> > mount: permission denied (are you root?)
> >
> > $ sudo docker run -ti --rm --cap-add=SYS_ADMIN busybox sh -c 'mkdir -p /unmasked-proc && mount -t proc proc /unmasked-proc && unshare -U -r -p -m -f mount -t proc proc /home && echo ok'
> > ok
> 
> Actually this does not show your problem because it does not reveal why
> you need to mount proc.
> 
> That is a ``Doctor it hurts when I do this'' example where the Doctor
> will reasonably tell you ``Don't do that then''.
> 
> 
> > For my use case, I will need to support at least the following entries:
> >
> > $ sudo docker run -ti --rm busybox sh -c 'mount|grep /proc/'
> > proc on /proc/asound type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
> > proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
> > tmpfs on /proc/kcore type tmpfs (rw,context="...",nosuid,mode=755)
> > tmpfs on /proc/latency_stats type tmpfs (rw,context="...",nosuid,mode=755)
> > tmpfs on /proc/timer_list type tmpfs (rw,context="...",nosuid,mode=755)
> > tmpfs on /proc/sched_debug type tmpfs (rw,context="...",nosuid,mode=755)
> > tmpfs on /proc/scsi type tmpfs (ro,seclabel,relatime)
> 
> It looks like a cruft free cousin of proc that is just processes would
> be applicable to your usecase.
> 
> Eric
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
