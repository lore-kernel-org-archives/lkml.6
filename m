Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB2DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204EC20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204EC20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404808AbeHGVQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:16:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404453AbeHGVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:16:26 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D832A74;
        Tue,  7 Aug 2018 19:00:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Phillip Lougher <phillip.lougher@gmail.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 76/85] squashfs: more metadata hardening
Date:   Tue,  7 Aug 2018 20:52:18 +0200
Message-Id: <20180807172400.180565044@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit d512584780d3e6a7cacb2f482834849453d444a1 upstream.

Anatoly reports another squashfs fuzzing issue, where the decompression
parameters themselves are in a compressed block.

This causes squashfs_read_data() to be called in order to read the
decompression options before the decompression stream having been set
up, making squashfs go sideways.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Acked-by: Phillip Lougher <phillip.lougher@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/squashfs/block.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -166,6 +166,8 @@ int squashfs_read_data(struct super_bloc
 	}
 
 	if (compressed) {
+		if (!msblk->stream)
+			goto read_failure;
 		length = squashfs_decompress(msblk, bh, b, offset, length,
 			output);
 		if (length < 0)


