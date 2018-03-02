Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981361-2-3566304514151434524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981361; b=JJAaqm3UAvQ/72kwsKw+MgbzT0t4iu2RiCtDMrXQpxB8OPy
    fMsCXQyywWkSiI3L9QnMOY4fwIA/DspGHQs8gqbnqs7Uw1AT2qG/LW+xkeDYJvxL
    Qc4t5ld1H5Kr2BKBPH0VMUwtD0hMxahESz+l2Q/Ue2zRoxlQDBymkAhTP4QNptoI
    BhNcz87CLPb3NAGSZ1O7gb75OzYboO4kJQPnEdqLsKVJIOAN3jRZBwtU7z1ck0XH
    L6jy7JLkD980jQ4eR4hB+MXlz9NV3QMYGPt4drpSTV/3iSd5yEVGbJidha/k9O1R
    vVxoO+BT+CzA96pccpM7sQZ7xjhqntMrTH59RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981361; bh=PDch8cBKu6wuYs/UAWWDpvd/SF
    em4KdxqqIMztRZUn0=; b=i2/afX56KY9fT4y4bYCxQ+fHjsHXgQmnuJ/UQF0bRU
    g0YAPVlYh0kRBJevehtnPJbuqn7wG9UbONll9rAipsszMnBQ1GpcmSkd5eumd7Mz
    2HHxAz9ITXDK9trvpzQzeFj5IXVnAXmzj+kgQYsgadGPLFvu4IGJ2HiaaQclaYMf
    4oNYq/0xcmtyk1hPNhsljZTGdYqPT29CzXNw7lYP2KWyY6HZirPwHOBBjUug9sKb
    qGm7UFUH5ZRluw7T0VuqZURMBe1JqDPBvZZYdh5Z/i1SIYd/EinWohBYLyIYkvbG
    yvffzWQ4rViKDqJz5VLXKnUWaS6bOf2KyIqxz6lhiIPQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424490AbeCBJCf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:02:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424870AbeCBJCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:02:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 029/115] x86-64/Xen: eliminate W+X mappings
Date: Fri,  2 Mar 2018 09:50:32 +0100
Message-Id: <20180302084505.057550469@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>


[ Upstream commit 2cc42bac1c795f75fcc062b95c6ca7ac1b84d5d8 ]

A few thousand such pages are usually left around due to the re-use of
L1 tables having been provided by the hypervisor (Dom0) or tool stack
(DomU). Set NX in the direct map variant, which needs to be done in L2
due to the dual use of the re-used L1s.

For x86_configure_nx() to actually do what it is supposed to do, call
get_cpu_cap() first. This was broken by commit 4763ed4d45 ("x86, mm:
Clean up and simplify NX enablement") when switching away from the
direct EFER read.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/enlighten_pv.c |    3 +++
 arch/x86/xen/mmu_pv.c       |   12 ++++++++++++
 2 files changed, 15 insertions(+)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -88,6 +88,8 @@
 #include "multicalls.h"
 #include "pmu.h"
 
+#include "../kernel/cpu/cpu.h" /* get_cpu_cap() */
+
 void *xen_initial_gdt;
 
 static int xen_cpu_up_prepare_pv(unsigned int cpu);
@@ -1257,6 +1259,7 @@ asmlinkage __visible void __init xen_sta
 	__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
 
 	/* Work out if we support NX */
+	get_cpu_cap(&boot_cpu_data);
 	x86_configure_nx();
 
 	/* Get mfn list */
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1902,6 +1902,18 @@ void __init xen_setup_kernel_pagetable(p
 	/* Graft it onto L4[511][510] */
 	copy_page(level2_kernel_pgt, l2);
 
+	/*
+	 * Zap execute permission from the ident map. Due to the sharing of
+	 * L1 entries we need to do this in the L2.
+	 */
+	if (__supported_pte_mask & _PAGE_NX) {
+		for (i = 0; i < PTRS_PER_PMD; ++i) {
+			if (pmd_none(level2_ident_pgt[i]))
+				continue;
+			level2_ident_pgt[i] = pmd_set_flags(level2_ident_pgt[i], _PAGE_NX);
+		}
+	}
+
 	/* Copy the initial P->M table mappings if necessary. */
 	i = pgd_index(xen_start_info->mfn_list);
 	if (i && i < pgd_index(__START_KERNEL_map))
