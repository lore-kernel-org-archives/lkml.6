Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5DDC04EBB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0FE224E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="azt0ILVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0FE224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbeKLISd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732860AbeKLISb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:31 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D042241B;
        Sun, 11 Nov 2018 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975315;
        bh=DwpjEVLcEHCD0l5nf1fC23ksVd8HPL3APqAlRfIq4fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azt0ILVY67/odkcIPOkYSSGGYD7BlR7juyjRROQNvNm77239nuB6P8ruyTNi/IJPL
         xqhs48YMoo9tsI/bDvMZBKprH8p/TPeYVFTNXGLMAiDXYxzGq96rPKIsR8fF6ULyzE
         y9fWTx/khkXQ4iA0IyqHXd50OziYXFRdHfC+I0tM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 303/361] media: cec: fix the Signal Free Time calculation
Date:   Sun, 11 Nov 2018 14:20:50 -0800
Message-Id: <20181111221657.655086036@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 7d867a1b765e2b70815fec4964d7822a976ed349 upstream.

The calculation of the Signal Free Time in the framework was not
correct. If a message was received, then the next transmit should be
considered a New Initiator and use a shorter SFT value.

This was not done with the result that if both sides where continually
sending messages, they both could use the same SFT value and one side
could deny the other side access to the bus.

Note that this fix does not take the corner case into account where
a receive is in progress when you call adap_transmit.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/cec/cec-adap.c |   26 +++++++-------------------
 include/media/cec.h          |    2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -513,9 +513,11 @@ int cec_thread_func(void *_adap)
 		if (data->attempts) {
 			/* should be >= 3 data bit periods for a retry */
 			signal_free_time = CEC_SIGNAL_FREE_TIME_RETRY;
-		} else if (data->new_initiator) {
+		} else if (adap->last_initiator !=
+			   cec_msg_initiator(&data->msg)) {
 			/* should be >= 5 data bit periods for new initiator */
 			signal_free_time = CEC_SIGNAL_FREE_TIME_NEW_INITIATOR;
+			adap->last_initiator = cec_msg_initiator(&data->msg);
 		} else {
 			/*
 			 * should be >= 7 data bit periods for sending another
@@ -700,7 +702,6 @@ int cec_transmit_msg_fh(struct cec_adapt
 			struct cec_fh *fh, bool block)
 {
 	struct cec_data *data;
-	u8 last_initiator = 0xff;
 
 	msg->rx_ts = 0;
 	msg->tx_ts = 0;
@@ -810,23 +811,6 @@ int cec_transmit_msg_fh(struct cec_adapt
 	data->adap = adap;
 	data->blocking = block;
 
-	/*
-	 * Determine if this message follows a message from the same
-	 * initiator. Needed to determine the free signal time later on.
-	 */
-	if (msg->len > 1) {
-		if (!(list_empty(&adap->transmit_queue))) {
-			const struct cec_data *last;
-
-			last = list_last_entry(&adap->transmit_queue,
-					       const struct cec_data, list);
-			last_initiator = cec_msg_initiator(&last->msg);
-		} else if (adap->transmitting) {
-			last_initiator =
-				cec_msg_initiator(&adap->transmitting->msg);
-		}
-	}
-	data->new_initiator = last_initiator != cec_msg_initiator(msg);
 	init_completion(&data->c);
 	INIT_DELAYED_WORK(&data->work, cec_wait_timeout);
 
@@ -1014,6 +998,8 @@ void cec_received_msg_ts(struct cec_adap
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
+	adap->last_initiator = 0xff;
+
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
 		valid_la = cec_has_log_addr(adap, msg_dest);
@@ -1476,6 +1462,8 @@ void __cec_s_phys_addr(struct cec_adapte
 	}
 
 	mutex_lock(&adap->devnode.lock);
+	adap->last_initiator = 0xff;
+
 	if ((adap->needs_hpd || list_empty(&adap->devnode.fhs)) &&
 	    adap->ops->adap_enable(adap, true)) {
 		mutex_unlock(&adap->devnode.lock);
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -63,7 +63,6 @@ struct cec_data {
 	struct delayed_work work;
 	struct completion c;
 	u8 attempts;
-	bool new_initiator;
 	bool blocking;
 	bool completed;
 };
@@ -174,6 +173,7 @@ struct cec_adapter {
 	bool is_configuring;
 	bool is_configured;
 	bool cec_pin_is_high;
+	u8 last_initiator;
 	u32 monitor_all_cnt;
 	u32 monitor_pin_cnt;
 	u32 follower_cnt;


