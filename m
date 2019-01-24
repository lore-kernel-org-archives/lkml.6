Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF956C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B2C21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DTCmeyTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfAXPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:24:16 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:56333
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbfAXPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5JAxgrWsn7TsBKS91IM9dQ6INqS7v4kCkbRIWpGC/4=;
 b=DTCmeyTPlB2IAnlBOeFhd4JL5fW/rYkNfcSDipzTeogxUEU2p1XCSEpZmE8RECbZs5B+Vju1qNub8J/CG4Gc3G1984qWbPPnFbGH5PMsl+mQEwt6Q0gZG9hXAL03bReCt8ODn5TSFGN/mExih1pglnydMjlUSoeAeeekx1znCBI=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4051.eurprd08.prod.outlook.com (20.178.119.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 15:24:11 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 15:24:11 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Topic: [PATCH] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Index: AQHUs/jb1VUEijWfO0aD6pb/ArbX3A==
Date:   Thu, 24 Jan 2019 15:24:11 +0000
Message-ID: <20190124152410.qjllxymor5mfzgf7@DESKTOP-E1NTVVP.localdomain>
References: <20190123192835.21827-1-afd@ti.com>
In-Reply-To: <20190123192835.21827-1-afd@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: CWLP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:10::22) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4051;6:F/Lp/1EWGdmMix3wnOSLLixUPxY6bWuqN+nso7onpBTKaGkAJdrjWoxQ9WwP50/xYlvgFP3UfBk0GaRdvr34F4Lt0l62Euoe/0LEHFWviQEcAhnYwkq9Tat8dJGbWDFBIivgIuXs2OZHnbalWAsK8JYg7DvgWej4g+zW8HAxlxM87iZ8Xoz1Gwz1rOqUX8EOamnWHqKtMY1P8pXnkY5DFO7prAYx/24syUF8gRN1aMnzsORRPFXwn75RLD2SMGxht1TzeSGQm2fKKTBbJEp5Q/spBbSJxPeEvIjronPMw6PClP6Ix9IUWh/3KSn28K0h4DrVh3H69zpK7zHWROGv8XsAfWR7wXWiqfY5VWAjQ7z4VWpjqoU4l55PTL4UuWat4wkN1SmzioWPBAM0GpBFj+PqcJALAYQLA2QcvKLTqgNYPbakBjXUsdlrqtgOOio/j0Bnfg3fA00l5jFMrX/h4w==;5:PhB3z9l6uTMS61R+BWEIC37A6SuIkFaOvYSwcKU4phzwCKAn+dnAZc5J+Fzr7pmSpP1kb0y/dGgTxNQspFaPGnV6UKsyBsx+/F9zmN8fAEgjMU3mq77Z50fXkuvMa/zMF1QH3VBGKFo5wmKAxe4HIT6W9851sMIs4dkq+e/jtEjfljrBa1KHtBSm961PlaPUk2jvTI0QFtyepcvOimEx1Q==;7:K1V/mO7uy7cQE890Z73x0JxaBaKRAzkByn2Fhz0dTZI6EcRdtawYq8PTNwpjwIJ6J1R+XpbaB9+c1e+eUEvFVdpokHwde7CY+xQBFQqvVD9T2WPqc/F4h8gn1BVh6PWDOWZB3vighJamuIca7EIUVA==
x-ms-office365-filtering-correlation-id: 9d24abb1-b41c-44e0-0ea9-08d6820ffd96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4051;
x-ms-traffictypediagnostic: AM0PR08MB4051:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4051AFC1ABB541C6BB4F1188F09A0@AM0PR08MB4051.eurprd08.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(76094002)(189003)(199004)(52116002)(7736002)(305945005)(53936002)(71200400001)(71190400001)(102836004)(76176011)(229853002)(446003)(6246003)(99286004)(6486002)(105586002)(106356001)(6346003)(68736007)(186003)(6116002)(3846002)(26005)(6436002)(66066001)(44832011)(6916009)(86362001)(9686003)(6512007)(486006)(25786009)(386003)(6506007)(478600001)(4326008)(72206003)(256004)(14454004)(14444005)(33896004)(58126008)(8676002)(966005)(1076003)(2906002)(476003)(54906003)(11346002)(81166006)(8936002)(81156014)(7416002)(6306002)(316002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4051;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p33rjN4vaLhlcx35M67CSGKfibofH2SInCWp3VTUXDCskPGya6iYDZLoLr9D40MeNtV86aR6gMElmleHVYFXLZXJQej3O2BAJ047kYce2tw3+ah+7l14Or/lZ0rj7R65Hhq7ifagaMW+EfA8or03IEwd5EAOLLuJcS40Rd5+1vOHUyTyPOjkoFsIe6/LC5cohuqrl0ahGy9ZjXA4sRjWGmhWY9DOQ4NE0r3A9hqP4IXjHV3AjgRSfTxe/7crf5EnLiduJUuTGtYgt2NEAfaedMfzTq4EvhKuwlYc9FGGsHupa1gUzyc8vg20bccTx3DvAKukZxaQIffJW+mDQv1f8d3Wc5HnKDavVdN4kT+mIKJw5+oSJ2XP4BOb4C0dLE0rGxrBi3ZCliRYqrPOBuf3Jq0BSN/XJOCpTKUvxlHukQk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D64AF3E256AFB24FB18AFE3E7EC6E890@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24abb1-b41c-44e0-0ea9-08d6820ffd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 15:24:10.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jan 23, 2019 at 01:28:35PM -0600, Andrew F. Davis wrote:
> Previously the heap to allocate from was selected by a mask of allowed
> heap types. This may have been done as a primitive form of constraint
> solving, the first heap type that matched any set bit of the heap mask
> was allocated from, unless that heap was excluded by having its heap
> ID bit not set in the separate passed in heap ID mask.

I checked our gralloc and it's not using the current "keep trying
until one succeeds" functionality, but it might be worth explicitly
calling out in the commit message that this will also disappear with
the new API. Maybe someone cares about that.

>=20
> The heap type does not really represent constraints that should be
> matched against to begin with. So the patch [0] removed the the heap type
> mask matching but unfortunately left the heap ID mask check (possibly by
> mistake or to preserve API). Therefor we now only have a mask of heap
> IDs, but heap IDs are unique identifiers and have nothing to do with the
> underling heap, so mask matching is not useful here. This also limits us

s/underling/underlying/

> to 32 heaps total in a system.
>=20
> With the heap query API users can find the right heap based on type or
> name themselves then just supply the ID for that heap. Remove heap ID
> mask and allow users to specify heap ID directly by its number.
>=20
> I know this is an ABI break, but we are in staging so lets get this over
> with now rather than limit ourselves later.

What do you think about renaming ion_allocation_data.unused to heap_id
and adding a flag instead? It's adding cruft to a staging API, but it
might soften the transition. The "old way" could get completely
removed just before destaging. Just a thought.

>=20
> [0] 2bb9f5034ec7 ("gpu: ion: Remove heapmask from client")
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>=20
> This also means we don't need to store the available heaps in a plist,
> we only operation we care about is lookup, so a better data structure
> should be chosen at some point, regular list or xarray maybe?
>=20
> This is base on -next as to be on top of the other taken Ion patches.
>=20
>  drivers/staging/android/ion/ion.c  | 21 ++++++++++-----------
>  drivers/staging/android/uapi/ion.h |  6 ++----
>  2 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/=
ion/ion.c
> index 92c2914239e3..06dd5bb10ecb 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -387,7 +387,7 @@ static const struct dma_buf_ops dma_buf_ops =3D {
>  	.unmap =3D ion_dma_buf_kunmap,
>  };
> =20
> -static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int=
 flags)
