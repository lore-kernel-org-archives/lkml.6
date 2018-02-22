Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226P094W4vQL9WuBnGdiLCeiXqxWx+fvef6IQZwkd4qGrTVDp12dywKDm0fpNLh7SwZNz0Ap
ARC-Seal: i=1; a=rsa-sha256; t=1519264833; cv=none;
        d=google.com; s=arc-20160816;
        b=H5jUbzxDPkX803Q3cYdHMAXCYo9OWjf4E0BnShzxAmnaK2Yjwyzw1bQ/md3IBTk+Vg
         ifey4xXySo1L4IMVpObqPj0iBqZmQbmz4/X3YS3XuT5yfURpl6JILsYdwotXvK1iq//9
         h5EYGH1eqBdzjK3a6Fc7npQCIfnw3gB7VVKiu7hgv8HzxUEdlYeWDI4m+H119qLVnc+x
         itZB3rQ7u7afWxseb1U8yiZZ73AWbpOEJRrjlSgA5TVSpLPSJiKHwiItgWZOgsSFsrct
         ZRdHybNu6ZNUrOlTEaRvc1EigDhp/7IAssNsd0A2KrS063YixHUzyaZyqBZfgEICXzR+
         a5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2LKR9x3N6qyD+dcLiierQ79FIEOB6rJZ8+h9mUGUtPk=;
        b=rId//nw7HXYFoX6NaTrabr58u2DUs1m/Er84vvR/wi6vRtyEHKbzCc89njeDBzdwml
         A9LFYRu3T+TZA7rvN9Sf8hPjlfJOmhthozwebEVREuIIRnEjakLQO1iwN1l+xDJpDOcc
         c6PD349wZElPrwdvJDOd2v3DYzmaninAVN4i/Aw9uDMvV9UkKy8XWZGE/THn7m3UGT7m
         46m/J/GV4JEsgNGnXtQF8u3vaezCwILAvxXrjNr/4umQ5NAasebY+5VrpttDN9JEv7Ry
         BhvnRVcKfc/IVPToaXCyE5ubeTXlJTiSE9BpZAHUiA7YM7lunTfuvXs4ATCxqVFG/ZoS
         N1hw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=hgeF4R2f;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=hgeF4R2f;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeBVB4l (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:56:41 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44187 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeBVB4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:38 -0500
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
Subject: [PATCH v12 08/22] selftests/vm: clear the bits in shadow reg when a pkey is freed.
Date: Wed, 21 Feb 2018 17:55:27 -0800
Message-Id: <1519264541-7621-9-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064595048468921?=
X-GMAIL-MSGID: =?utf-8?q?1593064641721887167?=
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
 tools/testing/selftests/vm/protection_keys.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index ca54a95..aaf9f09 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -582,6 +582,9 @@ int alloc_pkey(void)
 int sys_pkey_free(unsigned long pkey)
 {
 	int ret = syscall(SYS_pkey_free, pkey);
+
+	if (!ret)
+		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
 	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
 	return ret;
 }
-- 
1.7.1

