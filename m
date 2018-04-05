Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDER6r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:58:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55221 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751285AbeDER6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:58:45 -0400
X-ME-Sender: <xms:1GPGWuoczlxW0KWhOhfP4zWLK9L5XQM9nZsxZlczb4-1SBdVTdo5vg>
From: "Zi Yan" <zi.yan@sent.com>
To: "Michal Hocko" <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Date: Thu, 05 Apr 2018 13:58:43 -0400
X-Mailer: MailMate (2.0BETAr6106)
Message-ID: <7C2DE363-E113-4284-B94F-814F386743DF@sent.com>
In-Reply-To: <20180405160317.GP6312@dhcp22.suse.cz>
References: <20180403075928.GC5501@dhcp22.suse.cz>
 <20180403082405.GA23809@hori1.linux.bs1.fc.nec.co.jp>
 <20180403083451.GG5501@dhcp22.suse.cz>
 <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_59658812-A57F-4162-ADE9-D428C633317B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_59658812-A57F-4162-ADE9-D428C633317B_=
Content-Type: text/plain

On 5 Apr 2018, at 12:03, Michal Hocko wrote:

> On Thu 05-04-18 18:55:51, Kirill A. Shutemov wrote:
>> On Thu, Apr 05, 2018 at 05:05:47PM +0200, Michal Hocko wrote:
>>> On Thu 05-04-18 16:40:45, Kirill A. Shutemov wrote:
>>>> On Thu, Apr 05, 2018 at 02:48:30PM +0200, Michal Hocko wrote:
>>> [...]
>>>>> RIght, I confused the two. What is the proper layer to fix that then?
>>>>> rmap_walk_file?
>>>>
>>>> Maybe something like this? Totally untested.
>>>
>>> This looks way too complex. Why cannot we simply split THP page cache
>>> during migration?
>>
>> This way we unify the codepath for archictures that don't support THP
>> migration and shmem THP.
>
> But why? There shouldn't be really nothing to prevent THP (anon or
> shemem) to be migratable. If we cannot migrate it at once we can always
> split it. So why should we add another thp specific handling all over
> the place?

Then, it would be much easier if your "unclutter thp migration" patches is merged,
plus the patch below:

diff --git a/mm/migrate.c b/mm/migrate.c
index 60531108021a..b4087aa890f5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1138,7 +1138,9 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
        int rc = MIGRATEPAGE_SUCCESS;
        struct page *newpage;

-       if (!thp_migration_supported() && PageTransHuge(page))
+       if ((!thp_migration_supported() ||
+            (thp_migration_supported() && !PageAnon(page))) &&
+           PageTransHuge(page))
                return -ENOMEM;

        newpage = get_new_page(page, private)

--
Best Regards
Yan Zi

--=_MailMate_59658812-A57F-4162-ADE9-D428C633317B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJaxmPTAAoJEEGLLxGcTqbMGgAIAKnOSuGNcjeF+rn47lUvbr7J
lUFh+Q4lkvFFXajiO1H+A69eU/ZUmhHhkBEDHGFb4cR+Zbp6eHZ/5HAFVQcU+ftG
UsaEZ/IEXFmSxevG3Z6h3Uo/84eNhs+QpnrjClf5Jp3tZhODlPHBfLAwcG0H1oef
x1oj3fx4ShI6/9/28JpozBLDBCgs2ZMHKxY709PVhICAzjY3gc1vdrfCfXb3UqiP
LWJw1PzPBg+FyjKA9oi9lFA/mYTQs2GfmIiGFXKLONaN8r7wtZ7kLauL9h2+vaZX
be313lynxDNyZlsmLAFEnG1wIUvSfgY9nLcXJJidV0L7EEeHcS4VX+8bgLvQZVs=
=rWLp
-----END PGP SIGNATURE-----

--=_MailMate_59658812-A57F-4162-ADE9-D428C633317B_=--
