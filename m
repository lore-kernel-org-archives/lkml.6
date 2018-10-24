Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1252ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97782082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggodCmSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97782082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJYGl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:41:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39718 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeJYGlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:41:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id p11-v6so5192065lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kt0ifiviCYm9e+arNneTDb/upc83BNkTvPy8eJnbc1A=;
        b=ggodCmSyrpsvTrMb5CjscBt0YsKysH+YCtsFI/jgJVBzUDXK2BPABys6p8rLaw0i2p
         aVqW20qx6zqgqdUjnGTxhIaHhaRXcP9YIP74tW8Tt/c4akq5mmCUZGsfZTjfADXyQyxQ
         6G3hGh+dTm83w3pV9VJL+U8KALfm8X2QtQIAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kt0ifiviCYm9e+arNneTDb/upc83BNkTvPy8eJnbc1A=;
        b=fjMcF8Vk6ST31HRbGf3Vf3AwEnCNWQYqKwPJ9NSJjf06a0U/qdFqCglHcinyzJx5Ht
         jSz9jmiLpG5ngPDk76vr8yMxF516jhWqmHVImHFhfpUJ964PA/1Zonn9q7VmWopihzl+
         xkWZmZhv0FWFome0CrAupaIaFzLXk71B/2fw0YSw2gCy0Uq0YSqhnnMSElPDH8OQkeZz
         S0OmB4vIiz708SVqpZ1X74kAgidwyEq2BhiD64NO2+xbtSbzsgo7G6/AP/QBHKDPtzWO
         5qZl0LyJUyAJNPglyhRcd1ZJl01iwqCLEr/9mna4mUZwkzKTqS+I+4RMpdpUwEknqDjK
         Zs/w==
X-Gm-Message-State: AGRZ1gIAXdUgvMiu6znmmwPEB3MqUwQVsqdRMYY50rKQDFPBYOKD6XYs
        AWlCMUxE3uVH/1Dym0uimRce+Q==
X-Google-Smtp-Source: AJdET5d0ozkN75m3uQwtPQvWSEg05ubG+jS6KC3Dg33JU0cO9IWaG+68UehrTV9t7yQsG7N592njGg==
X-Received: by 2002:a19:d824:: with SMTP id p36-v6mr73317lfg.23.1540419074714;
        Wed, 24 Oct 2018 15:11:14 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f19-v6sm835350ljc.31.2018.10.24.15.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:11:13 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of vlans for real device
Date:   Thu, 25 Oct 2018 01:10:57 +0300
Message-Id: <20181024221059.21834-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
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

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h | 11 +++++++++++
 net/8021q/vlan_core.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 83ea4df6ab81..410a14cd856c 100644
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
@@ -236,6 +239,14 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
 	return NULL;
 }
 
+static inline int
+vlan_for_each(struct net_device *dev,
+	      int (*action)(struct net_device *dev, int vid, void *arg),
+	      void *arg)
+{
+	return 0;
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

