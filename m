Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839302081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="TcjhjxRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839302081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbeKFCRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42383 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbeKFCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so4700324pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77gYbunc2jxqm/I5r4+ygvOWBZzB4agcgfgzeomRm40=;
        b=TcjhjxRcuEq6Vagp7zxH0a5k8JsQ9nZ/TxE6xCSuA2pD4VNKA73FE1ig91RIakiDnB
         LTtmmX3MCusBf07i5uURvBBpLKruv6p0yNCZgk4ESJ5uioFuYIvPB3nvAjRT6Z6j1UY+
         2D9nJ0BNUAhY72/eN0GyTCdsxnElm1lg4CmRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77gYbunc2jxqm/I5r4+ygvOWBZzB4agcgfgzeomRm40=;
        b=E19gns4YoQ7uJojIuUVgSs51rjW06KhU1oOANfor/cOQ/i0RbM170xcvSdH+RNlLBl
         aS1o2wKDnINsma0a9K75QURjyux2sacNJLXA9l3i92gB93d7U7BuAphZ8mMkq3MSdlE/
         CrteYHXX2hnTNKgRV82sNplrBMiE4TTbBQeu/pEZdBkXsTv4qU5hhjl5tjoXHgrI9qg2
         Hn8WpN9xhvURIzaLOG5kMaNFMccnknHR5+R6wcXnNhUj9pqECk7X990zzD8DErhDephP
         rHs1JBCMgDGGCuofcKIV7iwRIdw5eMdpRt2MGX1Gi272aRfnDa+aeDdyyIFz7JoAVfb0
         k0IA==
X-Gm-Message-State: AGRZ1gIO2fslEivhOgjyO864jD3+czWkwkqvZBLaDk/R2kuw+R3uW8PY
        mquF+JJU6ie7JFrWKnPzyaolzw==
X-Google-Smtp-Source: AJdET5c3ALSI96HyPMBiNvub2H1725a1jDr4LaKadNQhD3LsqdDE7bYHXltbOoaZphIeURSOf8Hk3A==
X-Received: by 2002:aa7:8252:: with SMTP id e18-v6mr23053099pfn.164.1541437038423;
        Mon, 05 Nov 2018 08:57:18 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id l16-v6sm58445129pfj.179.2018.11.05.08.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:57:17 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V2 1/7] net: lorawan: Add macro and definition for LoRaWAN
Date:   Tue,  6 Nov 2018 00:55:39 +0800
Message-Id: <20181105165544.5215-2-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the macro and definition for the implementation of
LoRaWAN protocol.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Modify the commit message

 include/linux/socket.h              | 5 ++++-
 include/uapi/linux/if_arp.h         | 1 +
 include/uapi/linux/if_ether.h       | 1 +
 net/core/dev.c                      | 4 ++--
 security/selinux/hooks.c            | 4 +++-
 security/selinux/include/classmap.h | 4 +++-
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index aa1e288b1659..e5c8381fd1aa 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -209,8 +209,9 @@ struct ucred {
 				 */
 #define AF_XDP		44	/* XDP sockets			*/
 #define AF_LORA		45	/* LoRa sockets			*/
+#define AF_LORAWAN	46	/* LoRaWAN sockets			*/
 
-#define AF_MAX		46	/* For now.. */
+#define AF_MAX		47	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -261,6 +262,7 @@ struct ucred {
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
 #define PF_LORA		AF_LORA
+#define PF_LORAWAN	AF_LORAWAN
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
@@ -343,6 +345,7 @@ struct ucred {
 #define SOL_KCM		281
 #define SOL_TLS		282
 #define SOL_XDP		283
+#define SOL_LORAWAN	284
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 1ed7cb3f2129..2376f7839355 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -99,6 +99,7 @@
 #define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
 #define ARPHRD_VSOCKMON	826		/* Vsock monitor header		*/
 #define ARPHRD_LORA	827		/* LoRa				*/
+#define ARPHRD_LORAWAN	828		/* LoRaWAN			*/
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 #define ARPHRD_NONE	  0xFFFE	/* zero header length */
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 45644dcf5b39..b1ac70d4a377 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -148,6 +148,7 @@
 					 * aggregation protocol
 					 */
 #define ETH_P_LORA	0x00FA		/* LoRa				*/
+#define ETH_P_LORAWAN	0x00FB		/* LoRaWAN			*/
 
 /*
  *	This is an Ethernet frame header.
diff --git a/net/core/dev.c b/net/core/dev.c
index f68122f0ab02..b95ce79ec5a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -297,7 +297,7 @@ static const unsigned short netdev_lock_type[] = {
 	 ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
 	 ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
 	 ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
-	 ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
+	 ARPHRD_IEEE802154, ARPHRD_LORAWAN, ARPHRD_VOID, ARPHRD_NONE};
 
 static const char *const netdev_lock_name[] = {
 	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
@@ -314,7 +314,7 @@ static const char *const netdev_lock_name[] = {
 	"_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
 	"_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
 	"_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
-	"_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
+	"_xmit_IEEE802154", "_xmit_LORAWAN", "_xmit_VOID", "_xmit_NONE"};
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aaf520a689d8..0da3a1d69cb8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1477,7 +1477,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_XDP_SOCKET;
 		case PF_LORA:
 			return SECCLASS_LORA_SOCKET;
-#if PF_MAX > 46
+		case PF_LORAWAN:
+			return SECCLASS_LORAWAN_SOCKET;
+#if PF_MAX > 47
 #error New address family defined, please update this function.
 #endif
 		}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 060d4bf8385e..fa0151fe6f32 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,9 +244,11 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "lora_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lorawan_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ NULL }
   };
 
-#if PF_MAX > 46
+#if PF_MAX > 47
 #error New address family defined, please update secclass_map.
 #endif
-- 
2.19.1

