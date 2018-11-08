Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1431ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CDD206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dw3rPxBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CDD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKIGIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:08:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeKIGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:08:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so19207886lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dJ21MFheqMtGC0GP2Ri/IKr1RXrXmw8gJIrPZPUwV48=;
        b=Dw3rPxBiETf1OwrXIWVr1CKTjQCoEq+y9ZtYnMuSqIaqrFOfSCxGvVTrGv7Z1sCD4/
         m55iGr9ygEsGTpYgcl1nTL/BdnJMy8xMuVcPe/Bl1dTFIyDctu44hqNd8yILxr14cE6n
         gShHhNL3x+OhAI9iObgwRZObiDPLaPiwqQUI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dJ21MFheqMtGC0GP2Ri/IKr1RXrXmw8gJIrPZPUwV48=;
        b=ElYKLZjZlmur0ZzfypM55VM4+8k6BYu0cuZw4i97UggAXDPqJRSXzifaPLkfFSOO/U
         hoRyQ1TbELTy0e9XNF/RykmzVoQbXkWD+WrYftG2StQFI1UIie088IRTkQomHgPl6IHy
         LXL+tQkWDSxcuU0k/BhVxYaefPODHH90ecuUzM1sY9brr18dQWdWh6LkTI7QnAJgerh9
         sBXvZj+3ybPsFWhPnppveryqt3WvSnUnx+GNlFSh520LhG1jlYw5dS/VWpEOaPiGlB84
         r0cB+3qk93zszANv70roYokZkNR8OuPItUp6/lMDtADdClZuQ07rhTBTaxpHHqomu/i9
         zalw==
X-Gm-Message-State: AGRZ1gK0qCRRazwKH9kjW3nrhev6rFAj0ceYf4UILH3tIr41fGNOq6jR
        ZfHiWO3M30LGTBkLbM4lUl70BQ==
X-Google-Smtp-Source: AJdET5cF+fJTMI+J55l+6qvX/0ENwvb3E9xzGzbQb+jycmJNUCL7K4CcSY8UIWQuewDBWMsEipRw2A==
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr343251lji.124.1541709062298;
        Thu, 08 Nov 2018 12:31:02 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w9sm809250lfc.66.2018.11.08.12.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:31:01 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 4/4] net: ethernet: ti: cpsw: fix vlan configuration while down/up
Date:   Thu,  8 Nov 2018 22:27:57 +0200
Message-Id: <20181108202757.30110-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vlan configuration is not restored after interface donw/up sequence
(if dual-emac - both interfaces). Tested on am572x EVM.

Steps to check:
~# ip link add link eth1 name eth1.100 type vlan id 100
~# ifconfig eth0 down
~# ifconfig eth1 down

Try to remove vid and observe warning:
~# ip link del eth1.100
[  739.526757] net eth1: removing vlanid 100 from vlan filter
[  739.533322] failed to kill vid 0081/100 for device eth1

This patch fixes it, restoring only vlan ALE entries and all other
unicast/multicast entries are restored by system calling rx_mode ndo.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 0b18634d336c..9434fd5a5477 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,6 +565,9 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
+static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid);
+
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
@@ -1951,9 +1954,23 @@ static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	slave_write(slave, tx_prio_map, tx_prio_rg);
 }
 
+static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
+{
+	struct cpsw_priv *priv = arg;
+
+	if (!vdev)
+		return 0;
+
+	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
+	return 0;
+}
+
 /* restore resources after port reset */
 static void cpsw_restore(struct cpsw_priv *priv)
 {
+	/* restore vlan configurations */
+	vlan_for_each(priv->ndev, cpsw_restore_vlans, priv);
+
 	/* restore MQPRIO offload */
 	for_each_slave(priv, cpsw_mqprio_resume, priv);
 
-- 
2.17.1

