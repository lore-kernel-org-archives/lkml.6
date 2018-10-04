Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD9CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E40420684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E40420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJEErE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:47:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44476 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeJEErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:47:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so11721566qtd.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 14:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=Nt/MAoy0gbKk+6Po0KDrp889JQq+ai28/JIjWHJNt1o=;
        b=IHiaeS36YMVTRrIwSfMO7UYqGxETQ9vPCl3oM/lNyKow0lIYOCuk7eLc1vAqjnLprG
         aks3prEA/3PqCqfMZUE7Y6mHend0gDMuTAcc3i/Owyu3v2J51aXQ3rNiAJ47ac9Wm9Qu
         lKRJNMKZ0CN9XiFZYOVi+TFk4btvajxIFl1uhnFee5CyvhBynkv8UejpsMZXDggyfb/Q
         AdEzPz7tl3ONJjerO4sUox56Vm/1WqyXYK7YLIMKhnlukzSV5UGs3VSoQFLTgU6zg2RR
         NCGv8ZvsPFTtxnvFre2LYg6Radpa0J+1jLQQCyzlIe6NgROJrfi/W7ZlI7z2ZCTUIAas
         Z5Cg==
X-Gm-Message-State: ABuFfoj2pF4txG4lIW47OZi2KD9pRWEqdpcg4L8JSJ1Oz+UF2QVa7te1
        eh4YWz0nrSsIdAP8XPB8oik4LQ==
X-Google-Smtp-Source: ACcGV600PMbLAj00WSmvNu1NPoWOUlCwfrYRFgbR+RpyRjE52BfEvLeYakiRFyK79Ggjx3pzBCQzNQ==
X-Received: by 2002:ac8:3442:: with SMTP id v2-v6mr7108375qtb.231.1538689903079;
        Thu, 04 Oct 2018 14:51:43 -0700 (PDT)
Received: from [172.25.130.148] (pool-128-6-36-179.nat.rutgers.edu. [128.6.36.179])
        by smtp.gmail.com with ESMTPSA id p21-v6sm3186487qtj.18.2018.10.04.14.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 14:50:10 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "David Rientjes" <rientjes@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>, "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrea Argangeli" <andrea@kernel.org>,
        "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Date:   Thu, 04 Oct 2018 17:49:47 -0400
X-Mailer: MailMate (2.0BETAr6122)
Message-ID: <EA62D612-B537-435A-AF5B-96E49E878E0F@cs.rutgers.edu>
In-Reply-To: <alpine.DEB.2.21.1810041317010.16935@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <alpine.DEB.2.21.1810041317010.16935@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_B0E3F981-2CAE-4D98-A298-416090ED4D89_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_B0E3F981-2CAE-4D98-A298-416090ED4D89_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Oct 2018, at 16:17, David Rientjes wrote:

> On Wed, 26 Sep 2018, Kirill A. Shutemov wrote:
>
>> On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index c3bc7e9c9a2a..c0bcede31930 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(=
struct vm_fault *vmf,
>>>   *	    available
>>>   * never: never stall for any thp allocation
>>>   */
>>> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_str=
uct *vma)
>>> +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_str=
uct *vma, unsigned long addr)
>>>  {
>>>  	const bool vma_madvised =3D !!(vma->vm_flags & VM_HUGEPAGE);
>>> +	gfp_t this_node =3D 0;
>>> +
>>> +#ifdef CONFIG_NUMA
>>> +	struct mempolicy *pol;
>>> +	/*
>>> +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
>>> +	 * specified, to express a general desire to stay on the current
>>> +	 * node for optimistic allocation attempts. If the defrag mode
>>> +	 * and/or madvise hint requires the direct reclaim then we prefer
>>> +	 * to fallback to other node rather than node reclaim because that
>>> +	 * can lead to excessive reclaim even though there is free memory
>>> +	 * on other nodes. We expect that NUMA preferences are specified
>>> +	 * by memory policies.
>>> +	 */
>>> +	pol =3D get_vma_policy(vma, addr);
>>> +	if (pol->mode !=3D MPOL_BIND)
>>> +		this_node =3D __GFP_THISNODE;
>>> +	mpol_cond_put(pol);
>>> +#endif
>>
>> I'm not very good with NUMA policies. Could you explain in more detail=
s how
>> the code above is equivalent to the code below?
>>
>
> It breaks mbind() because new_page() is now using numa_node_id() to
> allocate migration targets for instead of using the mempolicy.  I'm not=

> sure that this patch was tested for mbind().

I do not see mbind() is broken. With both patches applied, I ran
"numactl -N 0 memhog -r1 4096m membind 1" and saw all pages are allocated=

in Node 1 not Node 0, which is returned by numa_node_id().

=46rom the source code, in alloc_pages_vma(), the nodemask is generated
from the memory policy (i.e. mbind in the case above), which only has
the nodes specified by mbind(). Then, __alloc_pages_nodemask() only uses
the zones from the nodemask. The numa_node_id() return value will be
ignored in the actual page allocation process if mbind policy is applied.=


Let me know if I miss anything.


--
Best Regards
Yan Zi

--=_MailMate_B0E3F981-2CAE-4D98-A298-416090ED4D89_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlu2ivsWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzCkeB/0c9VbvakI//1xIB6mRu1v+Rr3R
T2SzbshLuiKaJ0+PdjXaTYKbXamD0UoPpKrqic908yd9lx4rdGKpKuiMUclQTlQN
d792YKyiSFO3hEB1EJGPbeEhHEl8Inf28rJCtleJRrBkPqWj9+w1FHxzlk8bayif
oKaxQC8lZ17UoLxdtm40te5onbrkHg6dsfctWpGiqzJo02VNWaAkVWDbVztFA1mp
cJXIyB+XwlraxyOKLR90cUh+0u7s4mjaF82Pfbl1NOCjjlcMB/3yMnXHSEMLzlqh
JcM977Gr0fbWJouDKsOBQaW11NnqL/Tv7CnbrDmuqHlijeF3KGXcXvsK7jKU
=0fQi
-----END PGP SIGNATURE-----

--=_MailMate_B0E3F981-2CAE-4D98-A298-416090ED4D89_=--
