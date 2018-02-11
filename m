Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3173684-1518372120-3-1147016454286557224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518372119; b=Vb/2bXpXGJrUdcPbAJzLhSQ/zr55e67nSlyk92rl8xwi9k7
    voF4/GhcrCgk3B+NljQU4I9rRmeU0CXuouMIAKirma5cpfIlLxnGI4MdR/0CaZSb
    SrdIcohBtgj8RwgN4UKvQBg57Y3tYjI5JgEWumXnmtwRTGCMbP8xqCmElMpABndR
    eawVbn/PYJZ5HnSrBJW+7PsLVsUZ5fGnzSQdBlQ1kaoIOjubijkvm9yg+GnewlTR
    hUL0ZR0WM6nnu4+U4JdXtDIZYv6ecIKTqrgvbsvaUf8klA94/Nk7DvhCUOb0jrGb
    DGtcGzeEywt0+jjVtzDNNX5rMBZLIr+JDYV+5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518372119; bh=dr32kO+Fe7HXHhCsDjmC4KlK72
    Ze42SVHaizuiA6QuU=; b=Oo4q7E+vg90gvW9mtG2rs2X0EHPwXvCwsHO76aV4kL
    z7kvJOHWi91vSt7KkgQj4XFpHFuAswwVQhVxNDnaZro9nW0F7w/edmS9C8e84li/
    afxUPn3luR19O1l00xDY7pDqQqSvjPnICjDFoktlCasDKiBdkkKm4SyCH8NTljY5
    +eEXeRXrsdLpI9TAaap2qSNAo0DP0Yi/4+ZU25exT4p+nVB4muiiBy81y07x47qh
    iYYC0JQXZRDMhAa9fZfzvXX00jV2piBCtwdpFR+dOi/FycWmpp9BGj0pyaz/BflL
    QGq6gkCT3Q7OuTP0Za7bXNPyFb98JWx2mxIAzyHm57hQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeBKSB4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 13:01:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753520AbeBKSB4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 13:01:56 -0500
Message-ID: <1518372105.2617.22.camel@decadent.org.uk>
Subject: Re: [PATCH 3.2 39/79] ocfs2: should wait dio before inode lock in
 ocfs2_setattr()
From: Ben Hutchings <ben@decadent.org.uk>
To: alex chen <alex.chen@huawei.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 18:01:45 +0000
In-Reply-To: <5A7FF337.3000705@huawei.com>
References: <lsq.1518322806.798088185@decadent.org.uk>
         <5A7FF337.3000705@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-BNWVRJVxBCvZs5V5dgm3"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-BNWVRJVxBCvZs5V5dgm3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-02-11 at 15:39 +0800, alex chen wrote:
> Hi Ben,
>=20
> ocfs2_dio_end_io_write() was introduced in 4.6 and the problem this patch
> fixes is only exist in the kernel 4.6 and above 4.6.

Thanks for the reminder.  I'll drop this from the 3.2 and 3.16 patch
queues.

Ben.

