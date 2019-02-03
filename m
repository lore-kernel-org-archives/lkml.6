Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8309AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA52084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfBCOUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729782AbfBCOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:18 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId6-0006G7-NT; Sun, 03 Feb 2019 14:20:16 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006qG-Pe; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Simon Veith" <sveith@amazon.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Stefan Nuernberger" <snu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul Moore" <paul@paul-moore.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.799095700@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 039/305] net/ipv4: defensive cipso option parsing
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

From: Stefan Nuernberger <snu@amazon.com>

commit 076ed3da0c9b2f88d9157dbe7044a45641ae369e upstream.

commit 40413955ee26 ("Cipso: cipso_v4_optptr enter infinite loop") fixed
a possible infinite loop in the IP option parsing of CIPSO. The fix
assumes that ip_options_compile filtered out all zero length options and
that no other one-byte options beside IPOPT_END and IPOPT_NOOP exist.
While this assumption currently holds true, add explicit checks for zero
length and invalid length options to be safe for the future. Even though
ip_options_compile should have validated the options, the introduction of
new one-byte options can still confuse this code without the additional
checks.

Signed-off-by: Stefan Nuernberger <snu@amazon.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Veith <sveith@amazon.de>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/cipso_ipv4.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1595,7 +1595,7 @@ static int cipso_v4_parsetag_loc(const s
  *
  * Description:
  * Parse the packet's IP header looking for a CIPSO option.  Returns a pointer
- * to the start of the CIPSO option on success, NULL if one if not found.
+ * to the start of the CIPSO option on success, NULL if one is not found.
  *
  */
 unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
@@ -1605,10 +1605,8 @@ unsigned char *cipso_v4_optptr(const str
 	int optlen;
 	int taglen;
 
-	for (optlen = iph->ihl*4 - sizeof(struct iphdr); optlen > 0; ) {
+	for (optlen = iph->ihl*4 - sizeof(struct iphdr); optlen > 1; ) {
 		switch (optptr[0]) {
-		case IPOPT_CIPSO:
-			return optptr;
 		case IPOPT_END:
 			return NULL;
 		case IPOPT_NOOP:
@@ -1617,6 +1615,11 @@ unsigned char *cipso_v4_optptr(const str
 		default:
 			taglen = optptr[1];
 		}
+		if (!taglen || taglen > optlen)
+			return NULL;
+		if (optptr[0] == IPOPT_CIPSO)
+			return optptr;
+
 		optlen -= taglen;
 		optptr += taglen;
 	}

