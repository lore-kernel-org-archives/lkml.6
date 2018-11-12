Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC5C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84AA223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84AA223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeKLUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:20:16 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeKLUUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:20:15 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6472018751565;
        Mon, 12 Nov 2018 10:27:35 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 12 Nov 2018 10:27:28 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 00/12] keys: add support for PGP keys and signatures
Date:   Mon, 12 Nov 2018 11:24:11 +0100
Message-ID: <20181112102423.30415-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on kernel/git/dhowells/linux-modsign.git
(branch: pgp-parser) at git.kernel.org.

The goal of this patch set is to add support for PGP keys and signatures,
so that it will be possible to verify RPM header signatures (included in
RPM-based Linux distributions) when IMA Appraisal is enabled.

The patch set includes two preliminary patches: the first introduces
mpi_key_length(), to get the number of bits and bytes of an MPI; the second
introduces rsa_parse_priv_key_raw() and rsa_parse_pub_key_raw(), to parse
an RSA key in RAW format if the ASN.1 parser returns an error.

The remaining of the patch set includes the original patches with
modifications to work with the current kernel. It additionally introduces
verify_pgp_signature(), to verify PGP signatures with built-in or secondary
trusted keys. Trusted keys can be included in the kernel by enabling
CONFIG_PGP_PRELOAD_PUBLIC_KEYS and by copying the file pubring.gpg
containing the PGP keyring to the kernel source directory.

The changelog is included in the description of each patch.

David Howells (8):
  PGPLIB: PGP definitions (RFC 4880)
  PGPLIB: Basic packet parser
  PGPLIB: Signature parser
  KEYS: PGP data parser
  KEYS: Provide PGP key description autogeneration
  KEYS: PGP-based public key signature verification
  PGP: Provide a key type for testing PGP signatures
  KEYS: Provide a function to load keys from a PGP keyring blob

Roberto Sassu (4):
  mpi: introduce mpi_key_length()
  rsa: add parser of raw format
  verification: introduce verify_pgp_signature()
  KEYS: Introduce load_pgp_public_keyring()

 certs/Kconfig                           |   7 +
 certs/Makefile                          |   3 +
 certs/system_keyring.c                  |  64 +++
 crypto/asymmetric_keys/Kconfig          |  38 ++
 crypto/asymmetric_keys/Makefile         |  15 +
 crypto/asymmetric_keys/pgp_library.c    | 625 ++++++++++++++++++++++++
 crypto/asymmetric_keys/pgp_parser.h     |  22 +
 crypto/asymmetric_keys/pgp_preload.c    | 118 +++++
 crypto/asymmetric_keys/pgp_public_key.c | 380 ++++++++++++++
 crypto/asymmetric_keys/pgp_signature.c  | 428 ++++++++++++++++
 crypto/asymmetric_keys/pgp_test_key.c   | 132 +++++
 crypto/rsa.c                            |  14 +-
 crypto/rsa_helper.c                     |  69 +++
 include/crypto/internal/rsa.h           |   6 +
 include/linux/mpi.h                     |   2 +
 include/linux/pgp.h                     | 215 ++++++++
 include/linux/pgp_sig.h                 |  24 +
 include/linux/pgplib.h                  |  87 ++++
 include/linux/verification.h            |   5 +
 lib/mpi/mpicoder.c                      |  33 +-
 20 files changed, 2276 insertions(+), 11 deletions(-)
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgp_parser.h
 create mode 100644 crypto/asymmetric_keys/pgp_preload.c
 create mode 100644 crypto/asymmetric_keys/pgp_public_key.c
 create mode 100644 crypto/asymmetric_keys/pgp_signature.c
 create mode 100644 crypto/asymmetric_keys/pgp_test_key.c
 create mode 100644 include/linux/pgp.h
 create mode 100644 include/linux/pgp_sig.h
 create mode 100644 include/linux/pgplib.h

-- 
2.17.1

