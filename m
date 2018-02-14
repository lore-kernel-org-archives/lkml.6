Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032138AbeBNXpM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:45:12 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36162 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032019AbeBNXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:45:10 -0500
X-Google-Smtp-Source: AH8x227BuZTbwosYZkK7U3J3SNE/FG1zC9HuTolDrF96CMnjtGNqHXcP0G6YBQaNs763/W3eanv6yQ==
Date: Wed, 14 Feb 2018 15:45:07 -0800
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH] NFC: llcp: Limit size of SDP URI
Message-ID: <20180214234507.GA23681@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tlv_len is u8, so we need to limit the size of the SDP URI. Enforce
this both in the NLA policy and in the code that performs the allocation
and copy, to avoid writing past the end of the allocated buffer.

Fixes: d9b8d8e19b073 ("NFC: llcp: Service Name Lookup netlink interface")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
No reply from linux-wireless, so sending to netdev directly now...
---
 net/nfc/llcp_commands.c | 4 ++++
 net/nfc/netlink.c       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 367d8c027101..2ceefa183cee 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -149,6 +149,10 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
 
 	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
 
+	/* sdreq->tlv_len is u8, takes uri_len, + 3 for header, + 1 for NULL */
+	if (WARN_ON_ONCE(uri_len > U8_MAX - 4))
+		return NULL;
+
 	sdreq = kzalloc(sizeof(struct nfc_llcp_sdp_tlv), GFP_KERNEL);
 	if (sdreq == NULL)
 		return NULL;
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index c0b83dc9d993..f018eafc2a0d 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -61,7 +61,8 @@ static const struct nla_policy nfc_genl_policy[NFC_ATTR_MAX + 1] = {
 };
 
 static const struct nla_policy nfc_sdp_genl_policy[NFC_SDP_ATTR_MAX + 1] = {
-	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING },
+	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING,
+			       .len = U8_MAX - 4 },
 	[NFC_SDP_ATTR_SAP] = { .type = NLA_U8 },
 };
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
