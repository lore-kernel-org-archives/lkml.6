Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B9C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FBA21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJH8U1PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FBA21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJQCMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:12:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43387 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJQCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:12:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id p34-v6so17729167lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UY3go5N1XkoYGbYQ+I2v/woXzZQofslDCysYUjuM+2c=;
        b=dJH8U1PJ/BNay3RDFioWP26l0qJrNM9u6DCNd1A5aZhrVn5sRESYG4A9S8nG4bHRmR
         dTGIx9Pt0AEHZ1awjb/erEJo9BxfvPZN/oOY1iAgiFZSYLLkEe2S6Ey+YUFWlNpcsZpC
         zL8a95KcAvI9rathAbiZ9TYbzYnA5ZCn0CMPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UY3go5N1XkoYGbYQ+I2v/woXzZQofslDCysYUjuM+2c=;
        b=AoOIdz+TXuaULTG4b2wS2ZPnJhUs8XpInCmfk+tWbQiTn9PapN1cFRpHpLTpGnSX0x
         3RSqgYHYxfSBu6GkXc4eLdd0ISKu6pQoEjgPRqfGVcyhC2KbwhAE3IHhZ9MSTfv/OIL9
         VQ742lwpieLT16ee/IcrPzFlpmznWKaHgUGIO2ntd8kmg+cV9e6iRW57UO9JcgykPs8y
         YbEOv6tLf4REy8YhomjTXqQh3bIrq1sL4oOyFwjUVq+33cpFmXf+vLv+A0Imyqlt+lkm
         JQIzK7ZHI30lKDklyISa5gEIu3Fgtc7TTcOzbLfwAIaZ3n9t24TCgcioPzbw7zpFlSvi
         RJnA==
X-Gm-Message-State: ABuFfohIlIFPLDhP1dBkameAf3+xHCOb9MHsEEkU2HUA4pUsYBSMfLzr
        xvKCBv1Y4ifUsw7iu0/AAq275Q==
X-Google-Smtp-Source: ACcGV60CZa5GeLtVgVoQw02nFMELO2YxKvKGmva2gzIymsL5pKs3TPXKw9s1rJvCd1abhcWzuxmAwA==
X-Received: by 2002:a19:db84:: with SMTP id t4-v6mr7532859lfi.74.1539714039774;
        Tue, 16 Oct 2018 11:20:39 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i27-v6sm3207844lfc.22.2018.10.16.11.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:20:38 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 1/4] net: core: dev_addr_lists: add auxiliary func to handle reference address updates
Date:   Tue, 16 Oct 2018 21:20:32 +0300
Message-Id: <20181016182035.18234-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid all table update, and only remove or add new
address, the auxiliary function exists, named __hw_addr_sync_dev().
It allows end driver do nothing when nothing changed and add/rm when
concrete address is firstly added or lastly removed. But it doesn't
include cases when an address of real device or vlan was reused by
other vlans or vlan/macval devices.

For handaling events when address was reused/unreused the patch adds
new auxiliary routine - __hw_addr_ref_sync_dev(). It allows to do
nothing when nothing was changed and do updates only for an address
being added/reused/deleted/unreused. Thus, clone address changes for
vlans can be mirrored in the table. The function is exclusive with
__hw_addr_sync_dev(). It's responsibility of the end driver to
identify address vlan device, if it needs so.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h | 10 ++++
 net/core/dev_addr_lists.c | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dc1d9ed33b31..de95f96a6352 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4048,6 +4048,16 @@ int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
 		       int (*sync)(struct net_device *, const unsigned char *),
 		       int (*unsync)(struct net_device *,
 				     const unsigned char *));
+int __hw_addr_ref_sync_dev(struct netdev_hw_addr_list *list,
+			   struct net_device *dev,
+			   int (*sync)(struct net_device *,
+				       const unsigned char *, int),
+			   int (*unsync)(struct net_device *,
+					 const unsigned char *, int));
+void __hw_addr_ref_unsync_dev(struct netdev_hw_addr_list *list,
+			      struct net_device *dev,
+			      int (*unsync)(struct net_device *,
+					    const unsigned char *, int));
 void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 			  struct net_device *dev,
 			  int (*unsync)(struct net_device *,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d884d8f5f0e5..1385d75fe5ea 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -277,6 +277,103 @@ int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
 }
 EXPORT_SYMBOL(__hw_addr_sync_dev);
 
