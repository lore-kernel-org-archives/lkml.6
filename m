Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E3C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92392245E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtxWcNlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92392245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbeKLIV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389532AbeKLIV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CC3223C6;
        Sun, 11 Nov 2018 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975490;
        bh=kb7Iv/izCLenBEkE0iSMybFSyLN1zFcA2o4l4/ZQxTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtxWcNlYDrF8TzefmpD8PLQfjnuFD6JX9xUE0CDFNkawF9984rmvl5oVJYG63lvPZ
         tssd0ft0KTjIqNErdQPVDcKs2gg/JKR/K2/B45avXcqOQASB2E2h7eOU3eeZ43yx2y
         CyVURN4IG0S9NAs8ol4/hfHgmIuKDL+GpXJueHlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.18 289/350] media: cec: integrate cec_validate_phys_addr() in cec-api.c
Date:   Sun, 11 Nov 2018 14:22:33 -0800
Message-Id: <20181111221720.156653590@linuxfoundation.org>
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

From: Hans Verkuil <hans.verkuil@cisco.com>

commit e81bff39489a06384822bb38ce7a59f9e365bbe9 upstream.

The cec_phys_addr_validate() function will be moved to V4L2,
so use a simplified variant of that function in cec-api.c.
cec now no longer calls cec_phys_addr_validate() and it can
be safely moved to V4L2.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.17 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/cec/cec-api.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -101,6 +101,23 @@ static long cec_adap_g_phys_addr(struct
 	return 0;
 }
 
+static int cec_validate_phys_addr(u16 phys_addr)
+{
+	int i;
+
+	if (phys_addr == CEC_PHYS_ADDR_INVALID)
+		return 0;
+	for (i = 0; i < 16; i += 4)
+		if (phys_addr & (0xf << i))
+			break;
+	if (i == 16)
+		return 0;
+	for (i += 4; i < 16; i += 4)
+		if ((phys_addr & (0xf << i)) == 0)
+			return -EINVAL;
+	return 0;
+}
+
 static long cec_adap_s_phys_addr(struct cec_adapter *adap, struct cec_fh *fh,
 				 bool block, __u16 __user *parg)
 {
@@ -112,7 +129,7 @@ static long cec_adap_s_phys_addr(struct
 	if (copy_from_user(&phys_addr, parg, sizeof(phys_addr)))
 		return -EFAULT;
 
-	err = cec_phys_addr_validate(phys_addr, NULL, NULL);
+	err = cec_validate_phys_addr(phys_addr);
 	if (err)
 		return err;
 	mutex_lock(&adap->lock);


