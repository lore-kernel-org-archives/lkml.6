Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853FE208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853FE208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeHWL5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:57:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeHWL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:57:18 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7C51C74;
        Thu, 23 Aug 2018 08:28:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 121/217] fsl/fman: fix parser reporting bad checksum on short frames
Date:   Thu, 23 Aug 2018 09:53:54 +0200
Message-Id: <20180823075510.968264177@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit b95f6fbc8e15803a596ca5e5e21008fba29694c6 ]

The FMan hardware parser needs to be configured to remove the
short frame padding from the checksum calculation, otherwise
short UDP and TCP frames are likely to be marked as having a
bad checksum.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fman/fman_port.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -324,6 +324,10 @@ struct fman_port_qmi_regs {
 #define HWP_HXS_PHE_REPORT 0x00000800
 #define HWP_HXS_PCAC_PSTAT 0x00000100
 #define HWP_HXS_PCAC_PSTOP 0x00000001
+#define HWP_HXS_TCP_OFFSET 0xA
+#define HWP_HXS_UDP_OFFSET 0xB
+#define HWP_HXS_SH_PAD_REM 0x80000000
+
 struct fman_port_hwp_regs {
 	struct {
 		u32 ssa; /* Soft Sequence Attachment */
@@ -728,6 +732,10 @@ static void init_hwp(struct fman_port *p
 		iowrite32be(0xffffffff, &regs->pmda[i].lcv);
 	}
 
+	/* Short packet padding removal from checksum calculation */
+	iowrite32be(HWP_HXS_SH_PAD_REM, &regs->pmda[HWP_HXS_TCP_OFFSET].ssa);
+	iowrite32be(HWP_HXS_SH_PAD_REM, &regs->pmda[HWP_HXS_UDP_OFFSET].ssa);
+
 	start_port_hwp(port);
 }
 


