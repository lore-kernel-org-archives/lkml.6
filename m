Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9268DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6AF2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp09aiK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6AF2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeJSCJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbeJSCJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9E4204FD;
        Thu, 18 Oct 2018 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886013;
        bh=Dc/JuhonEwyxFPxYoRu1Fc+zFKcLZOQY3MUCRSL0ZLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jp09aiK4vSHJFYwlNpus9Z5Sb4sJGf0kWY1w0ejKX70bhtBZxGAwxy/VYgqjmZ7Rd
         yHrop/yd4axuZL29vrZUF8L5z0DWPmBUZ7/kneAfE1E5ziLNE+cY2GtCEk+WqvrOx5
         tiSMyer2qARZDK3aOMBYtoedrLKWUT6EZPRHqmjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4.4 46/48] Drivers: hv: util: Pass the channel information during the init call
Date:   Thu, 18 Oct 2018 19:55:21 +0200
Message-Id: <20181018175430.353000104@linuxfoundation.org>
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

From: K. Y. Srinivasan <kys@microsoft.com>

commit b9830d120cbe155863399f25eaef6aa8353e767f upstream.

Pass the channel information to the util drivers that need to defer
reading the channel while they are processing a request. This would address
the following issue reported by Vitaly:

Commit 3cace4a61610 ("Drivers: hv: utils: run polling callback always in
interrupt context") removed direct *_transaction.state = HVUTIL_READY
assignments from *_handle_handshake() functions introducing the following
race: if a userspace daemon connects before we get first non-negotiation
request from the server hv_poll_channel() won't set transaction state to
HVUTIL_READY as (!channel) condition will fail, we set it to non-NULL on
the first real request from the server.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv_fcopy.c    |    2 +-
 drivers/hv/hv_kvp.c      |    2 +-
 drivers/hv/hv_snapshot.c |    2 +-
 drivers/hv/hv_util.c     |    1 +
 include/linux/hyperv.h   |    1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -256,7 +256,6 @@ void hv_fcopy_onchannelcallback(void *co
 		 */
 
 		fcopy_transaction.recv_len = recvlen;
-		fcopy_transaction.recv_channel = channel;
 		fcopy_transaction.recv_req_id = requestid;
 		fcopy_transaction.fcopy_msg = fcopy_msg;
 
@@ -323,6 +322,7 @@ static void fcopy_on_reset(void)
 int hv_fcopy_init(struct hv_util_service *srv)
 {
 	recv_buffer = srv->recv_buffer;
+	fcopy_transaction.recv_channel = srv->channel;
 
 	init_completion(&release_event);
 	/*
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -640,7 +640,6 @@ void hv_kvp_onchannelcallback(void *cont
 			 */
 
 			kvp_transaction.recv_len = recvlen;
-			kvp_transaction.recv_channel = channel;
 			kvp_transaction.recv_req_id = requestid;
 			kvp_transaction.kvp_msg = kvp_msg;
 
@@ -690,6 +689,7 @@ int
 hv_kvp_init(struct hv_util_service *srv)
 {
 	recv_buffer = srv->recv_buffer;
+	kvp_transaction.recv_channel = srv->channel;
 
 	init_completion(&release_event);
 	/*
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -264,7 +264,6 @@ void hv_vss_onchannelcallback(void *cont
 			 */
 
 			vss_transaction.recv_len = recvlen;
-			vss_transaction.recv_channel = channel;
 			vss_transaction.recv_req_id = requestid;
 			vss_transaction.msg = (struct hv_vss_msg *)vss_msg;
 
@@ -340,6 +339,7 @@ hv_vss_init(struct hv_util_service *srv)
 		return -ENOTSUPP;
 	}
 	recv_buffer = srv->recv_buffer;
+	vss_transaction.recv_channel = srv->channel;
 
 	/*
 	 * When this driver loads, the user level daemon that
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -326,6 +326,7 @@ static int util_probe(struct hv_device *
 	srv->recv_buffer = kmalloc(PAGE_SIZE * 4, GFP_KERNEL);
 	if (!srv->recv_buffer)
 		return -ENOMEM;
+	srv->channel = dev->channel;
 	if (srv->util_init) {
 		ret = srv->util_init(srv);
 		if (ret) {
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1179,6 +1179,7 @@ int vmbus_allocate_mmio(struct resource
 
 struct hv_util_service {
 	u8 *recv_buffer;
+	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
 	void (*util_deinit)(void);


