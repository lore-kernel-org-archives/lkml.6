Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13195C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC738208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC738208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeFLO7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:59:48 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44697 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeFLO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:59:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSkls-0006ie-MO; Tue, 12 Jun 2018 08:59:44 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSklr-0004dL-Nz; Tue, 12 Jun 2018 08:59:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Djalal Harouni <tixxdz@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
References: <20180611195744.154962-1-astrachan@google.com>
        <87bmcgpzno.fsf@xmission.com>
        <CANDihLFmc21Ox_pe9S+oimiZcHB-hQLkv4avF7nReu+QjjL2Zg@mail.gmail.com>
Date:   Tue, 12 Jun 2018 09:59:36 -0500
In-Reply-To: <CANDihLFmc21Ox_pe9S+oimiZcHB-hQLkv4avF7nReu+QjjL2Zg@mail.gmail.com>
        (Alistair Strachan's message of "Mon, 11 Jun 2018 23:12:35 -0700")
Message-ID: <87fu1svynb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fSklr-0004dL-Nz;;;mid=<87fu1svynb.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jI0VjCmJAzfBHz3/gHhXPxvYwEDUA4Is=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Fix parsing of mount parameters.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan <astrachan@google.com> writes:

> On Mon, Jun 11, 2018 at 6:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Alistair Strachan <astrachan@google.com> writes:
>>
>> > In commit e94591d0d90c "proc: Convert proc_mount to use mount_ns"
>> > the parsing of mount parameters for the proc filesystem was broken.
>> >
>> > The SB_KERNMOUNT for procfs happens via:
>> >
>> >   start_kernel()
>> >     rest_init()
>> >       kernel_thread()
>> >         _do_fork()
>> >            copy_process()
>> >              alloc_pid()
>> >                pid_ns_prepare_proc()
>> >                  kern_mount_data()
>> >                    proc_mount()
>> >                      mount_ns()
>> >
>> > In mount_ns(), the kernel calls proc_fill_super() only if the superblock
>> > has not previously been set up (i.e. the first mount reference),
>> > regardless of SB_KERNMOUNT. Because the call to proc_parse_options() had
>> > been moved inside here, and the SB_KERNMOUNT uses no mount options, the
>> > option parser became a no-op.
>> >
>> > When userspace later mounted procfs with e.g. hidepid=2, the options
>> > would be ignored.
>> >
>> > This change backs out a part of the original cleanup and parses the
>> > procfs mount options at every mount call. Because the options currently
>> > only update the pid_ns for the mount, they are applied for all mounts of
>> > proc by that pid or childen of that pid, instantaneously. This is the
>> > same behavior as the original code.
>>
>> Two years for a regression to be reported is a litte long.  I think that
>> gets out of the kneejerk immediate fix or revert phase and into thinking
>> a little bout about what makes sense in this code.
>
> Android has been using hidepid=2 for a while, but most shipping
> products were on 3.18 or 4.4 kernels. To us, it's a new problem.

All that says is that no one from Android has looked at or tested a
kernel (not even a stable one) since 4.4.  That does not work for
justifying changes/fixes to the kernel.  People working together does
not work to well when some of the people don't show up.

As an engineer I sympathize with your position.   Whoever made the
decision that Android won't care for anything except for the best
effort long term stable kernels has made your job a challenge.  I do
appreciate that Android at least periodically updates their kernels.

The bottom line though is that if this had been caught within the
release or so of it's breaking restoring the old userspace behavior
would not have been a question.  Now after two years there is the
question of if other people have come to depend on the new behavior.

>> As we say with devpts there is a very real danger of someone mounting
>> a second instance of proc in a chroot and causing problems by either
>> strengthening or weakening the hid pid protections for the entire pid
>> namespace.  If we go with your proposed change in behavior.
>
> I guess my change does change the behavior, but it's just back to the
> behavior which the kernel had for a good while (~v3.3 thru v4.7).
>
>> Ordinary block device filesystems (like ext4) avoid this problem by
>> allowing a second mount and by not parsing the mount options except
>> on remount.  What proc currently does.
>
> IMHO, they're not really comparable. You'll only get kernmounts of an
> ext4 filesystem when finding rootfs, and in that case the user knows
> about the mount and can see it in /proc/mounts, so they know to use -o
> remount,<whatever>.
>
> Since the first mount (where the options might have been respected) is
> *always* the kernmount done before init, with your change these mount
> options for procfs will never be respected. As userspace didn't yet
> mount /proc, it can't know /proc was already mounted, in order to know
> to use a remount to re-parse the options. The behavior was changed in
> a non-obvious way.

Please not it is fundamentally required if the in kernel superblocks are
going to be shared.  

>> So I think it can be reasonably argued that the change in behavior is
>> was an unintentional fix.
>>
>> I can see an argument for failing the mount of proc if mount options
>> are specified or if those mount options differ from the existing mount
>> options.
>>
>> proc_remount's call of proc_parse_options is definitely buggy as it can
>> partially succeed and change the pid namespace and return an error code.
>> That is bad error handling.
>>
>> There may be an argument for making these options available in something
>> other than a mount of proc.  As they are pid namespace wide.
>>
>> There may be an argument for multiple instances of proc so that it makes
>> sense to process these options during an ordinary mount.
>>
>>
>> Ultimately what I see is that this is a difficult area of semantics that
>> there is at least a little room for improvement on, but it is not
>> as simple as this proposed change.
>
> An alternative fix might be to ignore the super setup if done from a
> kernmount of procfs. IMO, this initial mount shouldn't be considered
> the first reference, because it will not pass the mount options and
> cannot be observed by userspace. Such a change looks complicated,
> though, and it would only be relevant to procfs. It might be better to
> roll back the cleanup and implement these semantics directly in the
> procfs code.

That would be straight forward if we could get rid of proc_mnt.  Then
there would not need to be an internal kernel mount.  Which would get us
there and that would probably be a nice cleanup.

We can hand wave away the uml mconsole and sysctl syscall uses of
proc_mnt.  The tricky case is proc_flush_task.  That requires someone
having a reference to the proc super block and it noticably keeps the
amount of memory consumed by the proc filesystem down.  Enough so that
people notice when it is not performing well.

I have heard of people running Android in a chroot on chrome books, and
I have heard of people running normal linux chroots on Android phones.
So chroots and people mounting proc for a second time are definitely
things to worry about in the real world.  So I strongly suspect the old
behavior is quite risky in those real world situations.

At this moment I really hate mount options to proc.  They are quite
difficult to make work well and in a non-surprising way.

Eric
