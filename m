Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9891C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9685A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J2ag0t67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBLHno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:43:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39750 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBLHnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:43:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hBGx016251;
        Tue, 12 Feb 2019 01:43:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957392;
        bh=XWels34e0DKYVHZ79Wjwle8Ny7gFc786C3hZ5c0J2tw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J2ag0t67GBZj6duaap0V3HGSs0ptxKpYdEl/RURuEJugpsE3MoEhpKseK5jcbQ5mh
         r5rB9WlJQ0FpcQ8nVOaTgMMRbO2H8TNTYT+iX8M/37Ay9O9KJ6wE0d9yanEd1IBK0I
         XnPn5sDedFNaK2HQqTHF00n+ffOq2av5ibGmJ8Ig=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hBb3078952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:11 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:11 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gsrx000385;
        Tue, 12 Feb 2019 01:43:07 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 03/10] firmware: ti_sci: Add support for IRQ management
Date:   Tue, 12 Feb 2019 13:12:30 +0530
Message-ID: <20190212074237.2875-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TISCI abstracts the handling of IRQ routes where interrupt sources
are not directly connected to host interrupt controller. Add support
for the set of TISCI commands for requesting and releasing IRQs.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v4:
- Updated to the latest sysfw APIs where event irq configuration is broken
  down in two parts. One for event to vint map and other for vint to gic map.
- Dropped support for configuring irqs for secondary host to avoid confusion.
  This can be added later once the support is required.

 drivers/firmware/ti_sci.c              | 260 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  60 ++++++
 include/linux/soc/ti/ti_sci_protocol.h |  28 +++
 3 files changed, 348 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index a2a099b8f62a..729fef77379e 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1782,6 +1782,260 @@ int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
 					 range_start, range_num);
 }
 
