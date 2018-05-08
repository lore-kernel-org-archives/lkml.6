Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeEHAyc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55085 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753582AbeEHAya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:54:30 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 08 May 2018 10:54:21 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20180507093019.qkz75qm7rocnbfnl@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605438.18473.4797800779538116583.stgit@noble> <20180505094212.hpqjyv5ijibviuwh@gondor.apana.org.au> <87vac1db5t.fsf@notabene.neil.brown.name> <20180507093019.qkz75qm7rocnbfnl@gondor.apana.org.au>
Message-ID: <87wowfarwi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, May 07 2018, Herbert Xu wrote:

> On Sun, May 06, 2018 at 07:50:54AM +1000, NeilBrown wrote:
>>
>> Do we?  How could we fix it for both rhashtable and rhltable?
>
> Well I suggested earlier to insert the walker object into the
> hash table, which would be applicable regardless of whether it
> is a normal rhashtable of a rhltable.

Oh yes, that idea.  I had considered it and discarded it.
Moving a walker object around in an rcu-list is far from straight
forward.  A lockless iteration of the list would need to be very careful
not to be tripped up by the walker-object.  I don't think we want to
make the search code more complex.

I explored the idea a bit more and I think that any solution that we
came up with along those lines would look quite different for regular
rhash_tables than for rhl_tables.  So it is probably best to keep them
quite separate.
i.e. use the scheme I proposed for rhashtables and use something else
entirely for rhltables.

My current thinking for a stable walk for rhl tables goes like this:

- we embed
     struct rhl_cursor {
         struct rhl_cursor *next;
         int unseen;
     }
  in struct rhashtable_iter.

- on rhashtable_stop(), we:
  + lock the current hash chain
  + find the next object that is still in the table (after ->p).
  + count the number of objects from there to the end to the
     end of the rhlist_head.next list.
  + store that count in rhl_cursor.unseen
  + change the ->next pointer at the end of the list to point to the
    rhl_cursor, but with the lsb set.  If there was already an
    rhl_cursor there, they are chained together on ->next.

- on rhashtable_start(), we lock the hash chain and search the hash
  chain and sub-chains for  ->p or the rhl_cursor.
  If ->p is still there, that can be used as a reliable anchor.
  If ->p isn't found but the rhl_cursor is, then the 'unseen' counter
  tells us where to start in that rhl_list.
  If neither are found, then we start at the beginning of the hash chain.
  If the rhl_cursor is found, it is removed.

- lookup and insert can almost completely ignore the cursor.
  rhl_for_each_rcu() needs to detect the end-of-list by looking for
  lsb set, but that is the only change.
  As _insert() adds new objects to the head of the rhlist, that
  won't disturb the accuracy of the 'unseen' count.  The newly inserted
  object won't be seen by the walk, but that is expected.

- delete needs some extra handling.
  + When an object is deleted from an rhlist and the list does not become
    empty, then it counts the number of objects to the end of the list,
    and possibly decrements the 'unseen' counter on any rhl_cursors that
    are at the end of the list.
  + when an object is deleted resulting in an empty rhlist, any
    cursors at the end of the list needs to be moved to the next
    list in the hash chain, and their 'unseen' count needs to be set to
    the length of the list.
    If there is no next object in the hash chain, then the iter.slot is
    incremented and the rhlist_curs is left unconnected.

- rehash needs to remove any cursors from the end of an rhlist before
  moving them to the new table.  The cursors are left disconnected.

I'm happy to implement this if you think the approach is workable and
the functionality is necessary.  However there are no current users of
rhltable_walk_inter that would benefit from this.


Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrw9T0ACgkQOeye3VZi
gbl3lw//f+hGq05ANrcv1dCIGk7jKSQRtuDEPogbqJ/Ahh1sVf6reJm1XnmxE0jO
1NbXXOXk/WNvUU3OUoceWgibSm2+niKMakeBcF8OvVxBfgRKqiK2p+BNQqqH3A1T
K+2EOmaXfD4GIWxfidw38OAd9qeVFDZ0bg7MYTKNfyC4wt0T4N0/JyrXC4a0Rf/V
QEaYwIMN1I/981J6KDdw8oFzs7ay+WPT4nXNQZGxtpHBIzxeEQ90i3wVjvgnA2H8
gNSMSjC/1g/H81Uid7matz+gq0j+S/DHsu9oTIFyAX21QY+uAcECdsUxEpsfyd1N
sSUilnh3txNLtyLH2jiBQINWSk1QVio8Jq42/iNO01XfOyNR8McVkq0NdWNchlQU
aTq3yM1fdSPQTyehtuS2Ow7Lzkr8z7Wvv0YWcN150XiVKb4cnAaEdTxEYlmTexku
m8vU/zGYf8dW6D+v2K248UiyYMaZVSBsGKwgEGPDFoTrctjXGZ8LAG3EgQgjk3G0
TxNU9D6uCUrHRAz9K9hP3wGBPxd7p33BorELPFd5y1W04lyw18Wm+O/KhHYswqAU
7TtAEMrkxxtNb5GzhzvrBykPbyRln3bfJKn5JeuDoeF+PlXzz+/6kz36tc6JcV8r
IB1epxnVBPP3oNhZW406M1ln2X5Ddgd4b7D3/2uc3HykYLfIPfI=
=H7ch
-----END PGP SIGNATURE-----
--=-=-=--
