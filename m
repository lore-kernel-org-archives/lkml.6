Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226LD/VNzTxQVfhS0i5K/6hQLgBoYi/SqrDXhq0odHgLdmCKByXirCYw1bilUTmmKyGEBNFN
ARC-Seal: i=1; a=rsa-sha256; t=1519264788; cv=none;
        d=google.com; s=arc-20160816;
        b=KYuMDoFU3Kf2lodcYveD0lERjr9hh31w9dWeQlwlRCokx4lc0HrZz/Ni6POKtGLm4+
         fue3h1giakU4VWyStDXnWj+JSUH0YB+gbYWRYGaWy0LRkpIMBKuszrWZEXNgzsOWAcg1
         +5SPmwrCndjXgl7YRtOLJMj8I9mo1xXGy9QOXvuI14j3FM9ydLwryqhC5stZUrms6zuZ
         uggswXaaX2vQtsu0/cpe5tJDrup2YV4rXvF3j9vyHFM0BowfKUrM8fj0DS8Df5VURlw3
         GSiNQ5zFZqSBin9cnsYwHSH5njJHadSCrNBEr0qcnibESWrt0mgWTaStoWQ838Q6JaGL
         yP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6Mdu7M72g8s3iHURmwgkZUgfnUD5vohliguAoFi9vaI=;
        b=hXaHxdBDuHxm7qp/0LUHgSYyZ0HrdkCq0qvNO7Mcyq7TlkaA0Nn931JacbdZiBEc1P
         NnxPB5X6EB/zECPb3w1zW5OFZo+JIjH7POiiHhWyL9zOAXwo0iJt2SniOSpOdcOH9/R+
         R0GraPk+tGtkKJBVd+X7rGtnw4eLRFVqo8oEtmcaB0+kRLAl8bFWVdwIWXIghOwYfr4U
         YeEEcxGBTR3+h2uzWgZSt9B/pfnNb7+msvD/Kib1GK/2dRK33RhTfdzbJpub9Gyw3rpj
         D4/ru6OEw79NAqQfWxzJWwIcL7yq9O0DBMpJtJqLFDJELMsyqB+E2DFPZzumJsDf8DrS
         p/GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=SzDM2T8V;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=SzDM2T8V;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeBVB7e (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:59:34 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34630 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeBVB5J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:57:09 -0500
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
Subject: [PATCH v12 14/22] selftests/vm: clear the bits in shadow reg when a pkey is freed.
Date: Wed, 21 Feb 2018 17:55:33 -0800
Message-Id: <1519264541-7621-15-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064595048468921?=
X-GMAIL-MSGID: =?utf-8?q?1593064595048468921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a key is freed, the  key  is  no  more  effective.
Clear the bits corresponding to the pkey in the shadow
register. Otherwise  it  will carry some spurious bits
which can trigger false-positive asserts.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index c4c73e6..e82bd88 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -586,7 +586,8 @@ int sys_pkey_free(unsigned long pkey)
 	int ret = syscall(SYS_pkey_free, pkey);
 
 	if (!ret)
-		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
+		shadow_pkey_reg &= reset_bits(pkey,
+				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
 	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
 	return ret;
 }
-- 
1.7.1

