Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F3BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49D62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49D62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJPWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:22:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44991 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:22:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id c56-v6so25887423qtd.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=MFHv8rw5X09SI9om//YhegsaZBfZaIunkKUZb/sh18U=;
        b=rhJEretgC8CgxSqe951ppHM1RGv0uScQqDHhLdj1xKzFipuMZKGL7eldSlbPpPPBl4
         A3FWUUJ4R+x7PJvoe9O+BRaF3r1b2dXXpJkvFtMIbjVL/GE2ExIMGQalIxCzCuyMVN+h
         axJ5zU3/BWh/deT2DkVyy+SWh+oV+aFAzm08rYvLFVt49MKrpmOUZhnEzc+moH+njIwM
         4SIqbT6cKq/Fa7uBX1Gc5NFsAEgw8gl5kR7bkIEXpbnVCro+KOhwLcMTaq0isw5vxbXN
         Css5Mb5bDmdTUcm0f387t9p4UmtTOMmlqibG9zj6VYPsDNLvy8klo5lokUC8hoOuLGVp
         qu4Q==
X-Gm-Message-State: ABuFfogrEHXxlUGhfzU7Q80VAid3J5hwbsvq9rAU+N4rHx17E55EgIPe
        CF/Fju/gmAdRa9qd1L1XO6Awxg==
X-Google-Smtp-Source: ACcGV63qYQn3lROv7DuIogp7ulKhO4DfBsKgXmysn+H1iO+9JVONvYfqSzufZXSwXHTKx6JGDoiawg==
X-Received: by 2002:ac8:3097:: with SMTP id v23-v6mr20211780qta.335.1539700314593;
        Tue, 16 Oct 2018 07:31:54 -0700 (PDT)
Received: from [172.25.136.172] (pool-128-6-37-151.nat.rutgers.edu. [128.6.37.151])
        by smtp.gmail.com with ESMTPSA id q21-v6sm11341437qta.77.2018.10.16.07.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 07:31:52 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc:     "Andrea Arcangeli" <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, mhocko@suse.com, will.deacon@arm.com,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Date:   Tue, 16 Oct 2018 10:31:50 -0400
X-Mailer: MailMate (1.12r5528)
Message-ID: <5A0A88EF-4B86-4173-A506-DE19BDB786B8@cs.rutgers.edu>
In-Reply-To: <796cb545-7376-16a2-db3e-bc9a6ca9894d@arm.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
 <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
 <1968F276-5D96-426B-823F-38F6A51FB465@cs.rutgers.edu>
 <5e0e772c-7eef-e75c-2921-e80d4fbe8324@arm.com>
 <2398C491-E1DA-4B3C-B60A-377A09A02F1A@cs.rutgers.edu>
 <796cb545-7376-16a2-db3e-bc9a6ca9894d@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_181C4923-C24C-429A-A9F0-6D7072A3F4AB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_181C4923-C24C-429A-A9F0-6D7072A3F4AB_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15 Oct 2018, at 0:06, Anshuman Khandual wrote:

> On 10/15/2018 06:23 AM, Zi Yan wrote:
>> On 12 Oct 2018, at 4:00, Anshuman Khandual wrote:
>>
>>> On 10/10/2018 06:13 PM, Zi Yan wrote:
>>>> On 10 Oct 2018, at 0:05, Anshuman Khandual wrote:
>>>>
>>>>> On 10/09/2018 07:28 PM, Zi Yan wrote:
>>>>>> cc: Naoya Horiguchi (who proposed to use !_PAGE_PRESENT && !_PAGE_=
PSE for x86
>>>>>> PMD migration entry check)
>>>>>>
>>>>>> On 8 Oct 2018, at 23:58, Anshuman Khandual wrote:
>>>>>>
>>>>>>> A normal mapped THP page at PMD level should be correctly differe=
ntiated
>>>>>>> from a PMD migration entry while walking the page table. A mapped=
 THP would
>>>>>>> additionally check positive for pmd_present() along with pmd_tran=
s_huge()
>>>>>>> as compared to a PMD migration entry. This just adds a new condit=
ional test
>>>>>>> differentiating the two while walking the page table.
>>>>>>>
>>>>>>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic p=
ath")
>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>> ---
>>>>>>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always =
mutually
>>>>>>> exclusive which makes the current conditional block work for both=
 mapped
