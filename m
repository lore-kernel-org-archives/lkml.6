Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE1CC43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11962085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfAFNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:36:26 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52384 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfAFNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:36:26 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A27E772CC6C;
        Sun,  6 Jan 2019 16:36:23 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0A83E4A4A14;
        Sun,  6 Jan 2019 16:36:23 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] crypto: Add EC-RDSA algorithm
Date:   Sun,  6 Jan 2019 16:36:04 +0300
Message-Id: <20190106133608.820-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes akcipher api to support ECDSA style signature
verification. Augments x509 parser to make it work with EC-RDSA certificates.
And finally implements EC-RDSA (GOST 34.10) signature verification.

It is intended to use in IMA for appraisal.

Tested on x86_64 with openssl+gost-engine generated certificates.

Vitaly Chikunov (4):
  X.509: Parse public key parameters from x509 for akcipher
  akcipher: Introduce verify2 for public key algorithms
  KEYS: set correct flags for keyctl if encrypt is not supported
  crypto: Add EC-RDSA algorithm

 crypto/Kconfig                            |  63 ++--
 crypto/Makefile                           |   5 +-
 crypto/asymmetric_keys/public_key.c       |  74 +++--
 crypto/asymmetric_keys/x509.asn1          |   2 +-
 crypto/asymmetric_keys/x509_cert_parser.c |  51 ++-
 crypto/ecc.c                              | 421 +++++++++++++++++++++++--
 crypto/ecc.h                              | 162 +++++++++-
 crypto/ecc_curve_defs.h                   |  15 -
 crypto/ecrdsa.c                           | 494 ++++++++++++++++++++++++++++++
 crypto/testmgr.c                          |   5 +
 crypto/testmgr.h                          |   3 +
 include/crypto/akcipher.h                 |  87 +++++-
 include/crypto/public_key.h               |   4 +
 include/linux/oid_registry.h              |  18 ++
 14 files changed, 1319 insertions(+), 85 deletions(-)
 create mode 100644 crypto/ecrdsa.c

-- 
2.11.0