+/**
+ * ti_sci_manage_irq() - Helper api to configure/release the irq route between
+ *			 the requested source and destination
+ * @handle:		Pointer to TISCI handle.
+ * @valid_params:	Bit fields defining the validity of certain params
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ * @s_host:		Secondary host ID to which the irq/event is being
+ *			requested for.
+ * @type:		Request type irq set or release.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_manage_irq(const struct ti_sci_handle *handle,
+			     u32 valid_params, u16 src_id, u16 src_index,
+			     u16 dst_id, u16 dst_host_irq, u16 ia_id, u16 vint,
+			     u16 global_event, u8 vint_status_bit, u8 s_host,
+			     u16 type)
+{
+	struct ti_sci_msg_req_manage_irq *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_info *info;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, type, TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_manage_irq *)xfer->xfer_buf;
+	req->valid_params = valid_params;
+	req->src_id = src_id;
+	req->src_index = src_index;
+	req->dst_id = dst_id;
+	req->dst_host_irq = dst_host_irq;
+	req->ia_id = ia_id;
+	req->vint = vint;
+	req->global_event = global_event;
+	req->vint_status_bit = vint_status_bit;
+	req->secondary_host = s_host;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_set_irq() - Helper api to configure the irq route between the
+ *		      requested source and destination
+ * @handle:		Pointer to TISCI handle.
+ * @valid_params:	Bit fields defining the validity of certain params
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ * @s_host:		Secondary host ID to which the irq/event is being
+ *			requested for.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_set_irq(const struct ti_sci_handle *handle, u32 valid_params,
+			  u16 src_id, u16 src_index, u16 dst_id,
+			  u16 dst_host_irq, u16 ia_id, u16 vint,
+			  u16 global_event, u8 vint_status_bit, u8 s_host)
+{
+	pr_debug("%s: IRQ set with valid_params = 0x%x from src = %d, index = %d, to dst = %d, irq = %d,via ia_id = %d, vint = %d, global event = %d,status_bit = %d\n",
+		 __func__, valid_params, src_id, src_index,
+		 dst_id, dst_host_irq, ia_id, vint, global_event,
+		 vint_status_bit);
+
+	return ti_sci_manage_irq(handle, valid_params, src_id, src_index,
+				 dst_id, dst_host_irq, ia_id, vint,
+				 global_event, vint_status_bit, s_host,
+				 TI_SCI_MSG_SET_IRQ);
+}
+
+/**
+ * ti_sci_free_irq() - Helper api to free the irq route between the
+ *			   requested source and destination
+ * @handle:		Pointer to TISCI handle.
+ * @valid_params:	Bit fields defining the validity of certain params
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ * @s_host:		Secondary host ID to which the irq/event is being
+ *			requested for.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
+			   u16 src_id, u16 src_index, u16 dst_id,
+			   u16 dst_host_irq, u16 ia_id, u16 vint,
+			   u16 global_event, u8 vint_status_bit, u8 s_host)
+{
+	pr_debug("%s: IRQ release with valid_params = 0x%x from src = %d, index = %d, to dst = %d, irq = %d,via ia_id = %d, vint = %d, global event = %d,status_bit = %d\n",
+		 __func__, valid_params, src_id, src_index,
+		 dst_id, dst_host_irq, ia_id, vint, global_event,
+		 vint_status_bit);
+
+	return ti_sci_manage_irq(handle, valid_params, src_id, src_index,
+				 dst_id, dst_host_irq, ia_id, vint,
+				 global_event, vint_status_bit, s_host,
+				 TI_SCI_MSG_FREE_IRQ);
+}
+
+/**
+ * ti_sci_cmd_set_irq() - Configure a host irq route between the requested
+ *			  source and destination.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @vint_irq:		Boolean specifying if this interrupt belongs to
+ *			Interrupt Aggregator.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_set_irq(const struct ti_sci_handle *handle, u16 src_id,
+			      u16 src_index, u16 dst_id, u16 dst_host_irq,
+			      bool vint_irq)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
+
+	if (vint_irq) {
+		valid_params |= MSG_FLAG_IA_ID_VALID | MSG_FLAG_VINT_VALID;
+		return ti_sci_set_irq(handle, valid_params, 0, 0, dst_id,
+				      dst_host_irq, src_id, src_index, 0, 0, 0);
+	} else {
+		return ti_sci_set_irq(handle, valid_params, src_id, src_index,
+				      dst_id, dst_host_irq, 0, 0, 0, 0, 0);
+	}
+}
+
+/**
+ * ti_sci_cmd_set_event_map() - Configure an event based irq route between the
+ *				requested source and Interrupt Aggregator.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_set_event_map(const struct ti_sci_handle *handle,
+				    u16 src_id, u16 src_index, u16 ia_id,
+				    u16 vint, u16 global_event,
+				    u8 vint_status_bit)
+{
+	u32 valid_params = MSG_FLAG_IA_ID_VALID | MSG_FLAG_VINT_VALID |
+			   MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID;
+
+	return ti_sci_set_irq(handle, valid_params, src_id, src_index, 0, 0,
+			      ia_id, vint, global_event, vint_status_bit, 0);
+}
+
+/**
+ * ti_sci_cmd_free_irq() - Free a host irq route between the between the
+ *			   requested source and destination.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @vint_irq:		Boolean specifying if this interrupt belongs to
+ *			Interrupt Aggregator.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_free_irq(const struct ti_sci_handle *handle, u16 src_id,
+			       u16 src_index, u16 dst_id, u16 dst_host_irq,
+			       bool vint_irq)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
+
+	if (vint_irq) {
+		valid_params |= MSG_FLAG_IA_ID_VALID | MSG_FLAG_VINT_VALID;
+		return ti_sci_free_irq(handle, valid_params, 0, 0, dst_id,
+				       dst_host_irq, src_id, src_index, 0, 0,
+				       0);
+	} else {
+		return ti_sci_free_irq(handle, valid_params, src_id, src_index,
+				       dst_id, dst_host_irq, 0, 0, 0, 0, 0);
+	}
+}
+
+/**
+ * ti_sci_cmd_free_event_map() - Free an event map between the requested source
+ *				 and Interrupt Aggregator.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_free_event_map(const struct ti_sci_handle *handle,
+				     u16 src_id, u16 src_index, u16 ia_id,
+				     u16 vint, u16 global_event,
+				     u8 vint_status_bit)
+{
+	u32 valid_params = MSG_FLAG_IA_ID_VALID |
+			   MSG_FLAG_VINT_VALID | MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index, 0, 0,
+			       ia_id, vint, global_event, vint_status_bit, 0);
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -1793,6 +2047,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
+	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 
 	core_ops->reboot_device = ti_sci_cmd_core_reboot;
 
@@ -1827,6 +2082,11 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
+
+	iops->set_irq = ti_sci_cmd_set_irq;
+	iops->set_event_map = ti_sci_cmd_set_event_map;
+	iops->free_irq = ti_sci_cmd_free_irq;
+	iops->free_event_map = ti_sci_cmd_free_event_map;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index a043c4762791..4983827151bf 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -38,6 +38,10 @@
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
 
+/* IRQ requests */
+#define TI_SCI_MSG_SET_IRQ		0x1000
+#define TI_SCI_MSG_FREE_IRQ		0x1001
+
 /**
  * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
  * @type:	Type of messages: One of TI_SCI_MSG* values
@@ -503,4 +507,60 @@ struct ti_sci_msg_resp_get_resource_range {
 	u16 range_num;
 } __packed;
 
+/**
+ * struct ti_sci_msg_req_manage_irq - Request to configure/release the route
+ *					between the dev and the host.
+ * @hdr:		Generic Header
+ * @valid_params:	Bit fields defining the validity of interrupt source
+ *			parameters. If a bit is not set, then corresponding
+ *			field is not valid and will not be used for route set.
+ *			Bit field definitions:
+ *			0 - Valid bit for @dst_id
+ *			1 - Valid bit for @dst_host_irq
+ *			2 - Valid bit for @ia_id
+ *			3 - Valid bit for @vint
+ *			4 - Valid bit for @global_event
+ *			5 - Valid bit for @vint_status_bit_index
+ *			31 - Valid bit for @secondary_host
+ * @src_id:		IRQ source peripheral ID.
+ * @src_index:		IRQ source index within the peripheral
+ * @dst_id:		IRQ Destination ID. Based on the architecture it can be
+ *			IRQ controller or host processor ID.
+ * @dst_host_irq:	IRQ number of the destination host IRQ controller
+ * @ia_id:		Device ID of the interrupt aggregator in which the
+ *			vint resides.
+ * @vint:		Virtual interrupt number if the interrupt route
+ *			is through an interrupt aggregator.
+ * @global_event:	Global event that is to be mapped to interrupt
+ *			aggregator virtual interrupt status bit.
+ * @vint_status_bit:	Virtual interrupt status bit if the interrupt route
+ *			utilizes an interrupt aggregator status bit.
+ * @secondary_host:	Host ID of the IRQ destination computing entity. This is
+ *			required only when destination host id is different
+ *			from ti sci interface host id.
+ *
+ * Request type is TI_SCI_MSG_SET/RELEASE_IRQ.
+ * Response is generic ACK / NACK message.
+ */
+struct ti_sci_msg_req_manage_irq {
+	struct ti_sci_msg_hdr hdr;
+#define MSG_FLAG_DST_ID_VALID			TI_SCI_MSG_FLAG(0)
+#define MSG_FLAG_DST_HOST_IRQ_VALID		TI_SCI_MSG_FLAG(1)
+#define MSG_FLAG_IA_ID_VALID			TI_SCI_MSG_FLAG(2)
+#define MSG_FLAG_VINT_VALID			TI_SCI_MSG_FLAG(3)
+#define MSG_FLAG_GLB_EVNT_VALID			TI_SCI_MSG_FLAG(4)
+#define MSG_FLAG_VINT_STS_BIT_VALID		TI_SCI_MSG_FLAG(5)
+#define MSG_FLAG_SHOST_VALID			TI_SCI_MSG_FLAG(31)
+	u32 valid_params;
+	u16 src_id;
+	u16 src_index;
+	u16 dst_id;
+	u16 dst_host_irq;
+	u16 ia_id;
+	u16 vint;
+	u16 global_event;
+	u8 vint_status_bit;
+	u8 secondary_host;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 0c92a922db6a..a0216c947acd 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -217,17 +217,45 @@ struct ti_sci_rm_core_ops {
 				    u16 *range_start, u16 *range_num);
 };
 
