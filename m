Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA2EECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0944B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0944B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJRKRq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:17:46 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:50707 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:17:45 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w9I2IjRX004388
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Oct 2018 11:18:45 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9I2Ii36027473;
        Thu, 18 Oct 2018 11:18:45 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9I2HKhZ021286;
        Thu, 18 Oct 2018 11:18:44 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4698336; Thu, 18 Oct 2018 11:17:43 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Thu,
 18 Oct 2018 11:17:42 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Thread-Topic: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Thread-Index: AQHUX9gx4+HBXRN9yU+xyCP1lDR0eqUXRm+AgACQpYCAAtWPAIAEP+WAgAA11ICAAkEHAIACV4uA
Date:   Thu, 18 Oct 2018 02:17:42 +0000
Message-ID: <20181018021741.GA3603@hori1.linux.bs1.fc.nec.co.jp>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
 <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
 <1968F276-5D96-426B-823F-38F6A51FB465@cs.rutgers.edu>
 <5e0e772c-7eef-e75c-2921-e80d4fbe8324@arm.com>
 <2398C491-E1DA-4B3C-B60A-377A09A02F1A@cs.rutgers.edu>
 <796cb545-7376-16a2-db3e-bc9a6ca9894d@arm.com>
 <5A0A88EF-4B86-4173-A506-DE19BDB786B8@cs.rutgers.edu>
In-Reply-To: <5A0A88EF-4B86-4173-A506-DE19BDB786B8@cs.rutgers.edu>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6B718953A26B454C82B906162E76979F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:31:50AM -0400, Zi Yan wrote:
> On 15 Oct 2018, at 0:06, Anshuman Khandual wrote:
> 
> > On 10/15/2018 06:23 AM, Zi Yan wrote:
> >> On 12 Oct 2018, at 4:00, Anshuman Khandual wrote:
> >>
> >>> On 10/10/2018 06:13 PM, Zi Yan wrote:
> >>>> On 10 Oct 2018, at 0:05, Anshuman Khandual wrote:
> >>>>
> >>>>> On 10/09/2018 07:28 PM, Zi Yan wrote:
> >>>>>> cc: Naoya Horiguchi (who proposed to use !_PAGE_PRESENT && !_PAGE_PSE for x86
> >>>>>> PMD migration entry check)
> >>>>>>
> >>>>>> On 8 Oct 2018, at 23:58, Anshuman Khandual wrote:
> >>>>>>
> >>>>>>> A normal mapped THP page at PMD level should be correctly differentiated
> >>>>>>> from a PMD migration entry while walking the page table. A mapped THP would
> >>>>>>> additionally check positive for pmd_present() along with pmd_trans_huge()
> >>>>>>> as compared to a PMD migration entry. This just adds a new conditional test
> >>>>>>> differentiating the two while walking the page table.
> >>>>>>>
> >>>>>>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> >>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>>>>> ---
> >>>>>>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
> >>>>>>> exclusive which makes the current conditional block work for both mapped
> >>>>>>> and migration entries. This is not same with arm64 where pmd_trans_huge()
> >>>>>>
> >>>>>> !pmd_present() && pmd_trans_huge() is used to represent THPs under splitting,
> >>>>>
> >>>>> Not really if we just look at code in the conditional blocks.
> >>>>
> >>>> Yeah, I explained it wrong above. Sorry about that.
> >>>>
> >>>> In x86, pmd_present() checks (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PSE),
> >>>> thus, it returns true even if the present bit is cleared but PSE bit is set.
> >>>
> >>> Okay.
> >>>
> >>>> This is done so, because THPs under splitting are regarded as present in the kernel
> >>>> but not present when a hardware page table walker checks it.
> >>>
> >>> Okay.
> >>>
> >>>>
> >>>> For PMD migration entry, which should be regarded as not present, if PSE bit
> >>>> is set, which makes pmd_trans_huge() returns true, like ARM64 does, all
> >>>> PMD migration entries will be regarded as present
> >>>
> >>> Okay to make pmd_present() return false pmd_trans_huge() has to return false
> >>> as well. Is there anything which can be done to get around this problem on
> >>> X86 ? pmd_trans_huge() returning true for a migration entry sounds logical.
> >>> Otherwise we would revert the condition block order to accommodate both the
> >>> implementation for pmd_trans_huge() as suggested by Kirill before or just
> >>> consider this patch forward.
> >>>
> >>> Because I am not really sure yet about the idea of getting pmd_present()
> >>> check into pmd_trans_huge() on arm64 just to make it fit into this semantics
> >>> as suggested by Will. If a PMD is trans huge page or not should not depend on
> >>> whether it is present or not.
> >>
> >> In terms of THPs, we have three cases: a present THP, a THP under splitting,
> >> and a THP under migration. pmd_present() and pmd_trans_huge() both return true
> >> for a present THP and a THP under splitting, because they discover _PAGE_PSE bit
> >
> > Then how do we differentiate between a mapped THP and a splitting THP.
> 
> AFAIK, in x86, there is no distinction between a mapped THP and a splitting THP
> using helper functions.
> 
> A mapped THP has _PAGE_PRESENT bit and _PAGE_PSE bit set, whereas a splitting THP
> has only _PAGE_PSE bit set. But both pmd_present() and pmd_trans_huge() return
> true as long as _PAGE_PSE bit is set.
> 
> >
> >> is set for both cases, whereas they both return false for a THP under migration.
> >> You want to change them to make pmd_trans_huge() returns true for a THP under migration
> >> instead of false to help ARM64’s support for THP migration.
> > I am just trying to understand the rationale behind this semantics and see where
> > it should be fixed.
> >
> > I think the fundamental problem here is that THP under split has been difficult
> > to be re-presented through the available helper functions and in turn PTE bits.
> >
> > The following checks
> >
> > 1) pmd_present()
> > 2) pmd_trans_huge()
> >
> > Represent three THP states
> >
> > 1) Mapped THP		(pmd_present && pmd_trans_huge)
> > 2) Splitting THP	(pmd_present && pmd_trans_huge)
> > 3) Migrating THP	(!pmd_present && !pmd_trans_huge)
> >
> > The problem is if we make pmd_trans_huge() return true for all the three states
> > which sounds logical because they are all still trans huge PMD, then pmd_present()
> > can only represent two states not three as required.
> 
> We are on the same page about representing three THP states in x86.
> I also agree with you that it is logical to use three distinct representations
> for these three states, i.e. splitting THP could be changed to (!pmd_present && pmd_trans_huge).

I think that the behavior of pmd_trans_huge() for non-present pmd is
undefined by its nature. IOW, it's no use determining whether it's thp or
not for non-existing pages because it does not exist :)

So I think that the right direction is to make sure that pmd_trans_huge() is
never checked for non-present pmd, just like Kirill's suggestion.  And maybe
we have some room for engineering to ensure it (rather than just commenting it).

Thanks,
Naoya Horiguchi
