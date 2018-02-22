Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225iBzrA3v6eRb7hsHjq6lxR6s5aSmSc/Uzoi8G+Uns+F0dFd07PJH4a1dU1jxfMF8OD3UWP
ARC-Seal: i=1; a=rsa-sha256; t=1519264819; cv=none;
        d=google.com; s=arc-20160816;
        b=maD16zNJeKzWbSpGDFBcZZEH6+X/Xq2Q4qJPICOet3wht7QsToD8DWGrh4JO3wu7P0
         G3PNrReG2l5ea4J0BWYa0iXbIIa4cNan6azI7GwwKELzbjbpm/S9Dx2UgSo9qmdlpEMi
         wdIA5/NhEhUE/OjrMeCY2KKm+Qotdu/rSpQjUdGNbYYYWLkUPz84unW2up3HNyBpQ2BI
         AzT6x8KI9VyfovqHSp36Qg4jILwdO8RLqC0eMn4wbJbMdCpRVxxwsC3Om9cce2TYiRnl
         S23Mj8IVfGl9VeK4BdkeXf9g7BIZRDURG/uc6KmeePj0spQuH2zViPAuchCFtKcuOhIs
         WR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0m5RAt3VvWMaQLabgJKWqTns8hRVTnUzSdKh3rebOBE=;
        b=NKzLzS6h7yw/KYGoiadkppeZ0Fyfr2DFHRiGO9DMXf7wkvhOys/+HeWwdC26fb4ML3
         UDvxfPafBuAD+6f5dOc5sCt/vAnurpQOsctU1pQDjz7UyGZ1FMPlugXuzNjut0DhHu3x
         GfJqrRcqwU2G5bfKc9fOUMlKbzVLecz7WazYUv4EU805lvxptJDuFNUojJY20Z41d1Ts
         1GO9FRi4oncG00mByCQIeyN3ojkxeo2g6dB6ogMeDneXNKgCo0KgngK6eFFRo0zGdAm/
         0P13W7XZVaOzprfaC3aGBGu4Z9f75ZcF5/IBFfcbVYqKEZoIIyqcC4OkYJPbksRDA2fe
         9nOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=aa/oSTTb;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=aa/oSTTb;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBVB77 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:59:59 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40606 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeBVB4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:47 -0500
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
Subject: [PATCH v12 11/22] selftests/vm: pkey register should match shadow pkey
Date: Wed, 21 Feb 2018 17:55:30 -0800
Message-Id: <1519264541-7621-12-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064626705149797?=
X-GMAIL-MSGID: =?utf-8?q?1593064626705149797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

expected_pkey_fault() is comparing the contents of pkey
register with 0. This may not be true all the time. There
could be bits set by default by the architecture
which can never be changed. Hence compare the value against
shadow pkey register, which is supposed to track the bits
accurately all throughout

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 254b66d..6054093 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -926,10 +926,10 @@ void expected_pkey_fault(int pkey)
 	pkey_assert(last_pkey_faults + 1 == pkey_faults);
 	pkey_assert(last_si_pkey == pkey);
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler shold have cleared out pkey-register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__rdpkey_reg() != 0)
+	if (__rdpkey_reg() != shadow_pkey_reg)
 		pkey_assert(0);
 
 	__wrpkey_reg(shadow_pkey_reg);
-- 
1.7.1

