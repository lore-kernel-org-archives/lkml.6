Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDDOq5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:46:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48374 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDDOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:46:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alban Crequy <alban.crequy@gmail.com>
Cc: Alban Crequy <alban@kinvolk.io>, Dongsu Park <dongsu@kinvolk.io>,
        Iago Lopez Galeiras <iago@kinvolk.io>,
        Stephen J Day <stephen.day@docker.com>,
        Michael Crosby <crosbymichael@gmail.com>,
        Jess Frazelle <acidburn@microsoft.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Daniel J Walsh <dwalsh@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, containers@lists.linux-foundation.org
References: <20180404115311.725-1-alban@kinvolk.io>
Date: Wed, 04 Apr 2018 09:45:43 -0500
In-Reply-To: <20180404115311.725-1-alban@kinvolk.io> (Alban Crequy's message
        of "Wed, 4 Apr 2018 13:53:11 +0200")
Message-ID: <87tvsrjai0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3jgZ-0000v5-FX;;;mid=<87tvsrjai0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Sc/hgLAaw7gzA8cG8aXFJ47TLRXVX3DA=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alban Crequy <alban.crequy@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 788 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 4.2 (0.5%), b_tie_ro: 2.7 (0.3%), parse: 4.3 (0.5%),
        extract_message_metadata: 8 (1.0%), get_uri_detail_list: 4.2 (0.5%),
        tests_pri_-1000: 7 (0.9%), tests_pri_-950: 1.80 (0.2%), tests_pri_-900: 1.43
        (0.2%), tests_pri_-400: 36 (4.6%), check_bayes: 34 (4.4%), b_tokenize: 14
        (1.8%), b_tok_get_all: 10 (1.2%), b_comp_prob: 3.7 (0.5%), b_tok_touch_all:
        3.9 (0.5%), b_finish: 0.78 (0.1%), tests_pri_0: 706 (89.6%),
        check_dkim_signature: 0.68 (0.1%), check_dkim_adsp: 6 (0.8%), tests_pri_500:
        4.8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc mounts when not fully visible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alban Crequy <alban.crequy@gmail.com> writes:

> Since Linux v4.2 with commit 1b852bceb0d1 ("mnt: Refactor the logic for
> mounting sysfs and proc in a user namespace"), new mounts of proc or
> sysfs in non init userns are only allowed when there is at least one
> fully-visible proc or sysfs mount.
>
> This is to enforce that proc/sysfs files masked by a mount are still
> masked in a new mount in a unprivileged userns. The locked mount logic
> for bind mounts (has_locked_children()) was not enough in the case of
> proc/sysfs new mounts because some files in proc (/proc/kcore) exist as
> a singleton rather than being owned by a specific proc mount.
>
> Unfortunately, this blocks me from using userns from within a Docker
> container because Docker containers mask entries such as /proc/kcore. My
> use case is to build container images with arbitrary commands (such as
> using "RUN" commands in Dockerfiles) without privileges and from within
> a Docker container. Those arbitrary commands could be shell scripts that
> require /proc.

This is an understandable problem.  /proc/kcore is a file that policy
has a very reasonable right to make inaccessible.  Allowing unprivileged
users to bypass the policy setup by root is not ok, and is the whole
point of the restrictions.


I need to hear why you can't fix Docker.  Why your subcommand needs to
mount proc in the first place.  Neither have been mentioned.  So far
this looks like ``my sysadmin told me no, can I have a kernel patch to
get around that''.  Not something I support at all.



Before we get a kernel change for something like this there need to be
clear evidence this raises to the point of something that is really
going to be used and will have multiple users, and the proposal will
be simple and maintainble.

Hiding files in /proc simply because they were mounted over in the
parent proc does not qualify as simple or maintainble by any means.
Way too much mixing of the layers.  Needing to read from the parent
proc to find which files were already hidden makes this doubly complex.

Files like /proc/kcore can not be hidden always and automatically
because their attributes can change so they may reasonably be made
available to users who are not the global root.

The only option I have seen proposed that might qualify as something
general purpose and simple is a new filesystem that is just the process
directories of proc.  As there would in essence be no files that would
need restrictions it would be safe to allow anyone to mount without
restriction.

> The following commands show my problem:
>
> $ sudo docker run -ti --rm --cap-add=SYS_ADMIN busybox sh -c 'unshare -U -r -p -m -f mount -t proc proc /home && echo ok'
> mount: permission denied (are you root?)
>
> $ sudo docker run -ti --rm --cap-add=SYS_ADMIN busybox sh -c 'mkdir -p /unmasked-proc && mount -t proc proc /unmasked-proc && unshare -U -r -p -m -f mount -t proc proc /home && echo ok'
> ok

Actually this does not show your problem because it does not reveal why
you need to mount proc.

That is a ``Doctor it hurts when I do this'' example where the Doctor
will reasonably tell you ``Don't do that then''.


> For my use case, I will need to support at least the following entries:
>
> $ sudo docker run -ti --rm busybox sh -c 'mount|grep /proc/'
> proc on /proc/asound type proc (ro,nosuid,nodev,noexec,relatime)
> proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
> proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
> proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
> proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
> proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
> tmpfs on /proc/kcore type tmpfs (rw,context="...",nosuid,mode=755)
> tmpfs on /proc/latency_stats type tmpfs (rw,context="...",nosuid,mode=755)
> tmpfs on /proc/timer_list type tmpfs (rw,context="...",nosuid,mode=755)
> tmpfs on /proc/sched_debug type tmpfs (rw,context="...",nosuid,mode=755)
> tmpfs on /proc/scsi type tmpfs (ro,seclabel,relatime)

It looks like a cruft free cousin of proc that is just processes would
be applicable to your usecase.

Eric
