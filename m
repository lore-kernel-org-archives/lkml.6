Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1184C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F14214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfAJOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:25:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:50222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfAJOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:25:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 06:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="108859438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2019 06:25:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E133108; Thu, 10 Jan 2019 16:25:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org
Subject: [PATCH v2] vmbus: Switch to use new generic UUID API
Date:   Thu, 10 Jan 2019 16:25:32 +0200
Message-Id: <20190110142532.52067-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: devel@linuxdriverproject.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2:
- leave uapi untouched (Christoph, Haiyang)
- rebase on top of latest linux-next

 drivers/hv/channel.c      |  4 +-
 drivers/hv/channel_mgmt.c | 18 +++----
 drivers/hv/hyperv_vmbus.h |  4 +-
 drivers/hv/vmbus_drv.c    | 48 +++++++------------
 include/linux/hyperv.h    | 98 +++++++++++++++++++--------------------
 5 files changed, 79 insertions(+), 93 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ce0ba2062723..7f3f9994e55e 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -282,8 +282,8 @@ int vmbus_open(struct vmbus_channel *newchannel,
 EXPORT_SYMBOL_GPL(vmbus_open);
 
 /* Used for Hyper-V Socket: a guest client's connect() to the host */
-int vmbus_send_tl_connect_request(const uuid_le *shv_guest_servie_id,
-				  const uuid_le *shv_host_servie_id)
+int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
+				  const guid_t *shv_host_servie_id)
 {
 	struct vmbus_channel_tl_connect_request conn_msg;
 	int ret;
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index d01689079e9b..62703b354d6d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -141,7 +141,7 @@ static const struct vmbus_device vmbus_devs[] = {
 };
 
 static const struct {
-	uuid_le guid;
+	guid_t guid;
 } vmbus_unsupported_devs[] = {
 	{ HV_AVMA1_GUID },
 	{ HV_AVMA2_GUID },
@@ -171,26 +171,26 @@ static void vmbus_rescind_cleanup(struct vmbus_channel *channel)
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 }
 
-static bool is_unsupported_vmbus_devs(const uuid_le *guid)
+static bool is_unsupported_vmbus_devs(const guid_t *guid)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vmbus_unsupported_devs); i++)
-		if (!uuid_le_cmp(*guid, vmbus_unsupported_devs[i].guid))
+		if (guid_equal(guid, &vmbus_unsupported_devs[i].guid))
 			return true;
 	return false;
 }
 
 static u16 hv_get_dev_type(const struct vmbus_channel *channel)
 {
-	const uuid_le *guid = &channel->offermsg.offer.if_type;
+	const guid_t *guid = &channel->offermsg.offer.if_type;
 	u16 i;
 
 	if (is_hvsock_channel(channel) || is_unsupported_vmbus_devs(guid))
 		return HV_UNKNOWN;
 
 	for (i = HV_IDE; i < HV_UNKNOWN; i++) {
-		if (!uuid_le_cmp(*guid, vmbus_devs[i].guid))
+		if (guid_equal(guid, &vmbus_devs[i].guid))
 			return i;
 	}
 	pr_info("Unknown GUID: %pUl\n", guid);
@@ -561,10 +561,10 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	atomic_dec(&vmbus_connection.offer_in_progress);
 
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (!uuid_le_cmp(channel->offermsg.offer.if_type,
-				 newchannel->offermsg.offer.if_type) &&
-		    !uuid_le_cmp(channel->offermsg.offer.if_instance,
-				 newchannel->offermsg.offer.if_instance)) {
+		if (guid_equal(&channel->offermsg.offer.if_type,
+			       &newchannel->offermsg.offer.if_type) &&
+		    guid_equal(&channel->offermsg.offer.if_instance,
+			       &newchannel->offermsg.offer.if_instance)) {
 			fnew = false;
 			break;
 		}
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index a1f6ce6e5974..cb86b133eb4d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -312,8 +312,8 @@ extern const struct vmbus_channel_message_table_entry
 
 /* General vmbus interface */
 
-struct hv_device *vmbus_device_create(const uuid_le *type,
-				      const uuid_le *instance,
+struct hv_device *vmbus_device_create(const guid_t *type,
+				      const guid_t *instance,
 				      struct vmbus_channel *channel);
 
 int vmbus_device_register(struct hv_device *child_device_obj);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 403fee01572c..126c2de39e35 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -654,38 +654,28 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
 	return ret;
 }
 
-static const uuid_le null_guid;
-
-static inline bool is_null_guid(const uuid_le *guid)
-{
-	if (uuid_le_cmp(*guid, null_guid))
-		return false;
-	return true;
-}
-
 static const struct hv_vmbus_device_id *
-hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const uuid_le *guid)
-
+hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const guid_t *guid)
 {
 	if (id == NULL)
 		return NULL; /* empty device table */
 
-	for (; !is_null_guid(&id->guid); id++)
-		if (!uuid_le_cmp(id->guid, *guid))
+	for (; !guid_is_null(&id->guid); id++)
+		if (guid_equal(&id->guid, guid))
 			return id;
 
 	return NULL;
 }
 
 static const struct hv_vmbus_device_id *
