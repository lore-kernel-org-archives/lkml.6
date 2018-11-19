Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29DEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F7C21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwQJZ2T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F7C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbeKTDFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbeKTDFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0816A21104;
        Mon, 19 Nov 2018 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645690;
        bh=UG9yv+Q+HsGZUtyaw8dRo4zelFwCxjw0KC5AUsVoF68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwQJZ2T9aRq3zsplvtQMPEgkKYRI0NSnxvBOdk7crnLKGBw8TBxhIuef+VNiVObmv
         i/3+PztenOClqEX8JMeEY+qicNxB15XWKE43BKI8qWGUi+J+lu/4rQM7d1Aj9o4VEr
         sIUjFi2mxdzpDNv6c88k7cYklTEuO1vq2ZbFsPvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 053/171] arm64: dts: stratix10: fix multicast filtering
Date:   Mon, 19 Nov 2018 17:27:29 +0100
Message-Id: <20181119162628.537344007@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

commit fd5ba6ee3187617287fb9cb187e3d6b3631210a3 upstream

On Stratix 10, the EMAC has 256 hash buckets for multicast filtering. This
needs to be specified in DTS, otherwise the stmmac driver defaults to 64
buckets and initializes the filter incorrectly. As a result, e.g. valid
IPv6 multicast traffic ends up being dropped.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Cc: stable@vger.kernel.org
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 22f88188b0f5..6c8bd13d64b8 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -133,6 +133,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
@@ -148,6 +149,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
@@ -163,6 +165,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
-- 
2.17.1



