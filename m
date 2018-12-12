Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E74C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63392084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="do9T6+y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63392084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeLLTH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:07:59 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13431 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLTH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:07:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c115c890001>; Wed, 12 Dec 2018 11:07:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Dec 2018 11:07:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Dec 2018 11:07:56 -0800
Received: from [10.2.165.33] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 19:07:52 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
CC:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212170220.GA5037@redhat.com>
 <CAPcyv4hnQ-4DKwtrJjy9euvJvRf_sDO+1hbxuFCQv5m9qd9Drg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <78dc9959-5e9c-8a57-05e4-da02f688cc24@nvidia.com>
Date:   Wed, 12 Dec 2018 11:07:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hnQ-4DKwtrJjy9euvJvRf_sDO+1hbxuFCQv5m9qd9Drg@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544641674; bh=GImQPXizU5WXSaCeGZGcLwQgKxMqTe9fuSijHAQjNO4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=do9T6+y+sjhvyTKwioO3trdY4kelePWMlLpZDiIFv4EgDaIlEPi/gGFP2PrlUnjep
         D6xd5GYrvOJ1r1EwUrn9Yvd3u/wm4cSXbORWgZzSYVnFCBG9xd7cnpx4NsO/nlX3JC
         9wQAnnN6yGuIPUvbqgnclGhwOz55aoQAKm/VPDWjSTMpmnYUtX8FIt4912l+39AshU
         OcKH7uMzRr9LwznZDwoEtLOgDrOHLxgFrU4FvhQMR7IitvAECB+DZ3ZIOeQRwtj0w5
         KYeywp3abdF+gG51lhB1oDsrV32kZoY/Y/YfBnAcKhpivs/BmAB+hWTd50OJ/jyn76
         ZLbCJ6PEpDi/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 9:49 AM, Dan Williams wrote:
> On Wed, Dec 12, 2018 at 9:02 AM Jerome Glisse <jglisse@redhat.com> wrote:
>>
>> On Wed, Dec 12, 2018 at 08:27:35AM -0800, Dan Williams wrote:
>>> On Wed, Dec 12, 2018 at 7:03 AM Jerome Glisse <jglisse@redhat.com> wrot=
e:
>>>>
>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
>>>>>> Another crazy idea, why not treating GUP as another mapping of the p=
age
>>>>>> and caller of GUP would have to provide either a fake anon_vma struc=
t or
>>>>>> a fake vma struct (or both for PRIVATE mapping of a file where you c=
an
>>>>>> have a mix of both private and file page thus only if it is a read o=
nly
>>>>>> GUP) that would get added to the list of existing mapping.
>>>>>>
>>>>>> So the flow would be:
>>>>>>     somefunction_thatuse_gup()
>>>>>>     {
>>>>>>         ...
>>>>>>         GUP(_fast)(vma, ..., fake_anon, fake_vma);
>>>>>>         ...
>>>>>>     }
>>>>>>
>>>>>>     GUP(vma, ..., fake_anon, fake_vma)
>>>>>>     {
>>>>>>         if (vma->flags =3D=3D ANON) {
>>>>>>             // Add the fake anon vma to the anon vma chain as a chil=
d
>>>>>>             // of current vma
>>>>>>         } else {
>>>>>>             // Add the fake vma to the mapping tree
>>>>>>         }
>>>>>>
>>>>>>         // The existing GUP except that now it inc mapcount and not
>>>>>>         // refcount
>>>>>>         GUP_old(..., &nanonymous, &nfiles);
>>>>>>
>>>>>>         atomic_add(&fake_anon->refcount, nanonymous);
>>>>>>         atomic_add(&fake_vma->refcount, nfiles);
>>>>>>
>>>>>>         return nanonymous + nfiles;
>>>>>>     }
>>>>>
>>>>> Thanks for your idea! This is actually something like I was suggestin=
g back
>>>>> at LSF/MM in Deer Valley. There were two downsides to this I remember
>>>>> people pointing out:
>>>>>
>>>>> 1) This cannot really work with __get_user_pages_fast(). You're not a=
llowed
>>>>> to get necessary locks to insert new entry into the VMA tree in that
>>>>> context. So essentially we'd loose get_user_pages_fast() functionalit=
y.
>>>>>
>>>>> 2) The overhead e.g. for direct IO may be noticeable. You need to all=
ocate
>>>>> the fake tracking VMA, get VMA interval tree lock, insert into the tr=
ee.
>>>>> Then on IO completion you need to queue work to unpin the pages again=
 as you
