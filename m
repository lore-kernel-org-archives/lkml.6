Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHWKliAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIKWrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:47:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39411 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeIKWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:47:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so12589796pff.6;
        Tue, 11 Sep 2018 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKEc8uJK5WF/0VA+qn3WVF3E069tZioOWLCMOSK8/c0=;
        b=qHWKliASWv5ynkBAD7965oVYgzly6NlUSJdTKsPgYXP89ps16s+BKytXMNoK2/Yx6v
         s5FAB4c5hDwqRctYyvG/ag8hS1RRSGogcscBuwqRYhJ4AYx12+g7ANK/i6bW2avAQCT2
         tHDVxe3zvlVc31fkrs0cAR9zPeNFJMmj+cDME4Z5kma4ypEz6QDTt7Vzr75fj0SmtqfF
         +aStCxrod5Kh2PE8h/WBvvESkutkK1Og2aIb2UjRDlvvxZewES4HfvubJjCmdfiKNgzg
         IWef5cTgGXVfhhLlzFvb6bGz385uS25JH2fklzUW82X9F25eXcCls+I8WyUqoU9OjMtn
         vYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKEc8uJK5WF/0VA+qn3WVF3E069tZioOWLCMOSK8/c0=;
        b=ENoJ4BTHVhbkUij71LE7vZJb6YdVh0/AIcxEg4ehVXRy8B34937E0ms34GFzzpu8i1
         xLsVi6poROVYCqLdNWSN8M2CMtbIW1suSWoHsCgmrdpNWDG4O8iwQ5zjU8fPTQNQsySK
         lfOyPA/pSe5Vyu+UWbX2s2Wbq7qjs8sABRbUBdSugX45R8SKSeMDFMXeM/vOVVZH2+m9
         RXNoF2NdW1Psj/Z8EoaQX4rl0r0MjKU3fnpampAtHeVbvTZjywX3l2wo8EOFN5alNvW5
         atINGkoUtVk0H61au5H2qalsXcFTSeqVqYtofTUxGnOKidRyh9CJCxoZvT/bgvLA7Zk7
         laLw==
X-Gm-Message-State: APzg51D5C/Z455fKZj3YEmlmnCejeROO72IUn5uTYxJ8DBo0Ga29Nthz
        gIAhuExxk7Ge2knEvwXdE9w=
X-Google-Smtp-Source: ANB0VdbyekWf/KFeqzlfp9+SQ8oWYWey9oG8OZX61hlI3DxIQj8Jn/e03g6mdY5/OxoiA9t/mZPQmQ==
X-Received: by 2002:a63:f501:: with SMTP id w1-v6mr29601379pgh.446.1536688003316;
        Tue, 11 Sep 2018 10:46:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g6-v6sm28806719pfb.11.2018.09.11.10.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:46:42 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:46:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180911174641.GA15149@roeck-us.net>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 04:25:41PM +0100, David Howells wrote:
> Implement a filesystem context concept to be used during superblock
> creation for mount and superblock reconfiguration for remount.
> 
> The mounting procedure then becomes:
> 
>  (1) Allocate new fs_context context.
> 
>  (2) Configure the context.
> 
>  (3) Create superblock.
> 
>  (4) Query the superblock.
> 
>  (5) Create a mount for the superblock.
> 
>  (6) Destroy the context.
> 
> Rather than calling fs_type->mount(), an fs_context struct is created and
> fs_type->init_fs_context() is called to set it up.  Pointers exist for the
> filesystem and LSM to hang their private data off.
> 
> A set of operations has to be set by ->init_fs_context() to provide
> freeing, duplication, option parsing, binary data parsing, validation,
> mounting and superblock filling.
> 
> Legacy filesystems are supported by the provision of a set of legacy
> fs_context operations that build up a list of mount options and then invoke
> fs_type->mount() from within the fs_context ->get_tree() operation.  This
> allows all filesystems to be accessed using fs_context.
> 
> It should be noted that, whilst this patch adds a lot of lines of code,
> there is quite a bit of duplication with existing code that can be
> eliminated should all filesystems be converted over.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I don't find a more recent version of this patch in patchwork on kernel.org,
so I am replying to this one. My apologies if there are more recent versions.

