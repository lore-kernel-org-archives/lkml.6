Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675EBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA90208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA90208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLCAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:46:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbeLCAqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:46:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB30ht3j019992
        for <linux-kernel@vger.kernel.org>; Sun, 2 Dec 2018 19:46:29 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p4rwnjdab-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:46:29 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Mon, 3 Dec 2018 00:46:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 00:46:25 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB30kOhL49086708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 00:46:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B2D4C040;
        Mon,  3 Dec 2018 00:46:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07954C04E;
        Mon,  3 Dec 2018 00:46:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Dec 2018 00:46:23 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 363DBA0129;
        Mon,  3 Dec 2018 11:46:20 +1100 (AEDT)
Date:   Mon, 3 Dec 2018 11:46:19 +1100
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     "airlied@gmail.com" <airlied@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/ast: Fix connector leak during driver unload
References: <cover.1541397462.git.sbobroff@linux.ibm.com>
 <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
 <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com>
 <20181129020034.GA10328@tungsten.ozlabs.ibm.com>
 <CAKMK7uEY8C_9qwuUi5rR1+_xYOSXeKicopR1zTpQKaMEJTM-fA@mail.gmail.com>
 <20181130001750.GA6776@tungsten.ozlabs.ibm.com>
 <20181130094108.GT21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20181130094108.GT21184@phenom.ffwll.local>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18120300-4275-0000-0000-000002EB0973
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120300-4276-0000-0000-000037F809AE
Message-Id: <20181203004618.GA11552@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 10:41:08AM +0100, Daniel Vetter wrote:
> On Fri, Nov 30, 2018 at 11:17:51AM +1100, Sam Bobroff wrote:
> > On Thu, Nov 29, 2018 at 09:56:53AM +0100, Daniel Vetter wrote:
> > > On Thu, Nov 29, 2018 at 9:05 AM Sam Bobroff <sbobroff@linux.ibm.com> =
wrote:
> > > >
> > > > On Thu, Nov 29, 2018 at 09:40:53AM +1000, Dave Airlie wrote:
> > > > > On Mon, 5 Nov 2018 at 15:59, Sam Bobroff <sbobroff@linux.ibm.com>=
 wrote:
> > > > > >
> > > > > > When unloading the ast driver, a warning message is printed by
> > > > > > drm_mode_config_cleanup() because a reference is still held to =
one of
> > > > > > the drm_connector structs.
> > > > > >
> > > > > > Correct this by calling drm_framebuffer_remove() in
> > > > > > ast_fbdev_destroy().
> > > > > >
> > > > > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/ast/ast_fb.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast=
/ast_fb.c
> > > > > > index 0cd827e11fa2..655372ea81e9 100644
> > > > > > --- a/drivers/gpu/drm/ast/ast_fb.c
> > > > > > +++ b/drivers/gpu/drm/ast/ast_fb.c
> > > > > > @@ -263,6 +263,10 @@ static void ast_fbdev_destroy(struct drm_d=
evice *dev,
> > > > > >  {
> > > > > >         struct ast_framebuffer *afb =3D &afbdev->afb;
> > > > > >
> > > > > > +       /* drm_framebuffer_remove() expects us to hold a ref, w=
hich it
> > > > > > +        * will drop, so take one: */
> > > > > > +       drm_framebuffer_get(&afb->base);
> > > > > > +       drm_framebuffer_remove(&afb->base);
> > > > >
> > > > > This doesn't seem corret, no other driver does this pattern, and I
> > > > > can't believe ast is special here.
> > > > >
> > > > > The get just doesn't make sense.
> > > >
> > > > Thanks for having a look at this, as I said in the cover letter I w=
as
> > > > concerned that it might not be a good fix.
> > > >
> > > > But the AST driver does seem to be special (or just old?) because it
> > > > embeds the drm_framebuffer directly into ast_fbdev and (almost all)
> > > > other drivers dynamically allocate and reference count theirs.
> > > >
> > > > The drm_framebuffer_get() certainly looks weird but it is there in =
order
> > > > to cause drm_framebuffer_remove() to call legacy_remove_fb(), which=
 it
> > > > won't do unless the refcount is at least 2. (And because the
> > > > drm_framebuffer isn't dynamically allocated in this case we don't r=
eally
> > > > care about the reference count anyway.)
> > > >
> > > > An alternative might be to call legacy_remove_fb() directly, but it=
's
> > > > declared static.  Do you think it would be better to expose it and =
call
> > > > it directly from the AST driver code? Or is there some other better=
 way
> > > > to put the drm_connectors?
> > >=20
> > > Your problem isn't the dynamic fb vs. embedded fb for fbdev (you're
> > > already using drm_framebuffer_unregister_private to handle that). Your
> > > problem is you're not shutting down stuff on driver unload, which
> > > means the fb is still in use. drm_atomic_helper_shutdown() takes care
> > > of that for atomic drivers.
> > >=20
> > > No idea anymore what to do for legacy code, probably need to open code
> > > a shutdown sequence. Definitely not the above.
> > > -Daniel
> >=20
> > Well, it looks like drm_crtc_force_disable_all() would also do the job,
> > and from looking at nouveau_display_fini() it's used there as an
> > alternative to drm_atomic_helper_shutdown().
>=20
> Ah right, I tried looking for that one but didn't find it with a quick
> scan.
> =20
> > Would it be reasonable to call that at the start of
> > ast_fbdev_destroy() instead? (Testing shows that it does allow the
> > drm_connector to be released. Is it enough/correct though?)
>=20
> Yes.
> -Daniel

Great, I'll post a v2 with that change.

Cheers,
Sam.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlwEfNMACgkQMX8w6AQl
/iK1Egf/UwcLHeTtSzAGD6HEgpsNauIflJieagrSKOQJ4jllYkpOeg7RLOV856HA
OGu14+gkLHhSwrELl6kMBGQSLnxigDCaa+JzI3kUjQVe8dPC/hnWZSZbXGk82DaD
Ya6NVpcpm4wtCpM1gpUqlTftUt0GxOxwycmirq9zde35NoI0ZXLrQRuMUhxnkcYI
hvnAWyezV4D9HFp7CgP8epTESGtOuHqEnfe+n+tj2Mk6lBuu60VuF51ymeGbcvZ9
sJXcQ45PRygRltmM12GbpzSyFk8QTPqBJ/3BM9gikF2uGjjtcNWKiXJx8vavhE7F
VbdBIogr+MrJUgw7uKU9gc0I79Gm0Q==
=4k2e
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

