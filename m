Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A19216F3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A19216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbeHNTAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:00:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:41520 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731841AbeHNTAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:00:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 09:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="p7s'?scan'208";a="224591667"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2018 09:12:52 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 14 Aug 2018 09:12:51 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.46]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.2]) with mapi id 14.03.0319.002;
 Tue, 14 Aug 2018 09:12:51 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] PCI: Equalize hotplug memory for non/occupied slots
Thread-Topic: [PATCH] PCI: Equalize hotplug memory for non/occupied slots
Thread-Index: AQHUJGwISo4RbMWkQEqcaJwsAsbgs6S//8qA
Date:   Tue, 14 Aug 2018 16:12:50 +0000
Message-ID: <1534263169.4361.1.camel@intel.com>
References: <1532559779-3542-1-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1532559779-3542-1-git-send-email-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.101]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-EWgyLFeAbv/TF08WK4WF"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-EWgyLFeAbv/TF08WK4WF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's been a few weeks. Thoughts on this one?

On Wed, 2018-07-25 at 17:02 -0600, Jon Derrick wrote:
> Currently, a hotplug bridge will be given hpmemsize additional memory
> if
> available, in order to satisfy any future hotplug allocation
> requirements.
>=20
> These calculations don't consider the current memory size of the
> hotplug
> bridge/slot, so hotplug bridges/slots which have downstream devices
> will
> get their current allocation in addition to the hpmemsize value.
>=20
> This makes for possibly undesirable results with a mix of unoccupied
> and
> occupied slots (ex, with hpmemsize=3D2M):
>=20
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d64fffff [size=3D3M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6500000-d66fffff [size=3D2M]
>=20
> This change considers the current allocation size when using the
> hpmemsize parameter to make the reservations predictable for the mix
> of
> unoccupied and occupied slots:
>=20
> 02:03.0 PCI bridge: <-- Occupied
> 	Memory behind bridge: d6200000-d63fffff [size=3D2M]
> 02:04.0 PCI bridge: <-- Unoccupied
> 	Memory behind bridge: d6400000-d65fffff [size=3D2M]
>=20
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> Original RFC here:
> https://patchwork.ozlabs.org/patch/945374/
>=20
> I split this bit out from the RFC while awaiting the pci string
> handling
> enhancements to handle per-device settings
>=20
> Changed from RFC is a simpler algo
>=20
>  drivers/pci/setup-bus.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824..5ae39e6 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -831,7 +831,8 @@ static resource_size_t
> calculate_iosize(resource_size_t size,
> =20
>  static resource_size_t calculate_memsize(resource_size_t size,
>  		resource_size_t min_size,
> -		resource_size_t size1,
> +		resource_size_t add_size,
> +		resource_size_t children_add_size,
>  		resource_size_t old_size,
>  		resource_size_t align)
>  {
> @@ -841,7 +842,7 @@ static resource_size_t
> calculate_memsize(resource_size_t size,
>  		old_size =3D 0;
>  	if (size < old_size)
>  		size =3D old_size;
> -	size =3D ALIGN(size + size1, align);
> +	size =3D ALIGN(max(size, add_size) + children_add_size,
> align);
>  	return size;
>  }
> =20
> @@ -1079,12 +1080,10 @@ static int pbus_size_mem(struct pci_bus *bus,
> unsigned long mask,
> =20
>  	min_align =3D calculate_mem_align(aligns, max_order);
>  	min_align =3D max(min_align, window_alignment(bus, b_res-
> >flags));
> -	size0 =3D calculate_memsize(size, min_size, 0,
> resource_size(b_res), min_align);
> +	size0 =3D calculate_memsize(size, min_size, 0, 0,
> resource_size(b_res), min_align);
>  	add_align =3D max(min_align, add_align);
> -	if (children_add_size > add_size)
> -		add_size =3D children_add_size;
> -	size1 =3D (!realloc_head || (realloc_head && !add_size)) ?
> size0 :
> -		calculate_memsize(size, min_size, add_size,
> +	size1 =3D (!realloc_head || (realloc_head && !add_size &&
> !children_add_size)) ? size0 :
> +		calculate_memsize(size, min_size, add_size,
> children_add_size,
>  				resource_size(b_res), add_align);
>  	if (!size0 && !size1) {
>  		if (b_res->start || b_res->end)
--=-EWgyLFeAbv/TF08WK4WF
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
AG6qjTBc2iB2iz6IVnzrBtQT5DR3KM6EqbMTwur8keTC11xls7lwWexzsSgt37V9UNKAqfsZPgcX
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQUJRdznv8EeAa3g+3F5NKtNNctuBcwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA5LNb+VnWY0V21FlNjnQ2BIb5gmlED29zwQiC5yezn
2SexgvN31129iJSkXuiBHdcVJiUAUPHYuxPRwumwbrkY6m+sYi9kIzKt+ZKNNAN4WbnavsbyRBlb
cIn2E5swqD+sks8AmKivHmg+gFeboLaOf+EqVihIz1Wec1PpbX98R1t2ep7Y/81DD1fIjAWHl6Mq
TJwjKQuYB01kkJdXZAGPXUQSARR1y2D1YpCkDqfGH2STaB4nenD4INSyhTGo5RV9wwTAibyrIq50
rnmvBnHTmICQVdHuIhG1gGmDLUAGqfrU3W2QJr9gkICdrTMgIEdd8s73wknaZxZKqfRxnMVQMYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAKye+0C3syvSXOcAAAAArJ4wCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDgxNDE2MTI0OVowIwYJ
KoZIhvcNAQkEMRYEFFrFJf8IkyXmHKvXpgUYUYwCnN0mMA0GCSqGSIb3DQEBAQUABIIBADfch+0A
EN8VC+iWtoxYC4ypo2BIXGy/EtwFIXjbIjnliqsh3XDY8Q44XpaTdysAVuWMtC1lcqbS1b13dxly
Nbp5e8g1Jn8itaweza+RnfMzYDyaT7+YUR65DWSAPp4AIzKJGZFykFeAXUwYajY5Js1k+Rra1RYN
uJWxN4RFY+Yhw6OfHDdv4zYBfJ9FeTosahYcdakkdzR6COE9z3T7pwquje+p7RCsVk5m1I9jEuJ/
fuDkisfdt6DKjQ+BU7MeTbPxORJ83PslnyitK9vc3RkMsjaeW9OQVQvpygo+CkbWuGUzF04mXVsT
v+llup8BmJvgryJKmgtzj8mlQnVy+NgAAAAAAAA=


--=-EWgyLFeAbv/TF08WK4WF--