-hv_vmbus_dynid_match(struct hv_driver *drv, const uuid_le *guid)
+hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid)
 {
 	const struct hv_vmbus_device_id *id = NULL;
 	struct vmbus_dynid *dynid;
 
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (!uuid_le_cmp(dynid->id.guid, *guid)) {
+		if (guid_equal(&dynid->id.guid, guid)) {
 			id = &dynid->id;
 			break;
 		}
@@ -695,9 +685,7 @@ hv_vmbus_dynid_match(struct hv_driver *drv, const uuid_le *guid)
 	return id;
 }
 
-static const struct hv_vmbus_device_id vmbus_device_null = {
-	.guid = NULL_UUID_LE,
-};
+static const struct hv_vmbus_device_id vmbus_device_null;
 
 /*
  * Return a matching hv_vmbus_device_id pointer.
@@ -706,7 +694,7 @@ static const struct hv_vmbus_device_id vmbus_device_null = {
 static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
 							struct hv_device *dev)
 {
-	const uuid_le *guid = &dev->dev_type;
+	const guid_t *guid = &dev->dev_type;
 	const struct hv_vmbus_device_id *id;
 
 	/* When driver_override is set, only bind to the matching driver */
@@ -726,7 +714,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
 }
 
 /* vmbus_add_dynid - add a new device ID to this driver and re-probe devices */
