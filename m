Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A365C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266D0208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266D0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeKPHy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:54:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbeKPHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:54:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAFLiRqe072169
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:44:52 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nsent83r2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:44:52 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <julietk@linux.vnet.ibm.com>;
        Thu, 15 Nov 2018 21:44:52 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 21:44:47 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAFLikwj19202070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 21:44:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89E7C6E052;
        Thu, 15 Nov 2018 21:44:46 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71236E04C;
        Thu, 15 Nov 2018 21:44:45 +0000 (GMT)
Received: from juliets-mbp.austin.ibm.com (unknown [9.41.179.214])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 15 Nov 2018 21:44:45 +0000 (GMT)
To:     linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From:   Juliet Kim <julietk@linux.vnet.ibm.com>
Subject: [PATCH] net/ibmnvic: Fix deadlock problem in reset
Date:   Thu, 15 Nov 2018 15:44:44 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18111521-0004-0000-0000-000014B33762
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010057; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117969; UDB=6.00579908; IPR=6.00898078;
 MB=3.00024183; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-15 21:44:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111521-0005-0000-0000-000089861661
Message-Id: <25faa351-51d3-3aeb-a1c9-e8d3259604dd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] net/ibmnvic: Fix deadlock problem in reset

From: Juliet Kim <julietk@linux.vnet.ibm.com>

This patch changes to use rtnl_lock only during a reset to avoid
deadlock that could occur when a thread operating close is holding
rtnl_lock and waiting for reset_lock acquired by another thread,
which is waiting for rtnl_lock in order to set the number of tx/rx
queues during a reset.

Also, we now setting the number of tx/rx queues during a soft reset
for failover or LPM events.

Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
---
  drivers/net/ethernet/ibm/ibmvnic.c |   59 
+++++++++++++-----------------------
  drivers/net/ethernet/ibm/ibmvnic.h |    2 +
  2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c 
b/drivers/net/ethernet/ibm/ibmvnic.c
index 7893bef..4a5de59 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1103,20 +1103,15 @@ static int ibmvnic_open(struct net_device *netdev)
         return 0;
     }

-   mutex_lock(&adapter->reset_lock);
-
     if (adapter->state != VNIC_CLOSED) {
         rc = ibmvnic_login(netdev);
-       if (rc) {
-           mutex_unlock(&adapter->reset_lock);
+       if (rc)
             return rc;
-       }

         rc = init_resources(adapter);
         if (rc) {
             netdev_err(netdev, "failed to initialize resources\n");
             release_resources(adapter);
-           mutex_unlock(&adapter->reset_lock);
             return rc;
         }
     }
@@ -1124,8 +1119,6 @@ static int ibmvnic_open(struct net_device *netdev)
     rc = __ibmvnic_open(netdev);
     netif_carrier_on(netdev);

-   mutex_unlock(&adapter->reset_lock);
-
     return rc;
  }

@@ -1269,10 +1262,8 @@ static int ibmvnic_close(struct net_device *netdev)
         return 0;
     }

-   mutex_lock(&adapter->reset_lock);
     rc = __ibmvnic_close(netdev);
     ibmvnic_cleanup(netdev);
-   mutex_unlock(&adapter->reset_lock);

     return rc;
  }
@@ -1820,20 +1811,15 @@ static int do_reset(struct ibmvnic_adapter *adapter,
                 return rc;
         } else if (adapter->req_rx_queues != old_num_rx_queues ||
                adapter->req_tx_queues != old_num_tx_queues) {
-           adapter->map_id = 1;
             release_rx_pools(adapter);
             release_tx_pools(adapter);
-           rc = init_rx_pools(netdev);
-           if (rc)
-               return rc;
-           rc = init_tx_pools(netdev);
-           if (rc)
-               return rc;
-
             release_napi(adapter);
-           rc = init_napi(adapter);
+           release_vpd_data(adapter);
+
+           rc = init_resources(adapter);
             if (rc)
                 return rc;
+
         } else {
             rc = reset_tx_pools(adapter);
             if (rc)
@@ -1917,17 +1903,8 @@ static int do_hard_reset(struct ibmvnic_adapter 
*adapter,
         adapter->state = VNIC_PROBED;
         return 0;
     }
-   /* netif_set_real_num_xx_queues needs to take rtnl lock here
-    * unless wait_for_reset is set, in which case the rtnl lock
-    * has already been taken before initializing the reset
-    */
-   if (!adapter->wait_for_reset) {
-       rtnl_lock();
-       rc = init_resources(adapter);
-       rtnl_unlock();
-   } else {
-       rc = init_resources(adapter);
-   }
+
+   rc = init_resources(adapter);
     if (rc)
         return rc;

@@ -1986,13 +1963,21 @@ static void __ibmvnic_reset(struct work_struct 
*work)
     struct ibmvnic_rwi *rwi;
     struct ibmvnic_adapter *adapter;
     struct net_device *netdev;
+   bool we_lock_rtnl = false;
     u32 reset_state;
     int rc = 0;

     adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
     netdev = adapter->netdev;

-   mutex_lock(&adapter->reset_lock);
+   /* netif_set_real_num_xx_queues needs to take rtnl lock here
+    * unless wait_for_reset is set, in which case the rtnl lock
+    * has already been taken before initializing the reset
+    */
+   if (!adapter->wait_for_reset) {
+       rtnl_lock();
+       we_lock_rtnl = true;
+   }

     reset_state = adapter->state;


     rwi = get_next_rwi(adapter);
@@ -2020,12 +2005,11 @@ static void __ibmvnic_reset(struct work_struct 
*work)
     if (rc) {
         netdev_dbg(adapter->netdev, "Reset failed\n");
         free_all_rwi(adapter);
-       mutex_unlock(&adapter->reset_lock);
-       return;
     }

     adapter->resetting = false;
-   mutex_unlock(&adapter->reset_lock);
+   if (we_lock_rtnl)
+       rtnl_unlock();
  }

  static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
@@ -4768,7 +4752,6 @@ static int ibmvnic_probe(struct vio_dev *dev, 
const struct vio_device_id *id)

     INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
     INIT_LIST_HEAD(&adapter->rwi_list);
-   mutex_init(&adapter->reset_lock);
     mutex_init(&adapter->rwi_lock);
     adapter->resetting = false;

@@ -4840,8 +4823,8 @@ static int ibmvnic_remove(struct vio_dev *dev)
     struct ibmvnic_adapter *adapter = netdev_priv(netdev);

     adapter->state = VNIC_REMOVING;
-   unregister_netdev(netdev);
-   mutex_lock(&adapter->reset_lock);
+   rtnl_lock();
+   unregister_netdevice(netdev);

     release_resources(adapter);
     release_sub_crqs(adapter, 1);
@@ -4852,7 +4835,7 @@ static int ibmvnic_remove(struct vio_dev *dev)

     adapter->state = VNIC_REMOVED;

-   mutex_unlock(&adapter->reset_lock);
+   rtnl_unlock();
     device_remove_file(&dev->dev, &dev_attr_failover);
     free_netdev(netdev);
     dev_set_drvdata(&dev->dev, NULL);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h 
b/drivers/net/ethernet/ibm/ibmvnic.h
index 18103b8..99c4f8d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1075,7 +1075,7 @@ struct ibmvnic_adapter {
     struct tasklet_struct tasklet;
     enum vnic_state state;
     enum ibmvnic_reset_reason reset_reason;
-   struct mutex reset_lock, rwi_lock;
+   struct mutex rwi_lock;
     struct list_head rwi_list;
     struct work_struct ibmvnic_reset;
     bool resetting;

