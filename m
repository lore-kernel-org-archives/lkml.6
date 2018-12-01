Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01137C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38020867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA38020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLBBIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:08:39 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47025 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:08:39 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gT5kZ-0003x7-54; Sat, 01 Dec 2018 06:56:03 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gT5kX-00083H-6x; Sat, 01 Dec 2018 06:56:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Radoslaw Burny <rburny@google.com>
Cc:     mcgrof@kernel.org, seth.forshee@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
References: <20181126172607.125782-1-rburny@google.com>
        <20181127011627.GI4922@garbanzo.do-not-panic.com>
        <87k1kzjdff.fsf@xmission.com>
        <CAFkxGoM_rjciQ0sRh7Lhf_XfJu-g4Tth6Yo0L_YRVUaOnzjZuA@mail.gmail.com>
Date:   Sat, 01 Dec 2018 07:55:56 -0600
In-Reply-To: <CAFkxGoM_rjciQ0sRh7Lhf_XfJu-g4Tth6Yo0L_YRVUaOnzjZuA@mail.gmail.com>
        (Radoslaw Burny's message of "Thu, 29 Nov 2018 13:39:02 +0100")
Message-ID: <87y399z6z7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gT5kX-00083H-6x;;;mid=<87y399z6z7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+XxUdIZcVGee5Ka6863rkWzRBg7VCGBns=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw Burny <rburny@google.com> writes:

> On Tue, Nov 27, 2018 at 6:29 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>  Luis Chamberlain <mcgrof@kernel.org> writes:
>
>  > On Mon, Nov 26, 2018 at 06:26:07PM +0100, Radoslaw Burny wrote:
>  >> Due to a recent commit (d151ddc00498 - fs: Update i_[ug]id_(read|write)
>  >> to translate relative to s_user_ns),
>  >
>  > Recent? This is commit is from 2014 and present upstream since v4.8.
>  > And the commit ID you mentioned in your commit log seems to be
>  > incorrect. I get:
>  >
>  > 81754357770ebd900801231e7bc8d151ddc00498a fs: Update i_[ug]id_(read|write) to translate relative to s_user_ns
>  >
>  >> inodes under /proc/sys have -1
>  >> written to their i_uid/i_gid members if a containing userns does not
>  >> have entries for root in the uid/gid_map.
>  >
>  > Thanks for the description of how to run into the issue described but
>  > is there also a practical use case today where this is happening? I ask
>  > as it would be good to know the severity of the issue in the real world
>  > today.
>
>  People trying to run containers without a root user in the container.
>  It atypical but something doable. 
>
>  >> This wouldn't normally matter, because these values are not used for
>  >> access checks. However, a later change (0bd23d09b874 - Don't modify
>  >> inodes with a uid or gid unknown to the vfs) changes the kernel to
>  >> prevent opens for write if the i_uid/i_gid field in the inode is -1,
>  >> even if the /proc/sys-specific access checks would otherwise pass.
>  >> 
>  >> This causes a problem: in a userns without root mapping, even the
>  >> namespace creator cannot write to e.g. /proc/sys/kernel/shmmax.
>  >> This change fixes the problem by overriding i_uid/i_gid back to
>  >> GLOBAL_ROOT_UID/GID.
>  >
>  > We really need Seth and Eric to provide guidance here as they were
>  > the ones devising this long ago, but to me your solution seems backward.
>  > Why allow any namespace to muck with /proc/sys/ seettings?
>
>  There are many per namespace sysctls. Most of them are in the
>  networking stack.
>
>  > Let's recall that this case was a corner case, and writeback was the
>  > biggest concern, and for that it was decided that you'd simply not get
>  > write access, and so its read only. Its not clear to me if things like
>  > proc were considered. For the regular file case the situation can be
>  > addressed with chown, however we can't chown proc files.
>  >
>  >> Tested: Used a repro program that creates a user namespace without any
>  >> mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
>  >> Before the change, it shows uid/gid of 65534,
>  >
>  > I thought you said it would be uid/gid -1 without your patch?
>
>  It is INVALID_UID/INVALID_GID. It is an over simplifcation to call
>  them -1. As they are not a valid value and are never mapped in any
>  user namespace they are displayed as the overflow_uid or overflow_gid
>  which is 65534 by default.
>
>  >> with the change it's 0.
>  >
>  > Note that a good way to also test issues is with the lib/test_sysctl.c
>  > module and the tools/testing/selftests/sysctl/sysctl.sh script, so if
>  > you can device a test there, once we decide what to do that would be
>  > appreciated.
>
>  We spoke about this at LPC. And this is the correct behavioral change.
>
>  The problem is there is a default value for i_uid and i_gid that is
>  correct in the general case. That default value is not corect for
>  sysctl, because proc is weird. As the sysctl permission check in
>  test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
>  notice that i_uid and i_gid were being set wrong.
>
>  So all this patch does is fix the default values i_uid and i_gid.
>
>  The commit comment seems worth cleaning up. But for the
>  content of the code.
>
>  I expect when I have a few moments I will pick this change up.
>
>  Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>  Eric
>
> Thanks, Eric. Should I send a v2 patch with an updated description,
> or can you just modify the description when applying this one?

I am absolutely swampped and moving at the moment.  Can you please
send a v2 with an updated description.

Thank you,
Eric

>
>  >> Signed-off-by: Radoslaw Burny <rburny@google.com>
>  >> ---
>  >> fs/proc/proc_sysctl.c | 4 ++++
>  >> 1 file changed, 4 insertions(+)
>  >> 
>  >> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>  >> index c5cbbdff3c3d..67379a389658 100644
>  >> --- a/fs/proc/proc_sysctl.c
>  >> +++ b/fs/proc/proc_sysctl.c
>  >> @@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  >> 
>  >> if (root->set_ownership)
>  >> root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
>  >> + else {
>  >> + inode->i_uid = GLOBAL_ROOT_UID;
>  >> + inode->i_gid = GLOBAL_ROOT_GID;
>  >> + }
>  >> 
>  >> out:
>  >> return inode;
>  >> -- 
>  >> 2.20.0.rc0.387.gc7a69e6b6c-goog
>  >> 
