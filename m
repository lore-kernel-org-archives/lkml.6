Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDaUcT9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A70420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeINMrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7Sc4w121529;
        Fri, 14 Sep 2018 07:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=4GW0XAsEXLHCLW95OjpQtKQbSk369oM3/1gNP6/Abao=;
 b=kDaUcT9wENSVpftt5Ws0etiNESWMkDBo1tnGrOLDeEohdRJPcH1pzyqPWJw1llHgG53f
 5DH5rZ+jIC6WiVEXT47J8e7hjrnpDQbi1ZRsyr2P/dQkmKzR5H6N3L3CPiJkDrlE+YNs
 /SkwcokdHvtJyvfXhcyzGSwihop6wGwzLhP7YZBeO9Vh8iSvE+2htQDwcykDNaFHc0mY
 BcBrlbhtrAOJg/fA/8YNbw2hZyGUJhh7uDSniQ5pvqKGXaaSBbvF/5VKR1/5tVIZKgo7
 WTU8sktsAeF8Sj5qUudbu3unxfraAZaRaLoRUTvCLEl9JZS1ytMWrrBYPtj01WtkUOWI gQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mc6cq5dk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:34:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7Xu7g019572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:56 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8E7Xtuj001271;
        Fri, 14 Sep 2018 07:33:55 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:33:55 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 3/6] xenbus: dispatch per-domU watch event to per-domU xenwatch thread
Date:   Fri, 14 Sep 2018 15:34:13 +0800
Message-Id: <1536910456-13337-4-git-send-email-dongli.zhang@oracle.com>
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

This is the 3rd patch of a (6-patch) patch set.

This patch dispatches the watch event to per-domU xenwatch thread when the
event meets all of below conditions:

1. The watch is registered to use xenwatch multithreading feature and the
   get_domid() method returns valid domid.
2. There is xenwatch thread (mtwatch domain) available for the domid
   obtained from get_domid() method.
3. The xenwatch thread is forked successfully by kthread_run() during
   initialization and therefore its state should be MTWATCH_DOMAIN_UP.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 53 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 741dc54..7335e19 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -896,6 +896,32 @@ static struct xenbus_watch *find_watch(const char *token)
 	return NULL;
 }
 
+static int xs_watch_insert_event(struct xs_watch_event *event, domid_t domid)
+{
+	struct mtwatch_domain *domain;
+	int ret = -1;
+
+	rcu_read_lock();
+
+	domain = mtwatch_find_domain(domid);
+	if (!domain) {
+		rcu_read_unlock();
+		return ret;
+	}
+
+	spin_lock(&domain->events_lock);
+	if (domain->state == MTWATCH_DOMAIN_UP) {
+		list_add_tail(&event->list, &domain->events);
+		wake_up(&domain->events_wq);
+		ret = 0;
+	}
+	spin_unlock(&domain->events_lock);
+
+	rcu_read_unlock();
+
+	return ret;
+}
+
 int xs_watch_msg(struct xs_watch_event *event)
 {
 	if (count_strings(event->body, event->len) != 2) {
@@ -908,10 +934,29 @@ int xs_watch_msg(struct xs_watch_event *event)
 	spin_lock(&watches_lock);
 	event->handle = find_watch(event->token);
 	if (event->handle != NULL) {
-		spin_lock(&watch_events_lock);
-		list_add_tail(&event->list, &watch_events);
-		wake_up(&watch_events_waitq);
-		spin_unlock(&watch_events_lock);
+		domid_t domid = 0;
+
+		if (xen_mtwatch && event->handle->get_domid)
+			domid = event->handle->get_domid(event->handle,
+							 event->path,
+							 event->token);
+
+		/*
+		 * The event is processed by default xenwatch thread if:
+		 *
+		 * 1. The watch does not use xenwatch multithreading.
+		 * 2. There is no per-domU xenwatch thread (or mtwatch
+		 *    domain) available for this domid.
+		 * 3. The per-domU xenwatch thread is not created
+		 *    successfully by kthread_run() during initialization.
+		 */
+		if (!(domid &&
+		      xs_watch_insert_event(event, domid) == 0)) {
+			spin_lock(&watch_events_lock);
+			list_add_tail(&event->list, &watch_events);
+			wake_up(&watch_events_waitq);
+			spin_unlock(&watch_events_lock);
+		}
 	} else
 		kfree(event);
 	spin_unlock(&watches_lock);
-- 
2.7.4

