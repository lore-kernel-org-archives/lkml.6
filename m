Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE55C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9B320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9B320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404121AbeHATDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403961AbeHATDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:32 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35EA71251;
        Wed,  1 Aug 2018 17:09:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 286/336] media: cec: fix smatch error
Date:   Wed,  1 Aug 2018 18:50:21 +0200
Message-Id: <20180801165039.971012946@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit b66d448487a478c203368f2b72d7d9156a01f6be ]

drivers/media/cec/cec-pin-error-inj.c:231
cec_pin_error_inj_parse_line() error: uninitialized symbol 'pos'.

The tx-add-bytes command didn't check for the presence of an argument, and
also didn't check that it was > 0.

This should fix this error.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/cec/cec-pin-error-inj.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/media/cec/cec-pin-error-inj.c
+++ b/drivers/media/cec/cec-pin-error-inj.c
@@ -204,16 +204,18 @@ bool cec_pin_error_inj_parse_line(struct
 		mode_mask = CEC_ERROR_INJ_MODE_MASK << mode_offset;
 		arg_idx = cec_error_inj_cmds[i].arg_idx;
 
-		if (mode_offset == CEC_ERROR_INJ_RX_ARB_LOST_OFFSET ||
-		    mode_offset == CEC_ERROR_INJ_TX_ADD_BYTES_OFFSET)
-			is_bit_pos = false;
-
 		if (mode_offset == CEC_ERROR_INJ_RX_ARB_LOST_OFFSET) {
 			if (has_op)
 				return false;
 			if (!has_pos)
 				pos = 0x0f;
+			is_bit_pos = false;
+		} else if (mode_offset == CEC_ERROR_INJ_TX_ADD_BYTES_OFFSET) {
+			if (!has_pos || !pos)
+				return false;
+			is_bit_pos = false;
 		}
+
 		if (arg_idx >= 0 && is_bit_pos) {
 			if (!has_pos || pos >= 160)
 				return false;


