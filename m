Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80621773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mlq4JLmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfAIJL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57996 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbfAIJL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099BJfb041949;
        Wed, 9 Jan 2019 03:11:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025079;
        bh=F33iTF+6ocunBypeLGUFHJsGIC0hXEgIkfoF9lZATo4=;
        h=From:To:CC:Subject:Date;
        b=mlq4JLmmaWzrAaJHHi7ysEsEgHOAS4dU4HZrQr8+iSL1WWzfUn5lwmQ0MLziUrDEe
         ixY3M3VpDvkEyy3RfQM91POB1OR6td+gDDStKIFwZNZy3YEFI+mYGfiK+4T8xHno+l
         YYW0fM5SkPoYA2EVce9Alv94WrVamJ3qch5G54ZY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099BJ5b111431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:11:19 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:11:18 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:11:18 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099BFBO017497;
        Wed, 9 Jan 2019 03:11:16 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] 8250_omap: use clk APIs to get fclk freqeuncy
Date:   Wed, 9 Jan 2019 14:42:03 +0530
Message-ID: <20190109091206.25759-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support obtain clk frequency of functional clk via
clocks phandle instead of hard coding it in DT as part of
clock-frequency DT parameter. This eliminates need to calculate
frequency offline and populate it.

Vignesh R (3):
  serial: 8250_omap: Drop check for of_node
  dt-bindings: serial: omap_serial: add clocks entry
  serial: 8250_omap: Use clk_get_rate() to obtain fclk frequency

 .../bindings/serial/omap_serial.txt           |  2 +
 drivers/tty/serial/8250/8250_omap.c           | 75 ++++++++++---------
 2 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.20.1

