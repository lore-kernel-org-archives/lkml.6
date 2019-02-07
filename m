Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4B020844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGJ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:28:24 -0500
Received: from mx.gwdg.de ([134.76.10.20]:45863 "EHLO mx.gwdg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGJ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:28:24 -0500
Received: from mailgw.tuebingen.mpg.de ([192.124.27.5] helo=tuebingen.mpg.de)
        by mailer.gwdg.de with esmtp (Exim 4.90_1)
        (envelope-from <maan@tuebingen.mpg.de>)
        id 1grfym-0005nx-SH; Thu, 07 Feb 2019 10:28:20 +0100
Received: from [10.37.80.2] (HELO mailhost.tuebingen.mpg.de)
  by tuebingen.mpg.de (CommuniGate Pro SMTP 6.2.6)
  with SMTP id 21672203; Thu, 07 Feb 2019 10:29:20 +0100
Received: by mailhost.tuebingen.mpg.de (sSMTP sendmail emulation); Thu, 07 Feb 2019 10:28:19 +0100
Date:   Thu, 7 Feb 2019 10:28:19 +0100
From:   Andre Noll <maan@tuebingen.mpg.de>
To:     Coly Li <colyli@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>, Nix <nix@esperi.org.uk>,
        linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at
 all?
Message-ID: <20190207092819.GY24140@tuebingen.mpg.de>
References: <87h8dgefee.fsf@esperi.org.uk>
 <20190206234328.GH14116@dastard>
 <20190207002425.GX24140@tuebingen.mpg.de>
 <b982a23b-7225-d20a-2802-60bce314ccc2@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBii9oQw/U9UOygZ"
Content-Disposition: inline
In-Reply-To: <b982a23b-7225-d20a-2802-60bce314ccc2@suse.de>
User-Agent: Mutt/1.11.3 (eeed901d) (2019-02-01)
X-Virus-Scanned: (clean) by clamav
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBii9oQw/U9UOygZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 10:27, Coly Li wrote

> If different file system handles metadata flags in unified ways, it is
> OK to me to change the code to: !(bio->bi_opf & (REQ_META |REQ_PRIO)).

Yes, that's the smallest fix that should also go into 4.19-stable.

In the long run, we should try to get rid of the 45 instances of
REQ_PRIO. Most users specify REQ_META | REQ_PRIO anyway, which leaves
only a few other instances to look at.

I think the one in submit_bh_wbc() of fs/buffer.c can just be removed
while block/cfq-iosched.c does not use REQ_META at all, so the simple
s/REQ_PRIO/REQ_META should be OK. drivers/staging/erofs/data.c is
also easy to fix.

Best
Andre
--=20
Max Planck Institute for Developmental Biology
Max-Planck-Ring 5, 72076 T=C3=BCbingen, Germany. Phone: (+49) 7071 601 829
http://people.tuebingen.mpg.de/maan/

--gBii9oQw/U9UOygZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSHtF/cbZGyylvqq1Ra2jVAMQCTDwUCXFv6MAAKCRBa2jVAMQCT
D5coAKCcC0GuP2KTQi/SwEAsWqfUJw6gigCfX4CU1iFd0TsxJMy93V2ZSUUPpLg=
=ML1i
-----END PGP SIGNATURE-----

--gBii9oQw/U9UOygZ--