+/**
+ *  __hw_addr_ref_sync_dev - Synchronize device's multicast address list taking
+ *  into account references
+ *  @list: address list to synchronize
+ *  @dev:  device to sync
+ *  @sync: function to call if address or reference on it should be added
+ *  @unsync: function to call if address or some reference on it should removed
+ *
+ *  This function is intended to be called from the ndo_set_rx_mode
+ *  function of devices that require explicit address or references on it
+ *  add/remove notifications. The unsync function may be NULL in which case
+ *  the addresses or references on it requiring removal will simply be
+ *  removed without any notification to the device. That is responsibility of
+ *  the driver to identify and distribute address or references on it between
+ *  internal address tables.
+ **/
+int __hw_addr_ref_sync_dev(struct netdev_hw_addr_list *list,
+			   struct net_device *dev,
+			   int (*sync)(struct net_device *,
+				       const unsigned char *, int),
+			   int (*unsync)(struct net_device *,
+					 const unsigned char *, int))
+{
+	struct netdev_hw_addr *ha, *tmp;
+	int err, keep_sync;
+
+	/* first go through and flush out any unsynced/stale entries */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address is not used */
+		if ((ha->sync_cnt << 1) <= ha->refcount)
+			continue;
+
+		/* if fails defer unsyncing address */
+		keep_sync = ha->refcount - ha->sync_cnt;
+		if (unsync && unsync(dev, ha->addr, keep_sync))
+			continue;
+
+		ha->refcount = (keep_sync << 1) + 1;
+		ha->sync_cnt = keep_sync;
+		__hw_addr_del_entry(list, ha, false, false);
+	}
+
+	/* go through and sync updated/new entries to the list */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address added or reused */
+		if ((ha->sync_cnt << 1) >= ha->refcount)
+			continue;
+
+		keep_sync = ha->refcount - ha->sync_cnt;
+		err = sync(dev, ha->addr, keep_sync);
+		if (err)
+			return err;
+
+		ha->refcount = keep_sync << 1;
+		ha->sync_cnt = keep_sync;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__hw_addr_ref_sync_dev);
+
+/**
+ *  __hw_addr_ref_unsync_dev - Remove synchronized addresses and references on
+ *  it from device
+ *  @list: address list to remove synchronized addresses (references on it) from
+ *  @dev:  device to sync
+ *  @unsync: function to call if address and references on it should be removed
+ *
+ *  Remove all addresses that were added to the device by
+ *  __hw_addr_ref_sync_dev(). This function is intended to be called from the
+ *  ndo_stop or ndo_open functions on devices that require explicit address (or
+ *  references on it) add/remove notifications. If the unsync function pointer
+ *  is NULL then this function can be used to just reset the sync_cnt for the
+ *  addresses in the list.
+ **/
+void __hw_addr_ref_unsync_dev(struct netdev_hw_addr_list *list,
+			      struct net_device *dev,
+			      int (*unsync)(struct net_device *,
+					    const unsigned char *, int))
+{
+	struct netdev_hw_addr *ha, *tmp;
+
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		if (!ha->sync_cnt)
+			continue;
+
+		/* if fails defer unsyncing address */
+		if (unsync && unsync(dev, ha->addr, ha->sync_cnt))
+			continue;
+
+		ha->refcount -= ha->sync_cnt - 1;
+		ha->sync_cnt = 0;
+		__hw_addr_del_entry(list, ha, false, false);
+	}
+}
+EXPORT_SYMBOL(__hw_addr_ref_unsync_dev);
+
 /**
  *  __hw_addr_unsync_dev - Remove synchronized addresses from device
  *  @list: address list to remove synchronized addresses from
-- 
2.17.1

