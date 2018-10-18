Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BDECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BE221480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ywVN6vpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BE221480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeJSCF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BEB21476;
        Thu, 18 Oct 2018 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885832;
        bh=WtF5NOTEi0Pt5/BAvXwJCLWLj+OIPDKX2CT1CtwsZN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywVN6vpauMlG3i3V7Ya9E5cdtztR8U08DcXXUgjYs2HsYHVHtDQeGccdH/DCmqB+6
         rpad3pZO+73lVEb7PDbjtUM9z/oxZClREwMD7Mpr8GTrTrenUbLnuMFE09FBNZkv6V
         6j4pLVnSzum3rDT8U50hld+e6D12gr+18xzu/fWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 03/35] batman-adv: Fix segfault when writing to sysfs elp_interval
Date:   Thu, 18 Oct 2018 19:54:32 +0200
Message-Id: <20181018175422.974032369@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit a25bab9d723a08bd0bdafb1529faf9094c690b70 ]

The per hardif sysfs file "batman_adv/elp_interval" is using the generic
functions to store/show uint values. The helper __batadv_store_uint_attr
requires the softif net_device as parameter to print the resulting change
as info text when the users writes to this file. It uses the helper
function batadv_info to add it at the same time to the kernel ring buffer
and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG is enabled).

The function batadv_info requires as first parameter the batman-adv softif
net_device. This parameter is then used to find the private buffer which
contains the debug log for this batman-adv interface. But
batadv_store_throughput_override used as first argument the slave
net_device. This slave device doesn't have the batadv_priv private data
which is access by batadv_info.

Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
to a segfault or to memory corruption.

Fixes: 0744ff8fa8fa ("batman-adv: Add hard_iface specific sysfs wrapper macros for UINT")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/sysfs.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -187,7 +187,8 @@ ssize_t batadv_store_##_name(struct kobj
 									\
 	return __batadv_store_uint_attr(buff, count, _min, _max,	\
 					_post_func, attr,		\
-					&bat_priv->_var, net_dev);	\
+					&bat_priv->_var, net_dev,	\
+					NULL);	\
 }
 
 #define BATADV_ATTR_SIF_SHOW_UINT(_name, _var)				\
@@ -261,7 +262,9 @@ ssize_t batadv_store_##_name(struct kobj
 									\
 	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
 					  _post_func, attr,		\
-					  &hard_iface->_var, net_dev);	\
+					  &hard_iface->_var,		\
+					  hard_iface->soft_iface,	\
+					  net_dev);			\
 									\
 	batadv_hardif_put(hard_iface);				\
 	return length;							\
@@ -355,10 +358,12 @@ __batadv_store_bool_attr(char *buff, siz
 
 static int batadv_store_uint_attr(const char *buff, size_t count,
 				  struct net_device *net_dev,
+				  struct net_device *slave_dev,
 				  const char *attr_name,
 				  unsigned int min, unsigned int max,
 				  atomic_t *attr)
 {
+	char ifname[IFNAMSIZ + 3] = "";
 	unsigned long uint_val;
 	int ret;
 
@@ -384,8 +389,11 @@ static int batadv_store_uint_attr(const
 	if (atomic_read(attr) == uint_val)
 		return count;
 
-	batadv_info(net_dev, "%s: Changing from: %i to: %lu\n",
-		    attr_name, atomic_read(attr), uint_val);
+	if (slave_dev)
+		snprintf(ifname, sizeof(ifname), "%s: ", slave_dev->name);
+
+	batadv_info(net_dev, "%s: %sChanging from: %i to: %lu\n",
+		    attr_name, ifname, atomic_read(attr), uint_val);
 
 	atomic_set(attr, uint_val);
 	return count;
@@ -396,12 +404,13 @@ static ssize_t __batadv_store_uint_attr(
 					void (*post_func)(struct net_device *),
 					const struct attribute *attr,
 					atomic_t *attr_store,
-					struct net_device *net_dev)
+					struct net_device *net_dev,
+					struct net_device *slave_dev)
 {
 	int ret;
 
-	ret = batadv_store_uint_attr(buff, count, net_dev, attr->name, min, max,
-				     attr_store);
+	ret = batadv_store_uint_attr(buff, count, net_dev, slave_dev,
+				     attr->name, min, max, attr_store);
 	if (post_func && ret)
 		post_func(net_dev);
 
@@ -570,7 +579,7 @@ static ssize_t batadv_store_gw_sel_class
 	return __batadv_store_uint_attr(buff, count, 1, BATADV_TQ_MAX_VALUE,
 					batadv_post_gw_reselect, attr,
 					&bat_priv->gw.sel_class,
-					bat_priv->soft_iface);
+					bat_priv->soft_iface, NULL);
 }
 
 static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,


