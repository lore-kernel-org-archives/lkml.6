Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC08C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C33C2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C33C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407808AbeHATRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:17:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeHATRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:17:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48397D4A;
        Wed,  1 Aug 2018 17:30:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "John L. Hammond" <john.hammond@intel.com>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <uja.ornl@yahoo.com>,
        James Simmons <jsimmons@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 124/144] staging: lustre: llite: correct removexattr detection
Date:   Wed,  1 Aug 2018 18:52:31 +0200
Message-Id: <20180801164958.031982786@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Simmons <jsimmons@infradead.org>

[ Upstream commit 1b60f6dfa38403ff7c4d0b4b7ecdb810f9789a2a ]

In ll_xattr_set_common() detect the removexattr() case correctly by
testing for a NULL value as well as XATTR_REPLACE.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10787
Reviewed-on: https://review.whamcloud.com/
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -103,7 +103,11 @@ ll_xattr_set_common(const struct xattr_h
 	__u64 valid;
 	int rc;
 
-	if (flags == XATTR_REPLACE) {
+	/* When setxattr() is called with a size of 0 the value is
+	 * unconditionally replaced by "". When removexattr() is
+	 * called we get a NULL value and XATTR_REPLACE for flags.
+	 */
+	if (!value && flags == XATTR_REPLACE) {
 		ll_stats_ops_tally(ll_i2sbi(inode), LPROC_LL_REMOVEXATTR, 1);
 		valid = OBD_MD_FLXATTRRM;
 	} else {


