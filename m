Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F403C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D894A214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UeQNdU3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfAIIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:53:05 -0500
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:46720
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfAIIxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS4R+BNUqfs3zQAMMUM7oULd5AX+q/TG0fjlcbdhHrY=;
 b=UeQNdU3jis62UBMHcrEe4/Ol1/XdWWotOCXU9fmKj1zbSswH5E4c1aAluWUR8JXsrTr3u/Sb/rYT5Fx0ECJE3tfmCOHWoRovdYfNwJS9zsWCsvJ97nlJQfe6XzosGHBK2+Ck3ZiFOnA52CQJ/WW8CwUk+9EGbgy5+cnslCq0m6w=
Received: from BN7PR02MB5124.namprd02.prod.outlook.com (20.176.26.153) by
 BN7PR02MB5011.namprd02.prod.outlook.com (20.176.26.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 08:53:01 +0000
Received: from BN7PR02MB5124.namprd02.prod.outlook.com
 ([fe80::175:2887:46e7:513f]) by BN7PR02MB5124.namprd02.prod.outlook.com
 ([fe80::175:2887:46e7:513f%3]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:53:00 +0000
From:   Kalyani Akula <kalyania@xilinx.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sarat Chand Savitala <saratcha@xilinx.com>
Subject: RE: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
Thread-Topic: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
Thread-Index: AQHUpmfcxm+4/gz710S4EoKSNaMNSqWjlmKAgAGB9vA=
Date:   Wed, 9 Jan 2019 08:53:00 +0000
Message-ID: <BN7PR02MB5124F96B9291015478AC8F85AF8B0@BN7PR02MB5124.namprd02.prod.outlook.com>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
 <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
 <20190107101313.GA17747@Red>
In-Reply-To: <20190107101313.GA17747@Red>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kalyania@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR02MB5011;6:6nJTPsp8qZMrjjlkt9iQB2hZhGdk4Mnw/Zb+MQZdG31GNHQgbnWprdQNd/U4dUom7tZ2UCAF/YCGR21N6Rc6Mi4lcDVe89xbEpKhrT5KgTwXAgRrwjM9rTo/vojYBsVzIh87hhdyYIDG20TENPTqeAF0leq4LajRpW0VlB1Ulu9a4sHio+TpTzgy3rWeReHC92VbptSauwdrVJuRmaN65FpKP/zGBaLfSeNka2JMDXV6lpp+Ohz6yy+RYfBFJxoGWofdEEnzsGPwf2/xkFOQKMYG9uziknJTRv+716T23p4Xz+CVBGJ1fRaV9GGIJvtFkEEyjsuvQBG6k12KbCyDfRqY7CP2cd+Wa4OXfeV+OR/j6+HYH2nWULV+a1aplhMHeayJxRcWqesZzoo0BwaqmKqMCHDp6cgv6qE/iMnJxBJXH/hDAjlMc0eqdi39xmZiZpGh/ENBIL+5oOpFH0O1kQ==;5:aOw3qbA+G+6h6MCQeDzsoA2wqHIp92htqLL+NOZPy+/VgSB/2TKNdpdkYy3UqVtuLBcHFg8BDsp5Zyo52xPpu8jU9wouXeubtb6b564qghvACNRtR8cPZq3r9TCECVz5f4RMq4zlcHagQjg9+1xoSXk7dbR3av8hJXpi7jUygbcgKWmf7ihb9+qKOG0+Ixlpgk4rkCwWJI7Txf9CAoilpw==;7:XD+BbFDc5lWoQjZ8xkEJxnrwlXd37LQyMjBeA5Ght1Xussl7hmFS7pwk9NI7fl7TBH/K6PwdBFUXM+fd2/Z/KRLeblcN2HOqAHXJFKXffCX9lFQN2jR2dYDu/ZNysZfJYyXdfElogkthWZDZ/L1yDA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(13464003)(199004)(189003)(51914003)(217873002)(74316002)(316002)(97736004)(107886003)(6506007)(53546011)(8936002)(186003)(66066001)(26005)(81166006)(55016002)(81156014)(256004)(14444005)(3846002)(6116002)(8676002)(99286004)(6916009)(54906003)(2906002)(76176011)(7696005)(39060400002)(7736002)(9686003)(105586002)(6436002)(86362001)(71190400001)(71200400001)(106356001)(305945005)(478600001)(11346002)(446003)(102836004)(6246003)(53936002)(476003)(486006)(68736007)(14454004)(4326008)(5660300001)(229853002)(33656002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5011;H:BN7PR02MB5124.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 552449c4-2caa-4e79-64e7-08d6760fdbbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR02MB5011;
x-ms-traffictypediagnostic: BN7PR02MB5011:
x-microsoft-antispam-prvs: <BN7PR02MB5011C1D4EDCC5B12CA0C9DF9AF8B0@BN7PR02MB5011.namprd02.prod.outlook.com>
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3fU+zW/aqefasst1FtKJ3pcG3EJPER7+PnjkuVVZwWJ91KpmGg+N5c003QNm5ZcBhLW7JiC1A+0znocS7ijsAQQE811ALVdel+wC3k7gF81oiF9XRb0Dx/1AyFUuusvJLcMm/QXRj4g9x9iVW3VEnuujZMdjYK1bJrLkwcow1rYvYwJRSGBMj+G9ecajybC3NEgJlth+/FvNKWwNggz3V9sTAgvcXyyeb3SQ/mD2B4jCGonfes7hbbcn7UyAQgae1TSojaJXQsEWpHjFYG4EEVqTyVgI0UdLBKsRJVyJRM147dxLQmgNfoJOrQUHUM6r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552449c4-2caa-4e79-64e7-08d6760fdbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:53:00.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

Thanks for the review,
Please find my response inline.

> -----Original Message-----
> From: Corentin Labbe [mailto:clabbe.montjoie@gmail.com]
> Sent: Monday, January 7, 2019 3:43 PM
> To: Kalyani Akula <kalyania@xilinx.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Kalyani Akula
> <kalyania@xilinx.com>; Sarat Chand Savitala <saratcha@xilinx.com>
> Subject: Re: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
>=20
> On Mon, Jan 07, 2019 at 02:32:55PM +0530, Kalyani Akula wrote:
> > This patch adds SHA3 driver suuport for the Xilinx ZynqMP SoC.
> >
> > Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
>=20
> Hello
>=20
> I have some comment below
>=20
> > +static int zynqmp_sha_init(struct ahash_request *req) {
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +	struct zynqmp_sha_reqctx *ctx =3D ahash_request_ctx(req);
> > +	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
> > +	struct zynqmp_sha_ctx *tctx =3D crypto_ahash_ctx(tfm);
> > +	struct zynqmp_sha_dev *dd =3D NULL;
> > +	struct zynqmp_sha_dev *tmp;
> > +	int ret;
> > +
> > +	if (!eemi_ops || !eemi_ops->sha_hash)
> > +		return -ENOTSUPP;
> > +
>=20
> Where can I find sha_hash() ?
> It seems that your serie miss some patchs.

This API should go into drivers/firmware/xilinx/zynqmp.c file. Will send fi=
x and send next version.
I was in assumption that the above driver is not in main-line as it was sen=
t as drivers/firmware/Xilinx/zynqmp/firmware.c initially and renamed later =
to zynqmp.c.

>=20
> > +	spin_lock_bh(&zynqmp_sha.lock);
> > +	if (!tctx->dd) {
> > +		list_for_each_entry(tmp, &zynqmp_sha.dev_list, list) {
> > +			dd =3D tmp;
> > +			break;
> > +		}
> > +		tctx->dd =3D dd;
> > +	} else {
> > +		dd =3D tctx->dd;
> > +	}
> > +	spin_unlock_bh(&zynqmp_sha.lock);
> > +
> > +	ctx->dd =3D dd;
> > +	dev_dbg(dd->dev, "init: digest size: %d\n",
> > +		crypto_ahash_digestsize(tfm));
> > +
> > +	ret =3D eemi_ops->sha_hash(0, 0, ZYNQMP_SHA3_INIT);
> > +
> > +	return ret;
> > +}
> > +
> > +static int zynqmp_sha_update(struct ahash_request *req) {
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +	struct zynqmp_sha_ctx *tctx =3D crypto_tfm_ctx(req->base.tfm);
> > +	struct zynqmp_sha_dev *dd =3D tctx->dd;
> > +	size_t dma_size =3D req->nbytes;
> > +	dma_addr_t dma_addr;
> > +	char *kbuf;
> > +	int ret;
> > +
> > +	if (!req->nbytes)
> > +		return 0;
> > +
> > +	if (!eemi_ops || !eemi_ops->sha_hash)
> > +		return -ENOTSUPP;
> > +
> > +	kbuf =3D dma_alloc_coherent(dd->dev, dma_size, &dma_addr,
> GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
> > +	 __flush_cache_user_range((unsigned long)kbuf,
> > +				  (unsigned long)kbuf + dma_size);
> > +	ret =3D eemi_ops->sha_hash(dma_addr, req->nbytes,
> ZYNQMP_SHA3_UPDATE);
>=20
> Even with the sha_hash prototype missing, I think your driver have a
> problem:
> You support having more than one device, but sha_hash lacks any reference
> on the device doing the request.

Actually this is taken care using PM API id's by which the request is ident=
ified in the firmware (platform management unit (PMU-FW)) and sent to speci=
fic HW engine.=20
The ID specific to SHA3 engine will be added include/linux/firmware/xlnx-zy=
nqmp.h in the next version.=20

>=20
> > +static int zynqmp_sha_final(struct ahash_request *req) {
> > +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> > +	struct zynqmp_sha_ctx *tctx =3D crypto_tfm_ctx(req->base.tfm);
> > +	struct zynqmp_sha_dev *dd =3D tctx->dd;
> > +	size_t dma_size =3D SHA384_DIGEST_SIZE;
> > +	dma_addr_t dma_addr;
> > +	char *kbuf;
> > +	int ret;
> > +
> > +	if (!eemi_ops || !eemi_ops->sha_hash)
> > +		return -ENOTSUPP;
> > +
> > +	kbuf =3D dma_alloc_coherent(dd->dev, dma_size, &dma_addr,
> GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	ret =3D eemi_ops->sha_hash(dma_addr, dma_size,
> ZYNQMP_SHA3_FINAL);
> > +	memcpy(req->result, kbuf, 48);
>=20
> It is better to use SHA384_DIGEST_SIZE instead of 48

Will fix in the next version.

>=20
> [...]
> > +static int zynqmp_sha_probe(struct platform_device *pdev) {
> > +	struct zynqmp_sha_dev *sha_dd;
> > +	struct device *dev =3D &pdev->dev;
> > +	int err;
> > +
> > +	sha_dd =3D devm_kzalloc(&pdev->dev, sizeof(*sha_dd),
> GFP_KERNEL);
> > +	if (!sha_dd)
> > +		return -ENOMEM;
> > +
> > +	sha_dd->dev =3D dev;
> > +	platform_set_drvdata(pdev, sha_dd);
> > +	INIT_LIST_HEAD(&sha_dd->list);
> > +	spin_lock_init(&sha_dd->lock);
> > +	crypto_init_queue(&sha_dd->queue,
> ZYNQMP_SHA_QUEUE_LENGTH);
>=20
> You create a queue, but you didnt use it.
>=20
> [...]
> > +	spin_lock(&zynqmp_sha.lock);
> > +	list_add_tail(&sha_dd->list, &zynqmp_sha.dev_list);
> > +	spin_unlock(&zynqmp_sha.lock);
> > +
> > +	err =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(44));
> > +	if (err < 0)
> > +		dev_err(dev, "no usable DMA configuration");
>=20
> It is an error that you ignore, you miss some goto errxxx.
>
Will fix it in the next version.

Regards,
kalyani
=20
> Regards