>>>>>>> and migration entries. This is not same with arm64 where pmd_tran=
s_huge()
>>>>>>
>>>>>> !pmd_present() && pmd_trans_huge() is used to represent THPs under=
 splitting,
>>>>>
>>>>> Not really if we just look at code in the conditional blocks.
>>>>
>>>> Yeah, I explained it wrong above. Sorry about that.
>>>>
>>>> In x86, pmd_present() checks (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE=
_PSE),
>>>> thus, it returns true even if the present bit is cleared but PSE bit=
 is set.
>>>
>>> Okay.
>>>
>>>> This is done so, because THPs under splitting are regarded as presen=
t in the kernel
>>>> but not present when a hardware page table walker checks it.
>>>
>>> Okay.
>>>
>>>>
>>>> For PMD migration entry, which should be regarded as not present, if=
 PSE bit
>>>> is set, which makes pmd_trans_huge() returns true, like ARM64 does, =
all
>>>> PMD migration entries will be regarded as present
>>>
>>> Okay to make pmd_present() return false pmd_trans_huge() has to retur=
n false
>>> as well. Is there anything which can be done to get around this probl=
em on
>>> X86 ? pmd_trans_huge() returning true for a migration entry sounds lo=
gical.
>>> Otherwise we would revert the condition block order to accommodate bo=
th the
>>> implementation for pmd_trans_huge() as suggested by Kirill before or =
just
>>> consider this patch forward.
>>>
>>> Because I am not really sure yet about the idea of getting pmd_presen=
t()
>>> check into pmd_trans_huge() on arm64 just to make it fit into this se=
mantics
>>> as suggested by Will. If a PMD is trans huge page or not should not d=
epend on
>>> whether it is present or not.
>>
>> In terms of THPs, we have three cases: a present THP, a THP under spli=
tting,
>> and a THP under migration. pmd_present() and pmd_trans_huge() both ret=
urn true
>> for a present THP and a THP under splitting, because they discover _PA=
GE_PSE bit
>
> Then how do we differentiate between a mapped THP and a splitting THP.

AFAIK, in x86, there is no distinction between a mapped THP and a splitti=
ng THP
using helper functions.

A mapped THP has _PAGE_PRESENT bit and _PAGE_PSE bit set, whereas a split=
ting THP
has only _PAGE_PSE bit set. But both pmd_present() and pmd_trans_huge() r=
eturn
true as long as _PAGE_PSE bit is set.

>
>> is set for both cases, whereas they both return false for a THP under =
migration.
>> You want to change them to make pmd_trans_huge() returns true for a TH=
P under migration
>> instead of false to help ARM64=E2=80=99s support for THP migration.
> I am just trying to understand the rationale behind this semantics and =
see where
> it should be fixed.
>
> I think the fundamental problem here is that THP under split has been d=
ifficult
> to be re-presented through the available helper functions and in turn P=
TE bits.
>
> The following checks
>
> 1) pmd_present()
> 2) pmd_trans_huge()
>
> Represent three THP states
>
> 1) Mapped THP		(pmd_present && pmd_trans_huge)
> 2) Splitting THP	(pmd_present && pmd_trans_huge)
> 3) Migrating THP	(!pmd_present && !pmd_trans_huge)
>
> The problem is if we make pmd_trans_huge() return true for all the thre=
e states
> which sounds logical because they are all still trans huge PMD, then pm=
d_present()
> can only represent two states not three as required.

We are on the same page about representing three THP states in x86.
I also agree with you that it is logical to use three distinct representa=
tions
for these three states, i.e. splitting THP could be changed to (!pmd_pres=
ent && pmd_trans_huge).


>>
>> For x86, this change requires:
>> 1. changing the condition in pmd_trans_huge(), so that it returns true=
 for
>> PMD migration entries;
>> 2. changing the code, which calls pmd_trans_huge(), to match the new l=
ogic.
> Can those be fixed with an additional check for pmd_present() as sugges=
ted here
> in this patch ? Asking because in case we could not get common semantic=
s for
> these helpers on all arch that would be a fall back option for the mome=
nt.

