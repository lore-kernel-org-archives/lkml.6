Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC839ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807572075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QH4l17QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807572075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJYGlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:41:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34574 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeJYGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:41:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id c21-v6so387174ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TR0EsogAgO34iqbw5VJcRTSY0YEnIrhIhjr9xb1cTvc=;
        b=QH4l17QXxF0XBWk+z3/tnLL5j/cXJXpS/QtaI/1w62fb7r9KYN5Y65dC1lvQACWXHM
         ueVvCdK+DIwDu4w4OSSTQJd2uG8mHCeyihdzEZCFpc+ejNXzhsidz66vKNXDEmB166Ae
         VkGtsjN/WTeRBX7gLewyC6OEaA5jgepQ+gQhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TR0EsogAgO34iqbw5VJcRTSY0YEnIrhIhjr9xb1cTvc=;
        b=BmgSn8sX/sr35p0hZe2jMRk0OVu42VobEB/QBx3/8sJjlX9NxbpcJXbtquW7ttJiN3
         1w5WN8Qbsps6Pqe83vcXLiN8ddDLjMIl3VDpXg+NGZ+14aq15JIjhCUSHcqzqVSZ6Fj3
         g4U4ZYPWJ2gxKGBO0GgFLRabsgWUxck6sfIdtQWgjFNpsPzEoy1FUfAQDk0eByhwsjGj
         Zaw+3UESlr0rZj7sISNQndjb78dtiCHmZ/kPkp5S8WfKiCWN5olenfgpSkdKmEsl4cnA
         OsDGovKWWLcryUxUDP54fQ/lDsCz+2Pgaa5dct4TykJC0vkBpGwAF0c/+7+WUIg/gPOr
         kFnw==
X-Gm-Message-State: AGRZ1gJn8+oG9z8C6vfc6pvhTrQMKUJJWNXSbJxt3/c+PuJb/Sg4UG0l
        qAMJm60/3ittD9s5huCFqtFbUA==
X-Google-Smtp-Source: AJdET5fzsjx9iC+dbzwJM7VcnPoh5bc5w9V1Txr9UORGlY/GVkTTHqWFQKHmYtAxHIDws5ipPDejkA==
X-Received: by 2002:a2e:1311:: with SMTP id 17-v6mr2885804ljt.70.1540419077508;
        Wed, 24 Oct 2018 15:11:17 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f19-v6sm835350ljc.31.2018.10.24.15.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:11:16 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 4/4] net: ethernet: ti: cpsw: fix vlan configuration while down/up
Date:   Thu, 25 Oct 2018 01:10:59 +0300
Message-Id: <20181024221059.21834-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
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
index 27e0a5d5ccf9..a061a12e3022 100644
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
@@ -1977,9 +1980,23 @@ static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
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