> +static int ion_alloc(size_t len, unsigned int heap_id, unsigned int flag=
s)
>  {
>  	struct ion_device *dev =3D internal_dev;
>  	struct ion_buffer *buffer =3D NULL;
> @@ -396,23 +396,22 @@ static int ion_alloc(size_t len, unsigned int heap_=
id_mask, unsigned int flags)
>  	int fd;
>  	struct dma_buf *dmabuf;
> =20
> -	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
> -		 len, heap_id_mask, flags);
> -	/*
> -	 * traverse the list of heaps available in this system in priority
> -	 * order.  If the heap type is supported by the client, and matches the
> -	 * request of the caller allocate from it.  Repeat until allocate has
> -	 * succeeded or all heaps have been tried
> -	 */
> +	pr_debug("%s: len %zu heap_id %u flags %x\n", __func__,
> +		 len, heap_id, flags);
> +
>  	len =3D PAGE_ALIGN(len);
> =20
>  	if (!len)
>  		return -EINVAL;
> =20
> +	/*
> +	 * Traverse the list of heaps available in this system.  If the
> +	 * heap id matches the request of the caller allocate from it.
> +	 */
>  	down_read(&dev->lock);
>  	plist_for_each_entry(heap, &dev->heaps, node) {
>  		/* if the caller didn't specify this heap id */
> -		if (!((1 << heap->id) & heap_id_mask))
> +		if (heap->id !=3D heap_id)
>  			continue;
>  		buffer =3D ion_buffer_create(heap, dev, len, flags);
>  		if (!IS_ERR(buffer))

You can break unconditionally here now, though it might be neater to
refactor to:

 if (heap matches) {
	buffer =3D alloc();
	break;
 }

> @@ -541,7 +540,7 @@ static long ion_ioctl(struct file *filp, unsigned int=
 cmd, unsigned long arg)
>  		int fd;
> =20
>  		fd =3D ion_alloc(data.allocation.len,
> -			       data.allocation.heap_id_mask,
> +			       data.allocation.heap_id,
>  			       data.allocation.flags);
>  		if (fd < 0)
>  			return fd;
> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android=
/uapi/ion.h
> index 5d7009884c13..6a78a1e23251 100644
> --- a/drivers/staging/android/uapi/ion.h
> +++ b/drivers/staging/android/uapi/ion.h
> @@ -35,8 +35,6 @@ enum ion_heap_type {
>  			       */
>  };
> =20
> -#define ION_NUM_HEAP_IDS		(sizeof(unsigned int) * 8)
> -
>  /**
>   * allocation flags - the lower 16 bits are used by core ion, the upper =
16
>   * bits are reserved for use by the heaps themselves.
> @@ -59,7 +57,7 @@ enum ion_heap_type {
>  /**
>   * struct ion_allocation_data - metadata passed from userspace for alloc=
ations
>   * @len:		size of the allocation
> - * @heap_id_mask:	mask of heap ids to allocate from
> + * @heap_id:		heap id to allocate from
>   * @flags:		flags passed to heap
>   * @handle:		pointer that will be populated with a cookie to use to
>   *			refer to this allocation

Just noticed @handle should be @fd, if you're brewing another
clean-up series.

Cheers,
-Brian

> @@ -68,7 +66,7 @@ enum ion_heap_type {
>   */
>  struct ion_allocation_data {
>  	__u64 len;
> -	__u32 heap_id_mask;
> +	__u32 heap_id;
>  	__u32 flags;
>  	__u32 fd;
>  	__u32 unused;
> --=20
> 2.19.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
