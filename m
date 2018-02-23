Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Z0eEVW4Rp+sauXZWeTraUHcBdGnRrg9akgy0148iuYyyRlq9hySBLa77ebLWqu7SxjP7t
ARC-Seal: i=1; a=rsa-sha256; t=1519411314; cv=none;
        d=google.com; s=arc-20160816;
        b=DfZ1c0+Qh63qWWWpHzzlXeG6AKcj0XvunyRIAhOoPLfWBWCyuq8140HkWS3Mwz1VCd
         v1FKCLpAOw3CaQzZh59U4RPwOzIUB85Y6rQ4Yojcj7Y7/MdAVds6CMlIY6jmGoS+13Il
         f1luWEAkFJtcN8WYUrZj458I2H6eK5EfJlcQOYflCvI4Ro+aaYKEAq2hawtppW1wZZyc
         YzSuxgKe4dsdcA3/3jJDNlhoe/VPoGUGZi2Ri3dhk5fP01MFtA8/Cb4hsmEeyM4d+wqh
         iYAZBjDcueZWgVScJ2u7uDKCYPgLAuC8ztZUC9hT2FIR5l1Ap9DFnGbLXJwrlLpjR44n
         BkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p76JiLvAYQ40gT/bpBZE6Kb5rS66+Tp3dfHgLlqRZUc=;
        b=qn8H1kgm54mf+0//T7p9Sd7MxyvA1W+mYUUt1w5GPBuAn8QjMcpWat02pFokslReMf
         fB277ClOlzKtxYvrhf41I/tzJ6Uog+NminLbtze75ep9YifVpoR6BcBYEcuTpn0kQYG9
         p7n9AkAghYs0xtIlXsXyhb3f3uCzN7VrogU2JWCsShK3drUwGGPuH1e65iEaj6Gwmqoh
         WKyKkp6veMgh+6a/wL0Qkf72Zc80Dvl1Gx2BvRmos6DRNWJ/t41t32I6UF98bZ/iVbVT
         sAkUI3IDk3KMSfEMlMGn5bhNkM7TR9ThmYA8elK0B7bp6fE4a2V1+62NCCxXOn1QyFU4
         rjew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 158/193] netlink: fix nla_put_{u8,u16,u32} for KASAN
Date: Fri, 23 Feb 2018 19:26:31 +0100
Message-Id: <20180223170350.672132086@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218238787821665?=
X-GMAIL-MSGID: =?utf-8?q?1593218238787821665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b4391db42308c9940944b5d7be5ca4b78fb88dd0 upstream.

When CONFIG_KASAN is enabled, the "--param asan-stack=1" causes rather large
stack frames in some functions. This goes unnoticed normally because
CONFIG_FRAME_WARN is disabled with CONFIG_KASAN by default as of commit
3f181b4d8652 ("lib/Kconfig.debug: disable -Wframe-larger-than warnings with
KASAN=y").

The kernelci.org build bot however has the warning enabled and that led
me to investigate it a little further, as every build produces these warnings:

net/wireless/nl80211.c:4389:1: warning: the frame size of 2240 bytes is larger than 2048 bytes [-Wframe-larger-than=]
net/wireless/nl80211.c:1895:1: warning: the frame size of 3776 bytes is larger than 2048 bytes [-Wframe-larger-than=]
net/wireless/nl80211.c:1410:1: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]
net/bridge/br_netlink.c:1282:1: warning: the frame size of 2544 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Most of this problem is now solved in gcc-8, which can consolidate
the stack slots for the inline function arguments. On older compilers
we can add a workaround by declaring a local variable in each function
to pass the inline function argument.

Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[arnd: rebased to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netlink.h |   73 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 18 deletions(-)

--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -745,7 +745,10 @@ static inline int nla_parse_nested(struc
  */
 static inline int nla_put_u8(struct sk_buff *skb, int attrtype, u8 value)
 {
-	return nla_put(skb, attrtype, sizeof(u8), &value);
+	/* temporary variables to work around GCC PR81715 with asan-stack=1 */
+	u8 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u8), &tmp);
 }
 
 /**
@@ -756,7 +759,9 @@ static inline int nla_put_u8(struct sk_b
  */
 static inline int nla_put_u16(struct sk_buff *skb, int attrtype, u16 value)
 {
-	return nla_put(skb, attrtype, sizeof(u16), &value);
+	u16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u16), &tmp);
 }
 
 /**
@@ -767,7 +772,9 @@ static inline int nla_put_u16(struct sk_
  */
 static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be16), &value);