> Thanks,
> Alex
>=20
> On 2018/2/11 12:20, Ben Hutchings wrote:
> > 3.2.99-rc1 review patch.  If anyone has any objections, please let me k=
now.
> >=20
> > ------------------
> >=20
> > From: alex chen <alex.chen@huawei.com>
> >=20
> > commit 28f5a8a7c033cbf3e32277f4cc9c6afd74f05300 upstream.
> >=20
> > we should wait dio requests to finish before inode lock in
> > ocfs2_setattr(), otherwise the following deadlock will happen:
> >=20
> > process 1                  process 2                    process 3
> > truncate file 'A'          end_io of writing file 'A'   receiving the b=
ast messages
> > ocfs2_setattr
> >  ocfs2_inode_lock_tracker
> >   ocfs2_inode_lock_full
> >  inode_dio_wait
> >   __inode_dio_wait
> >   -->waiting for all dio
> >   requests finish
> >                                                         dlm_proxy_ast_h=
andler
> >                                                          dlm_do_local_b=
ast
> >                                                           ocfs2_blockin=
g_ast
> >                                                            ocfs2_generi=
c_handle_bast
> >                                                             set OCFS2_L=
OCK_BLOCKED flag
> >                         dio_end_io
> >                          dio_bio_end_aio
> >                           dio_complete
> >                            ocfs2_dio_end_io
> >                             ocfs2_dio_end_io_write
> >                              ocfs2_inode_lock
> >                               __ocfs2_cluster_lock
> >                                ocfs2_wait_for_mask
> >                                -->waiting for OCFS2_LOCK_BLOCKED
> >                                flag to be cleared, that is waiting
> >                                for 'process 1' unlocking the inode lock
> >                            inode_dio_end
> >                            -->here dec the i_dio_count, but will never
> >                            be called, so a deadlock happened.
> >=20
> > Link: http://lkml.kernel.org/r/59F81636.70508@huawei.com
> > Signed-off-by: Alex Chen <alex.chen@huawei.com>
> > Reviewed-by: Jun Piao <piaojun@huawei.com>
> > Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
> > Acked-by: Changwei Ge <ge.changwei@h3c.com>
> > Cc: Mark Fasheh <mfasheh@versity.com>
> > Cc: Joel Becker <jlbec@evilplan.org>
> > Cc: Junxiao Bi <junxiao.bi@oracle.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  fs/ocfs2/file.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > --- a/fs/ocfs2/file.c
> > +++ b/fs/ocfs2/file.c
> > @@ -1130,6 +1130,13 @@ int ocfs2_setattr(struct dentry *dentry,
> >  		dquot_initialize(inode);
> >  	size_change =3D S_ISREG(inode->i_mode) && attr->ia_valid & ATTR_SIZE;
> >  	if (size_change) {
> > +		/*
> > +		 * Here we should wait dio to finish before inode lock
> > +		 * to avoid a deadlock between ocfs2_setattr() and
> > +		 * ocfs2_dio_end_io_write()
> > +		 */
> > +		inode_dio_wait(inode);
> > +
> >  		status =3D ocfs2_rw_lock(inode, 1);
> >  		if (status < 0) {
> >  			mlog_errno(status);
> > @@ -1149,8 +1156,6 @@ int ocfs2_setattr(struct dentry *dentry,
> >  		if (status)
> >  			goto bail_unlock;
> > =20
> > -		inode_dio_wait(inode);
> > -
> >  		if (i_size_read(inode) >=3D attr->ia_size) {
> >  			if (ocfs2_should_order_data(inode)) {
> >  				status =3D ocfs2_begin_ordered_truncate(inode,
> >=20
> >=20
> > .
> >=20
>=20
>=20
--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.


--=-BNWVRJVxBCvZs5V5dgm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqAhQoACgkQ57/I7JWG
EQkyQxAAlfa6JRzVLG5YYqQuNBs/1FpiRvZkQzAk4Ke2P7De/FNTwd6rpTm1zm+v
2hNkykyV7BnzxmzC4HVK60klSUzPptYFAmQ+/3Rtwfg8IRtF+BgkRp9k5KqnHBYR
z102yWzPsToul8kHPq0aMns41cQnQybu4NxWkygPkMJEFMA60QKiHyNPUXzBGroo
5WI5sBaY2mNTmAg/MtchTbL6l9m6wd4jr1e3Cx08hl63sNEudd+wMUrDV7lCnWg1
curOlso8oZqMDWnAyZMfQyBXfmF05J2PHjwAo74LoWbMOiqPFfIdJUNgbuC5W3VS
FBZgQsiBf4I1kCbzV6FSin8ZloPXOtoZDCqKgWitwsw0PkRgT8x7/HuLLVCYLnkv
2KVoSkrTb08GOs8huxmG9ABr9fLLXeOpbk8v8mXgp318l5GAsn20NyqY3Klk8MzB
bM8WkYjluNwG9fDveMbJIc0ZeL7PEqJEJZL8ok/ha45tf8QS88GhvxKuUWFMcUts
KHKMzlB5EMw4LswM8L3O5kkQapnJbgeEAj55cX5L3k/fJf0FmI9WpQC78kY4/5l3
ETxlGs3QL7msb8tY7rIx3PBTMvqqbyAX9tR75zpp6WD7GdYepZopk3lQlcOIE43B
DbgvdWAlj8ND9eYQJCIawEJ2bb80szyXa7cMRJ4Roxd2RMuV+Qg=
=CiNz
-----END PGP SIGNATURE-----

--=-BNWVRJVxBCvZs5V5dgm3--
