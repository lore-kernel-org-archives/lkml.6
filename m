Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9447FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B87520871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAR9y0QH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B87520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbeKLISf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732860AbeKLISe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07019223C6;
        Sun, 11 Nov 2018 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975318;
        bh=2F6C9FeUGXFjY4vbrqwO7SAGUXwfu+AXTs7f1Fj/SBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAR9y0QH+e9AJ2wKDCqaRREsIn4yXt9ytkcVxN581BNIX0iVc3hfTfLWU3smAIXPR
         GGJz8f1BIwISny/b9Adup5pf6glHUVXx7sSeki7zsxV4GCMUwhN6Ntx+dtZtNzBVBi
         HFMKcw8NDM1Ck+2YJHwK0muiWfhUaRRUcZpJRnZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 310/361] media: adv7604: when the EDID is cleared, unconfigure CEC as well
Date:   Sun, 11 Nov 2018 14:20:57 -0800
Message-Id: <20181111221658.191787222@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit e7da89926f6dc6cf855f5ffdf79ef99a1b115ca7 upstream.

When there is no EDID the CEC adapter should be unconfigured as
well. So call cec_phys_addr_invalidate() when this happens.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/adv7604.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2284,8 +2284,10 @@ static int adv76xx_set_edid(struct v4l2_
 		state->aspect_ratio.numerator = 16;
 		state->aspect_ratio.denominator = 9;
 
-		if (!state->edid.present)
+		if (!state->edid.present) {
 			state->edid.blocks = 0;
+			cec_phys_addr_invalidate(state->cec_adap);
+		}
 
 		v4l2_dbg(2, debug, sd, "%s: clear EDID pad %d, edid.present = 0x%x\n",
 				__func__, edid->pad, state->edid.present);


