Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B314ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D31520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D31520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGMXye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:54:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbeGMXyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:54:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A728CAD00;
        Fri, 13 Jul 2018 23:37:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 14 Jul 2018 09:37:25 +1000
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "DRI Development" <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
In-Reply-To: <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709162509.29343-1-daniel.vetter@ffwll.ch> <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org> <20180710075328.GG3008@phenom.ffwll.local> <871scbwfd4.fsf@notabene.neil.brown.name> <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com> <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
Message-ID: <87bmbavhai.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Jul 11 2018, Andrew Morton wrote:

> On Wed, 11 Jul 2018 13:51:08 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
>> But I still have the situation that a bunch of maintainers acked this
>> and Andrew Morton defacto nacked it, which I guess means I'll keep the
>> macro in drm? The common way to go about this seems to be to just push
>> the patch series with the ack in some pull request to Linus and ignore
>> the people who raised questions, but not really my thing.
>
> Heh.
>
> But, am I wrong?  Code which uses regular kernel style doesn't have
> these issues.  We shouldn't be enabling irregular style - we should be
> making such sites more regular.  The fact that the compiler generates a
> nice warning in some cases simply helps us with that.

I think you are wrong .... or at least, not completely correct.

I think it is perfectly acceptable in Linux to have code like:

  for (....)
  	if (x)
        	something();
        else
        	something_else();

Would you agree?  If not, then I'm the one who is wrong.  Otherwise....

The problem is that for certain poorly written for_each_foo() macros,
such as blkg_for_each_descendant_pre() (and several others identified in
this patch series), writing

   blkg_for_each_descendant_pre(...)
     	if (x)
        	something();
        else
        	something_else();

will trigger a compiler warning.  This is inconsistent with the
behaviour of a simple "for".
So I do think that the macros should be fixed, and I don't think that
sprinkling extra braces is an appropriate response.

I'm not personally convinced that writing
   if_no_else(cond)
is easier than just writing
   if (!(cond)); else

in these macros, but I do think that the macros should be fixed and
maybe this is the path-of-least-resistance to getting it done.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltJN7cACgkQOeye3VZi
gblHDhAAj/rcY3vyWl833/lkI0CKhD84dktXAFOnagQGDe8kEJi/EfOhhxiii5Rm
dTwWsDlSrb0IN0/bZBDcKavMik5RJZRpOPaO/qFZaXwKLVQbjKZGpX8PMraUIzLK
bvlRdhO73I83/2gzKJmzhvkUFVmUA2LXoFCiU2O4UP+JtPvo1CduzgbP5PjAZ0ca
IC7ew+NRnj9nbEo8eeqJMoteJNz2+lEzWRBGn1NJ3vTKM4cPPUy7P7EHdZkzuoba
DBzoRroXJzjP1d+CmG8XmEWwr+CII2o0uv+kO6fGiLFZNF4EXxT3OnBfz7IS051t
UO4+PJVR8CzgsSl46NHTl14mvYgO+aLIz6S4+aK7RIQr5FXqk6GXMGsT9b6XtUdO
ebBIoYNmlbgyqjLPaq218+XfTeLfxwrNaBKBt7z5Qrt6oVkv4i0+qCThe0VgNrtp
uQMBJwLOojdz6mXnikqlHKzjDiD3fnMlxznFsgFWLk1Jt7/5miYHBjnA02H6YR/w
mqE4Fkutn1q8CQch80Ju/hMlwmll+NfWy8iRdCcn85LfbJYTqRsDpcCA/DodO0al
hpLZDUkA7io33jLFCDChqO6rfL+fE9Y4NYFSXpc/rmNe2F9fZZqEiwO24THx9UH4
kxjVnr5bQYMyxlU6HxALsNrd4tps1hhYhHhzok9pT0OddP1DrEM=
=OSfx
-----END PGP SIGNATURE-----
--=-=-=--
