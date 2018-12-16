Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF1C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6191121839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="DB2oFZjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeLPKUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:20:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42640 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbeLPKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:20:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so4743524plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4lGciqXuxRkWBcWMLd/OfHNvbQed3Eq4miXkQ1Y9S+o=;
        b=DB2oFZjzf4xCZynvBZBAFYhfrlR0ZO3mE6W+s86e1pudX2cW6w8v57cB509B+/kkTX
         v3avY1V5VCuH8ResG6xzS+CFn4mxatlsF4l6o4hquumcX3Eppj8UZjqdOxzByGyqQ7BB
         Ypw6Zu9MElKeZmtM+I090o6qkEgdV5f8ehAxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lGciqXuxRkWBcWMLd/OfHNvbQed3Eq4miXkQ1Y9S+o=;
        b=dsykwD/0hO3kvlV/b7Y+j9ShlsayKQRH9AGHE+uGKZ6Iu4vrVFuiotAS908kzLnZlo
         g8Md+iw9aKQEeA9XLW0FUDtJ5RvIJVx1KkKf5R+tyCR2rCl7y6pZ6LU7W2wc79abwILJ
         mK5P7m7Xpx7c/oHGTx5buCvUG92jDKO8iUXHxIwrMAMWs8SPnTkFfFYaPfP9n2IFww6N
         wh/sCbDf+satfjugIprbYdDoifj6c+VuqiBp2Xf0ViQYKKZjCKm+Y9lBBNtTvnaR4vGl
         bmBlxGvzPXgcVpW5t+DcErKcZucmWgrnEGP9EF6OfgE+PFu7eTdhw7UjXNSUCXdBVy54
         wj7g==
X-Gm-Message-State: AA+aEWYZywKqSY42q+UyH06WjCqqWzbRS1LhQEA37SL+w/YEWZZfonrd
        +N3RwbXxBzX8Ckr+1f0Ds9p0DA==
X-Google-Smtp-Source: AFSGD/XvGb/K/Y2d4BotstVdhBW7z5fJVfrcEOPvQ6xKB6tomu/UNu++p3fRWj7xhhCqlP/N2Auj2Q==
X-Received: by 2002:a17:902:1745:: with SMTP id i63mr8848715pli.145.1544955608166;
        Sun, 16 Dec 2018 02:20:08 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 02:20:07 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 3/6] net: maclorawan: Add maclorawan module declaration
Date:   Sun, 16 Dec 2018 18:18:57 +0800
Message-Id: <20181216101858.9585-4-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the maclorawan header file for common APIs in the module.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Use SPDX license identifiers

V4:
- Fix typo in comments
- Fix by coding style report from scripts/checkpatch.pl

V5:
- Add the frame control and frame count fields' length

 net/maclorawan/maclorawan.h | 202 ++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 net/maclorawan/maclorawan.h

