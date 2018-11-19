Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98903C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E98E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfoAvjfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E98E2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbeKTDWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:22:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbeKTDWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:22:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B59F2146D;
        Mon, 19 Nov 2018 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646677;
        bh=tyu/5Cyo3cakQrnigEPmIMmD/DTF62KjUQkiJn/SWZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfoAvjfapbiuc3U9599FyPHZKmuxjbcEmzLax+b/zWQVCsS8MwJGa2LxMcwwO3vGK
         JKU3yUJbQJOHV/3hS6g9OO7M63sJyPJxAm7HUFacPiGKk/khpdcLPxbgcbD4nmj7hm
         hy8ioFf13b+GXgfLrRlQm7nLy5DyUa+LQf94z5Bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Simon Veith <sveith@amazon.de>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 048/160] net/ipv4: defensive cipso option parsing
Date:   Mon, 19 Nov 2018 17:28:07 +0100
Message-Id: <20181119162636.181794770@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1582,7 +1582,7 @@ static int cipso_v4_parsetag_loc(const s
  *
  * Description:
  * Parse the packet's IP header looking for a CIPSO option.  Returns a pointer
- * to the start of the CIPSO option on success, NULL if one if not found.
+ * to the start of the CIPSO option on success, NULL if one is not found.
  *
  */
 unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
@@ -1592,10 +1592,8 @@ unsigned char *cipso_v4_optptr(const str
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
@@ -1604,6 +1602,11 @@ unsigned char *cipso_v4_optptr(const str
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


