Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E33A2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E33A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIFC02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:26:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727593AbeIFC02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5291F40216F3;
        Wed,  5 Sep 2018 21:54:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 256162027EA0;
        Wed,  5 Sep 2018 21:54:18 +0000 (UTC)
Subject: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:54:17 +0100
Message-ID: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:54:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Here's a set of patches that does the following, if you could pull it please:

 (1) Adds keyctl() functions that permit an asymmetric-type key to be used
     to encrypt, decrypt, sign and verify a small piece of data (typically
     a session key or a hash) using the public and/or private key held in
     the kernel.  A query function is also provided.

 (2) Adds an asymmetric-key parser for PKCS#8 to allow RSA private keys to
     be passed to the kernel.  Currently only DER-encoded and unencrypted
     PKCS#8 is supported.

 (3) Adds an asymmetric-key parser for TPM-wrapped key blobs.  The parser
     gets the TPM to unpack the blob and then attaches it to a key from
     which it can be used.  Currently only TPM-1.2 is supported.

Example usage for a PKCS#8 blob:

	j=`openssl pkcs8 -in private_key.pem -topk8 -nocrypt -outform DER | \
	    keyctl padd asymmetric foo @s`

Example usage for a TPM wrapped blob:

	openssl genrsa -out /tmp/privkey.foo.pem 2048
	create_tpm_key -s 2048 -w /tmp/privkey.foo.pem /tmp/privkey.foo.tpm
	j=`openssl asn1parse -inform pem -in /tmp/privkey.foo.tpm -noout |
	    keyctl padd asymmetric foo @s`

See http://david.woodhou.se/draft-woodhouse-cert-best-practice.html#rfc.section.4.4

These keys can then be used thusly:

	echo -n abcdefghijklmnopqrst >/tmp/data
	keyctl pkey_encrypt $j /tmp/data enc=pkcs1 >/tmp/enc
	keyctl pkey_decrypt $j /tmp/enc enc=pkcs1 >/tmp/dec
	cmp /tmp/data /tmp/dec
	keyctl pkey_sign $j /tmp/data enc=pkcs1 hash=sha1 >/tmp/sig
	keyctl pkey_verify $j /tmp/data /tmp/sig enc=pkcs1 hash=sha1


The kernel patches can be found tagged here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-asym-keyctl-20180905

and also on a branch here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-asym-keyctl

The keyutils changes needed can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/keyutils.git/log/?h=next

David
---
David Howells (8):
      KEYS: Provide key type operations for asymmetric key ops
      KEYS: Provide keyctls to drive the new key type ops for asymmetric keys
      KEYS: Provide missing asymmetric key subops for new key type ops
      KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type
      KEYS: Provide software public key query function
      KEYS: Allow the public_key struct to hold a private key
      KEYS: Implement encrypt, decrypt and sign for software asymmetric key
      KEYS: Implement PKCS#8 RSA Private Key parser

Denis Kenzior (14):
      crypto: rsa-pkcs1pad: Allow hash to be optional
      KEYS: asym_tpm: add skeleton for asym_tpm
      KEYS: asym_tpm: extract key size & public key
      KEYS: Add parser for TPM-based keys
      KEYS: asym_tpm: Implement pkey_query
      KEYS: asym_tpm: Implement encryption operation
      KEYS: trusted: Expose common functionality
      KEYS: Move trusted.h to include/keys
      KEYS: asym_tpm: Add loadkey2 and flushspecific
      KEYS: asym_tpm: Implement tpm_unbind
      KEYS: asym_tpm: Implement the decrypt operation
      KEYS: asym_tpm: Implement signature verification
      KEYS: asym_tpm: Implement tpm_sign
      KEYS: asym_tpm: Add support for the sign operation


 Documentation/crypto/asymmetric-keys.txt  |   26 +
 Documentation/security/keys/core.rst      |  217 ++++++
 crypto/asymmetric_keys/Kconfig            |   31 +
 crypto/asymmetric_keys/Makefile           |   25 +
 crypto/asymmetric_keys/asym_tpm.c         |  988 +++++++++++++++++++++++++++++
 crypto/asymmetric_keys/asymmetric_keys.h  |    3 
 crypto/asymmetric_keys/asymmetric_type.c  |   43 +
 crypto/asymmetric_keys/pkcs7_parser.c     |    1 
 crypto/asymmetric_keys/pkcs8.asn1         |   24 +
 crypto/asymmetric_keys/pkcs8_parser.c     |  184 +++++
 crypto/asymmetric_keys/public_key.c       |  191 +++++-
 crypto/asymmetric_keys/signature.c        |   95 +++
 crypto/asymmetric_keys/tpm.asn1           |    5 
 crypto/asymmetric_keys/tpm_parser.c       |  102 +++
 crypto/asymmetric_keys/x509_cert_parser.c |   21 -
 crypto/rsa-pkcs1pad.c                     |   59 +-
 include/crypto/asym_tpm_subtype.h         |   19 +
 include/crypto/public_key.h               |   14 
 include/keys/asymmetric-subtype.h         |    9 
 include/keys/trusted.h                    |  136 ++++
 include/linux/key-type.h                  |   11 
 include/linux/keyctl.h                    |   46 +
 include/uapi/linux/keyctl.h               |   30 +
 security/keys/Makefile                    |    1 
 security/keys/compat.c                    |   18 +
 security/keys/internal.h                  |   39 +
 security/keys/keyctl.c                    |   24 +
 security/keys/keyctl_pkey.c               |  323 +++++++++
 security/keys/trusted.c                   |   14 
 security/keys/trusted.h                   |  124 ----
 30 files changed, 2639 insertions(+), 184 deletions(-)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 crypto/asymmetric_keys/pkcs8.asn1
 create mode 100644 crypto/asymmetric_keys/pkcs8_parser.c
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c
 create mode 100644 include/crypto/asym_tpm_subtype.h
 create mode 100644 include/keys/trusted.h
 create mode 100644 include/linux/keyctl.h
 create mode 100644 security/keys/keyctl_pkey.c
 delete mode 100644 security/keys/trusted.h

