Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C7FC617F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E2A2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E2A2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIMVTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeIMVTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E93288313;
        Thu, 13 Sep 2018 16:09:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E67F2010CBA;
        Thu, 13 Sep 2018 16:09:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] dns: Allow the dns resolver to retrieve a server set
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 17:09:01 +0100
Message-ID: <153685494161.16086.536892492442787707.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Sep 2018 16:09:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the DNS resolver to retrieve a set of servers and their associated
addresses, ports, preference and weight ratings.

In terms of communication with userspace, "srv=1" is added to the callout
string (the '1' indicating the maximum data version supported by the
kernel) to ask the userspace side for this.

If the userspace side doesn't recognise it, it will ignore the option and
return the usual text address list.

If the userspace side does recognise it, it will return some binary data
that begins with a zero byte that would cause the string parsers to give an
error.  The second byte contains the version of the data in the blob (this
may be between 1 and the version specified in the callout data).  The
remainder of the payload is version-specific.

In version 1, the payload looks like (note that this is packed):

	u8	Non-string marker (ie. 0)
	u8	Content (0 => Server list)
	u8	Version (ie. 1)
	u8	Number of servers
	foreach-server {
		u16	Name length (LE)
		u16	Priority (as per SRV record) (LE)
		u16	Weight (as per SRV record) (LE)
		u16	Port (LE)
		u8	Protocol (IPPROTO_*)
		u8	Number of addresses
		char[]	Name (not NUL-terminated)
		foreach-address {
			u8		Family (AF_INET{,6})
			union {
				u8[4]	ipv4_addr
				u8[16]	ipv6_addr
			}
		}
	}

This can then be used to fetch a whole cell's configuration for AFS, for
example.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/dns_resolver/dns_key.c   |   61 ++++++++++++++++++++++++++++++++++++++++--
 net/dns_resolver/dns_query.c |    5 +--
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 7f4534828f6c..ac3c9aa75727 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -48,14 +48,40 @@ const struct cred *dns_resolver_cache;
 /*
  * Preparse instantiation data for a dns_resolver key.
  *
- * The data must be a NUL-terminated string, with the NUL char accounted in
- * datalen.
+ * For normal hostname lookups, the data must be a NUL-terminated string, with
+ * the NUL char accounted in datalen.
  *
  * If the data contains a '#' characters, then we take the clause after each
  * one to be an option of the form 'key=value'.  The actual data of interest is
  * the string leading up to the first '#'.  For instance:
  *
  *        "ip1,ip2,...#foo=bar"
+ *
+ * For server list requests, the data must begin with a NUL char and be
+ * followed by a byte indicating the version of the data format.  Version 1
+ * looks something like (note this is packed):
+ *
+ *	u8      Non-string marker (ie. 0)
+ *	u8	Content (0 is server list)
+ *	u8	Version (ie. 1)
+ *	u8	Number of servers
+ *	foreach-server {
+ *		u16	Name length (LE)
+ *		u16	Priority (as per SRV record, low first) (LE)
+ *		u16	Weight (as per SRV record, higher first) (LE)
+ *		u16	Port (LE)
+ *		u8	Protocol (IPPROTO_*)
+ *		u8	Number of addresses
+ *		char[]	Name (not NUL-terminated)
+ *		foreach-address {
+ *			u8		Family (AF_INET{,6})
+ *			union {
+ *				u8[4]	ipv4_addr
+ *				u8[16]	ipv6_addr
+ *			}
+ *		}
+ *	}
+ *
  */
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
@@ -66,9 +92,37 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	int datalen = prep->datalen, result_len = 0;
 	const char *data = prep->data, *end, *opt;
 
+	if (datalen <= 1 || !data)
+		return -EINVAL;
+
+	if (data[0] == 0) {
+		/* It may be a server list. */
+		if (datalen <= 3)
+			return -EINVAL;
+
+		data++;
+		kenter("[%u,%u],%u", data[0], data[1], datalen);
+		if (data[0] != 0) {
+			pr_warn_ratelimited(
+				"dns_resolver: Unsupported result type (%u)\n",
+				(unsigned char)data[0]);
+			return -EINVAL;
+		}
+
+		if (data[1] != 1) {
+			pr_warn_ratelimited(
+				"dns_resolver: Unsupported server list version (%u)\n",
+				(unsigned char)data[1]);
+			return -EINVAL;
+		}
+
+		result_len = datalen - 1;
+		goto store_result;
+	}
+
 	kenter("'%*.*s',%u", datalen, datalen, data, datalen);
 
-	if (datalen <= 1 || !data || data[datalen - 1] != '\0')
+	if (!data || data[datalen - 1] != '\0')
 		return -EINVAL;
 	datalen--;
 
@@ -144,6 +198,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		return 0;
 	}
 
+store_result:
 	kdebug("store result");
 	prep->quotalen = result_len;
 
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 49da67034f29..76338c38738a 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -148,12 +148,9 @@ int dns_query(const char *type, const char *name, size_t namelen,
 
 	if (_result) {
 		ret = -ENOMEM;
-		*_result = kmalloc(len + 1, GFP_KERNEL);
+		*_result = kmemdup_nul(upayload->data, len, GFP_KERNEL);
 		if (!*_result)
 			goto put;
-
-		memcpy(*_result, upayload->data, len);
-		(*_result)[len] = '\0';
 	}
 
 	if (_expiry)

