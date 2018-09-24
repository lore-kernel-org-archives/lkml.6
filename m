Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C901AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA7C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA7C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeIXPsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:48:53 -0400
Received: from shell.v3.sk ([90.176.6.54]:58815 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbeIXPsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:48:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2E21EBA289;
        Mon, 24 Sep 2018 11:47:37 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NkC8_gqiE1l4; Mon, 24 Sep 2018 11:47:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9A020BA28E;
        Mon, 24 Sep 2018 11:47:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OjTGSoHBm3Pd; Mon, 24 Sep 2018 11:47:31 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 874D1BA289;
        Mon, 24 Sep 2018 11:47:31 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"
Date:   Mon, 24 Sep 2018 11:47:23 +0200
Message-Id: <20180924094723.487697-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes UAPI, breaking iwd and libell:

  ell/key.c: In function 'kernel_dh_compute':
  ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named =
'private'; did you mean 'dh_private'?
    struct keyctl_dh_params params =3D { .private =3D private,
                                        ^~~~~~~
                                        dh_private

This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.

Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org>
---
 include/uapi/linux/keyctl.h | 2 +-
 security/keys/dh.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 910cc4334b21..7b8c9e19bad1 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
=20
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 dh_private;
+	__s32 private;
 	__s32 prime;
 	__s32 base;
 };
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 3b602a1e27fa..711e89d8c415 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -300,7 +300,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __us=
er *params,
 	}
 	dh_inputs.g_size =3D dlen;
=20
-	dlen =3D dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
+	dlen =3D dh_data_from_key(pcopy.private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret =3D dlen;
 		goto out2;
--=20
2.19.0

