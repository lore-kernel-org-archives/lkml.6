Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ABC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C2C2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvNsbleF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C2C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbeKLJPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389064AbeKLIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203B2224E3;
        Sun, 11 Nov 2018 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975453;
        bh=7Hf1Pl6raycGbpBUg0TJun1MwmolqWHSXvkBJ4skmLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvNsbleF4NZLOtmZ6HOEOTIy9sWRuVCrRReNgv+i9qAsRBoCGSbdneD92qn17uB6r
         v4FeuNA7VCguISXccyll33ietsFzk9vfZhSjne7jR22DXHApvFWnll72nnN1PPQdi1
         eMnRAxCfYjQ2zQPsMiBKd3z+R9GMlcfwEhPbmD0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.18 221/350] ext4: initialize retries variable in ext4_da_write_inline_data_begin()
Date:   Sun, 11 Nov 2018 14:21:25 -0800
Message-Id: <20181111221717.271824354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

commit 625ef8a3acd111d5f496d190baf99d1a815bd03e upstream.

Variable retries is not initialized in ext4_da_write_inline_data_begin()
which can lead to nondeterministic number of retries in case we hit
ENOSPC. Initialize retries to zero as we do everywhere else.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: bc0ca9df3b2a ("ext4: retry allocation when inline->extent conversion failed")
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -863,7 +863,7 @@ int ext4_da_write_inline_data_begin(stru
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
-	int retries;
+	int retries = 0;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)


