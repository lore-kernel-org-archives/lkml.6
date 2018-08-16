Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6119C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDDF208B1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTIDQoH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDDF208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbeHPPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:53:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44787 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391410AbeHPPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:53:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so2057801plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cvX4bf2n4cCtLSLi1usDuICrAMQwoBzNjS22rozmeSs=;
        b=PTIDQoH5Cmu8XzHr5m0+VtUI3H+FKVgyPdUSKOwErZgUrGqO7l+5I1wslMzqkJKnvK
         IQeNBSpaLINAbL6Cs6s3uSVDRYXhYUfL820sSCb1wB6CnqtDMZG0f4xOSSWqXHarZVPu
         +WAShEEDabkKa1TPKTlpcivLTrlF3LotCh2zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cvX4bf2n4cCtLSLi1usDuICrAMQwoBzNjS22rozmeSs=;
        b=r/lffqIZxe6LHi5GhM775x7r2VBk8kt3sf6et2e1URcpePc2sG5CntMOPmrj6cWLnF
         ao/V8/Q2+bzXSeRZi/q3G/NBCWlMIMJ6VCc931pvd2+5WfKsNy0KrOKc0pj4qgKabDGl
         eghgEz9kUklXi+DWNymY0eg+uBdsTo67HT0cOxGsA0+5tc8iWpxOM2EHV13dUVq5Rp92
         TfDqL9nHpwHqPG6xFsVSaDGYYOy/KDh95Qi08FZ/JpOVPHEmq69tFtdSGSyX1b1Jlwbg
         D8lPUpCwnziZ52CntTkv21OZtSkguI6M6WLUyMky7J3WzcvfH/9nBDRWep1b+LWLmfBt
         CHew==
X-Gm-Message-State: AOUpUlHBR+Dz+suMDxMy53T/brdClkurSZMYA4ypMoo5TFUiZSjxcMAO
        hpNlPUt2tsCocDVTin0KnqfLFg==
X-Google-Smtp-Source: AA+uWPwlSK8Ef+qKB0NYkgHCy3eo3xJbERRm9zojg8HuYvRmpdeggY5CeG/lkPu8IAfH+2bSz4hUwg==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15-v6mr29231316plm.332.1534424129053;
        Thu, 16 Aug 2018 05:55:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 203-v6sm34944589pgb.14.2018.08.16.05.55.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 05:55:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date:   Thu, 16 Aug 2018 20:54:49 +0800
Message-Id: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some SPI controllers, after each word size (specified by bits_per_word)
transimission, the hardware need some delay to make sure the slave has enough
time to receive the whole data.

So introducing one new 'word_delay' field of struct spi_tansfer for slave
devices to set this inter word delay time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - New patch in v2.
---
 include/linux/spi/spi.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..d698f9d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -711,6 +711,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay: clock cycles to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
@@ -793,6 +795,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
+	u16		word_delay;
 
 	struct list_head transfer_list;
 };
-- 
1.7.9.5

