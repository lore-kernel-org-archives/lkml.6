Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95157C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0C214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBD1uSa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB0C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbeKLIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391204AbeKLIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3F821780;
        Sun, 11 Nov 2018 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975665;
        bh=xtYHkaLCQ4S/kw9QUF9hGgoO905vukSCK+2c6JH71rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBD1uSa8WPVshdV/Lf/PRz8XZ6MabKTl5HlKvrkb9zKzz0UfLgiz4jwskPMT5z8JC
         +rVgfHFmxZPFzP7P4XRtdr3QilOEkQeuVHGjvSfBG4m6b7L7cVCQGS0w22JFih625z
         DgYuqFbY9QEKSPV04teoLI1NCpu8ZiCWnOcmcsH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Simon Veith <sveith@amazon.de>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 084/141] net/ipv4: defensive cipso option parsing
Date:   Sun, 11 Nov 2018 14:25:43 -0800
Message-Id: <20181111221639.791994980@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1512,7 +1512,7 @@ static int cipso_v4_parsetag_loc(const s
  *
  * Description:
  * Parse the packet's IP header looking for a CIPSO option.  Returns a pointer
- * to the start of the CIPSO option on success, NULL if one if not found.
+ * to the start of the CIPSO option on success, NULL if one is not found.
  *
  */
 unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
@@ -1522,10 +1522,8 @@ unsigned char *cipso_v4_optptr(const str
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
@@ -1534,6 +1532,11 @@ unsigned char *cipso_v4_optptr(const str
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


