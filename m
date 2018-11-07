Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF283C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530072086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/EOW0yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbeKGKBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52869 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbeKGKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:21 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so14907353itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NBN3uwl9LBhMVNbhCXlEY/BD2cUFMCX7LxSMHFFMj7M=;
        b=Z/EOW0yf74hpA2x7BxYQMcQN8J9qD1HxnNgDxzlleUvDWNLoH50B3FAN1tYbCbxWE+
         FdVK2q6khkzTlTGNeIPjnzut3ICaP2vcZcg/hSm3M2kuxpWULvpIZbrQ+JfBzx7UH4Ii
         12FDACzPDetXmb3ZR7fY7/9ZM1qqILDiIR8I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBN3uwl9LBhMVNbhCXlEY/BD2cUFMCX7LxSMHFFMj7M=;
        b=kCtkYkpO5FH24X8fUdGcz41th1pCFVgv6yrucJQhgTr14+zuLwMFVxpF8jmKDZUNYO
         LMM8+WbIUiuq3tSTXDiD+RZke8t/Ewzv8KDcmqjRVPvlnaImgyMmFoIJ/tg6UwGoMHp9
         8PsXO3fs4eCp7BsWzJT/cutvjU83TR3g3oJuzR805R+JJcZcJTkXvCdtZg+dFIm2nQMm
         S9MxfgNPqULlZzTc9MZvBtQ7p4ddCaxokp+lLBE5RdzeWNDd31Y/WBq3apD40GwV1fPP
         3nHcY83I+4JUpQJDeepvBEjMLKfD1oGBzV9j5aooSCh1RgYjc664vBpiX6yu2mDPzpgf
         GuaQ==
X-Gm-Message-State: AGRZ1gLWvOyL08fJ7K5Ojot5pnAP+eSdW/f+4sRohAx4x9E2e5iL7F6a
        4kdcBPudo9jLZ/TdUl9D6JvSDw==
X-Google-Smtp-Source: AJdET5cz5z4RfTNN/da7EJNZv9xGvjypDswukGswEQfrt+M4SjR8duA0S/MKNiWIgwyPzdJ0H9eRaw==
X-Received: by 2002:a24:d645:: with SMTP id o66-v6mr115582itg.9.1541550805307;
        Tue, 06 Nov 2018 16:33:25 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:24 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 06/12] soc: qcom: ipa: QMI modem communication
Date:   Tue,  6 Nov 2018 18:32:44 -0600
Message-Id: <20181107003250.5832-7-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMI is a mechanism that allows entities on the AP to communicate and
coordinate with peer entities on a modem.  Each peer can create an
endpoint for communicating with the other.  QMI defines a way for
the format of messages sent between endpoints to be described, and
uses a service to route and deliver these messages.

For IPA, QMI is used to synchronize the startup sequence of the IPA
drivers resident on the AP and modem.  The documentation in
"ipa_qmi.c" below provides more detail about the message interchange
involved.  The IPA QMI code is divided into the "main" code that
implements message handling and synchronization, and the message
code that defines the structure and layout of the messages used.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_qmi.c     | 406 +++++++++++++++++++++++
 drivers/net/ipa/ipa_qmi.h     |  12 +
 drivers/net/ipa/ipa_qmi_msg.c | 587 ++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_qmi_msg.h | 233 ++++++++++++++
 4 files changed, 1238 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_qmi.c
 create mode 100644 drivers/net/ipa/ipa_qmi.h
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.c
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.h

diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
new file mode 100644
index 000000000000..a19cfc4043d3
--- /dev/null
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/qrtr.h>
+#include <linux/soc/qcom/qmi.h>
+
+#include "ipa_qmi_msg.h"
+
+#include "ipa_i.h"	/* ipa_err() */
+
+#define QMI_INIT_DRIVER_TIMEOUT	60000	/* A minute in milliseconds */
+
+static bool ipa_qmi_initialized;
+
+/* The AP and modem perform a "handshake" at initialization time to
+ * ensure each side knows the other side is ready.  Two pairs of QMI
+ * handles (endpoints) are used for this; one provides service on
+ * the modem for AP requests, and the other is on the AP to service
+ * modem requests (and to supply an indication from the AP).
+ *
+ * The QMI service on the modem expects to receive an INIT_DRIVER
+ * request from the AP, which contains parameters used by the
+ * modem during initialization.  The AP sends this request as soon
+ * as it is knows the service is available.  The modem responds to
+ * this request immediately.
+ *
+ * When the modem learns the AP service is available, it is able
+ * to communicate its status to the AP.  The modem uses this to
+ * tell the AP when it is ready to receive an indication, sending
+ * an INDICATION_REGISTER request to the handle served by the AP.
+ * This is separate from the modem driver initialization.
+ *
+ * When the modem has completed the driver initialization requested
+ * by the AP, it sends a DRIVER_INIT_COMPLETE request to the AP.
+ * This request could arrive at the AP either before or after the
+ * INDICATION_REGISTER request.
+ *
+ * The final step in the handshake occurs after the AP has received
+ * both requests from the modem.  The AP completes the handshake by
+ * sending an INIT_COMPLETE_IND indication message to the modem.
+ */
+
+#define IPA_HOST_SERVICE_SVC_ID		0x31
+#define IPA_HOST_SVC_VERS		1
+#define IPA_HOST_SERVICE_INS_ID		1
+
+#define IPA_MODEM_SERVICE_SVC_ID	0x31
+#define IPA_MODEM_SERVICE_INS_ID	2
+#define IPA_MODEM_SVC_VERS		1
+
+/* Used to send an INIT_DRIVER request to the modem */
+static struct qmi_handle client_handle;
+
+/* Requests from the modem arrive on the server handle to tell us
+ * when it is prepared to receive an INIT_COMPLETE indication, and
+ * when its driver initialization is complete.  The AP sends the
+ * indication after it has received and responded to both requests.
+ */
+static struct qmi_handle server_handle;
+
+/* These track state during the handshake */
+static bool indication_register_received;
+static bool init_driver_response_received;
+
+/* Send an INIT_COMPLETE_IND indication message to the modem */
+static int ipa_send_master_driver_init_complete_ind(struct qmi_handle *qmi,
+						    struct sockaddr_qrtr *sq)
+{
+	struct ipa_init_complete_ind ind = { };
+
+	ind.status.result = QMI_RESULT_SUCCESS_V01;
+	ind.status.error = QMI_ERR_NONE_V01;
+
+	return qmi_send_indication(qmi, sq, IPA_QMI_INIT_COMPLETE_IND,
+				   IPA_QMI_INIT_COMPLETE_IND_SZ,
+				   ipa_init_complete_ind_ei, &ind);
+}
+
+/* This function is called to determine whether to complete the
+ * handshake by sending an INIT_COMPLETE_IND indication message to
+ * the modem.  The "init_driver" parameter is false when we've
+ * received an INDICATION_REGISTER request message from the modem,
+ * or true when we've received the response from the INIT_DRIVER
+ * request message we send.  If this function decides the message
+ * should be sent, it calls ipa_send_master_driver_init_complete_ind()
+ * to send it.
+ */
+static void ipa_handshake_complete(struct qmi_handle *qmi,
+				   struct sockaddr_qrtr *sq, bool init_driver)
+{
+	bool send_it;
+	int ret;
+
+	if (init_driver) {
+		init_driver_response_received = true;
+		send_it = indication_register_received;
+	} else {
+		indication_register_received = true;
+		send_it = init_driver_response_received;
+	}
+	if (!send_it)
+		return;
+
+	ret = ipa_send_master_driver_init_complete_ind(qmi, sq);
+	if (ret)
+		ipa_err("error %d sending init complete indication\n", ret);
+}
+
+/* Callback function to handle an INDICATION_REGISTER request message
+ * from the modem.  This informs the AP that the modem is now ready to
+ * receive the INIT_COMPLETE_IND indication message.
+ */
+static void ipa_indication_register_fn(struct qmi_handle *qmi,
+				       struct sockaddr_qrtr *sq,
+				       struct qmi_txn *txn,
+				       const void *decoded)
+{
+	struct ipa_indication_register_rsp rsp = { };
+	int ret;
+
+	rsp.rsp.result = QMI_RESULT_SUCCESS_V01;
+	rsp.rsp.error = QMI_ERR_NONE_V01;
+
+	ret = qmi_send_response(qmi, sq, txn, IPA_QMI_INDICATION_REGISTER,
+				IPA_QMI_INDICATION_REGISTER_RSP_SZ,
+				ipa_indication_register_rsp_ei, &rsp);
+	if (ret)
+		ipa_err("error %d sending response\n", ret);
+	else
+		ipa_handshake_complete(qmi, sq, false);
+}
+
+/* Callback function to handle a DRIVER_INIT_COMPLETE request message
+ * from the modem.  This informs the AP that the modem has completed
+ * the initializion of its driver.
+ */
+static void ipa_driver_init_complete_fn(struct qmi_handle *qmi,
+					struct sockaddr_qrtr *sq,
+					struct qmi_txn *txn,
+					const void *decoded)
+{
+	struct ipa_driver_init_complete_rsp rsp = { };
+	int ret;
+
+	rsp.rsp.result = QMI_RESULT_SUCCESS_V01;
+	rsp.rsp.error = QMI_ERR_NONE_V01;
+
+	ret = qmi_send_response(qmi, sq, txn, IPA_QMI_DRIVER_INIT_COMPLETE,
+				IPA_QMI_DRIVER_INIT_COMPLETE_RSP_SZ,
+				ipa_driver_init_complete_rsp_ei, &rsp);
+	if (ret)
+		ipa_err("error %d sending response\n", ret);
+}
+
+/* The server handles two request message types sent by the modem. */
+static struct qmi_msg_handler ipa_server_msg_handlers[] = {
+	{
+		.type		= QMI_REQUEST,
+		.msg_id		= IPA_QMI_INDICATION_REGISTER,
+		.ei		= ipa_indication_register_req_ei,
+		.decoded_size	= IPA_QMI_INDICATION_REGISTER_REQ_SZ,
+		.fn		= ipa_indication_register_fn,
+	},
+	{
+		.type		= QMI_REQUEST,
+		.msg_id		= IPA_QMI_DRIVER_INIT_COMPLETE,
+		.ei		= ipa_driver_init_complete_req_ei,
+		.decoded_size	= IPA_QMI_DRIVER_INIT_COMPLETE_REQ_SZ,
+		.fn		= ipa_driver_init_complete_fn,
+	},
+};
+
+/* Callback function to handle an IPA_QMI_INIT_DRIVER response message
+ * from the modem.  This only acknowledges that the modem received the
+ * request.  The modem will eventually report that it has completed its
+ * modem initialization by sending a IPA_QMI_DRIVER_INIT_COMPLETE request.
+ */
+static void ipa_init_driver_rsp_fn(struct qmi_handle *qmi,
+				   struct sockaddr_qrtr *sq,
+				   struct qmi_txn *txn,
+				   const void *decoded)
+{
+	txn->result = 0;	/* IPA_QMI_INIT_DRIVER request was successful */
+	complete(&txn->completion);
+
+	ipa_handshake_complete(qmi, sq, true);
+}
+
+/* The client handles one response message type sent by the modem. */
+static struct qmi_msg_handler ipa_client_msg_handlers[] = {
+	{
+		.type		= QMI_RESPONSE,
+		.msg_id		= IPA_QMI_INIT_DRIVER,
+		.ei		= ipa_init_modem_driver_rsp_ei,
+		.decoded_size	= IPA_QMI_INIT_DRIVER_RSP_SZ,
+		.fn		= ipa_init_driver_rsp_fn,
+	},
+};
+
+/* Return a pointer to an init modem driver request structure, which
+ * contains configuration parameters for the modem.  The modem may
+ * be started multiple times, but generally these parameters don't
+ * change so we can reuse the request structure once it's initialized.
+ * The only exception is the skip_uc_load field, which will be set
+ * only after the microcontroller has reported it has completed its
+ * initialization.
+ */
+static const struct ipa_init_modem_driver_req *init_modem_driver_req(void)
+{
+	static struct ipa_init_modem_driver_req req;
+	u32 base;
+
+	/* This is not the first boot if the microcontroller is loaded */
+	req.skip_uc_load = ipa_uc_loaded() ? 1 : 0;
+	req.skip_uc_load_valid = true;
+
+	/* We only have to initialize most of it once */
+	if (req.platform_type_valid)
+		return &req;
+
+	/* All offsets are relative to the start of IPA shared memory */
+	base = (u32)ipa_ctx->smem_offset;
+
+	req.platform_type_valid = true;
+	req.platform_type = IPA_QMI_PLATFORM_TYPE_MSM_ANDROID;
+
+	req.hdr_tbl_info_valid = IPA_MEM_MODEM_HDR_SIZE ? 1 : 0;
+	req.hdr_tbl_info.start = base + IPA_MEM_MODEM_HDR_OFST;
+	req.hdr_tbl_info.end = req.hdr_tbl_info.start +
+					IPA_MEM_MODEM_HDR_SIZE - 1;
+
+	req.v4_route_tbl_info_valid = true;
+	req.v4_route_tbl_info.start = base + IPA_MEM_V4_RT_NHASH_OFST;
+	req.v4_route_tbl_info.count = IPA_MEM_MODEM_RT_COUNT;
+
+	req.v6_route_tbl_info_valid = true;
+	req.v6_route_tbl_info.start = base + IPA_MEM_V6_RT_NHASH_OFST;
+	req.v6_route_tbl_info.count = IPA_MEM_MODEM_RT_COUNT;
+
+	req.v4_filter_tbl_start_valid = true;
+	req.v4_filter_tbl_start = base + IPA_MEM_V4_FLT_NHASH_OFST;
+
+	req.v6_filter_tbl_start_valid = true;
+	req.v6_filter_tbl_start = base + IPA_MEM_V6_FLT_NHASH_OFST;
+
+	req.modem_mem_info_valid = IPA_MEM_MODEM_SIZE ? 1 : 0;
+	req.modem_mem_info.start = base + IPA_MEM_MODEM_OFST;
+	req.modem_mem_info.size = IPA_MEM_MODEM_SIZE;
+
+	req.ctrl_comm_dest_end_pt_valid = true;
+	req.ctrl_comm_dest_end_pt = ipa_client_ep_id(IPA_CLIENT_APPS_WAN_CONS);
+
+	req.hdr_proc_ctx_tbl_info_valid =
+			IPA_MEM_MODEM_HDR_PROC_CTX_SIZE ? 1 : 0;
+	req.hdr_proc_ctx_tbl_info.start =
+			base + IPA_MEM_MODEM_HDR_PROC_CTX_OFST;
+	req.hdr_proc_ctx_tbl_info.end = req.hdr_proc_ctx_tbl_info.start +
+			IPA_MEM_MODEM_HDR_PROC_CTX_SIZE - 1;
+
+	req.v4_hash_route_tbl_info_valid = true;
+	req.v4_hash_route_tbl_info.start = base + IPA_MEM_V4_RT_HASH_OFST;
+	req.v4_hash_route_tbl_info.count = IPA_MEM_MODEM_RT_COUNT;
+
+	req.v6_hash_route_tbl_info_valid = true;
+	req.v6_hash_route_tbl_info.start = base + IPA_MEM_V6_RT_HASH_OFST;
+	req.v6_hash_route_tbl_info.count = IPA_MEM_MODEM_RT_COUNT;
+
+	req.v4_hash_filter_tbl_start_valid = true;
+	req.v4_hash_filter_tbl_start = base + IPA_MEM_V4_FLT_HASH_OFST;
+
+	req.v6_hash_filter_tbl_start_valid = true;
+	req.v6_hash_filter_tbl_start = base + IPA_MEM_V6_FLT_HASH_OFST;
+
+	return &req;
+}
+
+/* The modem service we requested is now available via the client
+ * handle.  Send an INIT_DRIVER request to the modem.
+ */
+static int
+ipa_client_new_server(struct qmi_handle *qmi, struct qmi_service *svc)
+{
+	const struct ipa_init_modem_driver_req *req = init_modem_driver_req();
+	struct sockaddr_qrtr sq;
+	struct qmi_txn *txn;
+	int ret;
+
+	txn = kzalloc(sizeof(*txn), GFP_KERNEL);
+	if (!txn)
+		return -ENOMEM;
+
+	ret = qmi_txn_init(qmi, txn, NULL, NULL);
+	if (ret) {
+		kfree(txn);
+		return ret;
+	}
+
+	sq.sq_family = AF_QIPCRTR;
+	sq.sq_node = svc->node;
+	sq.sq_port = svc->port;
+
+	ret = qmi_send_request(qmi, &sq, txn, IPA_QMI_INIT_DRIVER,
+			       IPA_QMI_INIT_DRIVER_REQ_SZ,
+			       ipa_init_modem_driver_req_ei, req);
+	if (!ret)
+		ret = qmi_txn_wait(txn, MAX_SCHEDULE_TIMEOUT);
+	if (ret)
+		qmi_txn_cancel(txn);
+	kfree(txn);
+
+	return ret;
+}
+
+/* The only callback we supply for the client handle is notification
+ * that the service on the modem has become available.
+ */
+static struct qmi_ops ipa_client_ops = {
+	.new_server	= ipa_client_new_server,
+};
+
+static int ipa_qmi_initialize(void)
+{
+	int ret;
+
+	/* The only handle operation that might be interesting for the
+	 * server would be del_client, to find out when the modem side
+	 * client has disappeared.  But other than reporting the event,
+	 * we wouldn't do anything about that.  So we just pass a null
+	 * pointer for its handle operations.  All the real work is
+	 * done by the message handlers.
+	 */
+	ret = qmi_handle_init(&server_handle, IPA_QMI_SERVER_MAX_RCV_SZ,
+			      NULL, ipa_server_msg_handlers);
+	if (ret < 0)
+		return ret;
+
+	ret = qmi_add_server(&server_handle, IPA_HOST_SERVICE_SVC_ID,
+			     IPA_HOST_SVC_VERS, IPA_HOST_SERVICE_INS_ID);
+	if (ret < 0)
+		goto err_release_server_handle;
+
+	/* The client handle is only used for sending an INIT_DRIVER
+	 * request to the modem, and receiving its response message.
+	 */
+	ret = qmi_handle_init(&client_handle, IPA_QMI_CLIENT_MAX_RCV_SZ,
+			      &ipa_client_ops, ipa_client_msg_handlers);
+	if (ret < 0)
+		goto err_release_server_handle;
+
+	ret = qmi_add_lookup(&client_handle, IPA_MODEM_SERVICE_SVC_ID,
+			     IPA_MODEM_SVC_VERS, IPA_MODEM_SERVICE_INS_ID);
+	if (ret < 0)
+		goto err_release_client_handle;
+
+	ipa_qmi_initialized = true;
+
+	return 0;
+
+err_release_client_handle:
+	/* Releasing the handle also removes registered lookups */
+	qmi_handle_release(&client_handle);
+	memset(&client_handle, 0, sizeof(client_handle));
+err_release_server_handle:
+	/* Releasing the handle also removes registered services */
+	qmi_handle_release(&server_handle);
+	memset(&server_handle, 0, sizeof(server_handle));
+
+	return ret;
+}
+
+/* This is called by the rmnet probe routine.  The rmnet driver can
+ * be unregistered after it has been initialized as a result of a
+ * subsystem shutdown; it can later be registered again if a
+ * subsystem restart occurs.  This function can therefore be called
+ * more than once.
+ */
+int ipa_qmi_init(void)
+{
+	init_driver_response_received = false;
+	indication_register_received = false;
+
+	if (!ipa_qmi_initialized)
+		return ipa_qmi_initialize();
+
+	return 0;
+}
+
+void ipa_qmi_exit(void)
+{
+	if (!ipa_qmi_initialized)
+		return;
+
+	qmi_handle_release(&client_handle);
+	memset(&client_handle, 0, sizeof(client_handle));
+
+	qmi_handle_release(&server_handle);
+	memset(&server_handle, 0, sizeof(server_handle));
+
+	ipa_qmi_initialized = false;
+}
diff --git a/drivers/net/ipa/ipa_qmi.h b/drivers/net/ipa/ipa_qmi.h
new file mode 100644
index 000000000000..3c03ff5c0454
--- /dev/null
+++ b/drivers/net/ipa/ipa_qmi.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPA_QMI_H_
+#define _IPA_QMI_H_
+
+int ipa_qmi_init(void);
+void ipa_qmi_exit(void);
+
+#endif /* !_IPA_QMI_H_ */
diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
new file mode 100644
index 000000000000..c5347c63ef41
--- /dev/null
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#include <linux/stddef.h>
+#include <linux/soc/qcom/qmi.h>
+
+#include "ipa_qmi_msg.h"
+
+#ifndef sizeof_field
+#define sizeof_field(TYPE, MEMBER)	sizeof(((TYPE *)0)->MEMBER)
+#endif /* !sizeof_field */
+
+/* QMI message structure definition for struct ipa_indication_register_req */
+struct qmi_elem_info ipa_indication_register_req_ei[] = {
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_indication_register_req,
+				     master_driver_init_complete_valid),
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct ipa_indication_register_req,
+					   master_driver_init_complete_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_indication_register_req,
+				     master_driver_init_complete),
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct ipa_indication_register_req,
+					   master_driver_init_complete),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_indication_register_req,
+				     data_usage_quota_reached_valid),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_indication_register_req,
+					   data_usage_quota_reached_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_indication_register_req,
+				     data_usage_quota_reached),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_indication_register_req,
+					   data_usage_quota_reached),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_indication_register_rsp */
+struct qmi_elem_info ipa_indication_register_rsp_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_indication_register_rsp,
+				     rsp),
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct ipa_indication_register_rsp,
+					   rsp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_driver_init_complete_req */
+struct qmi_elem_info ipa_driver_init_complete_req_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_driver_init_complete_req,
+				     status),
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct ipa_driver_init_complete_req,
+					   status),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_driver_init_complete_rsp */
+struct qmi_elem_info ipa_driver_init_complete_rsp_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_driver_init_complete_rsp,
+				     rsp),
+		.tlv_type	= 0x02,
+		.elem_size	= offsetof(struct ipa_driver_init_complete_rsp,
+					   rsp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_init_complete_ind */
+struct qmi_elem_info ipa_init_complete_ind_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_complete_ind,
+				     status),
+		.tlv_type	= 0x02,
+		.elem_size	= offsetof(struct ipa_init_complete_ind,
+					   status),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_mem_bounds */
+struct qmi_elem_info ipa_mem_bounds_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_bounds, start),
+		.offset		= offsetof(struct ipa_mem_bounds, start),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_bounds, end),
+		.offset		= offsetof(struct ipa_mem_bounds, end),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_mem_array */
+struct qmi_elem_info ipa_mem_array_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_array, start),
+		.offset		= offsetof(struct ipa_mem_array, start),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_array, count),
+		.offset		= offsetof(struct ipa_mem_array, count),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_mem_range */
+struct qmi_elem_info ipa_mem_range_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_range, start),
+		.offset		= offsetof(struct ipa_mem_range, start),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_mem_range, size),
+		.offset		= offsetof(struct ipa_mem_range, size),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_init_modem_driver_req */
+struct qmi_elem_info ipa_init_modem_driver_req_ei[] = {
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     platform_type_valid),
+		.tlv_type	= 0x10,
+		.elem_size	= offsetof(struct ipa_init_modem_driver_req,
+					   platform_type_valid),
+	},
+	{
+		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     platform_type),
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   platform_type),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     hdr_tbl_info_valid),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   hdr_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     hdr_tbl_info),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   hdr_tbl_info),
+		.ei_array	= ipa_mem_bounds_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_route_tbl_info_valid),
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_route_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_route_tbl_info),
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_route_tbl_info),
+		.ei_array	= ipa_mem_array_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_route_tbl_info_valid),
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_route_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_route_tbl_info),
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_route_tbl_info),
+		.ei_array	= ipa_mem_array_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_filter_tbl_start_valid),
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_filter_tbl_start_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_filter_tbl_start),
+		.tlv_type	= 0x14,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_filter_tbl_start),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_filter_tbl_start_valid),
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_filter_tbl_start_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_filter_tbl_start),
+		.tlv_type	= 0x15,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_filter_tbl_start),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     modem_mem_info_valid),
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   modem_mem_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     modem_mem_info),
+		.tlv_type	= 0x16,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   modem_mem_info),
+		.ei_array	= ipa_mem_range_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     ctrl_comm_dest_end_pt_valid),
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   ctrl_comm_dest_end_pt_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     ctrl_comm_dest_end_pt),
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   ctrl_comm_dest_end_pt),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     skip_uc_load_valid),
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   skip_uc_load_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     skip_uc_load),
+		.tlv_type	= 0x18,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   skip_uc_load),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     hdr_proc_ctx_tbl_info_valid),
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   hdr_proc_ctx_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     hdr_proc_ctx_tbl_info),
+		.tlv_type	= 0x19,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   hdr_proc_ctx_tbl_info),
+		.ei_array	= ipa_mem_bounds_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     zip_tbl_info_valid),
+		.tlv_type	= 0x1a,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   zip_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     zip_tbl_info),
+		.tlv_type	= 0x1a,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   zip_tbl_info),
+		.ei_array	= ipa_mem_bounds_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_hash_route_tbl_info_valid),
+		.tlv_type	= 0x1b,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_hash_route_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_hash_route_tbl_info),
+		.tlv_type	= 0x1b,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_hash_route_tbl_info),
+		.ei_array	= ipa_mem_array_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_hash_route_tbl_info_valid),
+		.tlv_type	= 0x1c,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_hash_route_tbl_info_valid),
+	},
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_hash_route_tbl_info),
+		.tlv_type	= 0x1c,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_hash_route_tbl_info),
+		.ei_array	= ipa_mem_array_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_hash_filter_tbl_start_valid),
+		.tlv_type	= 0x1d,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_hash_filter_tbl_start_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v4_hash_filter_tbl_start),
+		.tlv_type	= 0x1d,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v4_hash_filter_tbl_start),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_hash_filter_tbl_start_valid),
+		.tlv_type	= 0x1e,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_hash_filter_tbl_start_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_req,
+				     v6_hash_filter_tbl_start),
+		.tlv_type	= 0x1e,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
+					   v6_hash_filter_tbl_start),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
+
+/* QMI message structure definition for struct ipa_init_modem_driver_rsp */
+struct qmi_elem_info ipa_init_modem_driver_rsp_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     rsp),
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   rsp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     ctrl_comm_dest_end_pt_valid),
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   ctrl_comm_dest_end_pt_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     ctrl_comm_dest_end_pt),
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   ctrl_comm_dest_end_pt),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     default_end_pt_valid),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   default_end_pt_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     default_end_pt),
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   default_end_pt),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     modem_driver_init_pending_valid),
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   modem_driver_init_pending_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	=
+			sizeof_field(struct ipa_init_modem_driver_rsp,
+				     modem_driver_init_pending),
+		.tlv_type	= 0x12,
+		.offset		= offsetof(struct ipa_init_modem_driver_rsp,
+					   modem_driver_init_pending),
+	},
+	{
+		.data_type	= QMI_EOTI,
+	},
+};
diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
new file mode 100644
index 000000000000..009ce65ea114
--- /dev/null
+++ b/drivers/net/ipa/ipa_qmi_msg.h
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPA_QMI_MSG_H_
+#define _IPA_QMI_MSG_H_
+
+/* Request/response/indication QMI message ids used for IPA.  Receiving
+ * end issues a response for requests; indications require no response.
+ */
+#define IPA_QMI_INDICATION_REGISTER	0x20	/* modem -> AP request */
+#define IPA_QMI_INIT_DRIVER		0x21	/* AP -> modem request */
+#define IPA_QMI_INIT_COMPLETE_IND	0x22	/* AP -> modem indication */
+#define IPA_QMI_DRIVER_INIT_COMPLETE	0x35	/* modem -> AP request */
+
+/* The maximum size required for message types.  These sizes include
+ * the message data, along with type (1 byte) and length (2 byte)
+ * information for each field.  The qmi_send_*() interfaces require
+ * the message size to be provided.
+ */
+#define IPA_QMI_INDICATION_REGISTER_REQ_SZ	8	/* -> server handle */
+#define IPA_QMI_INDICATION_REGISTER_RSP_SZ	7	/* <- server handle */
+#define IPA_QMI_INIT_DRIVER_REQ_SZ		134	/* client handle -> */
+#define IPA_QMI_INIT_DRIVER_RSP_SZ		25	/* client handle <- */
+#define IPA_QMI_INIT_COMPLETE_IND_SZ		7	/* server handle -> */
+#define IPA_QMI_DRIVER_INIT_COMPLETE_REQ_SZ	4	/* -> server handle */
+#define IPA_QMI_DRIVER_INIT_COMPLETE_RSP_SZ	7	/* <- server handle */
+
+/* Maximum size of messages we expect the AP to receive (max of above) */
+#define IPA_QMI_SERVER_MAX_RCV_SZ		8
+#define IPA_QMI_CLIENT_MAX_RCV_SZ		25
+
+/* Request message for the IPA_QMI_INDICATION_REGISTER request */
+struct ipa_indication_register_req {
+	u8 master_driver_init_complete_valid;
+	u8 master_driver_init_complete;
+	u8 data_usage_quota_reached_valid;
+	u8 data_usage_quota_reached;
+};
+
+/* The response to a IPA_QMI_INDICATION_REGISTER request consists only of
+ * a standard QMI response.
+ */
+struct ipa_indication_register_rsp {
+	struct qmi_response_type_v01 rsp;
+};
+
+/* Request message for the IPA_QMI_DRIVER_INIT_COMPLETE request */
+struct ipa_driver_init_complete_req {
+	u8 status;
+};
+
+/* The response to a IPA_QMI_DRIVER_INIT_COMPLETE request consists only
+ * of a standard QMI response.
+ */
+struct ipa_driver_init_complete_rsp {
+	struct qmi_response_type_v01 rsp;
+};
+
+/* The message for the IPA_QMI_INIT_COMPLETE_IND indication consists
+ * only of a standard QMI response.
+ */
+struct ipa_init_complete_ind {
+	struct qmi_response_type_v01 status;
+};
+
+/* The AP tells the modem its platform type.  We assume Android. */
+enum ipa_platform_type {
+	IPA_QMI_PLATFORM_TYPE_INVALID		= 0,	/* Invalid */
+	IPA_QMI_PLATFORM_TYPE_TN		= 1,	/* Data card */
+	IPA_QMI_PLATFORM_TYPE_LE		= 2,	/* Data router */
+	IPA_QMI_PLATFORM_TYPE_MSM_ANDROID	= 3,	/* Android MSM */
+	IPA_QMI_PLATFORM_TYPE_MSM_WINDOWS	= 4,	/* Windows MSM */
+	IPA_QMI_PLATFORM_TYPE_MSM_QNX_V01	= 5,	/* QNX MSM */
+};
+
+/* This defines the start and end offset of a range of memory.  Both
+ * fields are offsets relative to the start of IPA shared memory.
+ * The end value is the last addressable byte *within* the range.
+ */
+struct ipa_mem_bounds {
+	u32 start;
+	u32 end;
+};
+
+/* This defines the location and size of an array.  The start value
+ * is an offset relative to the start of IPA shared memory.  The
+ * size of the array is implied by the number of entries (the entry
+ * size is assumed to be known).
+ */
+struct ipa_mem_array {
+	u32 start;
+	u32 count;
+};
+
+/* This defines the location and size of a range of memory.  The
+ * start is an offset relative to the start of IPA shared memory.
+ * This differs from the ipa_mem_bounds structure in that the size
+ * (in bytes) of the memory region is specified rather than the
+ * offset of its last byte.
+ */
+struct ipa_mem_range {
+	u32 start;
+	u32 size;
+};
+
+/* The message for the IPA_QMI_INIT_DRIVER request contains information
+ * from the AP that affects modem initialization.
+ */
+struct ipa_init_modem_driver_req {
+	u8			platform_type_valid;
+	u32			platform_type;	/* enum ipa_platform_type */
+
+	/* Modem header table information.  This defines the IPA shared
+	 * memory in which the modem may insert header table entries.
+	 */
+	u8			hdr_tbl_info_valid;
+	struct ipa_mem_bounds	hdr_tbl_info;
+
+	/* Routing table information.  These define the location and size of
+	 * non-hashable IPv4 and IPv6 filter tables.  The start values are
+	 * offsets relative to the start of IPA shared memory.
+	 */
+	u8			v4_route_tbl_info_valid;
+	struct ipa_mem_array	v4_route_tbl_info;
+	u8			v6_route_tbl_info_valid;
+	struct ipa_mem_array	v6_route_tbl_info;
+
+	/* Filter table information.  These define the location and size of
+	 * non-hashable IPv4 and IPv6 filter tables.  The start values are
+	 * offsets relative to the start of IPA shared memory.
+	 */
+	u8			v4_filter_tbl_start_valid;
+	u32			v4_filter_tbl_start;
+	u8			v6_filter_tbl_start_valid;
+	u32			v6_filter_tbl_start;
+
+	/* Modem memory information.  This defines the location and
+	 * size of memory available for the modem to use.
+	 */
+	u8			modem_mem_info_valid;
+	struct ipa_mem_range	modem_mem_info;
+
+	/* This defines the destination endpoint on the AP to which
+	 * the modem driver can send control commands.  IPA supports
+	 * 20 endpoints, so this must be 19 or less.
+	 */
+	u8			ctrl_comm_dest_end_pt_valid;
+	u32			ctrl_comm_dest_end_pt;
+
+	/* This defines whether the modem should load the microcontroller
+	 * or not.  It is unnecessary to reload it if the modem is being
+	 * restarted.
+	 *
+	 * NOTE: this field is named "is_ssr_bootup" elsewhere.
+	 */
+	u8			skip_uc_load_valid;
+	u8			skip_uc_load;
+
+	/* Processing context memory information.  This defines the memory in
+	 * which the modem may insert header processing context table entries.
+	 */
+	u8			hdr_proc_ctx_tbl_info_valid;
+	struct ipa_mem_bounds	hdr_proc_ctx_tbl_info;
+
+	/* Compression command memory information.  This defines the memory
+	 * in which the modem may insert compression/decompression commands.
+	 */
+	u8			zip_tbl_info_valid;
+	struct ipa_mem_bounds	zip_tbl_info;
+
+	/* Routing table information.  These define the location and size
+	 * of hashable IPv4 and IPv6 filter tables.  The start values are
+	 * offsets relative to the start of IPA shared memory.
+	 */
+	u8			v4_hash_route_tbl_info_valid;
+	struct ipa_mem_array	v4_hash_route_tbl_info;
+	u8			v6_hash_route_tbl_info_valid;
+	struct ipa_mem_array	v6_hash_route_tbl_info;
+
+	/* Filter table information.  These define the location and size
+	 * of hashable IPv4 and IPv6 filter tables.  The start values are
+	 * offsets relative to the start of IPA shared memory.
+	 */
+	u8			v4_hash_filter_tbl_start_valid;
+	u32			v4_hash_filter_tbl_start;
+	u8			v6_hash_filter_tbl_start_valid;
+	u32			v6_hash_filter_tbl_start;
+};
+
+/* The response to a IPA_QMI_INIT_DRIVER request begins with a standard
+ * QMI response, but contains other information as well.  Currently we
+ * simply wait for the the INIT_DRIVER transaction to complete and
+ * ignore any other data that might be returned.
+ */
+struct ipa_init_modem_driver_rsp {
+	struct qmi_response_type_v01	rsp;
+
+	/* This defines the destination endpoint on the modem to which
+	 * the AP driver can send control commands.  IPA supports
+	 * 20 endpoints, so this must be 19 or less.
+	 */
+	u8				ctrl_comm_dest_end_pt_valid;
+	u32				ctrl_comm_dest_end_pt;
+
+	/* This defines the default endpoint.  The AP driver is not
+	 * required to configure the hardware with this value.  IPA
+	 * supports 20 endpoints, so this must be 19 or less.
+	 */
+	u8				default_end_pt_valid;
+	u32				default_end_pt;
+
+	/* This defines whether a second handshake is required to complete
+	 * initialization.
+	 */
+	u8				modem_driver_init_pending_valid;
+	u8				modem_driver_init_pending;
+};
+
+/* Message structure definitions defined in "ipa_qmi_msg.c" */
+extern struct qmi_elem_info ipa_indication_register_req_ei[];
+extern struct qmi_elem_info ipa_indication_register_rsp_ei[];
+extern struct qmi_elem_info ipa_driver_init_complete_req_ei[];
+extern struct qmi_elem_info ipa_driver_init_complete_rsp_ei[];
+extern struct qmi_elem_info ipa_init_complete_ind_ei[];
+extern struct qmi_elem_info ipa_mem_bounds_ei[];
+extern struct qmi_elem_info ipa_mem_array_ei[];
+extern struct qmi_elem_info ipa_mem_range_ei[];
+extern struct qmi_elem_info ipa_init_modem_driver_req_ei[];
+extern struct qmi_elem_info ipa_init_modem_driver_rsp_ei[];
+
+#endif /* !_IPA_QMI_MSG_H_ */
-- 
2.17.1

