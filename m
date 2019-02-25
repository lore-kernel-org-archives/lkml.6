Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B55F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WE6eaS8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfBYIdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:33:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40784 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBYIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:33:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so6798166eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D40CQclCO4hMWO9fHOD6vg/10PhR54Lowd84clzMlx8=;
        b=WE6eaS8qfEbQqKwLVotlE0IK2x2IfuCszuqxcz4SJPSveucdwQTIgTaiH8kARKim0M
         YTFq18gbpJD6ivxXewYABswUeCHMgL9RzY7/PDjVB9I3e55jgdEG3XjE6du7ukw0vwvJ
         muk7q5qhv8qZWLlZ2JD8gl73IJMJix5y8oMgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=D40CQclCO4hMWO9fHOD6vg/10PhR54Lowd84clzMlx8=;
        b=X4XG15ZaPfg/MMG/Wm4qHA7O6U5b7pjQ+zruduwIr07wPMnW9p213UjTP31DdyqVFa
         wBHN/Xx+fZUPTlSk3x1IbZI33cL/Evy+H2+bviWqE7WFIAYI2F9Um2g+ftCyPExiRe/L
         RLFPM9aXQlaL0OUxPXFPsgKEh/8KVMAQ47WIDFghMI8+3scL2OJ2fP3lSO8DCyeK27AU
         W44M4JtWM3sbUkRQXHM3AhLJ1JfH3a9j0TrSGCq0bCuZcPrsO/MSWlm8i8ZBKonwbVL6
         Ts1NKqJ3vCVCIuStTh9f/qSa/UjjnSFMou5500uaoSZQmjQOG9M+Bbd9eqLVYZDLGLC6
         NfyQ==
X-Gm-Message-State: AHQUAuZw/pfZwiK8V4PGyjQP4yro3Bp3VJWGeRJIxHNqPsFrrZ5AzMfG
        C/XGaFb2OeDhavs4YpKpvNJZdQ==
X-Google-Smtp-Source: AHgI3IbhbMjYR9/8uBzLF6GmN5pRbqPpt5FGbRqStH75elRbDeQiFr2IhLea5RC1I6oygjn8JAdDUw==
X-Received: by 2002:a50:ae8d:: with SMTP id e13mr13678417edd.124.1551083594826;
        Mon, 25 Feb 2019 00:33:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k8sm2501728ede.65.2019.02.25.00.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 00:33:13 -0800 (PST)
Date:   Mon, 25 Feb 2019 09:33:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Rientjes <rientjes@google.com>
Cc:     syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        mahesh1.kumar@intel.com, rodrigo.vivi@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: trying to register non-static key in __flush_work
Message-ID: <20190225083311.GG2665@phenom.ffwll.local>
Mail-Followup-To: David Rientjes <rientjes@google.com>,
        syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        mahesh1.kumar@intel.com, rodrigo.vivi@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000f4fe3e057e25b276@google.com>
 <alpine.DEB.2.21.1902241238190.190029@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902241238190.190029@chino.kir.corp.google.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 12:40:19PM -0800, David Rientjes wrote:
> On Sat, 29 Dec 2018, syzbot wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    5694cecdb092 Merge tag 'arm64-upstream' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=124eebc7400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> > dashboard link: https://syzkaller.appspot.com/bug?extid=12f1b031b6da017e34f8
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1174a1dd400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1336e38b400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com
> > 
> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
> > turning off the locking correctness validator.
> > CPU: 0 PID: 8039 Comm: syz-executor964 Not tainted 4.20.0+ #389
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> > 01/01/2011
> > Call Trace:
> > __dump_stack lib/dump_stack.c:77 [inline]
> > dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
> > assign_lock_key kernel/locking/lockdep.c:727 [inline]
> > register_lock_class+0x21c5/0x29d0 kernel/locking/lockdep.c:753
> > __lock_acquire+0x184/0x4c20 kernel/locking/lockdep.c:3227
> > lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> > __flush_work+0x752/0x9b0 kernel/workqueue.c:2912
> > flush_work+0x17/0x20 kernel/workqueue.c:2938
> > vkms_atomic_crtc_destroy_state+0x2b/0x40 drivers/gpu/drm/vkms/vkms_crtc.c:139
> > drm_atomic_state_default_clear+0x37c/0xda0 drivers/gpu/drm/drm_atomic.c:171
> > drm_atomic_state_clear+0x9f/0xd0 drivers/gpu/drm/drm_atomic.c:240
> > __drm_atomic_state_free+0x3a/0xf0 drivers/gpu/drm/drm_atomic.c:256
> > kref_put include/linux/kref.h:70 [inline]
> > drm_atomic_state_put include/drm/drm_atomic.h:385 [inline]
> > drm_atomic_helper_set_config+0xe6/0x160
> > drivers/gpu/drm/drm_atomic_helper.c:2947
> > drm_mode_setcrtc+0x767/0x1890 drivers/gpu/drm/drm_crtc.c:748
> > drm_ioctl_kernel+0x278/0x330 drivers/gpu/drm/drm_ioctl.c:758
> > drm_ioctl+0x58f/0xb90 drivers/gpu/drm/drm_ioctl.c:858
> > vfs_ioctl fs/ioctl.c:46 [inline]
> > file_ioctl fs/ioctl.c:509 [inline]
> > do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> > ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> > __do_sys_ioctl fs/ioctl.c:720 [inline]
> > __se_sys_ioctl fs/ioctl.c:718 [inline]
> > __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> > do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x443e59
> > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48
> > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f
> > 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fff2bc037c8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443e59
> > RDX: 0000000020000100 RSI: 00000000c06864a2 RDI: 0000000000000003
> > RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> > R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401b60
> > R13: 0000000000401bf0 R14: 0000000000000000 R15: 000000000
> > 
> 
> This is reproducible up to at least
> 
> commit e60b5f79bd7529e76b13cf1e85823abbd0e33634
> Merge: 6089a91fc02e 8f5b27347e88
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Feb 23 11:13:50 2019 -0800
> 
>     Merge tag 'powerpc-5.0-6' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> 
> and my theory is that it's due to this:
> 
> commit dfb9f5cabfe31b8e936b725b5de8f787f7c18b0f
> Author: Haneen Mohammed <hamohammed.sa@gmail.com>
> Date:   Tue Jul 24 19:31:05 2018 +0300
> 
>     drm/vkms: subclass CRTC state
>     
> in 4.20-rc1.  We aren't doing INIT_WORK() for the workqueue that is being 
> flushed.
> 
> Don't we need to do INIT_WORK() in vkms_atomic_crtc_reset() too?

Patch is in linux-next:

commit b30b61ff6b1dc37f276cf56a8328b80086a3ffca
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sat Jan 19 01:43:43 2019 +0900

    drm/vkms: Fix flush_work() without INIT_WORK()

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
