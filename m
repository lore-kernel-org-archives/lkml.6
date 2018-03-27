Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELv3vL5pzkX1Bv8k13m0y3spfSFpwljXXdKMBsM1ZBrnC3qd8ImhtY6UQ6fRJQwqol6DAd3x
ARC-Seal: i=1; a=rsa-sha256; t=1522141899; cv=none;
        d=google.com; s=arc-20160816;
        b=OdkPwjR3Y+IAPv3rKCCOodfNP+92BSVEf3L7Mc+sfk3fGBzrxmuPuxKl7daesJ7TdW
         G1Ma3hTOQeCFWTU/SkHwEVNTf+P2WXkjtnsidl4PNADdbNdFgdLY9C51g+n1/m/LA71q
         y3Rfkx2sB31Ol3RhB/AK0bin17n2UE/vPvvkv92MK7iUsRGPsalQw2i7fvo+b/5+7JbS
         M1Bx7CoR5yS6K5anfYTufurDp3TeIfrjEb3By32LDbCl572kMGueuGAOI+OPXJa6bFFe
         cGYNeSjw2n75ExN0j1CXNGPflO1PaEHoKpulnw9hvjrxYjI0dsjvheok8pgt4XgCToVG
         UqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Urj4K6cor+xborGlLVQhsT/UJGk0+dXmLzxeHth/Y9A=;
        b=jOeNat3fhbsJ721lisVoMgLy4ICCWP3+F5yMSY1WQLVEGAApvdj5MBeQC4eI1rjXUn
         ceSN0SXTdYFYZaIIz7owTe9HZdNvZBmLQmnUccagmP/89e1VdjbPE1wuAnA80OjPMfTa
         eRrA7Q6Ld9KAgFtBsQM2ukx9wyQNpdOhm6iB42IwHB9OA72nnZFHqDgAlEiTwjfuFHY9
         Fr717KNIR9XTMLSKrqe6te7k5I7kvWbz7tFuS5UhnqnNeBD06R5rT7bg6HLkVbrdpGiq
         XRPCHumvYFo6epzXJyy/+V0/L4KownzeZ3Ay6O3UwadvLgYtBIe9bo59ip0WmZHYP8k9
         EeIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=jWxmfNgQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=jWxmfNgQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeC0JJz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 05:09:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36160 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeC0JJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 05:09:52 -0400
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
Subject: [PATCH v13 2/3] mm, powerpc, x86: introduce an additional vma bit for powerpc pkey
Date: Tue, 27 Mar 2018 02:09:27 -0700
Message-Id: <1522141768-25485-3-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
References: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596081464186527363?=
X-GMAIL-MSGID: =?utf-8?q?1596081464186527363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently only 4bits are allocated in the vma flags to hold 16
keys. This is sufficient for x86. PowerPC  supports  32  keys,
which needs 5bits. This patch allocates an  additional bit.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 fs/proc/task_mmu.c |    1 +
 include/linux/mm.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6b996d0..6d83bb7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -685,6 +685,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
+		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad207ad..d534f46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
 #if defined(CONFIG_X86)
-- 
1.7.1