It would be OK for x86, since pmd_trans_huge() implies pmd_present() and =
hence
adding pmd_present() to pmd_trans_huge() makes no difference. But for ARM=
64,
from my understanding of the code described below, adding pmd_present() t=
o
pmd_trans_huge() seems to exclude splitting THPs from the original semant=
ic.


>>
>> Another problem I see is that x86=E2=80=99s pmd_present() returns true=
 for a THP under
>> splitting but ARM64=E2=80=99s pmd_present() returns false for a THP un=
der splitting.
>
> But how did you conclude this ? I dont see any explicit helper for spli=
tting
> THP. Could you please point me in the code ?

=46rom the code I read for ARM64
(https://elixir.bootlin.com/linux/v4.19-rc8/source/arch/arm64/include/asm=
/pgtable.h#L360
and https://elixir.bootlin.com/linux/v4.19-rc8/source/arch/arm64/include/=
asm/pgtable.h#L86),
pmd_present() only checks _PAGE_PRESENT and _PAGE_PROTONE. During a THP s=
plitting,
pmdp_invalidate() clears _PAGE_PRESENT (https://elixir.bootlin.com/linux/=
v4.19-rc8/source/mm/huge_memory.c#L2130). So pmd_present() returns false =
in ARM64. Let me know
if I got anything wrong.



>> I do not know if there is any correctness issue with this. So I copy A=
ndrea
>> here, since he made x86=E2=80=99s pmd_present() returns true for a THP=
 under splitting
>> as an optimization. I want to understand more about it and potentially=
 make
>> x86 and ARM64 (maybe all other architectures, too) return the same val=
ue
>> for all three cases mentioned above.
>
> I agree. Fixing the semantics is the right thing to do. I am kind of wo=
ndering if
> it would be a good idea to have explicit helpers for (1) mapped THP, (2=
) splitting
> THP like the one for (3) migrating THP (e.g is_pmd_migration_entry) and=
 use them
> in various conditional blocks instead of looking out for multiple check=
s like
> pmd_trans_huge(), pmd_present() etc. It will help unify the semantics a=
s well.
>

I agree that explicit and distinct helpers for all three THP states would=
 be helpful.

>>
>>
>> Hi Andrea, what is the purpose/benefit of making x86=E2=80=99s pmd_pre=
sent() returns true
>> for a THP under splitting? Does it cause problems when ARM64=E2=80=99s=
 pmd_present()
>> returns false in the same situation?
>>
>>
>>>>
>>>> My concern is that if ARM64=E2=80=99s pmd_trans_huge() returns true =
for migration
>>>> entries, unlike x86, there might be bugs triggered in the kernel whe=
n
>>>> THP migration is enabled in ARM64.
>>>
>>> Right and that is exactly what we are trying to fix with this patch.
>>>
>>
>> I am not sure this patch can fix the problem in ARM64, because many ot=
her places
>> in the kernel, pmd_trans_huge() still returns false for a THP under mi=
gration.
>> We may need more comprehensive fixes for ARM64.
> Are there more places where semantics needs to be fixed than what was o=
riginally
> added through 616b8371539a ("mm: thp: enable thp migration in generic p=
ath").

I guess not, but it would be safer to grep for all pmd_trans_huge() and p=
md_present().

--
Best Regards
Yan Zi

--=_MailMate_181C4923-C24C-429A-A9F0-6D7072A3F4AB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlvF9lYWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzGxoCACACKfPF+zxul+KWg/wkGGbN3ZB
rMGPIpDwOkY+1bPL4lrZI5MW6V6hdpM/5u/cwtre9ndXd1JnJyYAEjjq6SGF5IRi
uQ4t6AKezWxTIs7CfF2oX7YRFZztnZAyKJEmN/aEy5Eua80DGxTn9LLvtDNg9gE6
k/bVP22BinEnkF0dBjh0JH8My9ZkPsUt0dG4j8iwtM/hvuuc0eE0W+MyACb/Uvn+
r2xUUuSqM3WyZQtGquCZr+E83ltCAXMGl/dvMJN+wo52ZCFlMQdZE6MyMTHPtfMN
wZpvVaP1KJQuZBZM7dTk5FxMRElmf4FdjqCij/myLbQURHvaC+RLg/bB31zw
=3Pb6
-----END PGP SIGNATURE-----

--=_MailMate_181C4923-C24C-429A-A9F0-6D7072A3F4AB_=--
