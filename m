Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934677AbeEIJbJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:31:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeEIJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:30:50 -0400
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH IB/core 1/2] IB/core: A full pkey is required to match a limited one
Date: Wed,  9 May 2018 11:30:19 +0200
Message-Id: <20180509093020.24503-2-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
References: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=922
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ib_find_cached_pkey(), the preference is to return the pkey-index
of the full pkey, if both a limited and the full exists in the cache.

However, if both pkeys are limited, the function return success.

To detect if two pkeys are eligible for communication,
ib_find_matched_cached_pkey() is introduced, which requires at least
one of the pkeys to be a full member, in order to return success.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c | 32 +++++++++++++++++++++++++++-----
 include/rdma/ib_cache.h         | 18 ++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index fb2d347f760f..cb7e9818a226 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -983,10 +983,11 @@ int ib_get_cached_subnet_prefix(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
 
-int ib_find_cached_pkey(struct ib_device *device,
-			u8                port_num,
-			u16               pkey,
-			u16              *index)
+static int __ib_find_cached_pkey(struct ib_device *device,
+				 u8                port_num,
+				 u16               pkey,
+				 u16              *index,
+				 bool allow_lim_to_lim_match)
 {
 	struct ib_pkey_cache *cache;
 	unsigned long flags;
@@ -1013,7 +1014,11 @@ int ib_find_cached_pkey(struct ib_device *device,
 				partial_ix = i;
 		}
 
-	if (ret && partial_ix >= 0) {
+	/*
+	 * If table content is limited, pkey must be full to match,
+	 * unless allow_lim_to_lim_match is set
+	 */
+	if (ret && partial_ix >= 0 && (pkey & 0x8000 || allow_lim_to_lim_match)) {
 		*index = partial_ix;
 		ret = 0;
 	}
@@ -1022,6 +1027,23 @@ int ib_find_cached_pkey(struct ib_device *device,
 
 	return ret;
 }
+
+int ib_find_matched_cached_pkey(struct ib_device *device,
+				u8                port_num,
+				u16               pkey,
+				u16              *index)
+{
+	return __ib_find_cached_pkey(device, port_num, pkey, index, false);
+}
+EXPORT_SYMBOL(ib_find_matched_cached_pkey);
+
+int ib_find_cached_pkey(struct ib_device *device,
+			u8                port_num,
+			u16               pkey,
+			u16              *index)
+{
+	return __ib_find_cached_pkey(device, port_num, pkey, index, true);
+}
 EXPORT_SYMBOL(ib_find_cached_pkey);
 
 int ib_find_exact_cached_pkey(struct ib_device *device,
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index eb49cc8d1f95..748bd27559b6 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -92,6 +92,24 @@ int ib_get_cached_pkey(struct ib_device    *device_handle,
 		       u16                 *pkey);
 
 /**
+ * ib_find_matched_cached_pkey - Returns the PKey table index where a
+ * specified PKey value occurs. Success requires at least one of the
+ * PKeys to be a full-member.
+ * @device: The device to query.
+ * @port_num: The port number of the device to search for the PKey.
+ * @pkey: The PKey value to search for.
+ * @index: The index into the cached PKey table where the PKey was found.
+ *
+ * ib_find_matched_cached_pkey() searches the specified PKey table in
+ * the local software cache and return success unless both PKeys are
+ * limited.
+ */
+int ib_find_matched_cached_pkey(struct ib_device    *device,
+				u8		     port_num,
+				u16		     pkey,
+				u16		    *index);
+
+/**
  * ib_find_cached_pkey - Returns the PKey table index where a specified
  *   PKey value occurs.
  * @device: The device to query.
-- 
2.13.6