+	__be16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be16), &tmp);
 }
 
 /**
@@ -778,7 +785,9 @@ static inline int nla_put_be16(struct sk
  */
 static inline int nla_put_net16(struct sk_buff *skb, int attrtype, __be16 value)
 {
-	return nla_put_be16(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be16 tmp = value;
+
+	return nla_put_be16(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -789,7 +798,9 @@ static inline int nla_put_net16(struct s
  */
 static inline int nla_put_le16(struct sk_buff *skb, int attrtype, __le16 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le16), &value);
+	__le16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le16), &tmp);
 }
 
 /**
@@ -800,7 +811,9 @@ static inline int nla_put_le16(struct sk
  */
 static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
 {
-	return nla_put(skb, attrtype, sizeof(u32), &value);
+	u32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u32), &tmp);
 }
 
 /**
@@ -811,7 +824,9 @@ static inline int nla_put_u32(struct sk_
  */
 static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be32), &value);
+	__be32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be32), &tmp);
 }
 
 /**
@@ -822,7 +837,9 @@ static inline int nla_put_be32(struct sk
  */
 static inline int nla_put_net32(struct sk_buff *skb, int attrtype, __be32 value)
 {
-	return nla_put_be32(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be32 tmp = value;
+
+	return nla_put_be32(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -833,7 +850,9 @@ static inline int nla_put_net32(struct s
  */
 static inline int nla_put_le32(struct sk_buff *skb, int attrtype, __le32 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le32), &value);
+	__le32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le32), &tmp);
 }
 
 /**
@@ -844,7 +863,9 @@ static inline int nla_put_le32(struct sk
  */
 static inline int nla_put_u64(struct sk_buff *skb, int attrtype, u64 value)
 {
-	return nla_put(skb, attrtype, sizeof(u64), &value);
+	u64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u64), &tmp);
 }
 
 /**
@@ -855,7 +876,9 @@ static inline int nla_put_u64(struct sk_
  */
 static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be64), &value);
+	__be64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be64), &tmp);
 }
 
 /**
@@ -866,7 +889,9 @@ static inline int nla_put_be64(struct sk
  */
 static inline int nla_put_net64(struct sk_buff *skb, int attrtype, __be64 value)
 {
-	return nla_put_be64(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be64 tmp = value;
+
+	return nla_put_be64(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -877,7 +902,9 @@ static inline int nla_put_net64(struct s
  */
 static inline int nla_put_le64(struct sk_buff *skb, int attrtype, __le64 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le64), &value);
+	__le64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le64), &tmp);
 }
 
 /**
@@ -888,7 +915,9 @@ static inline int nla_put_le64(struct sk
  */
 static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
 {
-	return nla_put(skb, attrtype, sizeof(s8), &value);
+	s8 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s8), &tmp);
 }
 
 /**
@@ -899,7 +928,9 @@ static inline int nla_put_s8(struct sk_b
  */
 static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
 {
-	return nla_put(skb, attrtype, sizeof(s16), &value);
+	s16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s16), &tmp);
 }
 
 /**
@@ -910,7 +941,9 @@ static inline int nla_put_s16(struct sk_
  */
 static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
 {
-	return nla_put(skb, attrtype, sizeof(s32), &value);
+	s32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s32), &tmp);
 }
 
 /**
@@ -921,7 +954,9 @@ static inline int nla_put_s32(struct sk_
  */
 static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
 {
-	return nla_put(skb, attrtype, sizeof(s64), &value);
+	s64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s64), &tmp);
 }
 
 /**
@@ -969,7 +1004,9 @@ static inline int nla_put_msecs(struct s
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
 				  __be32 addr)
 {
-	return nla_put_be32(skb, attrtype, addr);
+	__be32 tmp = addr;
+
+	return nla_put_be32(skb, attrtype, tmp);
 }
 
 /**
