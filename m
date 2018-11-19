Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F012C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47109214ED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frb0GSHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47109214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406773AbeKTD3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406762AbeKTD3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A28214D9;
        Mon, 19 Nov 2018 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647113;
        bh=UI++2Lqopsvn2zJ3d1wRTwfQjTBCU5uMRllw9NluXGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frb0GSHT2RGjss3CxfwFbMhmZAOagHnSonujqFvPVcQctF37ruMPhTGAYqacMxmjp
         swg+7inqhemgvKqd50m2Be+CW5rO/QuWXNYsPzy1Ri4/aYsFWbLDg6IxTGGg84jT8b
         BntJY0gZeE9NUQJKE6ZlwzR92yWdA514ncrQchNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Simon Veith <sveith@amazon.de>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 28/90] net/ipv4: defensive cipso option parsing
Date:   Mon, 19 Nov 2018 17:29:10 +0100
Message-Id: <20181119162625.433836842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/cipso_ipv4.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1580,7 +1580,7 @@ static int cipso_v4_parsetag_loc(const s
  *
  * Description:
  * Parse the packet's IP header looking for a CIPSO option.  Returns a pointer
- * to the start of the CIPSO option on success, NULL if one if not found.
+ * to the start of the CIPSO option on success, NULL if one is not found.
  *
  */
 unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
@@ -1590,10 +1590,8 @@ unsigned char *cipso_v4_optptr(const str
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
@@ -1602,6 +1600,11 @@ unsigned char *cipso_v4_optptr(const str
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