>>>>> cannot remove the fake VMA directly from interrupt context where the =
IO is
>>>>> completed.
>>>>>
>>>>> You are right that the cost could be amortized if gup() is called for
>>>>> multiple consecutive pages however for small IOs there's no help...
>>>>>
>>>>> So this approach doesn't look like a win to me over using counter in =
struct
>>>>> page and I'd rather try looking into squeezing HMM public page usage =
of
>>>>> struct page so that we can fit that gup counter there as well. I know=
 that
>>>>> it may be easier said than done...
>>>>
>>>> So i want back to the drawing board and first i would like to ascertai=
n
>>>> that we all agree on what the objectives are:
>>>>
>>>>     [O1] Avoid write back from a page still being written by either a
>>>>          device or some direct I/O or any other existing user of GUP.
>>>>          This would avoid possible file system corruption.
>>>>
>>>>     [O2] Avoid crash when set_page_dirty() is call on a page that is
>>>>          considered clean by core mm (buffer head have been remove and
>>>>          with some file system this turns into an ugly mess).
>>>>
>>>>     [O3] DAX and the device block problems, ie with DAX the page map i=
n
>>>>          userspace is the same as the block (persistent memory) and no
>>>>          filesystem nor block device understand page as block or pinne=
d
>>>>          block.
>>>>
>>>> For [O3] i don't think any pin count would help in anyway. I believe
>>>> that the current long term GUP API that does not allow GUP of DAX is
>>>> the only sane solution for now.
>>>
>>> No, that's not a sane solution, it's an emergency hack.
>>
>> Then how do you want to solve it ? Knowing pin count does not help
>> you, at least i do not see how that would help and if it does then
>> my solution allow you to know pin count it is the difference between
>> real mapping and mapcount value.
>=20
> True, pin count doesn't help, and indefinite waits are intolerable, so
> I think we need to make "long term" GUP revokable, but otherwise
> hopefully use the put_user_page() scheme to replace the use of the pin
> count for dax_layout_busy_page().
>=20
>>>> The real fix would be to teach file-
>>>> system about DAX/pinned block so that a pinned block is not reuse
>>>> by filesystem.
>>>
>>> We already have taught filesystems about pinned dax pages, see
>>> dax_layout_busy_page(). As much as possible I want to eliminate the
>>> concept of "dax pages" as a special case that gets sprinkled
>>> throughout the mm.
>>>
>>>> For [O1] and [O2] i believe a solution with mapcount would work. So
>>>> no new struct, no fake vma, nothing like that. In GUP for file back
>>>> pages
>>>
>>> With get_user_pages_fast() we don't know that we have a file-backed
>>> page, because we don't have a vma.
>>
>> You do not need a vma to know that we have PageAnon() for that so my
>> solution is just about adding to core GUP page table walker:
>>
>>     if (!PageAnon(page))
>>         atomic_inc(&page->mapcount);
>=20
> Ah, ok, would need to add proper mapcount manipulation for dax and
> audit that nothing makes page-cache assumptions based on a non-zero
> mapcount.
>=20
>> Then in put_user_page() you add the opposite. In page_mkclean() you
>> count the number of real mapping and voil=C3=A0 ... you got an answer fo=
r
>> [O1]. You could use the same count real mapping to get the pin count
>> in other place that cares about it but i fails to see why the actual
>> pin count value would matter to any one.
>=20
> Sounds like a could work... devil is in the details.
>=20

I also like this solution. It uses existing information and existing pointe=
rs
(PageAnon, page_mapping) plus a tiny bit more (another pointer in struct=20
address_space, probably, and that's not a size-contentious struct) to figur=
e
out the DMA pinned count, which neatly avoids the struct page contention th=
at I=20
ran into.=20

Thanks for coming up with this! I'll put together a patchset that shows the=
 details
so we can all take a closer look. This is on the top of my list.


--=20
thanks,
John Hubbard
NVIDIA

