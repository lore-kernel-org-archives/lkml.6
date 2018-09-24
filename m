Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30621486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F30621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeIXSYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:24:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732161AbeIXSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:24:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89CDF107E;
        Mon, 24 Sep 2018 12:22:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rick Farrington <ricardo.farrington@cavium.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 126/173] liquidio: fix hang when re-binding VF host drv after running DPDK VF driver
Date:   Mon, 24 Sep 2018 13:52:40 +0200
Message-Id: <20180924113125.135943817@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Rick Farrington <ricardo.farrington@cavium.com>

[ Upstream commit ac13d6d8eaded15c67265eafc32f439ea3a0ac4a ]

When configuring SLI_PKTn_OUTPUT_CONTROL, VF driver was assuming that IPTR
mode was disabled by reset, which was not true.  Since DPDK driver had
set IPTR mode previously, the VF driver (which uses buf-ptr-only mode) was
not properly handling DROQ packets (i.e. it saw zero-length packets).

This represented an invalid hardware configuration which the driver could
not handle.

Signed-off-by: Rick Farrington <ricardo.farrington@cavium.com>
Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c |    3 +++
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -493,6 +493,9 @@ static void cn23xx_pf_setup_global_outpu
 	for (q_no = srn; q_no < ern; q_no++) {
 		reg_val = octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no));
 
+		/* clear IPTR */
+		reg_val &= ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |= CN23XX_PKT_OUTPUT_CTL_DPTR;
 
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -165,6 +165,9 @@ static void cn23xx_vf_setup_global_outpu
 		reg_val =
 		    octeon_read_csr(oct, CN23XX_VF_SLI_OQ_PKT_CONTROL(q_no));
 
+		/* clear IPTR */
+		reg_val &= ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |= CN23XX_PKT_OUTPUT_CTL_DPTR;
 


