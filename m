Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A792208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A792208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeHAUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404221AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A55B7FB1;
        Wed,  1 Aug 2018 16:58:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 103/336] media: cec-pin-error-inj: avoid a false-positive Spectre detection
Date:   Wed,  1 Aug 2018 18:47:18 +0200
Message-Id: <20180801165033.106147009@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit a3d71f256c8a8b5d51ea0dfd09cd85ce3a09d9e1 ]

The current logic makes Smatch to false-detect a Spectre variant 1
vulnerability. The problem is that it initializes an u32 indirectly
from user space input.

After trying to write a fixup, after a while I realized that, in
practice, this shouldn't be a problem, as an u32 is initialized
from u8, but it took some time to discover it.

So, do some code cleanup to make it clearer for both humans
and machines about the valid range for "op".

Fix this warning:
	drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line() warn: potential spectre issue 'pin->error_inj_args'

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/cec/cec-pin-error-inj.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/media/cec/cec-pin-error-inj.c
+++ b/drivers/media/cec/cec-pin-error-inj.c
@@ -81,10 +81,9 @@ bool cec_pin_error_inj_parse_line(struct
 	u64 *error;
 	u8 *args;
 	bool has_op;
-	u32 op;
+	u8 op;
 	u8 mode;
 	u8 pos;
-	u8 v;
 
 	p = skip_spaces(p);
 	token = strsep(&p, delims);
@@ -146,12 +145,18 @@ bool cec_pin_error_inj_parse_line(struct
 	comma = strchr(token, ',');
 	if (comma)
 		*comma++ = '\0';
-	if (!strcmp(token, "any"))
-		op = CEC_ERROR_INJ_OP_ANY;
-	else if (!kstrtou8(token, 0, &v))
-		op = v;
-	else
+	if (!strcmp(token, "any")) {
+		has_op = false;
+		error = pin->error_inj + CEC_ERROR_INJ_OP_ANY;
+		args = pin->error_inj_args[CEC_ERROR_INJ_OP_ANY];
+	} else if (!kstrtou8(token, 0, &op)) {
+		has_op = true;
+		error = pin->error_inj + op;
+		args = pin->error_inj_args[op];
+	} else {
 		return false;
+	}
+
 	mode = CEC_ERROR_INJ_MODE_ONCE;
 	if (comma) {
 		if (!strcmp(comma, "off"))
@@ -166,10 +171,6 @@ bool cec_pin_error_inj_parse_line(struct
 			return false;
 	}
 
-	error = pin->error_inj + op;
-	args = pin->error_inj_args[op];
-	has_op = op <= 0xff;
-
 	token = strsep(&p, delims);
 	if (p) {
 		p = skip_spaces(p);


