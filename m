Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE74C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq/QPDls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE74C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeILDJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:09:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeILDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:09:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so12924729pgp.9;
        Tue, 11 Sep 2018 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fQfFZXcdvKiffdEGXqzDCbwPNc5uZbtBrs+8fK4f5Xk=;
        b=gq/QPDlsVlHEm4QpIjwZ8H8hHpt3POZfn1KxLa+wMq7SE+NYQeTwshg1XjQJvSCl4I
         3b0lgTZxH+amccVjfbhKhCl7IqJqccl/uTvm+0X272iddeFS7AM/YcGd4BK9P8AhLDed
         +T4DJxoMWqsMceWXfM55pL14ls3Na48GRMzrSwbDmfF8l574wFMH4xBqVeH6GblrHFoQ
         RUowHXj1TWBO6O/UJP73Qm3lY2Uib2BFUTM6csleB/dqpRLK2J2CMUTBdhEtl3R6LOdm
         bFtQdiXe2auzpuGqIZkBN3YT8CDb+bXowStkRTnGPCGPNuek89XW/TFr4CEJwymcRVod
         Qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQfFZXcdvKiffdEGXqzDCbwPNc5uZbtBrs+8fK4f5Xk=;
        b=O17lpre3lBId99ncTL91egYKlAk1KlibV/epdPQHB2tYf8zXULxUsGRFiah4iq/g88
         he53N9Pec4HUk+mFsuuUIf9MYYmILozPSlEXjPBsEC1ut7si33eIDDNI5sbxRdVgJ5cC
         6ZXz1CaxbjoWJ9mBQKCJbyZjMBtaDYTnot2kPTIjg0o0aRTzmFiIcPWfG3OxOZxH96oc
         2G370gCy8Pio3ZintAr3KcAxlMSEOAVUUlsMAlVq/hQOtLiHBYUNYCo6r6Uj4jIw0uLs
         YJvGdAGxPMySE3K+qV7tN6JkZSaKqYUGA91/nGlbOMzV8rSZabFpmFirNfl5/bhVVgKk
         rBpg==
X-Gm-Message-State: APzg51DlG8QqkFU+XffkXKRzm2XUwEPZ5NE5EBCpKTygTDZFdiA+Kj1M
        cX+Dj39RHSUiMcXhNj5TkGc=
X-Google-Smtp-Source: ANB0VdY8suFod8ZijQ7+YiaOpuBvE6OvJS5rL6ungEpoXe3D0fQbhZ4HfODWPPvWj4h/auknzrQiTA==
X-Received: by 2002:a63:d90b:: with SMTP id r11-v6mr30716705pgg.315.1536703665476;
        Tue, 11 Sep 2018 15:07:45 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 6-v6sm35227473pfs.58.2018.09.11.15.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:07:44 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:07:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180911220743.GA13208@roeck-us.net>
References: <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27113.1536702746@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 10:52:26PM +0100, David Howells wrote:
> > [    5.057003] RIP: 0010:reconfigure_super+0x47/0x210
> 
> Can you tell me what file and line this is?
> 
> Also, do you know which filesystem was involved?
> 
> > I don't find a more recent version of this patch in patchwork on kernel.org,
> > so I am replying to this one. My apologies if there are more recent versions.
> 
> I've just updated my tree with some fixes.  Can you try:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/
> 
> branch "fsinfo"?
> 

Unfortunately, that does not work either.
With v4.19-rc3-40-g09f0a401de37:

[    8.505130] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[    8.506237] PGD 800000001d81e067 P4D 800000001d81e067 PUD 1dfb1067 PMD 0 
[    8.506669] Oops: 0000 [#1] SMP PTI
[    8.506915] CPU: 0 PID: 1180 Comm: umount Not tainted 4.19.0-rc3+ #1
[    8.507052] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    8.507672] RIP: 0010:reconfigure_super+0x47/0x210
[    8.507877] Code: d4 01 00 00 44 8b a3 30 02 00 00 45 85 e4 0f 85 9d 01 00 00 a8 01 48 89 fd 75 4f 48 89 df 45 31 ed e8 ad 4f 01 00 48 8b 45 00 <48> 4
[    8.508222] RSP: 0018:ffffb3794015bdd0 EFLAGS: 00000246
[    8.508345] RAX: 0000000000000000 RBX: ffff9d855df27800 RCX: ffff9d855df278b8
[    8.508479] RDX: ffff9d855df27848 RSI: 0000000000000000 RDI: ffffffff8d54a9a8
[    8.508617] RBP: ffffb3794015be00 R08: 00000000000000d8 R09: 0000000000000000
[    8.508752] R10: ffffb3794011fce8 R11: 0000000000000001 R12: 0000000000000000
[    8.508885] R13: 0000000000000001 R14: ffff9d855effc920 R15: 0000000000000000
[    8.509056] FS:  00007f6712967500(0000) GS:ffff9d855f200000(0000) knlGS:0000000000000000
[    8.509217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.509332] CR2: 0000000000000030 CR3: 000000001dfe0000 CR4: 00000000000006f0
[    8.509516] Call Trace:
[    8.510121]  do_umount_root+0x7b/0xb0
[    8.510244]  ksys_umount+0x250/0x3e0
[    8.510535]  ? vfs_write+0x13f/0x190
[    8.510629]  __x64_sys_umount+0xd/0x10
[    8.510722]  do_syscall_64+0x39/0xe0
[    8.510810]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Guenter
