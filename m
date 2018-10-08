Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8DBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478B321479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n57Xh2ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478B321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeJICAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeJICAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE19214C2;
        Mon,  8 Oct 2018 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024447;
        bh=NdPdHCOvjTY3TIcTOjpdRikiJCMGaNG8oHyByuum97A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n57Xh2rimiRhxYGWtekeVZ8O4yfO6Qk5JKcbKZ83miTYLXEtm/Iifv1XeAgoCLlVW
         dYViqW1y7BPkShmU17dur46jNcZGgutrWQHy9fzR/rxkUaB6DhCE0wtOEnKuphOUm4
         F/910hfSIWS9Tixpui1l6HluwKvvI8/Wo6XCW2/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 035/168] net: mvpp2: initialize port of_node pointer
Date:   Mon,  8 Oct 2018 20:30:15 +0200
Message-Id: <20181008175621.383132467@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit c4053ef322081554765e1b708d6cdd8855e1d72d ]

Without a valid of_node in struct device we can't find the mvpp2 port
device by its DT node. Specifically, this breaks
of_find_net_device_by_node().

For example, the Armada 8040 based Clearfog GT-8K uses Marvell 88E6141
switch connected to the &cp1_eth2 port:

&cp1_mdio {
	...

	switch0: switch0@4 {
		compatible = "marvell,mv88e6085";
		...

		ports {
			...

			port@5 {
				reg = <5>;
				label = "cpu";
				ethernet = <&cp1_eth2>;
			};
		};
	};
};

Without this patch, dsa_register_switch() returns -EPROBE_DEFER because
of_find_net_device_by_node() can't find the device_node of the &cp1_eth2
device.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4685,6 +4685,7 @@ static int mvpp2_port_probe(struct platf
 	dev->min_mtu = ETH_MIN_MTU;
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
+	dev->dev.of_node = port_node;
 
 	/* Phylink isn't used w/ ACPI as of now */
 	if (port_node) {


