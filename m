Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5B26E44
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lo3qCm6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B5B26E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeFZRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:30:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36343 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbeFZR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so4630928pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bs3PaT7gEFbZXPSG6yJfGZRtmLpSeEZfBn/CACPZ/fs=;
        b=lo3qCm6v6A/qALHgFxE2ZjcDb9KAjwcSfxkHli0D3TLrvxtXTBgoGqbYfA2FuxhmmD
         w/722klCx/sa8CbFYBT4ovKIt42CKjjEANzkwwyBpa+Xfqos4YUxtIoS95hZieXvnD1g
         NdyM+F1ayH26TS/jh1pS+XxyP5KflNjta2lkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bs3PaT7gEFbZXPSG6yJfGZRtmLpSeEZfBn/CACPZ/fs=;
        b=Kia8UcpgAcRBbBPSGLMSZ2Olhr7z5jklUDbcvigZXlgqS2j65rClqWOifdxxXgRsGC
         8iFF7Z8O8k7RI9K9TDNmMU+/uH1cDXgIMBN8nu7jX2p0FcA+AUl+BIfzovXz82m3u+r+
         s4d2Ctg907B1jmHvbp1gZJFBNbxTsIZVDh+jjKVdaOyidtoWbynF/wt93ylv0pXOCNPp
         GxSTWfu+BcE2JrYGwwXZlAda/B83k89Qv/emP1Oi1hSRfgfiUA9xJSg3Vt+Fk4VKX3xf
         X6YuhPhZCadRwPAYJjxZiMHYb3PVtaOoXTQ5qhZap+K2FXmh6eZd6NPrZguCviMyxbzt
         tFzA==
X-Gm-Message-State: APt69E3kIDZVxn373wRBASKiYCsziuyaD0L5Q+eILq/H+wNmA1jPvQm6
        Zlgp6qHI9Neb29uSrVRiTlZdwMzjGY8=
X-Google-Smtp-Source: AAOMgpew3/a2EkWfiF3+Z+NFBGb2JxvN2N12V8jwhQ2TEgbtBuL4Ej19uqstuhrkDE8hxaF65zkeAA==
X-Received: by 2002:a62:6203:: with SMTP id w3-v6mr2445509pfb.65.1530034162789;
        Tue, 26 Jun 2018 10:29:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d15-v6sm6397395pfh.92.2018.06.26.10.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:29:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] NTFS: aops: Remove VLA usage
Date:   Tue, 26 Jun 2018 10:29:07 -0700
Message-Id: <20180626172909.41453-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626172909.41453-1-keescook@chromium.org>
References: <20180626172909.41453-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the maximum size needed on the stack and adds a sanity check for
robustness: index.block_size cannot be larger than PAGE_SIZE nor less
than NTFS_BLOCK_SIZE.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ntfs/aops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 3a2e509c77c5..58dadff3e0e0 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -926,7 +926,7 @@ static int ntfs_write_mst_block(struct page *page,
 	ntfs_volume *vol = ni->vol;
 	u8 *kaddr;
 	unsigned int rec_size = ni->itype.index.block_size;
-	ntfs_inode *locked_nis[PAGE_SIZE / rec_size];
+	ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
 	struct buffer_head *bh, *head, *tbh, *rec_start_bh;
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	runlist_element *rl;
@@ -935,6 +935,9 @@ static int ntfs_write_mst_block(struct page *page,
 	bool sync, is_mft, page_is_dirty, rec_is_dirty;
 	unsigned char bh_size_bits;
 
+	if (WARN_ON(rec_size < NTFS_BLOCK_SIZE))
+		return -EINVAL;
+
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx.", vi->i_ino, ni->type, page->index);
 	BUG_ON(!NInoNonResident(ni));
-- 
2.17.1

