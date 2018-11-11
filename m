Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5A1223DD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih0tY5eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5A1223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbeKLIXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404039AbeKLIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B98E2241E;
        Sun, 11 Nov 2018 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975584;
        bh=N0hg1GwiB9XGPR/SF7YFRDCILUA0QSU+mHGARIou9As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ih0tY5eE1/i0uLkfDy4CFM1mDlgv/zS153LyZtd8HQFnAHI3vWq1iV2Zx/C9q7n6n
         zd21MCBKw3rha8Cr/lr8u1iMHkA9E3swe74I7DurKaNpUT1g3Je/W6VrUooFpOMZA0
         wClR0yDdy+j8/imwKYOUsqWyElBgUO/Mf+txAhDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 137/222] ext4: initialize retries variable in ext4_da_write_inline_data_begin()
Date:   Sun, 11 Nov 2018 14:23:54 -0800
Message-Id: <20181111221659.802163680@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -869,7 +869,7 @@ int ext4_da_write_inline_data_begin(stru
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
-	int retries;
+	int retries = 0;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)


