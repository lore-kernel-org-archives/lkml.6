Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C70C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619020815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfBCODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfBCNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0003to-Uv; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006q1-NU; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paul Moore" <pmoore@redhat.com>,
        "Casey Schaufler" <casey@schaufler-ca.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.846007741@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 037/305] cipso: don't use IPCB() to locate the CIPSO
 IP option
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <pmoore@redhat.com>

commit 04f81f0154e4bf002be6f4d85668ce1257efa4d9 upstream.

Using the IPCB() macro to get the IPv4 options is convenient, but
unfortunately NetLabel often needs to examine the CIPSO option outside
of the scope of the IP layer in the stack.  While historically IPCB()
worked above the IP layer, due to the inclusion of the inet_skb_param
struct at the head of the {tcp,udp}_skb_cb structs, recent commit
971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses")
reordered the tcp_skb_cb struct and invalidated this IPCB() trick.

This patch fixes the problem by creating a new function,
cipso_v4_optptr(), which locates the CIPSO option inside the IP header
without calling IPCB().  Unfortunately, this isn't as fast as a simple
lookup so some additional tweaks were made to limit the use of this
new function.

Reported-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <pmoore@redhat.com>
Tested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/cipso_ipv4.h     | 25 +++++++++++-------
 net/ipv4/cipso_ipv4.c        | 51 +++++++++++++++++++++---------------
 net/netlabel/netlabel_kapi.c | 15 +++++++----
 3 files changed, 56 insertions(+), 35 deletions(-)

--- a/include/net/cipso_ipv4.h
+++ b/include/net/cipso_ipv4.h
@@ -121,13 +121,6 @@ extern int cipso_v4_rbm_strictvalid;
 #endif
 
 /*
- * Helper Functions
- */
-
-#define CIPSO_V4_OPTEXIST(x) (IPCB(x)->opt.cipso != 0)
-#define CIPSO_V4_OPTPTR(x) (skb_network_header(x) + IPCB(x)->opt.cipso)
-
-/*
  * DOI List Functions
  */
 
@@ -190,7 +183,7 @@ static inline int cipso_v4_doi_domhsh_re
 
 #ifdef CONFIG_NETLABEL
 void cipso_v4_cache_invalidate(void);
-int cipso_v4_cache_add(const struct sk_buff *skb,
+int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr);
 #else
 static inline void cipso_v4_cache_invalidate(void)
@@ -198,7 +191,7 @@ static inline void cipso_v4_cache_invali
 	return;
 }
 
-static inline int cipso_v4_cache_add(const struct sk_buff *skb,
+static inline int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 				     const struct netlbl_lsm_secattr *secattr)
 {
 	return 0;
@@ -211,6 +204,8 @@ static inline int cipso_v4_cache_add(con
 
 #ifdef CONFIG_NETLABEL
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway);
+int cipso_v4_getattr(const unsigned char *cipso,
+		     struct netlbl_lsm_secattr *secattr);
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
 			  const struct netlbl_lsm_secattr *secattr);
@@ -226,6 +221,7 @@ int cipso_v4_skbuff_setattr(struct sk_bu
 int cipso_v4_skbuff_delattr(struct sk_buff *skb);
 int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
 			    struct netlbl_lsm_secattr *secattr);
+unsigned char *cipso_v4_optptr(const struct sk_buff *skb);
 int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option);
 #else
 static inline void cipso_v4_error(struct sk_buff *skb,
@@ -235,6 +231,12 @@ static inline void cipso_v4_error(struct
 	return;
 }
 
+static inline int cipso_v4_getattr(const unsigned char *cipso,
+				   struct netlbl_lsm_secattr *secattr)
+{
+	return -ENOSYS;
+}
+
 static inline int cipso_v4_sock_setattr(struct sock *sk,
 				      const struct cipso_v4_doi *doi_def,
 				      const struct netlbl_lsm_secattr *secattr)
@@ -282,6 +284,11 @@ static inline int cipso_v4_skbuff_getatt
 	return -ENOSYS;
 }
 
