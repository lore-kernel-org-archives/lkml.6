Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CFEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6EE206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdwgnrsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6EE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeKIGIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:08:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44933 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeKIGII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:08:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so19200359lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6h7cGyTcDwoxdKOJu25q1JmarscrLLy/bea2IWaKVw=;
        b=fdwgnrskFVFXQdC2Zsbdp+Y2cJu2gQPi4Y00LnERc5nmYMzNIkNHhdc5nVvDTkvJvP
         dDd9NE7D0UkJ9TQz6oEiK2HxxA7NOa8iAZtfSh34zlFGyAZGWQOQRtSTze/BM9Jx49dp
         ajZDzZsnhZPySHp2CZG8UdMVDLZTJM8UXb0HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j6h7cGyTcDwoxdKOJu25q1JmarscrLLy/bea2IWaKVw=;
        b=aZ1vdpJoge6FsGKngTR/eaiobF/eXK0714GFmLY6w6Cdw5ySy82fN65vHtHQiqhyhD
         /qDAxsCmzczjV4p8wudVGzK0eK8+eUbU+9lZMiWujrGZ2EeLmivULgca5SUnZjIKg3hj
         Aa26BmLBxKZP6/9snZUw6TG2l9g5q6jevAZT3zBZF6RltR7Q8Psb7JT6XnWYIenmAnLV
         XSCA/b9IhoKEnXhmSMOR287mZ4rjTk5kueYiK3pLI6+8moh9oAMjjNjFJCT69v3sV7fR
         I9NORtRRTvfaaEOUNdfT1LfwvOG5t4VBklVCcgdTOTrNlnyl75WRrVyKkcAxqeSid7MY
         IoZw==
X-Gm-Message-State: AGRZ1gLEJc0iSarmYPJg3rrfHbOm98nG59cZgLv1m5TFUh5WElTmLHMu
        s5J4/abhe5qF5XrInx8mWbrukw==
X-Google-Smtp-Source: AJdET5fKkUv3s9riUrhgueQXrA9lEESoHi3WpBDmLQ/aW4Gcq9Xx+nrSMBuwEE82wBuvrBRA3Ki23g==
X-Received: by 2002:a2e:9c59:: with SMTP id t25-v6mr4152333ljj.107.1541709058001;
        Thu, 08 Nov 2018 12:30:58 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w9sm809250lfc.66.2018.11.08.12.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:30:57 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 1/4] net: core: dev_addr_lists: add auxiliary func to handle reference address updates
Date:   Thu,  8 Nov 2018 22:27:54 +0200
Message-Id: <20181108202757.30110-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
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
index 857f8abf7b91..487fa5e0e165 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4068,6 +4068,16 @@ int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
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
index d884d8f5f0e5..81a8cd4ea3bd 100644
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
+	int err, ref_cnt;
+
+	/* first go through and flush out any unsynced/stale entries */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address is not used */
+		if ((ha->sync_cnt << 1) <= ha->refcount)
+			continue;
+
+		/* if fails defer unsyncing address */
+		ref_cnt = ha->refcount - ha->sync_cnt;
+		if (unsync && unsync(dev, ha->addr, ref_cnt))
+			continue;
+
+		ha->refcount = (ref_cnt << 1) + 1;
+		ha->sync_cnt = ref_cnt;
+		__hw_addr_del_entry(list, ha, false, false);
+	}
+
+	/* go through and sync updated/new entries to the list */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address added or reused */
+		if ((ha->sync_cnt << 1) >= ha->refcount)
+			continue;
+
+		ref_cnt = ha->refcount - ha->sync_cnt;
+		err = sync(dev, ha->addr, ref_cnt);
+		if (err)
+			return err;
+
+		ha->refcount = ref_cnt << 1;
+		ha->sync_cnt = ref_cnt;
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