-static int vmbus_add_dynid(struct hv_driver *drv, uuid_le *guid)
+static int vmbus_add_dynid(struct hv_driver *drv, guid_t *guid)
 {
 	struct vmbus_dynid *dynid;
 
@@ -764,10 +752,10 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 			    size_t count)
 {
 	struct hv_driver *drv = drv_to_hv_drv(driver);
-	uuid_le guid;
+	guid_t guid;
 	ssize_t retval;
 
-	retval = uuid_le_to_bin(buf, &guid);
+	retval = guid_parse(buf, &guid);
 	if (retval)
 		return retval;
 
@@ -791,10 +779,10 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 {
 	struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct vmbus_dynid *dynid, *n;
-	uuid_le guid;
+	guid_t guid;
 	ssize_t retval;
 
-	retval = uuid_le_to_bin(buf, &guid);
+	retval = guid_parse(buf, &guid);
 	if (retval)
 		return retval;
 
@@ -803,7 +791,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	list_for_each_entry_safe(dynid, n, &drv->dynids.list, node) {
 		struct hv_vmbus_device_id *id = &dynid->id;
 
-		if (!uuid_le_cmp(id->guid, guid)) {
+		if (guid_equal(&id->guid, &guid)) {
 			list_del(&dynid->node);
 			kfree(dynid);
 			retval = count;
@@ -1556,8 +1544,8 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
  * vmbus_device_create - Creates and registers a new child device
  * on the vmbus.
  */
-struct hv_device *vmbus_device_create(const uuid_le *type,
-				      const uuid_le *instance,
+struct hv_device *vmbus_device_create(const guid_t *type,
+				      const guid_t *instance,
 				      struct vmbus_channel *channel)
 {
 	struct hv_device *child_device_obj;
@@ -1569,12 +1557,10 @@ struct hv_device *vmbus_device_create(const uuid_le *type,
 	}
 
 	child_device_obj->channel = channel;
-	memcpy(&child_device_obj->dev_type, type, sizeof(uuid_le));
-	memcpy(&child_device_obj->dev_instance, instance,
-	       sizeof(uuid_le));
+	guid_copy(&child_device_obj->dev_type, type);
+	guid_copy(&child_device_obj->dev_instance, instance);
 	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
 
-
 	return child_device_obj;
 }
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dcb6977afce9..d5678a0fe598 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -222,8 +222,8 @@ static inline u32 hv_get_avail_to_write_percent(
  * struct contains the fundamental information about an offer.
  */
 struct vmbus_channel_offer {
-	uuid_le if_type;
-	uuid_le if_instance;
+	guid_t if_type;
+	guid_t if_instance;
 
 	/*
 	 * These two fields are not currently used.
@@ -614,8 +614,8 @@ struct vmbus_channel_initiate_contact {
 /* Hyper-V socket: guest's connect()-ing to host */
 struct vmbus_channel_tl_connect_request {
 	struct vmbus_channel_message_header header;
-	uuid_le guest_endpoint_id;
-	uuid_le host_service_id;
+	guid_t guest_endpoint_id;
+	guid_t host_service_id;
 } __packed;
 
 struct vmbus_channel_version_response {
@@ -714,7 +714,7 @@ enum vmbus_device_type {
 
 struct vmbus_device {
 	u16  dev_type;
-	uuid_le guid;
+	guid_t guid;
 	bool perf_device;
 };
 
@@ -1096,7 +1096,7 @@ struct hv_driver {
 	bool hvsock;
 
 	/* the device type supported by this driver */
-	uuid_le dev_type;
+	guid_t dev_type;
 	const struct hv_vmbus_device_id *id_table;
 
 	struct device_driver driver;
@@ -1116,10 +1116,10 @@ struct hv_driver {
 /* Base device object */
 struct hv_device {
 	/* the device type id of this device */
-	uuid_le dev_type;
+	guid_t dev_type;
 
 	/* the device instance id of this device */
-	uuid_le dev_instance;
+	guid_t dev_instance;
 	u16 vendor_id;
 	u16 device_id;
 
@@ -1188,102 +1188,102 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
  * {f8615163-df3e-46c5-913f-f2d2f965ed0e}
  */
 #define HV_NIC_GUID \
-	.guid = UUID_LE(0xf8615163, 0xdf3e, 0x46c5, 0x91, 0x3f, \
-			0xf2, 0xd2, 0xf9, 0x65, 0xed, 0x0e)
+	.guid = GUID_INIT(0xf8615163, 0xdf3e, 0x46c5, 0x91, 0x3f, \
+			  0xf2, 0xd2, 0xf9, 0x65, 0xed, 0x0e)
 
 /*
  * IDE GUID
  * {32412632-86cb-44a2-9b5c-50d1417354f5}
  */
 #define HV_IDE_GUID \
-	.guid = UUID_LE(0x32412632, 0x86cb, 0x44a2, 0x9b, 0x5c, \
-			0x50, 0xd1, 0x41, 0x73, 0x54, 0xf5)
+	.guid = GUID_INIT(0x32412632, 0x86cb, 0x44a2, 0x9b, 0x5c, \
+			  0x50, 0xd1, 0x41, 0x73, 0x54, 0xf5)
 
 /*
  * SCSI GUID
  * {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f}
  */
 #define HV_SCSI_GUID \
-	.guid = UUID_LE(0xba6163d9, 0x04a1, 0x4d29, 0xb6, 0x05, \
-			0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
+	.guid = GUID_INIT(0xba6163d9, 0x04a1, 0x4d29, 0xb6, 0x05, \
+			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
 
 /*
  * Shutdown GUID
  * {0e0b6031-5213-4934-818b-38d90ced39db}
  */
 #define HV_SHUTDOWN_GUID \
-	.guid = UUID_LE(0x0e0b6031, 0x5213, 0x4934, 0x81, 0x8b, \
-			0x38, 0xd9, 0x0c, 0xed, 0x39, 0xdb)
+	.guid = GUID_INIT(0x0e0b6031, 0x5213, 0x4934, 0x81, 0x8b, \
+			  0x38, 0xd9, 0x0c, 0xed, 0x39, 0xdb)
 
 /*
  * Time Synch GUID
  * {9527E630-D0AE-497b-ADCE-E80AB0175CAF}
  */
 #define HV_TS_GUID \
-	.guid = UUID_LE(0x9527e630, 0xd0ae, 0x497b, 0xad, 0xce, \
-			0xe8, 0x0a, 0xb0, 0x17, 0x5c, 0xaf)
+	.guid = GUID_INIT(0x9527e630, 0xd0ae, 0x497b, 0xad, 0xce, \
+			  0xe8, 0x0a, 0xb0, 0x17, 0x5c, 0xaf)
 
 /*
  * Heartbeat GUID
  * {57164f39-9115-4e78-ab55-382f3bd5422d}
  */
 #define HV_HEART_BEAT_GUID \
-	.guid = UUID_LE(0x57164f39, 0x9115, 0x4e78, 0xab, 0x55, \
-			0x38, 0x2f, 0x3b, 0xd5, 0x42, 0x2d)
+	.guid = GUID_INIT(0x57164f39, 0x9115, 0x4e78, 0xab, 0x55, \
+			  0x38, 0x2f, 0x3b, 0xd5, 0x42, 0x2d)
 
 /*
  * KVP GUID
  * {a9a0f4e7-5a45-4d96-b827-8a841e8c03e6}
  */
 #define HV_KVP_GUID \
-	.guid = UUID_LE(0xa9a0f4e7, 0x5a45, 0x4d96, 0xb8, 0x27, \
-			0x8a, 0x84, 0x1e, 0x8c, 0x03, 0xe6)
+	.guid = GUID_INIT(0xa9a0f4e7, 0x5a45, 0x4d96, 0xb8, 0x27, \
+			  0x8a, 0x84, 0x1e, 0x8c, 0x03, 0xe6)
 
 /*
  * Dynamic memory GUID
  * {525074dc-8985-46e2-8057-a307dc18a502}
  */
 #define HV_DM_GUID \
-	.guid = UUID_LE(0x525074dc, 0x8985, 0x46e2, 0x80, 0x57, \
-			0xa3, 0x07, 0xdc, 0x18, 0xa5, 0x02)
+	.guid = GUID_INIT(0x525074dc, 0x8985, 0x46e2, 0x80, 0x57, \
+			  0xa3, 0x07, 0xdc, 0x18, 0xa5, 0x02)
 
 /*
  * Mouse GUID
  * {cfa8b69e-5b4a-4cc0-b98b-8ba1a1f3f95a}
  */
 #define HV_MOUSE_GUID \
-	.guid = UUID_LE(0xcfa8b69e, 0x5b4a, 0x4cc0, 0xb9, 0x8b, \
-			0x8b, 0xa1, 0xa1, 0xf3, 0xf9, 0x5a)
+	.guid = GUID_INIT(0xcfa8b69e, 0x5b4a, 0x4cc0, 0xb9, 0x8b, \
+			  0x8b, 0xa1, 0xa1, 0xf3, 0xf9, 0x5a)
 
 /*
  * Keyboard GUID
  * {f912ad6d-2b17-48ea-bd65-f927a61c7684}
  */
 #define HV_KBD_GUID \
-	.guid = UUID_LE(0xf912ad6d, 0x2b17, 0x48ea, 0xbd, 0x65, \
-			0xf9, 0x27, 0xa6, 0x1c, 0x76, 0x84)
+	.guid = GUID_INIT(0xf912ad6d, 0x2b17, 0x48ea, 0xbd, 0x65, \
+			  0xf9, 0x27, 0xa6, 0x1c, 0x76, 0x84)
 
 /*
  * VSS (Backup/Restore) GUID
  */
 #define HV_VSS_GUID \
-	.guid = UUID_LE(0x35fa2e29, 0xea23, 0x4236, 0x96, 0xae, \
-			0x3a, 0x6e, 0xba, 0xcb, 0xa4, 0x40)
+	.guid = GUID_INIT(0x35fa2e29, 0xea23, 0x4236, 0x96, 0xae, \
+			  0x3a, 0x6e, 0xba, 0xcb, 0xa4, 0x40)
 /*
  * Synthetic Video GUID
  * {DA0A7802-E377-4aac-8E77-0558EB1073F8}
  */
 #define HV_SYNTHVID_GUID \
-	.guid = UUID_LE(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
-			0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
+	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
+			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
 
 /*
  * Synthetic FC GUID
  * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
  */
 #define HV_SYNTHFC_GUID \
-	.guid = UUID_LE(0x2f9bcc4a, 0x0069, 0x4af3, 0xb7, 0x6b, \
-			0x6f, 0xd0, 0xbe, 0x52, 0x8c, 0xda)
+	.guid = GUID_INIT(0x2f9bcc4a, 0x0069, 0x4af3, 0xb7, 0x6b, \
+			  0x6f, 0xd0, 0xbe, 0x52, 0x8c, 0xda)
 
 /*
  * Guest File Copy Service
@@ -1291,16 +1291,16 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
  */
 
 #define HV_FCOPY_GUID \
-	.guid = UUID_LE(0x34d14be3, 0xdee4, 0x41c8, 0x9a, 0xe7, \
-			0x6b, 0x17, 0x49, 0x77, 0xc1, 0x92)
+	.guid = GUID_INIT(0x34d14be3, 0xdee4, 0x41c8, 0x9a, 0xe7, \
+			  0x6b, 0x17, 0x49, 0x77, 0xc1, 0x92)
 
 /*
  * NetworkDirect. This is the guest RDMA service.
  * {8c2eaf3d-32a7-4b09-ab99-bd1f1c86b501}
  */
 #define HV_ND_GUID \
-	.guid = UUID_LE(0x8c2eaf3d, 0x32a7, 0x4b09, 0xab, 0x99, \
-			0xbd, 0x1f, 0x1c, 0x86, 0xb5, 0x01)
+	.guid = GUID_INIT(0x8c2eaf3d, 0x32a7, 0x4b09, 0xab, 0x99, \
+			  0xbd, 0x1f, 0x1c, 0x86, 0xb5, 0x01)
 
 /*
  * PCI Express Pass Through
@@ -1308,8 +1308,8 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
  */
 
 #define HV_PCIE_GUID \
-	.guid = UUID_LE(0x44c4f61d, 0x4444, 0x4400, 0x9d, 0x52, \
-			0x80, 0x2e, 0x27, 0xed, 0xe1, 0x9f)
+	.guid = GUID_INIT(0x44c4f61d, 0x4444, 0x4400, 0x9d, 0x52, \
+			  0x80, 0x2e, 0x27, 0xed, 0xe1, 0x9f)
 
 /*
  * Linux doesn't support the 3 devices: the first two are for
@@ -1321,16 +1321,16 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
  */
 
 #define HV_AVMA1_GUID \
-	.guid = UUID_LE(0xf8e65716, 0x3cb3, 0x4a06, 0x9a, 0x60, \
-			0x18, 0x89, 0xc5, 0xcc, 0xca, 0xb5)
+	.guid = GUID_INIT(0xf8e65716, 0x3cb3, 0x4a06, 0x9a, 0x60, \
+			  0x18, 0x89, 0xc5, 0xcc, 0xca, 0xb5)
 
 #define HV_AVMA2_GUID \
-	.guid = UUID_LE(0x3375baf4, 0x9e15, 0x4b30, 0xb7, 0x65, \
-			0x67, 0xac, 0xb1, 0x0d, 0x60, 0x7b)
+	.guid = GUID_INIT(0x3375baf4, 0x9e15, 0x4b30, 0xb7, 0x65, \
+			  0x67, 0xac, 0xb1, 0x0d, 0x60, 0x7b)
 
 #define HV_RDV_GUID \
-	.guid = UUID_LE(0x276aacf4, 0xac15, 0x426c, 0x98, 0xdd, \
-			0x75, 0x21, 0xad, 0x3f, 0x01, 0xfe)
+	.guid = GUID_INIT(0x276aacf4, 0xac15, 0x426c, 0x98, 0xdd, \
+			  0x75, 0x21, 0xad, 0x3f, 0x01, 0xfe)
 
 /*
  * Common header for Hyper-V ICs
@@ -1432,7 +1432,7 @@ struct ictimesync_ref_data {
 struct hyperv_service_callback {
 	u8 msg_type;
 	char *log_msg;
-	uuid_le data;
+	guid_t data;
 	struct vmbus_channel *channel;
 	void (*callback)(void *context);
 };
@@ -1452,8 +1452,8 @@ void vmbus_setevent(struct vmbus_channel *channel);
 
 extern __u32 vmbus_proto_version;
 
-int vmbus_send_tl_connect_request(const uuid_le *shv_guest_servie_id,
-				  const uuid_le *shv_host_servie_id);
+int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
+				  const guid_t *shv_host_servie_id);
 void vmbus_set_event(struct vmbus_channel *channel);
 
 /* Get the start of the ring buffer. */
-- 
2.20.1

