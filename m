Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D3C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660AD20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="INrYQ7WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660AD20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeINMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7SdhD101657;
        Fri, 14 Sep 2018 07:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rmlSwTgRO73T2BE2nhVwhf7PmjgUIM0FjLaj95+Aheo=;
 b=INrYQ7WCENDUlr/oPIPhAEzUbUxQhFHdrTpUItWP/m89/MbdGasltBVVrfp+Jd3eCgBK
 X+Ud1yTWIhNefII+Tp3YI9WZDLSS25CBEBgVkvihhZoTK/hhCkUvhu95z/3MYCyPSXw8
 8ur8MgdpOxxr0Cr/8Gc9JF0AGvnWBgeFh70H7i9EHlUVZkH7m4oTxfynaE14Sa11XpdI
 y0qVdwA11AA90HIp7FFdiPFW974I6QKq2zGb9O1tCCxvwlQx04WdImU/hnMV1bmley1X
 R7m6CqcAM8j5P2Aojy/3Wjm2lOXlHoMxtro5KsAU7sS9V/ubgTow40ifJBJjjWA37DYU 2w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5utwe01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:34:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7Y1kx014926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:34:01 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8E7Y1Nm001301;
        Fri, 14 Sep 2018 07:34:01 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:34:01 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 5/6] xenbus: process be_watch events in xenwatch multithreading
Date:   Fri, 14 Sep 2018 15:34:15 +0800
Message-Id: <1536910456-13337-6-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 5th patch of a (6-patch) patch set.

With this patch, watch event in relative path pattern
'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
thread.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/xen/xenbus/xenbus_probe.c         |  2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
 include/xen/xenbus.h                      |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index ba0644c..aa1b15a 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(xenbus_probe_devices);
 
-static unsigned int char_count(const char *str, char c)
+unsigned int char_count(const char *str, char c)
 {
 	unsigned int i, ret = 0;
 
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4f..50df86a 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
 	xenbus_dev_changed(path, &xenbus_backend);
 }
 
+static domid_t path_to_domid(const char *path)
+{
+	const char *p = path;
+	domid_t domid = 0;
+
+	while (*p) {
+		if (*p < '0' || *p > '9')
+			break;
+		domid = (domid << 3) + (domid << 1) + (*p - '0');
+		p++;
+	}
+
+	return domid;
+}
+
+/* path: backend/<pvdev>/<domid>/... */
+static domid_t be_get_domid(struct xenbus_watch *watch,
+			    const char *path,
+			    const char *token)
+{
+	const char *p = path;
+
+	if (char_count(path, '/') < 2)
+		return 0;
+
+	p = strchr(p, '/') + 1;
+	p = strchr(p, '/') + 1;
+
+	return path_to_domid(p);
+}
+
 static struct xenbus_watch be_watch = {
 	.node = "backend",
 	.callback = backend_changed,
+	.get_domid = be_get_domid,
 };
 
 static int read_frontend_details(struct xenbus_device *xendev)
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 4ac2cee..79d784e 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -241,6 +241,8 @@ extern const struct file_operations xen_xenbus_fops;
 extern struct xenstore_domain_interface *xen_store_interface;
 extern int xen_store_evtchn;
 
+unsigned int char_count(const char *str, char c);
+
 void mtwatch_create_domain(domid_t domid);
 void mtwatch_put_domain(domid_t domid);
 
-- 
2.7.4

