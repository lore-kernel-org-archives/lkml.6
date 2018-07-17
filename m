Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9073ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7421D20647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7421D20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeGQXmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:42:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:56818 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbeGQXmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:42:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 16:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,367,1526367600"; 
   d="scan'208";a="75608409"
Received: from 2b52.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2018 16:07:18 -0700
Message-ID: <1531868610.3541.21.camel@intel.com>
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 17 Jul 2018 16:03:30 -0700
In-Reply-To: <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-17-yu-cheng.yu@intel.com>
         <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
         <1531328731.15351.3.camel@intel.com>
         <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 11:26 -0700, Dave Hansen wrote:
> On 07/11/2018 10:05 AM, Yu-cheng Yu wrote:
> > 
> > My understanding is that we don't want to follow write pte if the page
> > is shared as read-only.  For a SHSTK page, that is (R/O + DIRTY_SW),
> > which means the SHSTK page has not been COW'ed.  Is that right?
> Let's look at the code again:
> 
> > 
> > -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> > +static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
> > +					bool shstk)
> >  {
> > +	bool pte_cowed = shstk ? is_shstk_pte(pte):pte_dirty(pte);
> > +
> >  	return pte_write(pte) ||
> > -		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> > +		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_cowed);
> >  }
> This is another case where the naming of pte_*() is biting us vs. the
> perversion of the PTE bits.  The lack of comments and explanation inthe
> patch is compounding the confusion.
> 
> We need to find a way to differentiate "someone can write to this PTE"
> from "the write bit is set in this PTE".
> 
> In this particular hunk, we need to make it clear that pte_write() is
> *never* true for shadowstack PTEs.  In other words, shadow stack VMAs
> will (should?) never even *see* a pte_write() PTE.
> 
> I think this is a case where you just need to bite the bullet and
> bifurcate can_follow_write_pte().  Just separate the shadowstack and
> non-shadowstack parts.

In case I don't understand the exact issue.
What about the following.

diff --git a/mm/gup.c b/mm/gup.c
index fc5f98069f4e..45a0837b27f9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -70,6 +70,12 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
 }
 
+static inline bool can_follow_write_shstk_pte(pte_t pte, unsigned int flags)
+{
+	return ((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
+		is_shstk_pte(pte));
+}
+
 static struct page *follow_page_pte(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
@@ -105,9 +111,16 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
-		pte_unmap_unlock(ptep, ptl);
-		return NULL;
+	if (flags & FOLL_WRITE) {
+		if (is_shstk_mapping(vma->vm_flags)) {
+			if (!can_follow_write_shstk_pte(pte, flags)) {
+				pte_unmap_unlock(ptep, ptl);
+				return NULL;
+			}
+		} else if (!can_follow_write_pte(pte, flags) {
+			pte_unmap_unlock(ptep, ptl);
+			return NULL;
+		}
 	}
 
 	page = vm_normal_page(vma, address, pte);