This patch is causing widespread crashes in next-20180910 and next-20180911.
Example and bisect log (for x86_64) attached.

Guenter

---
Rebooting.
[    4.894299] random: dd: uninitialized urandom read (512 bytes read)
[    5.055206] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[    5.055518] PGD 800000000c025067 P4D 800000000c025067 PUD c7a3067 PMD 0 
[    5.055941] Oops: 0000 [#1] SMP PTI
[    5.056191] CPU: 0 PID: 1208 Comm: umount Not tainted 4.19.0-rc3-next-20180911 #1
[    5.056367] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    5.057003] RIP: 0010:reconfigure_super+0x47/0x210
[    5.057214] Code: d4 01 00 00 44 8b a3 30 02 00 00 45 85 e4 0f 85 9d 01 00 00 a8 01 48 89 fd 75 4f 48 89 df 45 31 ed e8 ad 4f 01 00 48 8b 45 00 <48> 8b 40 30 48 85 c0 0f 84 d3 00 00 00 48 89 ef ff d0 85 c0 0f 84
[    5.057573] RSP: 0018:ffffa8560011bdd0 EFLAGS: 00000246
[    5.057709] RAX: 0000000000000000 RBX: ffffa2cd4c72c000 RCX: ffffa2cd4c72c0b8
[    5.057850] RDX: ffffa2cd4c72c048 RSI: 0000000000000000 RDI: ffffffff98b49e28
[    5.057991] RBP: ffffa8560011be00 R08: 000000000000019b R09: 0000000000000000
[    5.058132] R10: ffffa856000bfd08 R11: 0000000000000001 R12: 0000000000000000
[    5.058274] R13: 0000000000000001 R14: ffffa2cd4f38f920 R15: 0000000000000000
[    5.058451] FS:  00007fa2f1a15500(0000) GS:ffffa2cd4f600000(0000) knlGS:0000000000000000
[    5.059178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.059302] CR2: 0000000000000030 CR3: 000000000c7b4000 CR4: 00000000003406f0
[    5.059496] Call Trace:
[    5.060118]  do_umount_root+0x7b/0xb0
[    5.060244]  ksys_umount+0x250/0x3e0
[    5.060345]  ? vfs_write+0x13f/0x190
[    5.060439]  __x64_sys_umount+0xd/0x10
[    5.060537]  do_syscall_64+0x39/0xe0
[    5.060635]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.060874] RIP: 0033:0x7fa2f1534b47
[    5.060970] Code: 73 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 73 2b 00 f7 d8 64 89 01 48
[    5.061311] RSP: 002b:00007ffeb7926e68 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[    5.061478] RAX: ffffffffffffffda RBX: 0000000000d078e0 RCX: 00007fa2f1534b47
[    5.061612] RDX: 00007ffeb7927050 RSI: 0000000000000000 RDI: 0000000000d078e0
[    5.061744] RBP: 0000000000d07b40 R08: 0000000000d07920 R09: 00007fa2f15726c0
[    5.061875] R10: 000000000000089e R11: 0000000000000206 R12: 0000000000d078a0
[    5.062006] R13: 0000000000d07ba0 R14: 0000000000000000 R15: 00007ffeb7927050
[    5.062188] Modules linked in:
[    5.062375] CR2: 0000000000000030
[    5.062675] ---[ end trace c42a74534e5e2f3f ]---
[    5.062816] RIP: 0010:reconfigure_super+0x47/0x210
[    5.062924] Code: d4 01 00 00 44 8b a3 30 02 00 00 45 85 e4 0f 85 9d 01 00 00 a8 01 48 89 fd 75 4f 48 89 df 45 31 ed e8 ad 4f 01 00 48 8b 45 00 <48> 8b 40 30 48 85 c0 0f 84 d3 00 00 00 48 89 ef ff d0 85 c0 0f 84
[    5.063263] RSP: 0018:ffffa8560011bdd0 EFLAGS: 00000246
[    5.063372] RAX: 0000000000000000 RBX: ffffa2cd4c72c000 RCX: ffffa2cd4c72c0b8
[    5.063526] RDX: ffffa2cd4c72c048 RSI: 0000000000000000 RDI: ffffffff98b49e28
[    5.063665] RBP: ffffa8560011be00 R08: 000000000000019b R09: 0000000000000000
[    5.063797] R10: ffffa856000bfd08 R11: 0000000000000001 R12: 0000000000000000
[    5.063928] R13: 0000000000000001 R14: ffffa2cd4f38f920 R15: 0000000000000000
[    5.064060] FS:  00007fa2f1a15500(0000) GS:ffffa2cd4f600000(0000) knlGS:0000000000000000
[    5.064224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.064337] CR2: 0000000000000030 CR3: 000000000c7b4000 CR4: 00000000003406f0

