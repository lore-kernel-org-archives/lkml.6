Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IJz6EchGGVtvOQAAmS7hNA
	; Thu, 07 Jun 2018 14:52:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 774AF608BA; Thu,  7 Jun 2018 14:52:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC0416074D;
	Thu,  7 Jun 2018 14:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC0416074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeFGOw4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934867AbeFGOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:53 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbb-0005Zs-Kp; Thu, 07 Jun 2018 15:09:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00034k-7m; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.333203788@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 251/410] NFC: llcp: Limit size of SDP URI
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit fe9c842695e26d8116b61b80bfb905356f07834b upstream.

The tlv_len is u8, so we need to limit the size of the SDP URI. Enforce
this both in the NLA policy and in the code that performs the allocation
and copy, to avoid writing past the end of the allocated buffer.

Fixes: d9b8d8e19b073 ("NFC: llcp: Service Name Lookup netlink interface")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/nfc/llcp_commands.c | 4 ++++
 net/nfc/netlink.c       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -149,6 +149,10 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_
 
 	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
 
+	/* sdreq->tlv_len is u8, takes uri_len, + 3 for header, + 1 for NULL */
+	if (WARN_ON_ONCE(uri_len > U8_MAX - 4))
+		return NULL;
+
 	sdreq = kzalloc(sizeof(struct nfc_llcp_sdp_tlv), GFP_KERNEL);
 	if (sdreq == NULL)
 		return NULL;
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -60,7 +60,8 @@ static const struct nla_policy nfc_genl_
 };
 
 static const struct nla_policy nfc_sdp_genl_policy[NFC_SDP_ATTR_MAX + 1] = {
-	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING },
+	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING,
+			       .len = U8_MAX - 4 },
 	[NFC_SDP_ATTR_SAP] = { .type = NLA_U8 },
 };
 
