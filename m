Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DnxnFgLzG1tQYAAAmS7hNA
	; Sat, 09 Jun 2018 15:34:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4E77608CA; Sat,  9 Jun 2018 15:34:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsyTzyC/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24CA8607DC;
	Sat,  9 Jun 2018 15:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24CA8607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeFIPeC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932769AbeFIPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:48 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F7E204EC;
        Sat,  9 Jun 2018 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558428;
        bh=U1dAjqJ2MEjTz9Ny+lPLWFyvnfEdhWFuYNLo9WYJtc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsyTzyC/s7n2jwsGV8Z2QDOARVa1PmVWh7AK2yQrrgEAqwOwVK4PQ7k0LJkJ1cljY
         m6xPYs72xWzZuiOFIJDyBnaHecczryqAC7NE4bIEiCr3VY8kPrQpDRXHbyXbeLeIgy
         8jUnxXP4NVWDIXXsOePPe3cMdLKKXsnOPs8lndpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.16 48/48] PCI: hv: Do not wait forever on a device that has disappeared
Date: Sat,  9 Jun 2018 17:30:00 +0200
Message-Id: <20180609145951.076280982@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit c3635da2a336441253c33298b87b3042db100725 upstream.

Before the guest finishes the device initialization, the device can be
removed anytime by the host, and after that the host won't respond to
the guest's request, so the guest should be prepared to handle this
case.

Add a polling mechanism to detect device presence.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
[lorenzo.pieralisi@arm.com: edited commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-hyperv.c |   46 +++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_d
 static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 
+/*
+ * There is no good way to get notified from vmbus_onoffer_rescind(),
+ * so let's use polling here, since this is not a hot path.
+ */
+static int wait_for_response(struct hv_device *hdev,
+			     struct completion *comp)
+{
+	while (true) {
+		if (hdev->channel->rescind) {
+			dev_warn_once(&hdev->device, "The device is gone.\n");
+			return -ENODEV;
+		}
+
+		if (wait_for_completion_timeout(comp, HZ / 10))
+			break;
+	}
+
+	return 0;
+}
+
 /**
  * devfn_to_wslot() - Convert from Linux PCI slot to Windows
  * @devfn:	The Linux representation of PCI slot
@@ -1568,7 +1588,8 @@ static struct hv_pci_dev *new_pcichild_d
 	if (ret)
 		goto error;
 
-	wait_for_completion(&comp_pkt.host_event);
+	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
+		goto error;
 
 	hpdev->desc = *desc;
 	refcount_set(&hpdev->refs, 1);
@@ -2061,15 +2082,16 @@ static int hv_pci_protocol_negotiation(s
 				sizeof(struct pci_version_request),
 				(unsigned long)pkt, VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (!ret)
+			ret = wait_for_response(hdev, &comp_pkt.host_event);
+
 		if (ret) {
 			dev_err(&hdev->device,
-				"PCI Pass-through VSP failed sending version reqquest: %#x",
+				"PCI Pass-through VSP failed to request version: %d",
 				ret);
 			goto exit;
 		}
 
-		wait_for_completion(&comp_pkt.host_event);
-
 		if (comp_pkt.completion_status >= 0) {
 			pci_protocol_version = pci_protocol_versions[i];
 			dev_info(&hdev->device,
@@ -2278,11 +2300,12 @@ static int hv_pci_enter_d0(struct hv_dev
 	ret = vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
 			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (!ret)
+		ret = wait_for_response(hdev, &comp_pkt.host_event);
+
 	if (ret)
 		goto exit;
 
-	wait_for_completion(&comp_pkt.host_event);
-
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -2322,11 +2345,10 @@ static int hv_pci_query_relations(struct
 
 	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
 			       0, VM_PKT_DATA_INBAND, 0);
-	if (ret)
-		return ret;
+	if (!ret)
+		ret = wait_for_response(hdev, &comp);
 
-	wait_for_completion(&comp);
-	return 0;
+	return ret;
 }
 
 /**
@@ -2396,11 +2418,11 @@ static int hv_send_resources_allocated(s
 				size_res, (unsigned long)pkt,
 				VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		if (!ret)
+			ret = wait_for_response(hdev, &comp_pkt.host_event);
 		if (ret)
 			break;
 
-		wait_for_completion(&comp_pkt.host_event);
-
 		if (comp_pkt.completion_status < 0) {
 			ret = -EPROTO;
 			dev_err(&hdev->device,
