Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79886C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39365204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si90Rq1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39365204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJQCMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:12:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39273 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQCMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:12:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id n14-v6so5884359lfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMvp12l9HpDMt+3I+o7Ztx63A+0YQDl6lBkSGcvnOGY=;
        b=Si90Rq1sZ31V16S2ywoKtMnwHKjTBjCvpfPLoTDD5pjncIPiQhJaQ5/skVfJEiUwQk
         /vL4E225IMom3GkKtza2Q2O/P0cfzc60X8dognBpB7GKSv/7RgDmK6CJOAmxmQdDz/Uf
         BqqNBHmdSq/oMECjFfzpYMndPPbHMYGrM9nfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMvp12l9HpDMt+3I+o7Ztx63A+0YQDl6lBkSGcvnOGY=;
        b=DZnfUsGKwMmItj11dRryN0q7807ZpU3NAFDynO1St895qfBp4AEM/kv1+dWPpup3Mb
         uD/qeWdKRFQRMG43+5ppBubTuNfv8cqP5ij/QEa2nOLQPWEweLACmKWiudL1yiyqtvL7
         RCS9GGpSJrqiOERQmKThatfkRoI1B1ujrJdry3a/QI3XOH9Yci+ts2k1HzfEjQ640VgA
         4J3HBtUz8gDbbBCtzSdxXs6+AvU7itL3GZ3hpk8i1bhUbEMcFPp1YjON4zRF7y8wxZOF
         JQ4Ui+3kWaWg/nJwKiOaIztTUPObS5mMFt0CmV3EPB3Rq6SK4VC21PqL9BYht/GqZirI
         rxyQ==
X-Gm-Message-State: ABuFfoieiMAss2h4daxligXCQSfRDKFO4H3nzdYehkxoVOqLHEyecUcM
        juwA7JqMMRWFVFKbnFCaE9sCsQ==
X-Google-Smtp-Source: ACcGV636YVIqaEbfmz9GrOpTlGYH3VaxLwnCgFnnjda6yOYI2/JVPYRndNAZ+j/SnLlgWe4keGW8lg==
X-Received: by 2002:a19:480c:: with SMTP id v12-v6mr13279098lfa.46.1539714041252;
        Tue, 16 Oct 2018 11:20:41 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i27-v6sm3207844lfc.22.2018.10.16.11.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:20:40 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of vlans for real device
Date:   Tue, 16 Oct 2018 21:20:33 +0300
Message-Id: <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's redundancy for the drivers to hold the list of vlans when
absolutely the same list exists in vlan core. In most cases it's
needed only to traverse the vlan devices, their vids and sync some
settings with h/w, so add API to simplify this.

At least some of these drivers also can benefit:
grep "for_each.*vid" -r drivers/net/ethernet/

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:
drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:
drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:
drivers/net/ethernet/via/via-rhine.c:
drivers/net/ethernet/via/via-velocity.c:
drivers/net/ethernet/intel/igb/igb_main.c:
drivers/net/ethernet/intel/ice/ice_main.c:
drivers/net/ethernet/intel/e1000/e1000_main.c:
drivers/net/ethernet/intel/i40e/i40e_main.c:
drivers/net/ethernet/intel/e1000e/netdev.c:
drivers/net/ethernet/intel/igbvf/netdev.c:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:
drivers/net/ethernet/intel/ixgb/ixgb_main.c:
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
drivers/net/ethernet/amd/xgbe/xgbe-dev.c:
drivers/net/ethernet/emulex/benet/be_main.c:
drivers/net/ethernet/neterion/vxge/vxge-main.c:
drivers/net/ethernet/adaptec/starfire.c:
drivers/net/ethernet/brocade/bna/bnad.c:

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h | 10 ++++++++++
 net/8021q/vlan_core.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 83ea4df6ab81..4ae3993f7166 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -133,6 +133,9 @@ struct vlan_pcpu_stats {
 
 extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
 					       __be16 vlan_proto, u16 vlan_id);
+extern int vlan_for_each(struct net_device *dev,
+			 int (*action)(struct net_device *dev, int vid,
+				       void *arg), void *arg);
 extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
 extern u16 vlan_dev_vlan_id(const struct net_device *dev);
 extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
@@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
 	return NULL;
 }
 
+static inline int
+vlan_for_each(struct net_device *dev,
+	      int (*action)(struct net_device *dev, int vid, void *arg),
+	      void *arg)
+{
+}
+
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
 	BUG();
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 4f60e86f4b8d..6308b5427a66 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -223,6 +223,33 @@ static int vlan_kill_rx_filter_info(struct net_device *dev, __be16 proto, u16 vi
 		return -ENODEV;
 }
 
+int vlan_for_each(struct net_device *dev,
+		  int (*action)(struct net_device *dev, int vid, void *arg),
+		  void *arg)
+{
+	struct vlan_vid_info *vid_info;
+	struct vlan_info *vlan_info;
+	struct net_device *vdev;
+	int ret;
+
+	ASSERT_RTNL();
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	if (!vlan_info)
+		return 0;
+
+	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		vdev = vlan_group_get_device(&vlan_info->grp, vid_info->proto,
+					     vid_info->vid);
+		ret = action(vdev, vid_info->vid, arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(vlan_for_each);
+
 int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto)
 {
 	struct net_device *real_dev = vlan_info->real_dev;
-- 
2.17.1

