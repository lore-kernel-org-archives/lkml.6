Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69098C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146FC20891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146FC20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeFPVPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 17:15:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49056 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933337AbeFPVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 17:15:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIXd-0002HE-C2; Sat, 16 Jun 2018 22:15:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIXX-0003nN-9L; Sat, 16 Jun 2018 22:15:19 +0100
Message-ID: <82e77f3c9b0dd8f177c608a3d89271d950c70bf4.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 183/410] mm: pin address_space before dereferencing
 it while isolating an LRU page
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ivan Kalvachev <ikalvachev@gmail.com>
Date:   Sat, 16 Jun 2018 22:15:19 +0100
In-Reply-To: <alpine.LSU.2.11.1806101101550.9044@eggly.anvils>
References: <lsq.1528380321.441239617@decadent.org.uk>
         <alpine.LSU.2.11.1806101101550.9044@eggly.anvils>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-9ETiuREbpNRyb52klzTt"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ETiuREbpNRyb52klzTt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-06-10 at 11:06 -0700, Hugh Dickins wrote:
> On Thu, 7 Jun 2018, Ben Hutchings wrote:
>=20
> > 3.16.57-rc1 review patch.  If anyone has any objections, please let me =
know.
>=20
> Not an objection as such, but if you're including this one,
> please be sure to add 145e1a71e090575c74969e3daa8136d1e5b99fc8
> "mm: fix the NULL mapping case in __isolate_lru_page()"

Added, thanks.

Ben.

> Thanks,
> Hugh
>=20
> >=20
> > ------------------
> >=20
> > From: Mel Gorman <mgorman@techsingularity.net>
> >=20
> > commit 69d763fc6d3aee787a3e8c8c35092b4f4960fa5d upstream.
> >=20
> > Minchan Kim asked the following question -- what locks protects
> > address_space destroying when race happens between inode trauncation an=
d
> > __isolate_lru_page? Jan Kara clarified by describing the race as follow=
s
> >=20
> > CPU1                                            CPU2
> >=20
> > truncate(inode)                                 __isolate_lru_page()
> >   ...
> >   truncate_inode_page(mapping, page);
> >     delete_from_page_cache(page)
> >       spin_lock_irqsave(&mapping->tree_lock, flags);
> >         __delete_from_page_cache(page, NULL)
> >           page_cache_tree_delete(..)
> >             ...                                   mapping =3D page_mapp=
ing(page);
> >             page->mapping =3D NULL;
> >             ...
> >       spin_unlock_irqrestore(&mapping->tree_lock, flags);
> >       page_cache_free_page(mapping, page)
> >         put_page(page)
> >           if (put_page_testzero(page)) -> false
> > - inode now has no pages and can be freed including embedded address_sp=
ace
> >=20
> >                                                   if (mapping && !mappi=
ng->a_ops->migratepage)
> > - we've dereferenced mapping which is potentially already free.
> >=20
> > The race is theoretically possible but unlikely.  Before the
> > delete_from_page_cache, truncate_cleanup_page is called so the page is
> > likely to be !PageDirty or PageWriteback which gets skipped by the only
> > caller that checks the mappping in __isolate_lru_page.  Even if the rac=
e
> > occurs, a substantial amount of work has to happen during a tiny window
> > with no preemption but it could potentially be done using a virtual
> > machine to artifically slow one CPU or halt it during the critical
> > window.
> >=20
> > This patch should eliminate the race with truncation by try-locking the
> > page before derefencing mapping and aborting if the lock was not
> > acquired.  There was a suggestion from Huang Ying to use RCU as a
> > side-effect to prevent mapping being freed.  However, I do not like the
> > solution as it's an unconventional means of preserving a mapping and
> > it's not a context where rcu_read_lock is obviously protecting rcu data=
.
> >=20
> > Link: http://lkml.kernel.org/r/20180104102512.2qos3h5vqzeisrek@techsing=
ularity.net
> > Fixes: c82449352854 ("mm: compaction: make isolate_lru_page() filter-aw=
are again")
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > [bwh: Backported to 3.16: adjust context]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  mm/vmscan.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1206,6 +1206,7 @@ int __isolate_lru_page(struct page *page
> > =20
> >               if (PageDirty(page)) {
> >                       struct address_space *mapping;
> > +                     bool migrate_dirty;
> > =20
> >                       /* ISOLATE_CLEAN means only clean pages */
> >                       if (mode & ISOLATE_CLEAN)
> > @@ -1214,10 +1215,19 @@ int __isolate_lru_page(struct page *page
> >                       /*
> >                        * Only pages without mappings or that have a
> >                        * ->migratepage callback are possible to migrate
> > -                      * without blocking
> > +                      * without blocking. However, we can be racing wi=
th
> > +                      * truncation so it's necessary to lock the page
> > +                      * to stabilise the mapping as truncation holds
> > +                      * the page lock until after the page is removed
> > +                      * from the page cache.
> >                        */
> > +                     if (!trylock_page(page))
> > +                             return ret;
> > +
> >                       mapping =3D page_mapping(page);
> > -                     if (mapping && !mapping->a_ops->migratepage)
> > +                     migrate_dirty =3D mapping && mapping->a_ops->migr=
atepage;
> > +                     unlock_page(page);
> > +                     if (!migrate_dirty)
> >                               return ret;
> >               }
> >       }
> >=20
> >=20
--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                       - Robert Coveyou


--=-9ETiuREbpNRyb52klzTt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlslfecACgkQ57/I7JWG
EQnJEw//f+fIIbFnvujjjp+BO6fR6ASHCdw9of97D2EgJyDc26cQFLu4G8PHin7l
U9vYPAGeC1cws32nOtHpHw40uNzfBJGLt/uC88cY0Rf1YoLY3uupN7uyNoLR70aV
suPVKCSzaD4eXIo8s39q3LB16/Cogm60TLqTS2xNIMJjS9j56gF3eunMA+bKIkbe
UOaOmSguvR/bzt3SuVlDBjH9HfyeHX1Se28WjGYrJrmQHUnXQRYw3swWufQfqG5U
3fVI64ooPgh/gcfSPTrJe85giRph4ACAjn8ZRdoCHLSUnCXwNrUrR7eF9UNoDJVq
MtQo9CKywi7bcz1BLtWjaYQdq7Urxo6titEur51FccD4iQAMbz2DTrHxZ2vRwqVc
h5oKKSI3i6/0RekFe6e1wRdzdCxnZWY5lJx1PuNOfXQxejdN62xC5yyhLLDrdAXX
qPAE5oIVwDdRzLjgG8VjD/DBKxhcv++EbFe0cb5Ymf3et0PZim4sFWh9RnoR8BTk
FQ0fHsDSNIaV9DoRCrcK68nv+PABS+W50QoPvilp0kYSROQDCfCNFQnBSos6c5nX
0kJaeLzLBOeKsm4ph6B7kRPBVRFXU7pb7+npIxOR3ugJTigJEVVT2eUA0+MEwKme
ygTm7EXizmzo+mWMpi/4LgWwV4QVCWLu31OjVcY1PWI6wCjn/XA=
=BxVh
-----END PGP SIGNATURE-----

--=-9ETiuREbpNRyb52klzTt--
