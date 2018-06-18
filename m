Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55683C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A719208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A719208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbeFRITc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeFRIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42286BAD;
        Mon, 18 Jun 2018 08:19:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 063/279] vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion
Date:   Mon, 18 Jun 2018 10:10:48 +0200
Message-Id: <20180618080611.437741166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit a9e5b73288cf1595ac2e05cf1acd1924ceea05fa ]

In do_mount() when the MS_* flags are being converted to MNT_* flags,
MS_RDONLY got accidentally convered to SB_RDONLY.

Undo this change.

Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2810,7 +2810,7 @@ long do_mount(const char *dev_name, cons
 		mnt_flags |= MNT_NODIRATIME;
 	if (flags & MS_STRICTATIME)
 		mnt_flags &= ~(MNT_RELATIME | MNT_NOATIME);
-	if (flags & SB_RDONLY)
+	if (flags & MS_RDONLY)
 		mnt_flags |= MNT_READONLY;
 
 	/* The default atime for remount is preservation */