+static inline unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
+{
+	return NULL;
+}
+
 static inline int cipso_v4_validate(const struct sk_buff *skb,
 				    unsigned char **option)
 {
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -376,20 +376,18 @@ static int cipso_v4_cache_check(const un
  * negative values on failure.
  *
  */
-int cipso_v4_cache_add(const struct sk_buff *skb,
+int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val = -EPERM;
 	u32 bkt;
 	struct cipso_v4_map_cache_entry *entry = NULL;
 	struct cipso_v4_map_cache_entry *old_entry = NULL;
-	unsigned char *cipso_ptr;
 	u32 cipso_ptr_len;
 
 	if (!cipso_v4_cache_enabled || cipso_v4_cache_bucketsize <= 0)
 		return 0;
 
-	cipso_ptr = CIPSO_V4_OPTPTR(skb);
 	cipso_ptr_len = cipso_ptr[1];
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
@@ -1592,6 +1590,33 @@ static int cipso_v4_parsetag_loc(const s
 }
 
 /**
+ * cipso_v4_optptr - Find the CIPSO option in the packet
+ * @skb: the packet
+ *
+ * Description:
+ * Parse the packet's IP header looking for a CIPSO option.  Returns a pointer
+ * to the start of the CIPSO option on success, NULL if one if not found.
+ *
+ */
+unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
+{
+	const struct iphdr *iph = ip_hdr(skb);
+	unsigned char *optptr = (unsigned char *)&(ip_hdr(skb)[1]);
+	int optlen;
+	int taglen;
+
+	for (optlen = iph->ihl*4 - sizeof(struct iphdr); optlen > 0; ) {
+		if (optptr[0] == IPOPT_CIPSO)
+			return optptr;
+		taglen = optptr[1];
+		optlen -= taglen;
+		optptr += taglen;
+	}
+
+	return NULL;
+}
+
+/**
  * cipso_v4_validate - Validate a CIPSO option
  * @option: the start of the option, on error it is set to point to the error
  *
@@ -2136,8 +2161,8 @@ void cipso_v4_req_delattr(struct request
  * on success and negative values on failure.
  *
  */
-static int cipso_v4_getattr(const unsigned char *cipso,
-			    struct netlbl_lsm_secattr *secattr)
+int cipso_v4_getattr(const unsigned char *cipso,
+		     struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val = -ENOMSG;
 	u32 doi;
@@ -2322,22 +2347,6 @@ int cipso_v4_skbuff_delattr(struct sk_bu
 	return 0;
 }
 
-/**
- * cipso_v4_skbuff_getattr - Get the security attributes from the CIPSO option
- * @skb: the packet
- * @secattr: the security attributes
- *
- * Description:
- * Parse the given packet's CIPSO option and return the security attributes.
- * Returns zero on success and negative values on failure.
- *
- */
-int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
-			    struct netlbl_lsm_secattr *secattr)
-{
-	return cipso_v4_getattr(CIPSO_V4_OPTPTR(skb), secattr);
-}
-
 /*
  * Setup Functions
  */
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -948,10 +948,12 @@ int netlbl_skbuff_getattr(const struct s
 			  u16 family,
 			  struct netlbl_lsm_secattr *secattr)
 {
+	unsigned char *ptr;
+
 	switch (family) {
 	case AF_INET:
-		if (CIPSO_V4_OPTEXIST(skb) &&
-		    cipso_v4_skbuff_getattr(skb, secattr) == 0)
+		ptr = cipso_v4_optptr(skb);
+		if (ptr && cipso_v4_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -977,7 +979,7 @@ int netlbl_skbuff_getattr(const struct s
  */
 void netlbl_skbuff_err(struct sk_buff *skb, int error, int gateway)
 {
-	if (CIPSO_V4_OPTEXIST(skb))
+	if (cipso_v4_optptr(skb))
 		cipso_v4_error(skb, error, gateway);
 }
 
@@ -1009,11 +1011,14 @@ void netlbl_cache_invalidate(void)
 int netlbl_cache_add(const struct sk_buff *skb,
 		     const struct netlbl_lsm_secattr *secattr)
 {
+	unsigned char *ptr;
+
 	if ((secattr->flags & NETLBL_SECATTR_CACHE) == 0)
 		return -ENOMSG;
 
-	if (CIPSO_V4_OPTEXIST(skb))
-		return cipso_v4_cache_add(skb, secattr);
+	ptr = cipso_v4_optptr(skb);
+	if (ptr)
+		return cipso_v4_cache_add(ptr, secattr);
 
 	return -ENOMSG;
 }