+/**
+ * struct ti_sci_rm_irq_ops: IRQ management operations
+ * @set_irq:		Set an IRQ route between the requested source
+ *			and destination
+ * @set_event_map:	Set an Event based peripheral irq to Interrupt
+ *			Aggregator.
+ * @free_irq:		Free an an IRQ route between the requested source
+ *			destination.
+ * @free_event_map:	Free an event based peripheral irq to Interrupt
+ *			Aggregator.
+ */
+struct ti_sci_rm_irq_ops {
+	int (*set_irq)(const struct ti_sci_handle *handle, u16 src_id,
+		       u16 src_index, u16 dst_id, u16 dst_host_irq,
+		       bool vint_irq);
+	int (*set_event_map)(const struct ti_sci_handle *handle, u16 src_id,
+			     u16 src_index, u16 ia_id, u16 vint,
+			     u16 global_event, u8 vint_status_bit);
+	int (*free_irq)(const struct ti_sci_handle *handle, u16 src_id,
+			u16 src_index, u16 dst_id, u16 dst_host_irq,
+			bool vint_irq);
+	int (*free_event_map)(const struct ti_sci_handle *handle, u16 src_id,
+			      u16 src_index, u16 ia_id, u16 vint,
+			      u16 global_event, u8 vint_status_bit);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @dev_ops:	Device specific operations
  * @clk_ops:	Clock specific operations
  * @rm_core_ops:	Resource management core operations.
+ * @rm_irq_ops:		IRQ management specific operations
  */
 struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
+	struct ti_sci_rm_irq_ops rm_irq_ops;
 };
 
 /**
-- 
2.19.2

