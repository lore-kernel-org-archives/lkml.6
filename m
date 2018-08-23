Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E0B20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="G6vRKlUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E0B20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeHWUuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:50:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43173 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeHWUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:50:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so2931694pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KoHEYW9wxzKxZkT9cZKzsJNfwrFeb6lfM11FdkwBbY8=;
        b=G6vRKlUYiBiXKW+qTPQQvE4PaTUWEtyVk0sx31c4WeLc1BeBZbtoctqOoHfRKhhpKf
         F/fUT4U4JrTqC5JZ8UwKJyuJv9ysH2RANyGTNdNPG4l7Rqs43QctBQlRigtByxtUJ/8V
         h8dzOtvd0QaC5camoiw5yUxP/9pRZwFKAlTeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KoHEYW9wxzKxZkT9cZKzsJNfwrFeb6lfM11FdkwBbY8=;
        b=Rm6bfuJPPRscHb6aPJdFsNHxDDu7ZV/vX9p/7rMwCD4NpJ17qZUAnb4VOGWmwaeJi9
         KMxmkC/YgIlRiGznjWS8f6S/pgUO+VkpzB3AGTCwLoepL4216VAmz/fxBYryFqJ0E9v7
         h72/DXWzUmvBo+LPgwhxAXS20LNSjS5mfoxkF42+jlppoKpRJ42oy4RC3leL3KJM5kus
         kjLxeQD9us9nGXGacOHXwZ0nrOZAyIwCZcn4YBtakQv2BL4d+t/5iv13D9pUN0dD68ik
         hFL7ajBdYe+eR4r246cZ8FPlJnXfxCZfOJpLecBPrjyy1aOssaCv0rU/FRzHhXGRyn61
         EAxg==
X-Gm-Message-State: AOUpUlHDOP/mOnNs6HRT+dpa53+6PFe/FGKDovIVHhpAQcDLaTCXGn+5
        WLIkHX2NuxotzbbCIs5k0I3TIg==
X-Google-Smtp-Source: AA+uWPxnj3sA5CV/C19KKaRoM4EP5Rf4IHQDmuAX6EAQo1au/nczaFbxP8CZJlJMizNTR6/M7qUcQg==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr56171429pga.353.1535044763492;
        Thu, 23 Aug 2018 10:19:23 -0700 (PDT)
Received: from starnight.local ([150.116.244.148])
        by smtp.gmail.com with ESMTPSA id n9-v6sm7483404pfg.21.2018.08.23.10.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:19:23 -0700 (PDT)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 2/3 net] lorawan: Add macro and definition for LoRaWAN class modlue
Date:   Fri, 24 Aug 2018 01:15:42 +0800
Message-Id: <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the macro and definition for the implementation of
LoRaWAN protocol.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
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
2.18.0

