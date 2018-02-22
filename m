Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225e+FegYTIqbwRPulsN0CEwOrynyXMnwfoX03zkkSFQCSWI9ZW5pzbe/DygAulQtC8pIkr8
ARC-Seal: i=1; a=rsa-sha256; t=1519264869; cv=none;
        d=google.com; s=arc-20160816;
        b=i3dq7g3JqzNpYyAVepRzA4aepiK53GpyCL3Sc1ycWJrZQTbeq/DK8DoVIIXH5cfgPD
         WYJgDKC3H19iRI59Kh67hFNBzX4fFDmHUmzbl0ikHVevlXAruQS1LQBjfJXP7vXT2uDe
         B4EkU+osqngX7y4J1MVumH0IjH7fVw9Zj4hZmZVaw0s3E4bmYbumPYdYKkbGXvHftVBF
         eKdp8yCl7m+pm/4xAgXquBoTaAAd4xjFlAmGy3nMF+27gx+Jr9UpQyItTb4lG3LrGL1T
         odZkWf7e3yxC1hBYmTOkRfCMRF3132jqXz3oOldUMLs1D3V3ei/1qTGK3CMIDLPWW/uF
         59JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sv97mxweOiZD3jZb+FDvREl/KQT7v2zxhclS3+by93o=;
        b=qccz/OPTQVpuf7YiVyCCVEebHYiO/UWQu52hjnp0YZHX4clrUTMuUWdcp5JuKEzXrG
         yq4S/8oamNoAZCrxFwMnoe4nOh/p+amMJ1BOuG3jUD8+fRht/9v/ywu1DOszKz5+CiLl
         pMqs4IJfc5GbDOlvHHNm6DDYh+pzPNi1vZfZhhY9vQNZWOnWDhxbfv7weQ1TtX5fsL50
         TiwSqi2B0gl1uxhfQgs+auf5rgxfn5NZMirIqy0N2nro0kiQNOm26o+TMY3ReCvt9Q+z
         DzPDFtuPgokfTQN8i407HPFCrNJpzWRyy/UugWuaVendypWphin6Sisdsdw4yXQXY7gg
         qEJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=D+MBVQQL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=D+MBVQQL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBVCAz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 21:00:55 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44184 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeBVB4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:36 -0500
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
Subject: [PATCH v12 07/22] selftests/vm: fixed bugs in pkey_disable_clear()
Date: Wed, 21 Feb 2018 17:55:26 -0800
Message-Id: <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064680200522222?=
X-GMAIL-MSGID: =?utf-8?q?1593064680200522222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

instead of clearing the bits, pkey_disable_clear() was setting
the bits. Fixed it.

Also fixed a wrong assertion in that function. When bits are
cleared, the resulting bit value will be less than the original.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 0109388..ca54a95 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
-	pkey_rights |= flags;
+	pkey_rights &= ~flags;
 
 	ret = pkey_set(pkey, pkey_rights, 0);
 	/* pkey_reg and flags have the same format */
@@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
 			pkey, rdpkey_reg());
 	if (flags)
-		assert(rdpkey_reg() > orig_pkey_reg);
+		assert(rdpkey_reg() < orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
1.7.1