---

# bad: [09c0888767529cdb382f34452819e42d1a66a114] Add linux-next specific files for 20180911
# good: [11da3a7f84f19c26da6f86af878298694ede0804] Linux 4.19-rc3
git bisect start 'HEAD' 'v4.19-rc3'
# bad: [a2ebc71cf97bed9b453318418e4a281434565e8b] Merge remote-tracking branch 'nfc-next/master'
git bisect bad a2ebc71cf97bed9b453318418e4a281434565e8b
# good: [6fde463b32bf4105c28c0a297a5b66aca5d6ecd4] Merge remote-tracking branch 's390/features'
git bisect good 6fde463b32bf4105c28c0a297a5b66aca5d6ecd4
# bad: [136fd6d530a3ae0dd003984f683345cfe88c01f3] Merge remote-tracking branch 'v4l-dvb/master'
git bisect bad 136fd6d530a3ae0dd003984f683345cfe88c01f3
# good: [c7ae95368af43c08f5f615b00f2f7bf2e9c45788] Merge remote-tracking branch 'v9fs/9p-next'
git bisect good c7ae95368af43c08f5f615b00f2f7bf2e9c45788
# good: [4c640c41381e47b328c6507bcf534812761256cd] Merge branch 'for-4.19/fixes' into for-next
git bisect good 4c640c41381e47b328c6507bcf534812761256cd
# bad: [5bc91f70c5ecc2bc5967b98ce7fa4e55ad230d99] Merge remote-tracking branch 'hid/for-next'
git bisect bad 5bc91f70c5ecc2bc5967b98ce7fa4e55ad230d99
# bad: [88abb54c46648cf25930133fbdeb145bf8537673] vfs: syscall: Add fsconfig() for configuring and managing a context
git bisect bad 88abb54c46648cf25930133fbdeb145bf8537673
# good: [b2bbd433151748c5268769f560c926343dece319] vfs: Separate changing mount flags full remount
git bisect good b2bbd433151748c5268769f560c926343dece319
# bad: [b348b6230aac28ffe555000831966d45529ab3b0] kernfs, sysfs, cgroup, intel_rdt: Support fs_context
git bisect bad b348b6230aac28ffe555000831966d45529ab3b0
# bad: [bf090f3c0282903ad55bca27a482180c70627bd5] procfs: Move proc_fill_super() to fs/proc/root.c
git bisect bad bf090f3c0282903ad55bca27a482180c70627bd5
# bad: [d3f3eaba540acf5b521865dec5634e3a1e138f1d] vfs: Remove unused code after filesystem context changes
git bisect bad d3f3eaba540acf5b521865dec5634e3a1e138f1d
# bad: [5d5eb529715b5a7a4caf10825e2a330608dcd1ef] vfs: Implement a filesystem superblock creation/configuration context
git bisect bad 5d5eb529715b5a7a4caf10825e2a330608dcd1ef
# first bad commit: [5d5eb529715b5a7a4caf10825e2a330608dcd1ef] vfs: Implement a filesystem superblock creation/configuration context
