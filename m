Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45348206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XufzLPeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45348206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKIGIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:08:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44934 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKIGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:08:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so19200426lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8QdsjuBuNR4syD4kYHeYJE3yp+I/xfPRdcYr33cc40E=;
        b=XufzLPeCqLvabFv/vXBBK9r+yrpq47Q+NRR/7PiXHDl3QB+5W+c2pF3Aiu7RewOUeK
         aCnxJzZwU1wqQ1kkvzysaOOCIyii+vi3OEaV/wq6kSyKH6WLmOD3SNv8KEBVlRUYQVpd
         YHTJXAvj/NxuP6RcxA6EPGYLbjuU1KOKfnEyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8QdsjuBuNR4syD4kYHeYJE3yp+I/xfPRdcYr33cc40E=;
        b=r8By9E/QhXceV70F8uCIO6i9Y6IyiDVSG0MFFArY1BpxJoI6IAWH0TXZuwSaTrqKvW
         omYau5yiYcUM6tQDRy5+cTVJsnqNdNhmFSDsDGByQLAu89wDxezdjn7jJOfIen5UNOEX
         uEhpAdBN8GeJq7Ip46Q+4o9NCtMZVoJCGqt8JzLMKOrn3mfXkOegiFaIr3XNBGygl637
         rA2L4MonhN/AjgXwf4vE+fr/xPe4zfAhgLw7Jbmeb/TcBZ0uzRfe047yVK7UHcWAOTaV
         aYwPjr3xf/T46NsmjW/0U1fN/+eAQEnivB0NydJB/cu0O/5TRVdHpUqqUnZZKD64/eDP
         iFRA==
X-Gm-Message-State: AGRZ1gIrPqaIsHzDUC9aEf39RfztpHcklRCUgcOhQBuweuIM69FCXeSa
        +4E1qgE3JINvlSw/rFonl4sXvA==
X-Google-Smtp-Source: AJdET5crCkfP8Lb8xh9AJITif4hBPto7bJkJln6PavkKWDFY2p5UMnon/6XQ+xq3CeYWnjm6S6F9jg==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr3725823ljj.95.1541709059378;
        Thu, 08 Nov 2018 12:30:59 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w9sm809250lfc.66.2018.11.08.12.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:30:58 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 2/4] net: 8021q: vlan_core: allow use list of vlans for real device
Date:   Thu,  8 Nov 2018 22:27:55 +0200
Message-Id: <20181108202757.30110-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
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
index 03b08ffded07..1be5230921b5 100644
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

