Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE26C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F923208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="ap4jmn3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F923208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbeKOCGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40437 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbeKOCGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so8122274pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77gYbunc2jxqm/I5r4+ygvOWBZzB4agcgfgzeomRm40=;
        b=ap4jmn3tIyyl9WP4wGLge+eNcov8WwMHGcVF+4+HMmDq/ATWGb6YgZyyQW5a2NWB72
         U1j/+zZjkBaVlvmc6i8HFGrtGYxnfr7JS61uczfnpnOf/g62Cy0etdIH0VUtm25CDbSr
         RGCuipsf1Jz9jZnHX7k2mioq9zEyZaK2ngG14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77gYbunc2jxqm/I5r4+ygvOWBZzB4agcgfgzeomRm40=;
        b=tcI7zHy8H7GfQ/6+mIDGklRZQzmu4z+G3uIHi3MHV98GSA/WqdRVEj6tLdBmqbgKRC
         r6eApCZsB4+vWDqKgft+csc4bqx5B3KUTIHB2bVRaVaNYC/NA+HLaqHGzgSKbzoiHM/7
         3pkF0nFtyQgK2wXOpy0S+55V1M1MsHcYpgvVzQtKwe89iUHzTPZEAFaOzy9TNwmVPwHZ
         LTaKjw4zXDi4rKXMfb6aVnC/C3yQN9kPHpimdldgY2yzIIvUWOy0VDWiUSmHyVNFtvjz
         Zi3calCM4m5rsMUAxaa5B9CTylcW5u6BPHJz2xnN1hDEkJljytp5kC07ObAkiqxHOQ1Z
         3pDQ==
X-Gm-Message-State: AGRZ1gLFzw/MAknbt7dUeWU/BrxnIHmWrYX3Oc3t1VcNxqpPAxSpAnny
        kUjRyVtgTa4NvRwq4PSpC33OWg==
X-Google-Smtp-Source: AJdET5fxGz6fNawGtbnyK939jLxmLnZ1wDN4lScMGryeZP4Hj7h0uF1b7uUnw2GNgab+tdPb6SvxVA==
X-Received: by 2002:a62:5793:: with SMTP id i19-v6mr2618267pfj.158.1542211378543;
        Wed, 14 Nov 2018 08:02:58 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53449854pfk.133.2018.11.14.08.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:02:58 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V3 1/7] net: lorawan: Add macro and definition for LoRaWAN
Date:   Thu, 15 Nov 2018 00:01:22 +0800
Message-Id: <20181114160126.4445-2-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
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

