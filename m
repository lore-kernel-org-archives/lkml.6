Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEBEECDE2C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3592082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3592082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJIWjD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeJIWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:39:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A27F3097074;
        Tue,  9 Oct 2018 15:21:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCC626EE56;
        Tue,  9 Oct 2018 15:21:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LRH.2.21.1810040520570.16168@namei.org>
References: <alpine.LRH.2.21.1810040520570.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk>
To:     James Morris <jmorris@namei.org>
Cc:     dhowells@redhat.com, denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/22] KEYS: Provide software public key query function
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16729.1539098496.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 09 Oct 2018 16:21:36 +0100
Message-ID: <16730.1539098496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 09 Oct 2018 15:21:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +	if (strcmp(encoding, "raw") == 0) {
> > +		strcpy(alg_name, pkey->pkey_algo);
> > +		return 0;
> > +	}
> 
> Can encoding here also be NULL to indicate raw? per patch 01:

Okay, I'm making the attached changes to patch 01.  They're
documentary/commentary only.

David
---
diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 2cdccde6c585..c144978479d5 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1507,12 +1507,12 @@ The structure has a number of fields, some of which are mandatory:
 		enum kernel_pkey_operation op : 8;
 	};
 
-     This includes the key to be used; an optional string indicating the
-     encoding to use (for instance, "pkcs1" may be used with an RSA key to
-     indicate RSASSA-PKCS1-v1.5 or RSAES-PKCS1-v1.5 encoding); the name of the
-     hash algorithm used to generate the data for a signature (if appropriate);
-     the sizes of the input and output (or second input) buffers; and the ID of
-     the operation to be performed.
+     This includes the key to be used; a string indicating the encoding to use
+     (for instance, "pkcs1" may be used with an RSA key to indicate
+     RSASSA-PKCS1-v1.5 or RSAES-PKCS1-v1.5 encoding or "raw" if no encoding);
+     the name of the hash algorithm used to generate the data for a signature
+     (if appropriate); the sizes of the input and output (or second input)
+     buffers; and the ID of the operation to be performed.
 
      For a given operation ID, the input and output buffers are used as
      follows::
diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
index e89b4a4e43d0..c7c48c79ce0e 100644
--- a/include/linux/keyctl.h
+++ b/include/linux/keyctl.h
@@ -32,7 +32,7 @@ enum kernel_pkey_operation {
 
 struct kernel_pkey_params {
 	struct key	*key;
-	const char	*encoding;	/* Encoding (eg. "oaep" or NULL for raw) */
+	const char	*encoding;	/* Encoding (eg. "oaep" or "raw" for none) */
 	const char	*hash_algo;	/* Digest algorithm used (eg. "sha1") or NULL if N/A */
 	char		*info;		/* Modified info string to be released later */
 	__u32		in_len;		/* Input data size */
