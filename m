Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B957C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D1E20C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nSGCtDhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D1E20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeHBJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:39:05 -0400
Received: from ozlabs.org ([203.11.71.1]:45049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeHBJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:39:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41h2PG4SG7z9s3q;
        Thu,  2 Aug 2018 17:49:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533196147;
        bh=DP6fAIlMLIjT3+2aczeCLDlCMp6kpR8mk4zXUQ+Jurk=;
        h=Date:From:To:Cc:Subject:From;
        b=nSGCtDhsHqo21hLvkbyyalpAcafpJE5d0caN9bQCOBsqzbwQy+FG63ez7X9Dbdr7x
         ycT0Zs5yOwbIeFU18inr27s1r8YnlbD1xv0iQGziB9do5T87e8UOPf32yKldd/9r0h
         s1cUAMR6ob4jQXMLuv0f1mpy9Mt1JPpzmbGe1I2ZJMt8sWqwZEk5u6QsnddtA9VoSi
         Kx6CzXciSBDLRlTK0l2Nr8r1mCZD0ooGeI+xt6fpxDViEaBTUSzaaVONvxddMczb0o
         IQXUt5Yu1c7jPUDe07SRvSkxLmhUt61OlM9Us4PzPENEBi/aT56g+ArtDJsRW6pNr7
         Xg6RK6zXqiyCw==
Date:   Thu, 2 Aug 2018 17:48:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: linux-next: manual merge of the xarray tree with the ext4 tree
Message-ID: <20180802174855.4edeba34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/77PPRZipcHuIHOFwjMzZXOK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/77PPRZipcHuIHOFwjMzZXOK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  fs/dax.c

between commit:

  cdbf8897cb09 ("dax: dax_layout_busy_page() warn on !exceptional")

from the ext4 tree and commits:

  49520d317715 ("xarray: Replace exceptional entries")
  cc9f1fb1672f ("dax: Convert dax_layout_busy_page to XArray")

from the xarray tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/dax.c
index f32d7125ad0f,1914e4e24615..000000000000
--- a/fs/dax.c
+++ b/fs/dax.c
@@@ -662,44 -556,26 +556,26 @@@ struct page *dax_layout_busy_page(struc
  	 */
  	unmap_mapping_range(mapping, 0, 0, 1);
 =20
- 	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
- 				min(end - index, (pgoff_t)PAGEVEC_SIZE),
- 				indices)) {
- 		for (i =3D 0; i < pagevec_count(&pvec); i++) {
- 			struct page *pvec_ent =3D pvec.pages[i];
- 			void *entry;
-=20
- 			index =3D indices[i];
- 			if (index >=3D end)
- 				break;
-=20
- 			if (WARN_ON_ONCE(
- 			     !radix_tree_exceptional_entry(pvec_ent)))
- 				continue;
-=20
- 			xa_lock_irq(&mapping->i_pages);
- 			entry =3D get_unlocked_mapping_entry(mapping, index, NULL);
- 			if (entry)
- 				page =3D dax_busy_page(entry);
- 			put_unlocked_mapping_entry(mapping, index, entry);
- 			xa_unlock_irq(&mapping->i_pages);
- 			if (page)
- 				break;
- 		}
-=20
- 		/*
- 		 * We don't expect normal struct page entries to exist in our
- 		 * tree, but we keep these pagevec calls so that this code is
- 		 * consistent with the common pattern for handling pagevecs
- 		 * throughout the kernel.
- 		 */
- 		pagevec_remove_exceptionals(&pvec);
- 		pagevec_release(&pvec);
- 		index++;
-=20
+ 	xas_lock_irq(&xas);
+ 	xas_for_each(&xas, entry, ULONG_MAX) {
 -		if (!xa_is_value(entry))
++		if (WARN_ON_ONCE(!xa_is_value(entry)))
+ 			continue;
+ 		if (unlikely(dax_is_locked(entry)))
+ 			entry =3D get_unlocked_entry(&xas);
+ 		if (entry)
+ 			page =3D dax_busy_page(entry);
+ 		put_unlocked_entry(&xas, entry);
  		if (page)
  			break;
+ 		if (++scanned % XA_CHECK_SCHED)
+ 			continue;
+=20
+ 		xas_pause(&xas);
+ 		xas_unlock_irq(&xas);
+ 		cond_resched();
+ 		xas_lock_irq(&xas);
  	}
+ 	xas_unlock_irq(&xas);
  	return page;
  }
  EXPORT_SYMBOL_GPL(dax_layout_busy_page);

--Sig_/77PPRZipcHuIHOFwjMzZXOK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltit2cACgkQAVBC80lX
0GzQzQf7BdM89FtI6KLmCbbykC8IWxt4zP3u4pxz0ErdgZ4cpQF6/TiLHpOfTBFt
XTT7HRkRuZG35zJ9zbUE00J7IaMFZ3/TBZBXrHly3KDCnMahrefFgJLKEZwbKwcU
y9lTwroGav8WNqPfrW/2rdaDFB4ewlXPQJ9AIy+Udx1xwahnmHF7lpJMB1wR0ofJ
SiSb6dzFak/BzRCp1mjex7uI1F8hGEFNzV+jXEs3sQ4a2yAreLp+4bE7BX8CsXb1
8+Xy+hQyxqVG/EI4aUNhRARHpeeIMNi66hDHen6G4XL1PSK+N5dMlGzdT9kkwZUa
o04GXBZx3VbTF+ic9qt5i4d4ItFqlg==
=/wi1
-----END PGP SIGNATURE-----

--Sig_/77PPRZipcHuIHOFwjMzZXOK--
