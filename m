Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225M62bcwNS8VZzVshuJLt2vaoIBadPmI2u+thCnNGa11LNUIMKr65wlQvVkEx9YmM7q6C9T
ARC-Seal: i=1; a=rsa-sha256; t=1519264871; cv=none;
        d=google.com; s=arc-20160816;
        b=amJkhWqg+TrrXHJqwdauLm373QpPA4PvJ/iQDs3m1fxCQLzry9+Zdeyx1ccNP/FuFu
         KEV93WAmw+fllsEeb5aF2HSf15yNx1Hm01LaECBPYKyLMs3g6IkSAoLGrfW8pJZN1h5A
         6nbQilcR/KIq7W6jkpiDURGCqqWCFBLdzRPNCNeLw+gXZb2gneJS8Voc281T5QRs+PTV
         a4kXS9J2P5v5OVJaHj5nR6NDegZ+nItV8kYy+EH4m8W807GCJLUfwGJeideInOwvCJq7
         qjla8SF3jirnkWs8gxZj+6BnDrKKDYOoU1e538ZQ6ahUomNR/G2jtx7tebK1LNQKnQcN
         +XiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=uqvsRnaHRcwGE0SMac/AwzF5nxxbiG6SGM7Ny69GGAc=;
        b=gDXYM9zL5mE+PxWu51Pw1p0N40pVfX9DbBJga6PIZVT5OZGMkLPF2VxzxNzB2Lx1Ty
         tiKVz/9hwiY3fFI/M1M5WSGZzuQRZ5Ia88rHVgBS7iKlLJXzC2lwTh+Rlu1QDFvZFCos
         rNzFqs20ocZuhMhtybc7ZMriKtXzJY7pH+XqgKWq7CLzgF8WSpqHc6aV8xER/Vnm74ak
         Dn4fUYpXXJD5WesezuzO+JreK6vjny5cbsbajwgEu9kvctp7JyqykB7/bhGeRmj/sh+I
         BCVS/mqiCtfV1LApW2bllBYp5k0MkpAQJ/2wHRLGfDso6xWQBhYaL2PjOwyg/M9EUUsx
         p/4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=DLhGsLbd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=DLhGsLbd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeBVB4g (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:56:36 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38690 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeBVB4c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:32 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, arnd@arndb.de
Subject: [PATCH v12 06/22] selftests/vm: fix the wrong assert in pkey_disable_set()
Date: Wed, 21 Feb 2018 17:55:25 -0800
Message-Id: <1519264541-7621-7-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064682238197500?=
X-GMAIL-MSGID: =?utf-8?q?1593064682238197500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the flag is 0, no bits will be set. Hence we cant expect
the resulting bitmap to have a higher value than what it
was earlier.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 83216c5..0109388 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -443,7 +443,7 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%lx\n",
 		__func__, pkey, rdpkey_reg());
 	if (flags)
-		pkey_assert(rdpkey_reg() > orig_pkey_reg);
+		pkey_assert(rdpkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
-- 
1.7.1

