Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5808C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5808C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeKLF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51998 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbeKLF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsx-0000lF-Mt; Sun, 11 Nov 2018 19:59:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001dU-BW; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "James Morris" <james.morris@microsoft.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.388729595@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 197/366] X.509: unpack RSA signatureValue field from
 BIT STRING
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

commit b65c32ec5a942ab3ada93a048089a938918aba7f upstream.

The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
For RSA signatures this BIT STRING is of so-called primitive subtype, which
contains a u8 prefix indicating a count of unused bits in the encoding.

We have to strip this prefix from signature data, just as we already do for
key data in x509_extract_key_data() function.

This wasn't noticed earlier because this prefix byte is zero for RSA key
sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
prefixes has no bearing on its value.

The signature length, however was incorrect, which is a problem for RSA
implementations that need it to be exactly correct (like AMD CCP).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: c26fd69fa009 ("X.509: Add a crypto key parser for binary (DER) X.509 certificates")
Signed-off-by: James Morris <james.morris@microsoft.com>
[bwh: Backported to 3.16:
 - x509_certificate::sig is a structure, not a pointer
 - public_key_signature::pkey_algo is an enumeration type, not a string]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -205,6 +205,15 @@ int x509_note_signature(void *context, s
 		return -EINVAL;
 	}
 
+	if (ctx->cert->sig.pkey_algo == PKEY_ALGO_RSA) {
+		/* Discard the BIT STRING metadata */
+		if (vlen < 1 || *(const u8 *)value != 0)
+			return -EBADMSG;
+
+		value++;
+		vlen--;
+	}
+
 	ctx->cert->raw_sig = value;
 	ctx->cert->raw_sig_size = vlen;
 	return 0;

