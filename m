Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC19DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E8020834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E8020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJZSMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:12:25 -0400
Received: from namei.org ([65.99.196.166]:49316 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJZSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:12:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9Q9a1V3007957;
        Fri, 26 Oct 2018 09:36:01 GMT
Date:   Fri, 26 Oct 2018 20:36:01 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security: keys updates for v4.20
Message-ID: <alpine.LRH.2.21.1810262033270.5228@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull. Note these patches have been in next and my tree under a 
different branch for some weeks.

From David: "Provide five new operations in the key_type struct that can 
be used to provide access to asymmetric key operations.  These will be 
implemented for the asymmetric key type in a later patch and may refer to 
a key retained in RAM by the kernel or a key retained in crypto hardware.

     int (*asym_query)(const struct kernel_pkey_params *params,
                       struct kernel_pkey_query *info);
     int (*asym_eds_op)(struct kernel_pkey_params *params,
                        const void *in, void *out);
     int (*asym_verify_signature)(struct kernel_pkey_params *params,
                                  const void *in, const void *in2);

Since encrypt, decrypt and sign are identical in their interfaces, they're
rolled together in the asym_eds_op() operation and there's an operation ID
in the params argument to distinguish them.

Verify is different in that we supply the data and the signature instead 
and get an error value (or 0) as the only result on the expectation that 
this may well be how a hardware crypto device may work."

---


The following changes since commit e5f6d9afa3415104e402cd69288bb03f7165eeba:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-25 18:14:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-keys2

for you to fetch changes up to 64ae16dfeefec670276607fa789ce096c7ebd7c4:

  KEYS: asym_tpm: Add support for the sign operation [ver #2] (2018-10-26 09:30:47 +0100)

----------------------------------------------------------------
David Howells (8):
      KEYS: Provide key type operations for asymmetric key ops [ver #2]
      KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]
      KEYS: Provide missing asymmetric key subops for new key type ops [ver #2]
      KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type [ver #2]
      KEYS: Provide software public key query function [ver #2]
      KEYS: Allow the public_key struct to hold a private key [ver #2]
      KEYS: Implement encrypt, decrypt and sign for software asymmetric key [ver #2]
      KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]

Denis Kenzior (14):
      crypto: rsa-pkcs1pad: Allow hash to be optional [ver #2]
      KEYS: asym_tpm: add skeleton for asym_tpm [ver #2]
      KEYS: asym_tpm: extract key size & public key [ver #2]
      KEYS: Add parser for TPM-based keys [ver #2]
      KEYS: asym_tpm: Implement pkey_query [ver #2]
      KEYS: asym_tpm: Implement encryption operation [ver #2]
      KEYS: trusted: Expose common functionality [ver #2]
      KEYS: Move trusted.h to include/keys [ver #2]
      KEYS: asym_tpm: Add loadkey2 and flushspecific [ver #2]
      KEYS: asym_tpm: Implement tpm_unbind [ver #2]
      KEYS: asym_tpm: Implement the decrypt operation [ver #2]
      KEYS: asym_tpm: Implement signature verification [ver #2]
      KEYS: asym_tpm: Implement tpm_sign [ver #2]
      KEYS: asym_tpm: Add support for the sign operation [ver #2]

 Documentation/crypto/asymmetric-keys.txt  |  26 +-
 Documentation/security/keys/core.rst      | 217 +++++++
 crypto/asymmetric_keys/Kconfig            |  31 +
 crypto/asymmetric_keys/Makefile           |  25 +
 crypto/asymmetric_keys/asym_tpm.c         | 988 ++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/asymmetric_keys.h  |   3 +
 crypto/asymmetric_keys/asymmetric_type.c  |  43 ++
 crypto/asymmetric_keys/pkcs7_parser.c     |   1 +
 crypto/asymmetric_keys/pkcs8.asn1         |  24 +
 crypto/asymmetric_keys/pkcs8_parser.c     | 184 ++++++
 crypto/asymmetric_keys/public_key.c       | 191 +++++-
 crypto/asymmetric_keys/signature.c        |  95 +++
 crypto/asymmetric_keys/tpm.asn1           |   5 +
 crypto/asymmetric_keys/tpm_parser.c       | 102 +++
 crypto/asymmetric_keys/x509_cert_parser.c |  21 +-
 crypto/rsa-pkcs1pad.c                     |  59 +-
 include/crypto/asym_tpm_subtype.h         |  19 +
 include/crypto/public_key.h               |  14 +-
 include/keys/asymmetric-subtype.h         |   9 +
 {security => include}/keys/trusted.h      |  14 +-
 include/linux/key-type.h                  |  11 +
 include/linux/keyctl.h                    |  46 ++
 include/uapi/linux/keyctl.h               |  30 +
 security/keys/Makefile                    |   1 +
 security/keys/compat.c                    |  18 +
 security/keys/internal.h                  |  39 ++
 security/keys/keyctl.c                    |  24 +
 security/keys/keyctl_pkey.c               | 323 ++++++++++
 security/keys/trusted.c                   |  14 +-
 29 files changed, 2516 insertions(+), 61 deletions(-)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 crypto/asymmetric_keys/pkcs8.asn1
 create mode 100644 crypto/asymmetric_keys/pkcs8_parser.c
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c
 create mode 100644 include/crypto/asym_tpm_subtype.h
 rename {security => include}/keys/trusted.h (87%)
 create mode 100644 include/linux/keyctl.h
 create mode 100644 security/keys/keyctl_pkey.c
