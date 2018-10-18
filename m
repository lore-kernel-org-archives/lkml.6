Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3D721476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeAUvp/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3D721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeJSCJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbeJSCJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F71A204FD;
        Thu, 18 Oct 2018 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886016;
        bh=bsSUSDkIovqOw60lwWa3Yl+3Y5rMmRIl2wEVmHWxSBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeAUvp/XgBNiSjlw5uIz+iFfvCaJ84xTg/JNevRrfyGFtHbuhn+k5Jn0oYWey440C
         d2iSdFUpEF3Pm0nsVPeXfFeHjbyLGsQJA8K3L12Mj5+LJgkCVmR4yVHNH3EetZdIAg
         aX4GPTgg9q25uHkONDUVsvMt6Os08IZNo89eg8jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4.4 47/48] Drivers: hv: kvp: fix IP Failover
Date:   Thu, 18 Oct 2018 19:55:22 +0200
Message-Id: <20181018175430.411024179@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 4dbfc2e68004c60edab7e8fd26784383dd3ee9bc upstream.

Hyper-V VMs can be replicated to another hosts and there is a feature to
set different IP for replicas, it is called 'Failover TCP/IP'. When
such guest starts Hyper-V host sends it KVP_OP_SET_IP_INFO message as soon
as we finish negotiation procedure. The problem is that it can happen (and
it actually happens) before userspace daemon connects and we reply with
HV_E_FAIL to the message. As there are no repetitions we fail to set the
requested IP.

Solve the issue by postponing our reply to the negotiation message till
userspace daemon is connected. We can't wait too long as there is a
host-side timeout (cca. 75 seconds) and if we fail to reply in this time
frame the whole KVP service will become inactive. The solution is not
ideal - if it takes userspace daemon more than 60 seconds to connect
IP Failover will still fail but I don't see a solution with our current
separation between kernel and userspace parts.

Other two modules (VSS and FCOPY) don't require such delay, leave them
untouched.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv_kvp.c       |   31 +++++++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h |    5 +++++
 2 files changed, 36 insertions(+)

--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -78,9 +78,11 @@ static void kvp_send_key(struct work_str
 
 static void kvp_respond_to_host(struct hv_kvp_msg *msg, int error);
 static void kvp_timeout_func(struct work_struct *dummy);
+static void kvp_host_handshake_func(struct work_struct *dummy);
 static void kvp_register(int);
 
 static DECLARE_DELAYED_WORK(kvp_timeout_work, kvp_timeout_func);
+static DECLARE_DELAYED_WORK(kvp_host_handshake_work, kvp_host_handshake_func);
 static DECLARE_WORK(kvp_sendkey_work, kvp_send_key);
 
 static const char kvp_devname[] = "vmbus/hv_kvp";
@@ -131,6 +133,11 @@ static void kvp_timeout_func(struct work
 	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 }
 
+static void kvp_host_handshake_func(struct work_struct *dummy)
+{
+	hv_poll_channel(kvp_transaction.recv_channel, hv_kvp_onchannelcallback);
+}
+
 static int kvp_handle_handshake(struct hv_kvp_msg *msg)
 {
 	switch (msg->kvp_hdr.operation) {
@@ -155,6 +162,12 @@ static int kvp_handle_handshake(struct h
 	pr_debug("KVP: userspace daemon ver. %d registered\n",
 		 KVP_OP_REGISTER);
 	kvp_register(dm_reg_value);
+
+	/*
+	 * If we're still negotiating with the host cancel the timeout
+	 * work to not poll the channel twice.
+	 */
+	cancel_delayed_work_sync(&kvp_host_handshake_work);
 	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 
 	return 0;
@@ -595,7 +608,22 @@ void hv_kvp_onchannelcallback(void *cont
 	struct icmsg_negotiate *negop = NULL;
 	int util_fw_version;
 	int kvp_srv_version;
+	static enum {NEGO_NOT_STARTED,
+		     NEGO_IN_PROGRESS,
+		     NEGO_FINISHED} host_negotiatied = NEGO_NOT_STARTED;
 
+	if (host_negotiatied == NEGO_NOT_STARTED &&
+	    kvp_transaction.state < HVUTIL_READY) {
+		/*
+		 * If userspace daemon is not connected and host is asking
+		 * us to negotiate we need to delay to not lose messages.
+		 * This is important for Failover IP setting.
+		 */
+		host_negotiatied = NEGO_IN_PROGRESS;
+		schedule_delayed_work(&kvp_host_handshake_work,
+				      HV_UTIL_NEGO_TIMEOUT * HZ);
+		return;
+	}
 	if (kvp_transaction.state > HVUTIL_READY)
 		return;
 
@@ -673,6 +701,8 @@ void hv_kvp_onchannelcallback(void *cont
 		vmbus_sendpacket(channel, recv_buffer,
 				       recvlen, requestid,
 				       VM_PKT_DATA_INBAND, 0);
+
+		host_negotiatied = NEGO_FINISHED;
 	}
 
 }
@@ -711,6 +741,7 @@ hv_kvp_init(struct hv_util_service *srv)
 void hv_kvp_deinit(void)
 {
 	kvp_transaction.state = HVUTIL_DEVICE_DYING;
+	cancel_delayed_work_sync(&kvp_host_handshake_work);
 	cancel_delayed_work_sync(&kvp_timeout_work);
 	cancel_work_sync(&kvp_sendkey_work);
 	hvutil_transport_destroy(hvt);
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -36,6 +36,11 @@
 #define HV_UTIL_TIMEOUT 30
 
 /*
+ * Timeout for guest-host handshake for services.
+ */
+#define HV_UTIL_NEGO_TIMEOUT 60
+
+/*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HVCPUID_VERSION_FEATURES).
  */


