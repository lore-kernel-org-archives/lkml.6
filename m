Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED44C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372C7218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGJGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:06:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:25223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfBGJGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:06:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 01:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="asc'?scan'208";a="136579406"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2019 01:06:04 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Use ffs() to find page size in xhci_mem_init()
In-Reply-To: <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com>
References: <20190207000349.7816-1-andrew.smirnov@gmail.com> <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com>
Date:   Thu, 07 Feb 2019 11:06:00 +0200
Message-ID: <87mun8klxj.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> On 07.02.2019 02:03, Andrey Smirnov wrote:
>> Get page size order using ffs() instead of open coding it with a loop.
>>=20
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   drivers/usb/host/xhci-mem.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 36a3eb8849f1..44b43c3d819f 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -2362,11 +2362,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t fl=
ags)
>>   	page_size =3D readl(&xhci->op_regs->page_size);
>>   	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>   			"Supported page size register =3D 0x%x", page_size);
>> -	for (i =3D 0; i < 16; i++) {
>> -		if ((0x1 & page_size) !=3D 0)
>> -			break;
>> -		page_size =3D page_size >> 1;
>> -	}
>> +	i =3D ffs(page_size);
>>   	if (i < 16)
>>   		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>   			"Supported page size of %iK", (1 << (i+12)) / 1024);
>
> Hi
>
> using ffs() is a welcome change, but it will give different a result than=
 the loop.
>
> *old loop
>    valid page_size value if i < 16
> *ffs()
>    valid page_size value if i >=3D 1 and i < 17

off-by-one, just use i =3D ffs() - 1. Or use __ffs().

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxb9PgACgkQzL64meEa
mQaXbhAArgTijIIcdXJwhwk/Lh4UKQgcWmlTNlvxx9RA//yC5bHxVIt75Zl3WDs9
C7afM7QUYDL9fv5jtCN4482sOLYQeMQ/NmrKjfmHwAlb7tIUY0ntD81E/fe0SvRy
PZVheDGwwsN6YVp1ti/S1KHA/KKQuOcm4OMdWUXr9qymVt+pXrEG5oyZVihLInMC
NCEdsn+PLo9j8KvdtiEAFMzOp5ibzzIwp6b/DOXeGk6aeeEr+jgkLL/H/5eGDpev
4t+ZJRRX9QV8Ld+qfefOvp/+K+hlXpbnLxVMJiosepkxEOz/5chGWziBtiwGz5MF
+jKuLOlu63+z1bm+ZmX/kiJd43JYopMvMXGc5v5ZPTYwvTEGf5ALGTv5HW+iMcO8
gsmeBZVTIORI7ZMEMUooC3qZuyP6OMwx3g4G/5NZ9m5u4M9llzG1y2b8B6KlRMm7
+Pv1IfQxcZSBKUngSoQo+Hm+ENJZX7I9YtL28Luh9UwDO/hgJ6xBrpz2PX/BSupe
PeHIBcddmu0Gu2CekP1Fvr6YgD+AOXfvynPZLhlbx/sxYLPlKkekJ9WntXIso/Vu
mnnV0GTKoK0v0HZMFCl8j4aQSWHQgaq0egKLzAhB1OGPExAaZuP83NQ2LLyt300j
mmtShemkLGMMPIMXlik3wm7i6+y/rO134dIKTReo+P3nJpvMuN0=
=JBew
-----END PGP SIGNATURE-----
--=-=-=--
