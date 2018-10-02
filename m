Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3082C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFFF2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="PizaOKqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFFF2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJBVdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:33:24 -0400
Received: from imap.thunk.org ([74.207.234.97]:37134 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeJBVdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z2QEvOcbezwAtkSyUuoeYTZeTpztA4GoiWRdMbJKK24=; b=PizaOKqWG5PCT5HwCfF4cCNFs4
        6/Ei2w5HJj/YbBrr6U9db7KfpQUFb/0HsQteJnmCR4/h7fzV125DfLv9QUAbQZ9HHPnfBl+vyfnqY
        OVBgmH8jjExmyayS4XsLEcIceCJSMAhyrN7JvmADAnV1+6f5JrN5yC2PH/ipkZdslbqw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7LzT-0005Zh-Tt; Tue, 02 Oct 2018 14:49:35 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D61E17A55B3; Tue,  2 Oct 2018 10:49:33 -0400 (EDT)
Date:   Tue, 2 Oct 2018 10:49:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in seq_escape
Message-ID: <20181002144933.GC17537@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
References: <000000000000902cb10577255369@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000902cb10577255369@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 11:58:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    17b57b1883c1 Linux 4.19-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1672d711400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2872d6feea6918008a9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

This should be fixed with the following patch.

     	       	     	      		- Ted

From 89cc85e761c5b905b1a61cb85440bf9b5e841c80 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 2 Oct 2018 10:40:57 -0400
Subject: [PATCH] ext4: fix use-after-free race in ext4_remount()'s error path

It's possible for ext4_show_quota_options() to try reading
s_qf_names[i] while it is being modified by ext4_remount() --- most
notably, in ext4_remount's error path when the original values of the
quota file name gets restored.

Reported-by: syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index faf293ed8060..11a1bfae0937 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2048,11 +2048,13 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
+	down_read(&sb->s_umount);
 	if (sbi->s_qf_names[USRQUOTA])
 		seq_show_option(seq, "usrjquota", sbi->s_qf_names[USRQUOTA]);
 
 	if (sbi->s_qf_names[GRPQUOTA])
 		seq_show_option(seq, "grpjquota", sbi->s_qf_names[GRPQUOTA]);
+	up_read(&sb->s_umount);
 #endif
 }
 
-- 
2.18.0.rc0

