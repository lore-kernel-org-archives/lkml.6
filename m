Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227aobn/TKtw0FTvuYxX8L5+pQNhdNGRwa6hAxnjJDJTDxhtoegFkAMVHpOncKqVv9M2iE5G
ARC-Seal: i=1; a=rsa-sha256; t=1519127951; cv=none;
        d=google.com; s=arc-20160816;
        b=h59c08MGkrvk75Qg/whF53Z/BHXf6ta34ugxpPd8p5rDKWCtVnYoW4vGL9PJZAVPS9
         afDH0F21SYxRhL1XBVIgpQYY/YhsCNFpVu/8ljc035SEJHGPUOADl98Y06xfaioyM3Tv
         gYCGehJ0ZA5Ewgj9RzK87Pqx7XWg2ccU2MYETBRO8LxLCpF5hjC2lIFqVsvksMEHJUia
         EEBan/rWuU+dO4Of9Mar0WH0AwnBCbDvZSjhBog2BJProaDZJgFxkiTYEwpinvBrf4eA
         imQkaueI/rRIgrhman3OmNZ9PHXrLEBCLpaYF96FOOc5M3Uo2OaYvHahX+4b2l8WArkt
         e8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=xqqLNR0AgpK6YV06ynWMyNUCYsWVSwiyqjZKNq2We4s=;
        b=UVOb5xV4UJmmocIJqydNhRgKR+Mf1JVMmT/8z8kqUpsh/V7ohfKgbV1fj7NjvocEzj
         zgXUxpinsD9TS+iiEwX46RX2cMGu2dIprEjV4dcS7wVBMfby5PXuasmSCrZCYcJLm8uu
         0gFWYtIL0nT7Qt8xWeAmGM9s0c//PuvFkHAoQ/r2yGs6+CPyAb1sutjmz+a0nC/R15HY
         xmRllIwarGmFMtFfSJFXXG0Xs5Ag+UxQAk+1Zznc77Yf2OvDBlMcvqtD3GODJd0xJvRq
         SyrGtBfLBCB0S+p2p1iJ3LaWuRfdl7YEAr1tWKDoq/PDpvChRQCJ293Av44Rm2K65WRA
         u6fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [4.4-stable 11/22] netlink: fix nla_put_{u8,u16,u32} for KASAN
Date: Tue, 20 Feb 2018 12:54:58 +0100
Message-Id: <20180220115527.1806578-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Xu89oNkFxYuzL4uV1TH0bm+rOk3zezfVpuqv4g4cMWWAarq64Mm
 GBIe5b+C314ZDF+TqPe/p0gJdoBkB8lG3KfXzBbxflLJ4aSEp0Un3F5Ryauplc77+h7h8ye
 8scyqDKItXN9Q3vwwAqENimoYITroWG/zFmaVqjZSEzvJdiLqGf9L3UPpnTAvmkAh8jwo8S
 4QsqXFkMrII+2Y95EllHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/89b7o/dO3E=:8zOLVFsgBm0bYiIKzqxTec
 tIv+StwB3Wb6bHUEMxMf74V0GtHk6cD/nWet8zRWjZihw0MPUih/yLTdFtBL+ioRTHKEndWEd
 OShcllop2MUkWLxCLrtQivXTgilGUoAKIlA0I4KTX9q1KxS3m04hluRFkRDeV0LFzlcgXGJUs
 qL03KyAmB9yhyo34VyBKDuufIqsKud80rl5YSOAZGDRTRUkFvkRalz33uwc5h8D/+uNE7zf2r
 sv9gAH0TMr0nuB1LypzYTruyOcaUzHi4IJ/ObwtuUdRIPdXcYZQy5tv5bQKNcxcJ6nh3cGFDn
 m+qvlQvNkbPC9Vqbdu6Gxf44b2ATwaL0eouucnfKEJByhqXCUmleVGwD+XD0RAgtYAefgdzEK
 e2At4GpdKIjlUdVjP/7ArzRqxei6b45wIoI89SBejiKBSVk/K08ebaCXMSTkTq5fvirLaa6+S
 lBFaKLOq6fKLbKgIagfll93K+QY7qnFGNkAL9QwIhJoWDtz4s050vw/0F3GuRY+QYOswx4dM4
 cZeXEp/WvqtU/mWUki8unTbW4unaqmqkcxgXXuk63p+diO2NXqDtP5DXDQEkHJ/iIJg+kKpUn
 Nb7/2RPirbIVdARza4HT35AC7VtEBsCTc5e3Qexmjp/hxQR5LvE3ePqNYL2Oogh2ehbxUOTHR
 HidAQFKYo1aN3CK7fLDpc1GCMly4bWuSejvcATsw/cuvi2botV8vrqrdWixpgzibSzSULEvH3
 TDHpxD3wg4Vcyr1zBRYlIRrE56m0mR2gDlcUog==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921111670662570?=
