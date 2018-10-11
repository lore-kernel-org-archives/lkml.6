Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C06C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A8120652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwKowRLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A8120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJKXFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeJKXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52C02098A;
        Thu, 11 Oct 2018 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272238;
        bh=chRxzRNcm8nhw27hnHtvkZc4qAAQtszKTZjvtXFj04k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwKowRLQVlB3Ch4Rcf+TttJgppX6rlU3XElzPemLRyHpKCMGHKPh2aAXu1a9nbOu4
         vppnLjDHwL2NB0lOH5fmbhKJ1FRevwaO689ZvN51JG9GTMwTflyjecUHpg9F9er6zz
         oSeIXHSlkjiW2MkO3ZsHimjDUZ+Py4o8xacsk4X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 038/120] media: tm6000: add error handling for dvb_register_adapter
Date:   Thu, 11 Oct 2018 17:33:39 +0200
Message-Id: <20181011152551.324765864@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit e95d7c6eb94c634852eaa5ff4caf3db05b5d2e86 ]

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
[hans.verkuil@cisco.com: use pr_err and fix typo: adater -> adapter]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/tm6000/tm6000-dvb.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -275,6 +275,11 @@ static int register_dvb(struct tm6000_co
 
 	ret = dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T",
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		pr_err("tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv = dev;
 
 	if (dvb->frontend) {


