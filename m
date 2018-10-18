Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642DCECDE45
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B42148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SCauWALV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16B42148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeJRXmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:42:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeJRXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:42:44 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9IFeglP097775;
        Thu, 18 Oct 2018 10:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539877242;
        bh=mZbUWHEWCjTEU/nSjpGC2qlzY+lw+sLTd7Ga+ai+VcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SCauWALVlyl11SEGRTLtNH8Lua0r2WbO2dY6pZuwm9l8ve0wT0Zw8szEhEhIKjjHX
         ZfsXxjJ53XgWJeM9+RbHazF3RBYjJtlRsqws5uyg2Ri+06Is6w20hFrciIVjvu86Ri
         BwIIxehgm/6l5QvVDZK79/8eRnBVYGJ25n7BSECA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFegbC016610;
        Thu, 18 Oct 2018 10:40:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 10:40:42 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 10:40:42 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFePOi006432;
        Thu, 18 Oct 2018 10:40:38 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 03/10] firmware: ti_sci: Add support for IRQ management
Date:   Thu, 18 Oct 2018 21:10:10 +0530
Message-ID: <20181018154017.7112-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018154017.7112-1-lokeshvutla@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TISCI abstracts the handling of IRQ routes where interrupt sources
are not directly connected to interrupt controller. Add support for
the set of TISCI commands for requesting and releasing IRQs.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v1:
- None.

 drivers/firmware/ti_sci.c              | 446 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  60 ++++
 include/linux/soc/ti/ti_sci_protocol.h |  77 +++++
 3 files changed, 583 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index a2a099b8f62a..987bfb29475c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1782,6 +1782,439 @@ int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
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
+ * ti_sci_cmd_set_direct_irq() - Configure a non-event based direct irq route
+ *				 between the requested source and destination.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_set_direct_irq(const struct ti_sci_handle *handle,
+				     u16 src_id, u16 src_index, u16 dst_id,
+				     u16 dst_host_irq)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
+
+	return ti_sci_set_irq(handle, valid_params, src_id, src_index,
+			      dst_id, dst_host_irq, 0, 0, 0, 0, 0);
+}
+
+/**
+ * ti_sci_cmd_set_event_irq() - Configure an event based irq route between the
+ *				requested source and destination
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_set_event_irq(const struct ti_sci_handle *handle,
+				    u16 src_id, u16 src_index, u16 dst_id,
+				    u16 dst_host_irq, u16 ia_id, u16 vint,
+				    u16 global_event, u8 vint_status_bit)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID |
+			   MSG_FLAG_DST_HOST_IRQ_VALID | MSG_FLAG_IA_ID_VALID |
+			   MSG_FLAG_VINT_VALID | MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID;
+
+	return ti_sci_set_irq(handle, valid_params, src_id, src_index, dst_id,
+			      dst_host_irq, ia_id, vint, global_event,
+			      vint_status_bit, 0);
+}
+
+/**
+ * ti_sci_cmd_set_direct_irq_from_shost() - Configure a non-event based direct
+ *					    irq route between the source and
+ *					    destination belonging to a
+ *					    specified host.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @s_host:		Secondary host ID to which the irq/event is being
+ *			requested for.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static
+int ti_sci_cmd_set_direct_irq_from_shost(const struct ti_sci_handle *handle,
+					 u16 src_id, u16 src_index, u16 dst_id,
+					 u16 dst_host_irq, u8 s_host)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID |
+			   MSG_FLAG_SHOST_VALID;
+
+	return ti_sci_set_irq(handle, valid_params, src_id, src_index,
+			      dst_id, dst_host_irq, 0, 0, 0, 0, s_host);
+}
+
+/**
+ * ti_sci_cmd_set_event_irq_from_shost() - Configure an event based irq
+ *					   route between the source and
+ *					   destination belonging to a
+ *					   specified host.
+ * @handle:		Pointer to TISCI handle.
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
+static
+int ti_sci_cmd_set_event_irq_from_shost(const struct ti_sci_handle *handle,
+					u16 src_id, u16 src_index, u16 dst_id,
+					u16 dst_host_irq, u16 ia_id, u16 vint,
+					u16 global_event, u8 vint_status_bit,
+					u8 s_host)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID |
+			   MSG_FLAG_DST_HOST_IRQ_VALID | MSG_FLAG_IA_ID_VALID |
+			   MSG_FLAG_VINT_VALID | MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID | MSG_FLAG_SHOST_VALID;
+
+	return ti_sci_set_irq(handle, valid_params, src_id, src_index,
+			      dst_id, dst_host_irq, ia_id, vint,
+			      global_event, vint_status_bit, s_host);
+}
+
+/**
+ * ti_sci_cmd_set_event_irq_to_poll() - Configure an event based irq
+ *					in polling mode
+ * @handle:		Pointer to TISCI handle.
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
+static int ti_sci_cmd_set_event_irq_to_poll(const struct ti_sci_handle *handle,
+					    u16 src_id, u16 src_index,
+					    u16 ia_id, u16 vint,
+					    u16 global_event,
+					    u8 vint_status_bit)
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
+ * ti_sci_cmd_free_direct_irq() - Free a non-event based direct irq route
+ *				  between the requested source and destination.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_free_direct_irq(const struct ti_sci_handle *handle,
+				      u16 src_id, u16 src_index, u16 dst_id,
+				      u16 dst_host_irq)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index,
+			       dst_id, dst_host_irq, 0, 0, 0, 0, 0);
+}
+
+/**
+ * ti_sci_cmd_free_event_irq() - Free an event based irq route between the
+ *				 requested source and destination
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @ia_id:		Device ID of the IA, if the IRQ flows through this IA
+ * @vint:		Virtual interrupt to be used within the IA
+ * @global_event:	Global event number to be used for the requesting event
+ * @vint_status_bit:	Virtual interrupt status bit to be used for the event
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_free_event_irq(const struct ti_sci_handle *handle,
+				     u16 src_id, u16 src_index, u16 dst_id,
+				     u16 dst_host_irq, u16 ia_id, u16 vint,
+				     u16 global_event, u8 vint_status_bit)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID |
+			   MSG_FLAG_DST_HOST_IRQ_VALID | MSG_FLAG_IA_ID_VALID |
+			   MSG_FLAG_VINT_VALID | MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index,
+			       dst_id, dst_host_irq, ia_id, vint,
+			       global_event, vint_status_bit, 0);
+}
+
+/**
+ * ti_sci_cmd_free_direct_irq_from_shost() - Free a non-event based direct irq
+ *					     route between the source and
+ *					     destination belonging to a
+ *					     specified host.
+ * @handle:		Pointer to TISCI handle.
+ * @src_id:		Device ID of the IRQ source
+ * @src_index:		IRQ source index within the source device
+ * @dst_id:		Device ID of the IRQ destination
+ * @dt_host_irq:	IRQ number of the destination device
+ * @s_host:		Secondary host ID to which the irq/event is being
+ *			requested for.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static
+int ti_sci_cmd_free_direct_irq_from_shost(const struct ti_sci_handle *handle,
+					  u16 src_id, u16 src_index, u16 dst_id,
+					  u16 dst_host_irq, u8 s_host)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID | MSG_FLAG_DST_HOST_IRQ_VALID |
+			   MSG_FLAG_SHOST_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index,
+			       dst_id, dst_host_irq, 0, 0, 0, 0, s_host);
+}
+
+/**
+ * ti_sci_cmd_free_event_irq_from_shost() - Free an event based irq
+ *					    route between the source and
+ *					    destination belonging to a
+ *					    specified host.
+ * @handle:		Pointer to TISCI handle.
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
+static
+int ti_sci_cmd_free_event_irq_from_shost(const struct ti_sci_handle *handle,
+					 u16 src_id, u16 src_index, u16 dst_id,
+					 u16 dst_host_irq, u16 ia_id, u16 vint,
+					 u16 global_event, u8 vint_status_bit,
+					 u8 s_host)
+{
+	u32 valid_params = MSG_FLAG_DST_ID_VALID |
+			   MSG_FLAG_DST_HOST_IRQ_VALID | MSG_FLAG_IA_ID_VALID |
+			   MSG_FLAG_VINT_VALID | MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID | MSG_FLAG_SHOST_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index,
+			       dst_id, dst_host_irq, ia_id, vint,
+			       global_event, vint_status_bit, s_host);
+}
+
+/**
+ * ti_sci_cmd_free_event_irq_to_poll() - Free an event based irq
+ *					 in polling mode
+ * @handle:		Pointer to TISCI handle.
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
+static int ti_sci_cmd_free_event_irq_to_poll(const struct ti_sci_handle *handle,
+					     u16 src_id, u16 src_index,
+					     u16 ia_id, u16 vint,
+					     u16 global_event,
+					     u8 vint_status_bit)
+{
+	u32 valid_params = MSG_FLAG_IA_ID_VALID | MSG_FLAG_VINT_VALID |
+			   MSG_FLAG_GLB_EVNT_VALID |
+			   MSG_FLAG_VINT_STS_BIT_VALID;
+
+	return ti_sci_free_irq(handle, valid_params, src_id, src_index, 0, 0,
+			       ia_id, vint, global_event, vint_status_bit, 0);
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -1793,6 +2226,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
+	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 
 	core_ops->reboot_device = ti_sci_cmd_core_reboot;
 
@@ -1827,6 +2261,18 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
+
+	iops->set_direct_irq = ti_sci_cmd_set_direct_irq;
+	iops->set_event_irq = ti_sci_cmd_set_event_irq;
+	iops->set_direct_irq_from_shost = ti_sci_cmd_set_direct_irq_from_shost;
+	iops->set_event_irq_from_shost = ti_sci_cmd_set_event_irq_from_shost;
+	iops->set_event_irq_to_poll = ti_sci_cmd_set_event_irq_to_poll;
+	iops->free_direct_irq = ti_sci_cmd_free_direct_irq;
+	iops->free_event_irq = ti_sci_cmd_free_event_irq;
+	iops->free_direct_irq_from_shost =
+					ti_sci_cmd_free_direct_irq_from_shost;
+	iops->free_event_irq_from_shost = ti_sci_cmd_free_event_irq_from_shost;
+	iops->free_event_irq_to_poll = ti_sci_cmd_free_event_irq_to_poll;
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
index 0c92a922db6a..6d17580839dc 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -217,17 +217,94 @@ struct ti_sci_rm_core_ops {
 				    u16 *range_start, u16 *range_num);
 };
 
+/**
+ * struct ti_sci_rm_irq_ops: IRQ management operations
+ * @set_direct_irq:		Set Non-event Sourced direct irq to destination
+ *				host(same host as ti sci interface id).
+ * @set_event_irq:		Set Event based peripheral irq to destination
+ *				host(same host as ti sci interface id).
+ * @set_direct_irq_from_shost:	Set Non-event Sourced direct irq to a
+ *				specified destination host.
+ * @set_event_irq_from_shost:	Set Event based peripheral irq to a
+ *				specified destination host.
+ * @set_event_irq_to_poll:	Set Event based peripheral irq to polling mode.
+ *				vint_status_bit is used for polling.
+ * @free_direct_irq:		Free a non-event sourced direct irq to
+ *				destination host(same as ti sci interface id)
+ * @free_event_irq:		Free an event based peripheral irq to
+ *				destination host(same as ti sci interface id)
+ * @free_direct_irq_from_shost:	Free non-event based direct irq from a
+ *				specified destination host.
+ * @free_event_irq_from_shost:	Free event based peripheral irq from a
+ *				specified destination host.
+ * @free_event_irq_to_poll:	Free an event based peripheral irq that is
+ *				configured in polling mode.
+ *
+ * NOTE: for these functions, all the parameters are consolidated and defined
+ * as below:
+ * - handle:	Pointer to TISCI handle as retrieved by *ti_sci_get_handle
+ * - src_id:	Device ID of the IRQ source
+ * - src_index:	IRQ source index within the source device
+ * - dst_id:	Device ID of the IRQ destination.
+ * - dst_host_irq:	IRQ number of the destination device.
+ * - ia_id:	Device ID of the IA, if the IRQ flows through this IA
+ * - vint:	Virtual interrupt to be used within the IA
+ * - global_event:	Global event number to be used for the requesting event.
+ * - vint_status_bit:	Virtual interrupt status bit to be used for the event.
+ * - s_host:	Secondary host ID to which the irq/event is being requested.
+ */
+struct ti_sci_rm_irq_ops {
+	int (*set_direct_irq)(const struct ti_sci_handle *handle, u16 src_id,
+			      u16 src_index, u16 dst_id, u16 dst_host_irq);
+	int (*set_event_irq)(const struct ti_sci_handle *handle, u16 src_id,
+			     u16 src_index, u16 dst_id, u16 dst_host_irq,
+			     u16 ia_id, u16 vint, u16 global_event,
+			     u8 vint_status_bit);
+	int (*set_direct_irq_from_shost)(const struct ti_sci_handle *handle,
+					 u16 src_id, u16 src_index, u16 dst_id,
+					 u16 dst_host_irq, u8 s_host);
+	int (*set_event_irq_from_shost)(const struct ti_sci_handle *handle,
+					u16 src_id, u16 src_index, u16 dst_id,
+					u16 dst_host_irq, u16 ia_id, u16 vint,
+					u16 global_event, u8 vint_status_bit,
+					u8 s_host);
+	int (*set_event_irq_to_poll)(const struct ti_sci_handle *handle,
+				     u16 src_id, u16 src_index, u16 ia_id,
+				     u16 vint, u16 global_event,
+				     u8 vint_status_bit);
+	int (*free_direct_irq)(const struct ti_sci_handle *handle, u16 src_id,
+			       u16 src_index, u16 dst_id, u16 dst_host_irq);
+	int (*free_event_irq)(const struct ti_sci_handle *handle, u16 src_id,
+			      u16 src_index, u16 dst_id, u16 dst_host_irq,
+			      u16 ia_id, u16 vint, u16 global_event,
+			      u8 vint_status_bit);
+	int (*free_direct_irq_from_shost)(const struct ti_sci_handle *handle,
+					  u16 src_id, u16 src_index, u16 dst_id,
+					  u16 dst_host_irq, u8 s_host);
+	int (*free_event_irq_from_shost)(const struct ti_sci_handle *handle,
+					 u16 src_id, u16 src_index, u16 dst_id,
+					 u16 dst_host_irq, u16 ia_id, u16 vint,
+					 u16 global_event, u8 vint_status_bit,
+					 u8 s_host);
+	int (*free_event_irq_to_poll)(const struct ti_sci_handle *handle,
+				      u16 src_id, u16 src_index, u16 ia_id,
+				      u16 vint, u16 global_event,
+				      u8 vint_status_bit);
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
2.19.1

