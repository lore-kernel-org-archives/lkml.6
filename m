Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeDETJT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:09:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34291 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751952AbeDETJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:09:16 -0400
X-ME-Sender: <xms:W3TGWpaQ169ZxfkpBRNSwV3qUU1kmbRKVnAIfN335K1nvxVzp-URWg>
From: "Zi Yan" <zi.yan@sent.com>
To: "Michal Hocko" <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Date: Thu, 05 Apr 2018 15:09:14 -0400
X-Mailer: MailMate (2.0BETAr6106)
Message-ID: <D2A2BB95-6D1D-487D-9CCA-FC66CE42B03D@sent.com>
In-Reply-To: <20180405190405.GS6312@dhcp22.suse.cz>
References: <20180403083451.GG5501@dhcp22.suse.cz>
 <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
 <7C2DE363-E113-4284-B94F-814F386743DF@sent.com>
 <20180405190405.GS6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_1F40A8E4-9490-440F-838A-F266C1BA263E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_1F40A8E4-9490-440F-838A-F266C1BA263E_=
Content-Type: text/plain

On 5 Apr 2018, at 15:04, Michal Hocko wrote:

> On Thu 05-04-18 13:58:43, Zi Yan wrote:
>> On 5 Apr 2018, at 12:03, Michal Hocko wrote:
>>
>>> On Thu 05-04-18 18:55:51, Kirill A. Shutemov wrote:
>>>> On Thu, Apr 05, 2018 at 05:05:47PM +0200, Michal Hocko wrote:
>>>>> On Thu 05-04-18 16:40:45, Kirill A. Shutemov wrote:
>>>>>> On Thu, Apr 05, 2018 at 02:48:30PM +0200, Michal Hocko wrote:
>>>>> [...]
>>>>>>> RIght, I confused the two. What is the proper layer to fix that then?
>>>>>>> rmap_walk_file?
>>>>>>
>>>>>> Maybe something like this? Totally untested.
>>>>>
>>>>> This looks way too complex. Why cannot we simply split THP page cache
>>>>> during migration?
>>>>
>>>> This way we unify the codepath for archictures that don't support THP
>>>> migration and shmem THP.
>>>
>>> But why? There shouldn't be really nothing to prevent THP (anon or
>>> shemem) to be migratable. If we cannot migrate it at once we can always
>>> split it. So why should we add another thp specific handling all over
>>> the place?
>>
>> Then, it would be much easier if your "unclutter thp migration" patches is merged,
>> plus the patch below:
>
> Good point. Except I would prefer a less convoluted condition
>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 60531108021a..b4087aa890f5 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1138,7 +1138,9 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>         int rc = MIGRATEPAGE_SUCCESS;
>>         struct page *newpage;
>>
>> -       if (!thp_migration_supported() && PageTransHuge(page))
>> +       if ((!thp_migration_supported() ||
>> +            (thp_migration_supported() && !PageAnon(page))) &&
>> +           PageTransHuge(page))
>>                 return -ENOMEM;
>
> What about this?
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5d0dc7b85f90..cd02e2bdf37c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1138,7 +1138,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  	int rc = MIGRATEPAGE_SUCCESS;
>  	struct page *newpage;
>
> -	if (!thp_migration_supported() && PageTransHuge(page))
> +	/*
> +	 * THP pagecache or generally non-migrateable THP need to be split
> +	 * up before migration
> +	 */
> +	if (PageTransHuge(page) && (!thp_migration_supported() || !PageAnon(page)))
>  		return -ENOMEM;
>
>  	newpage = get_new_page(page, private);

I think it works and is better than mine.

Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>

--
Best Regards
Yan Zi

--=_MailMate_1F40A8E4-9490-440F-838A-F266C1BA263E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJaxnRaAAoJEEGLLxGcTqbMKggIAK5A4NcuMdLaR9QOIM3+j+JV
BtnR6JiepqxpUkRuHcD3bTqv8noaY0lerQGgGsFhMI5+DG3jrLrKIbgpFAe7HmT/
0pSLn5WW18RcxZaNtexobQqSB3TuK6HlFDAYBxfpBPcr8dx/6GcQDo77LKq35jB/
gxVLIkaPvZBTWx/kJ+ELx5r7PGiuuAsKlaIh8tmF83NJReO0BvQn1q8ionWaSzAi
xDZtB1sbzH5WIlZ58bCs5PHh3deblMR6b80BF/0Zc3pr/ws5rQ+d7jusjfi+m1p6
5laRqesLHsDTbTlPzjcVgSVI84IVx4tV1YmAOhqHqvePr5C8qQPe1FMhl+WqG30=
=dq+5
-----END PGP SIGNATURE-----

--=_MailMate_1F40A8E4-9490-440F-838A-F266C1BA263E_=--
