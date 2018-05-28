Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161469AbeE1KcL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161359AbeE1KcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 114/329] NFC: llcp: Limit size of SDP URI
Date: Mon, 28 May 2018 12:00:43 +0200
Message-Id: <20180528100252.215418053@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit fe9c842695e26d8116b61b80bfb905356f07834b ]

The tlv_len is u8, so we need to limit the size of the SDP URI. Enforce
this both in the NLA policy and in the code that performs the allocation
and copy, to avoid writing past the end of the allocated buffer.

Fixes: d9b8d8e19b073 ("NFC: llcp: Service Name Lookup netlink interface")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/llcp_commands.c |    4 ++++
 net/nfc/netlink.c       |    3 ++-
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
@@ -68,7 +68,8 @@ static const struct nla_policy nfc_genl_
 };
 
 static const struct nla_policy nfc_sdp_genl_policy[NFC_SDP_ATTR_MAX + 1] = {
-	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING },
+	[NFC_SDP_ATTR_URI] = { .type = NLA_STRING,
+			       .len = U8_MAX - 4 },
 	[NFC_SDP_ATTR_SAP] = { .type = NLA_U8 },
 };
 
