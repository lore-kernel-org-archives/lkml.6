Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeDYWAa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:00:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751887AbeDYWA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:00:29 -0400
From: NeilBrown <neil@brown.name>
To: James Hogan <jhogan@kernel.org>
Date: Thu, 26 Apr 2018 08:00:18 +1000
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: c-r4k: fix data corruption related to cache coherence.
In-Reply-To: <20180425214650.GA25917@saruman>
References: <87sh7klyhc.fsf@notabene.neil.brown.name> <20180425214650.GA25917@saruman>
Message-ID: <87h8nzlzf1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25 2018, James Hogan wrote:

> Hi NeilBrown,
>
> On Wed, Apr 25, 2018 at 02:08:15PM +1000, NeilBrown wrote:
>> Cc: stable@vger.kernel.org (v4.8)
>
> FYI my preferred form of this is:
>
> Cc: <stable@vger.kernel.org> # 4.8+

Ugh.  Cc: looks like an RFC822 header, and # does not introduce
a comment in RFC822 headers. () do provide comments.
I would consider that a syntax error :-(
Apparently Documentation/process/stable-kernel-rules.rst
doesn't.  Sad.

>
>>  	/*
>>  	 * Either no secondary cache or the available caches don't have the
>>  	 * subset property so we have to flush the primary caches
>> -	 * explicitly
>> +	 * explicitly.
>> +	 * As Index type operations are not globalized by CM, we must
>> +	 * use the HIT type when CM is present.
>
> I don't think Index type operations *can* be sensibly globalised to
> separate primary caches, since they directly index the lines in the
> cache rather than any particular physical or virtual address, so this
> fundamental issue doesn't sound specific to the CM.
>
> I'm not entirely clear OTOH whether there are any non-CM r4k-like SMP
> capable cores that don't have coherent IO or inclusive caches.
> - Octeon doesn't use c-r4k and has coherent IO
> - Netlogic appear to have coherent IO=20
> - Loongson64 have inclusive caches
> - bmips, only bmips5000 appears to have multicore (not just multi-thread
>   with I presume shared dcaches), and that has inclusive caches
>
> So I suppose that does just leave non-multicore and CM systems as
> potentially reaching these bits of code...
>
>>  	 */
>> -	if (size >=3D dcache_size) {
>> +	if (!mips_cm_present() && size >=3D dcache_size) {
>
> ... but even for CM systems its only if there are foreign CPUs running
> (i.e. not just threads on the same core sharing the same dcache) that it
> actually matters.
>
> So I'm thinking "!mips_cm_present()" should probably be replaced with
> "!r4k_op_needs_ipi(R4K_INDEX)" (and the comment updated to mention that
> IPI calls aren't implemented here).

That makes sense.  I tried ipi calls at one stage.  Synchronous ones
cannot be used because this code is called with interrupts disabled, and
async ones cannot provide the required guarantees.

I'll update the patch, test that it still works, and resend, in the next
day or so.

Thanks,
NeilBrown

>
> That effectively means:
> 	!CONFIG_SMP || cpumask_empty(&cpu_foreign_map[0])
>
> Otherwise the patch looks spot on. Thanks for spotting this!
>
> Cheers
> James

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrg+nIACgkQOeye3VZi
gbmsKA//RPxpN7J1tdKr3uMEu4V1IeJLtNtQRi7rfYnVwyAUx8IE3IQHMJwwnT0r
hEYHGa42nskeXqLFIVaSszPh6F3+DErdpGKhlPnG5EX9xEKus/bF7IE7gHW45HDd
Lv2YBIVMiW3bwEZF6Z999ycWTBMSCyQ0uP4XFzQdybZhrWFhE0TX9auSI+ccpBwD
TigwWfZUgbv8AolyX5quA6+jiyi9+bxTVfT0gK8gQ/5KgBAvdQxpnKONR4FfDlTq
6rdY+GgZFiwq/ZuP5kXuoaGCD7Ld5FMq+5eVasGHpTSslzJ9Tgn2nbG6uv827O1K
oQ0ahPuBmQx0qi1SpvFPa+OE6PewbATtCBRMfONJlvQ5HfDxOITuIBT7135CRL0I
aTRNT/SmgCXPgzkrIU2voAxodOrqRweq1oJRueBRJocIXBvgDbjZbVrMQfXThNKp
DQxuiey7e3aKChFG+hI+uITlC2K5v89e7RrG5A2urxJ2Y4gDP1dO7+fUQ6hMGL1G
y5SuIKQ0mKmE0ymQ0WZ3DPRA63eBSAAVdQyJPeAFyUUFzlE6LF1IV6KPXjfS4c5U
HiuGTSVZez4uPxdppOYAlODSuLsjJFL2b+oKb5ueAfsTtFG9uKKxD7NPTljApV2B
b3c4/rQ/q5h4l8cWABr99loPec8nwpFgYNPZ32ommLyBj41jn6w=
=X6Lc
-----END PGP SIGNATURE-----
--=-=-=--