diff --git a/net/maclorawan/maclorawan.h b/net/maclorawan/maclorawan.h
new file mode 100644
index 000000000000..024c394bebca
--- /dev/null
+++ b/net/maclorawan/maclorawan.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __MAC_LORAWAN_H__
+#define __MAC_LORAWAN_H__
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include <linux/netdevice.h>
+#include <uapi/linux/if_arp.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include <linux/lora/lorawan.h>
+
+#define	LORAWAN_MODULE_NAME	"maclorawan"
+
+/* List the message types of LoRaWAN */
+enum {
+	LRW_JOIN_REQUEST,
+	LRW_JOIN_ACCEPT,
+	LRW_UNCONFIRMED_DATA_UP,
+	LRW_UNCONFIRMED_DATA_DOWN,
+	LRW_CONFIRMED_DATA_UP,
+	LRW_CONFIRMED_DATA_DOWN,
+	LRW_RFU,
+	LRW_PROPRIETARY,
+};
+
+/* List the communication directions */
+enum {
+	LRW_UPLINK,
+	LRW_DOWNLINK,
+};
+
+/* States of LoRaWAN slot timing */
+enum {
+	LRW_INIT_SS,
+	LRW_XMITTING_SS,
+	LRW_XMITTED,
+	LRW_RX1_SS,
+	LRW_RX2_SS,
+	LRW_RXTIMEOUT_SS,
+	LRW_RXRECEIVED_SS,
+	LRW_RETRANSMIT_SS,
+};
+
+#define	LRW_MHDR_LEN		1
+#define	LRW_FHDR_MAX_LEN	22
+#define	LRW_FCTRL_LEN		1
+#define	LRW_FCNT_LEN		2
+#define	LRW_FOPS_MAX_LEN	15
+#define	LRW_FPORT_LEN		1
+#define	LRW_MIC_LEN		4
+
+/**
+ * lrw_fhdr - Hold the message's basic information of the frame
+ *
+ * @mtype:		this message's type
+ * @fctrl:		the frame control byte
+ * @fcnt:		this message's frame counter value
+ * @fopts:		this frame's options field
+ * @fopts_len:		the length of the fopts
+ */
+struct lrw_fhdr {
+	u8 mtype;
+	u8 fctrl;
+	u16 fcnt;
+	u8 fopts[LRW_FPORT_LEN];
+	u8 fopts_len;
+};
+
+/**
+ * lrw_session - LoRaWAN session for Class A end device
+ *
+ * @lrw_st:		points to the belonging lrw_st
+ * @entry:		the entry of the ss_list in lrw_struct
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @fcnt_up:		uplink frame counter
+ * @fcnt_down:		downlink frame counter
+ * @fport:		the LoRaWAN data message's port field
+ * @tx_skb:		points to the TX skb, the frame
+ * @rx_skb:		points to the RX skb, the frame
+ * @tx_fhdr:		hold the message's basic information of the TX frame
+ * @rx_fhdr:		hold the message's basic information of the RX frame
+ * @tx_should_ack:	flag for determining the TX which should be acked or not
+ * @retry:		retry times for xmitting failed
+ * @state:		this session's current state
+ * @state_lock:		lock of the session's state
+ * @timer:		timing for this session and the state transition
+ * @timeout_work:	work if waiting acknowledge time out
+ * @rx_delay1:		RX1 delay time in seconds
+ * @rx_delay2:		RX2 delay time in seconds
+ * @rx1_window:		RX1 window opening time in milliseconds
+ * @rx2_window:		RX2 window opening time in milliseconds
+ * @ack_timeout:	time out time for waiting acknowledge in seconds
+ */
+struct lrw_session {
+	struct lrw_struct *lrw_st;
+	struct list_head entry;
+
+	u32 devaddr;
+	u16 fcnt_up;
+	u16 fcnt_down;
+	u8 fport;
+	struct sk_buff *tx_skb;
+	struct sk_buff *rx_skb;
+	struct lrw_fhdr tx_fhdr;
+	struct lrw_fhdr rx_fhdr;
+
+	u8 tx_should_ack;
+	u8 retry;
+	u8 state;
+	spinlock_t state_lock; /* lock of the session's state */
+
+	struct timer_list timer;
+	struct work_struct timeout_work;
+	unsigned long rx_delay1;
+	unsigned long rx_delay2;
+	unsigned long rx1_window;
+	unsigned long rx2_window;
+	unsigned long ack_timeout;
+};
+
+/**
+ * lrw_struct - The full LoRaWAN hardware to the LoRa device.
+ *
+ * @dev:		this LoRa device registed in system
+ * @hw:			the LoRa device of this LoRaWAN hardware
+ * @ops:		handle of LoRa operations interfaces
+ * @rx_skb_list:	the list of received frames
+ * @ss_list:		LoRaWAN session list of this LoRaWAN hardware
+ * @ss_list_lock:	lock of the session list
+ * @_cur_ss:		pointer of the current processing session
+ * @rx_should_ack:	represent the current session should be acked or not
+ * @state:		the state of this LoRaWAN hardware
+ * @app_eui:		the LoRaWAN application EUI
+ * @dev_eui:		the LoRaWAN device EUI
+ * @devaddr:		the LoRaWAN device address of this LoRaWAN hardware
+ * @appky:		the Application key
+ * @nwkskey:		the Network session key
+ * @appskey:		the Application session key
+ * @nwks_shash_tfm:	the hash handler for LoRaWAN network session
+ * @nwks_skc_tfm:	the crypto handler for LoRaWAN network session
+ * @apps_skc_tfm:	the crypto handler for LoRaWAN application session
+ * @fcnt_up:		the counter of this LoRaWAN hardware's up frame
+ * @fcnt_down:		the counter of this LoRaWAN hardware's down frame
+ * @xmit_task:		the xmit task for the current LoRaWAN session
+ * @rx_work:		the RX work in workqueue for the current LoRaWAN session
+ * @ndev:		points to the emulating network device
+ * @_net:		the current network namespace of this LoRaWAN hardware
+ */
+struct lrw_struct {
+	struct device dev;
+	struct lrw_hw hw;
+	struct lrw_operations *ops;
+
+	struct sk_buff_head rx_skb_list;
+	struct list_head ss_list;
+	struct mutex ss_list_lock; /* lock of the session list */
+	struct lrw_session *_cur_ss;
+	u8 rx_should_ack;
+	u8 state;
+
+	u64 app_eui;
+	u64 dev_eui;
+	u32 devaddr;
+	u8 appkey[LRW_KEY_LEN];
+	u8 nwkskey[LRW_KEY_LEN];
+	u8 appskey[LRW_KEY_LEN];
+	struct crypto_shash *nwks_shash_tfm;
+	struct crypto_sync_skcipher *nwks_skc_tfm;
+	struct crypto_sync_skcipher *apps_skc_tfm;
+
+	u16 fcnt_up;
+	u16 fcnt_down;
+
+	struct tasklet_struct xmit_task;
+	struct work_struct rx_work;
+
+	struct net_device *ndev;
+	possible_net_t _net;
+};
+
+#define	NETDEV_2_LRW(ndev)	((struct lrw_struct *)netdev_priv(ndev))
+
+struct lrw_session *lrw_alloc_ss(struct lrw_struct *lrw_st);
+void lrw_free_ss(struct lrw_session *ss);
+void lrw_del_ss(struct lrw_session *ss);
+int lrw_start_hw(struct lrw_struct *lrw_st);
+void lrw_stop_hw(struct lrw_struct *lrw_st);
+void lrw_prepare_tx_frame(struct lrw_session *ss);
+void lrw_xmit(unsigned long data);
+void lrw_rx_work(struct work_struct *work);
+
+#endif
-- 
2.20.0