X-GMAIL-MSGID: =?utf-8?q?1592921111670662570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 include/net/netlink.h | 73 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 0e3172751755..5ffaea4665f8 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -745,7 +745,10 @@ static inline int nla_parse_nested(struct nlattr *tb[], int maxtype,
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
@@ -756,7 +759,9 @@ static inline int nla_put_u8(struct sk_buff *skb, int attrtype, u8 value)
  */
 static inline int nla_put_u16(struct sk_buff *skb, int attrtype, u16 value)
 {
-	return nla_put(skb, attrtype, sizeof(u16), &value);
+	u16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u16), &tmp);
 }
 
 /**
@@ -767,7 +772,9 @@ static inline int nla_put_u16(struct sk_buff *skb, int attrtype, u16 value)
  */
 static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be16), &value);
+	__be16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be16), &tmp);
 }
 
 /**
@@ -778,7 +785,9 @@ static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
  */
 static inline int nla_put_net16(struct sk_buff *skb, int attrtype, __be16 value)
 {
-	return nla_put_be16(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be16 tmp = value;
+
+	return nla_put_be16(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -789,7 +798,9 @@ static inline int nla_put_net16(struct sk_buff *skb, int attrtype, __be16 value)
  */
 static inline int nla_put_le16(struct sk_buff *skb, int attrtype, __le16 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le16), &value);
+	__le16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le16), &tmp);
 }
 
 /**
@@ -800,7 +811,9 @@ static inline int nla_put_le16(struct sk_buff *skb, int attrtype, __le16 value)
  */
 static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
 {
-	return nla_put(skb, attrtype, sizeof(u32), &value);
+	u32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u32), &tmp);
 }
 
 /**
@@ -811,7 +824,9 @@ static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
  */
 static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be32), &value);
+	__be32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be32), &tmp);
 }
 
 /**
@@ -822,7 +837,9 @@ static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
  */
 static inline int nla_put_net32(struct sk_buff *skb, int attrtype, __be32 value)
 {
-	return nla_put_be32(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be32 tmp = value;
+
+	return nla_put_be32(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -833,7 +850,9 @@ static inline int nla_put_net32(struct sk_buff *skb, int attrtype, __be32 value)
  */
 static inline int nla_put_le32(struct sk_buff *skb, int attrtype, __le32 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le32), &value);
+	__le32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le32), &tmp);
 }
 
 /**
@@ -844,7 +863,9 @@ static inline int nla_put_le32(struct sk_buff *skb, int attrtype, __le32 value)
  */
 static inline int nla_put_u64(struct sk_buff *skb, int attrtype, u64 value)
 {
-	return nla_put(skb, attrtype, sizeof(u64), &value);
+	u64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(u64), &tmp);
 }
 
 /**
@@ -855,7 +876,9 @@ static inline int nla_put_u64(struct sk_buff *skb, int attrtype, u64 value)
  */
 static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 {
-	return nla_put(skb, attrtype, sizeof(__be64), &value);
+	__be64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__be64), &tmp);
 }
 
 /**
@@ -866,7 +889,9 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
  */
 static inline int nla_put_net64(struct sk_buff *skb, int attrtype, __be64 value)
 {
-	return nla_put_be64(skb, attrtype | NLA_F_NET_BYTEORDER, value);
+	__be64 tmp = value;
+
+	return nla_put_be64(skb, attrtype | NLA_F_NET_BYTEORDER, tmp);
 }
 
 /**
@@ -877,7 +902,9 @@ static inline int nla_put_net64(struct sk_buff *skb, int attrtype, __be64 value)
  */
 static inline int nla_put_le64(struct sk_buff *skb, int attrtype, __le64 value)
 {
-	return nla_put(skb, attrtype, sizeof(__le64), &value);
+	__le64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(__le64), &tmp);
 }
 
 /**
@@ -888,7 +915,9 @@ static inline int nla_put_le64(struct sk_buff *skb, int attrtype, __le64 value)
  */
 static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
 {
-	return nla_put(skb, attrtype, sizeof(s8), &value);
+	s8 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s8), &tmp);
 }
 
 /**
@@ -899,7 +928,9 @@ static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
  */
 static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
 {
-	return nla_put(skb, attrtype, sizeof(s16), &value);
+	s16 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s16), &tmp);
 }
 
 /**
@@ -910,7 +941,9 @@ static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
  */
 static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
 {
-	return nla_put(skb, attrtype, sizeof(s32), &value);
+	s32 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s32), &tmp);
 }
 
 /**
@@ -921,7 +954,9 @@ static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
  */
 static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
 {
-	return nla_put(skb, attrtype, sizeof(s64), &value);
+	s64 tmp = value;
+
+	return nla_put(skb, attrtype, sizeof(s64), &tmp);
 }
 
 /**
@@ -969,7 +1004,9 @@ static inline int nla_put_msecs(struct sk_buff *skb, int attrtype,
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
 				  __be32 addr)
 {
-	return nla_put_be32(skb, attrtype, addr);
+	__be32 tmp = addr;
+
+	return nla_put_be32(skb, attrtype, tmp);
 }
 
 /**
-- 
2.9.0
