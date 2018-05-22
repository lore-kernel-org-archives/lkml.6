Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeEVQzo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:55:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43934 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:55:42 -0400
Date: Tue, 22 May 2018 17:55:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180522165537.GE24776@sirena.org.uk>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
X-Cookie: I have not yet begun to byte!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 09:43:02AM -0700, Doug Anderson wrote:
> On Mon, May 21, 2018 at 5:00 PM, David Collins <collinsd@codeaurora.org> wrote:

> > Returning the cached (but not sent) initial voltage equal to the min
> > constraint voltage in get_voltage() calls should not cause any problems.
> > This represents the highest voltage that is guaranteed to be output by the
> > regulator.  Consumer's should call regulator_set_voltage() to specify
> > their voltage needs.  If they simply call regulator_enable(), then the
> > cached voltage will be sent along with the enable request.

> I'm still not seeing the argument for initial-voltage here.  If we
> added a feature like you describe where we don't send the voltage
> until the first enable couldn't we use the minimum voltage here?  If a
> consumer calls regulator_enable() without setting a voltage (which
> seems like a terrible idea for something where the voltage could vary)
> then it would end up at the minimum voltage.

Or if something else has already set a voltage...  though shared voltage
varying regulators aren't a superb idea they do occasionally happen.

> >> I was asking for specific examples.  Do you have any?

> > I was able to track down an example that requires initialization at a
> > non-minimum voltage: PM8998 LDO 13 on SDM845 MTP.  This regulator supplies
> > the microSD card with a voltage in the range 1.8 V to 2.96 V.  The boot
> > loader leaves this regulator enabled at 2.96 V.  It is only guaranteed to
> > be safe to reduce the voltage to 1.8 V on UHS type cards and only after
> > following the proper SD identification and command sequence.

> Ironically, this is also a perfect example of why we _shouldn't_ have
> an "initial-voltage" specified in the device tree.  It is certainly
> plausible to imagine a bootloader that might enable UHS speeds on an
> SD card and leave the rail on at 1.8V.  Having an initial-voltage
> specified in the device tree would be a bad idea here because it's
> even worse to transition to 2.96V when the card was expecting 1.8V.

Right, this sort of situation is why the regulator API has a policy of
leaving things untouched unless it was specifically told to do
something.

> I suppose this is a theoretical example since (as far as I know) no
> bootloaders run the micro SD card at UHS speeds, but it is still

kexec is the most obvious example I can think of here.  You could
probably arrange for something to patch the device tree that's provided
to the kexeced kernel to tell it about the current state but we don't
currently do anything there.

> OK, so how's this for a proposal then:

> 1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
> specified that the regulator is enabled then we don't send the
> voltage, we just cache it.

> 2. When we see the first enable then we first send the cached voltage
> and then do the enable.

> 3. We don't need an "initial voltage" because any rails that are
> expected to be variable voltage the client should be choosing a
> voltage.

That seems relatively safe.

> You can even come up with a less contrived use case here.  One could
> argue that the SD card framework really ought to be ensuring VMMC and
> VQMMC are off before it starts tweaking with them just in case the
> bootloader left them on.  Thus, it should do:

> A) Turn off VMMC and VQMMC
> B) Program VMMC and VQMMC to defaults
> C) Turn on VMMC and VQMMC

> ...right now we bootup and pretend to Linux that VMMC and VQMMC start
> off, so step A) will be no-op.  Sigh.

> Do we need to have ".is_enabled" return -ENOTRECOVERABLE to help the
> regulator framework understand that we don't know the state?  I think

Yes, we should be doing that.  Then subsystems where it's an issue can
explicitly turn off the supply.

> that might require a pile of patches to the regulator framework, but
> it can't be helped unless we can somehow get RPMh to give us back the
> status of how the bootloader left us (if we had that, we could return
> 0 for anything the bootloader didn't touch and that would be correct
> from the point of view of the AP).

I think it's fine from a framework point of view, just provide an
is_enabled() operation which returns the error.  The required fiddling
in the core should be fairly minor.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsES4kACgkQJNaLcl1U
h9AzUwf9FzNerHoeUPdczcZoyOO51AFp/II2N3caAmCEgxX2DnmGrq9yelc4T/ze
O02VEOavGMsmcd/TvPbAATCoee1z+pfJzvnqh3ISgB5mEeQ9xM9614P0Oz9dPAv0
lM9DGJlsVy3ZvuUywKQqsk5iru3QNTDbipLazNaFfzP3/ciHSex8LdlilSu2praM
pffRmgHpO6M+qgmDap9+z5tbtJIgP5gmOdKLZQSWXQMchHeZieITAUkyTyHgT56Q
NRwAkPOHA7p5MgCh785jrxjDrU0JIk9Nb87wpmi05aw+m7bcjUV8OQAFDhuuNflt
tTuRbh+mp2QEOZXQVGrXhtBm1wgIPg==
=SKz+
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
