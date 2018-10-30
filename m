Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE83C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="P7h8Ry+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJ3Uua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:50:30 -0400
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:59392
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbeJ3Uu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLaoJJrkUA8xlSSTS+i1eMRo/r5/YchYBIwQV33gl6A=;
 b=P7h8Ry+zDHkn3uIjklE/sQt3z8iN/yzP1UIAY8vDa+MUNyQhoEKZ1b5X2LMkwK/h7DP1JhtsIQmHWZAMOdTmNK5b0EsYk/BcyubyeNKuG6p4wl78vXZDw/4aViqSIrs5HFCfFyAL9cbfhcNXm6RPdTOC6WQ7c08yKnnACMrFz70=
Received: from DM6PR07MB4619.namprd07.prod.outlook.com (20.176.80.12) by
 DM6PR07MB5433.namprd07.prod.outlook.com (20.176.113.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Tue, 30 Oct 2018 11:56:23 +0000
Received: from DM6PR07MB4619.namprd07.prod.outlook.com
 ([fe80::a4f7:1ac9:1da3:7108]) by DM6PR07MB4619.namprd07.prod.outlook.com
 ([fe80::a4f7:1ac9:1da3:7108%2]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 11:56:23 +0000
From:   "Srikanth, Jampala" <Jampala.Srikanth@cavium.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "Gadam, Sreerama" <Sreerama.Gadam@cavium.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: cavium/nitrox - fix a DMA pool free failure
Thread-Topic: [PATCH] crypto: cavium/nitrox - fix a DMA pool free failure
Thread-Index: AQHUZ0XPRlFzQSTmZE6DYFY0Ifdjz6U2nmuAgAEU/uc=
Date:   Tue, 30 Oct 2018 11:56:23 +0000
Message-ID: <BYAPR07MB46140E96ED4162B33655480BF4CC0@BYAPR07MB4614.namprd07.prod.outlook.com>
References: <1539910247-9250-1-git-send-email-wang6495@umn.edu>,<CAAa=b7eOM+NPNxaanw-mK-i05UfQ7uhCsN2ViiSoe0_YB-ppyA@mail.gmail.com>
In-Reply-To: <CAAa=b7eOM+NPNxaanw-mK-i05UfQ7uhCsN2ViiSoe0_YB-ppyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
x-originating-ip: [115.113.156.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR07MB5433;6:R4fOHDXBgJBEOd6yAnF1xfB/wCqUc8Dzmbt5CJDOFAFTFH9inYaOWHnQisCR/VEu1qUqoRSEDxPXj1/twu8QqvnB79pVFmk0c5uCJyBpbq4EcSIzyJYMP250/BnfqjK4NDZtlf+wPhdiHnOWokj46qVevuz9uw0/PAzMCGpsU+Nzbcal70GhKa4S4kKsIc0KXFMxOABRb1hlrJsTV4HXahuu5JFINSBVi29vhcWh+rLgKncTf6GB8aWvTDu64lpjJI7bjPSxlnO917rAq8yfrGPpe28wQY3cqVUG02i5cfbsVvy/qexK31x/vtpfKMtl4f7Z08Ne3A+D9HW+PiAUbuouN+O5xFoIRJew5CvzuiM+3eaJ+cfbALIO4zYaHanlKxqULjOxcuIp8u0oowx730SVp+w54Pf3qZZHMys7ZEKiVqao2GpZuHJ9OnnAGKEg8l6cf85WrtoQU5x9iHgIVg==;5:dC/YxHHan9ACbDvLEkYuEXU5sZ5Y5oY4kwwSi1w7dKjXSC2JWsRihGfCFbNCMfAmRT8IgHQJQShY3lq8dyCT5CJLWixyyJISWs9pLM0wavpHkqCUIcpZFPYs9vmiry8o+W693USaaR5G7/DmMvTKQJUoAcBPcLP2lFQlqSQlcJc=;7:X4ObLt2euZ/fDBR6wCB654RRKt6PkaPWkFuORGqFMKSnHOiDUhn8fXBd1X32xw5p5i9qAZqAAK1mVkwhc3wh6LxX6DvToPj7L6Wz7RkEMB9kkjkWgtgbbDJmDAKTH/13Xrkf8lpcDPgzijtAlmLttA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(51914003)(189003)(199004)(53936002)(105586002)(86362001)(54906003)(26005)(97736004)(71200400001)(6116002)(229853002)(39060400002)(102836004)(6246003)(106356001)(2900100001)(575784001)(5250100002)(55236004)(53546011)(6506007)(7736002)(74316002)(316002)(186003)(33656002)(305945005)(2171002)(8936002)(72206003)(66066001)(14444005)(14454004)(6512007)(486006)(476003)(256004)(25786009)(76176011)(71190400001)(9686003)(4326008)(8676002)(6436002)(6486002)(11346002)(478600001)(68736007)(2906002)(6916009)(5660300001)(446003)(81166006)(3846002)(7416002)(99286004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5433;H:DM6PR07MB4619.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 87545d22-de67-4ba7-99e5-08d63e5eb6e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB5433;
x-ms-traffictypediagnostic: DM6PR07MB5433:
x-microsoft-antispam-prvs: <DM6PR07MB5433DF7ED85F136DA48A326EF4CC0@DM6PR07MB5433.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB5433;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5433;
x-forefront-prvs: 08417837C5
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uNMiTczxWqmpGysxOEd0Qk5ZSofdNtz7V51k0SvBqLl34Lyy3KdZeENI3vt5BHHQwiBx4CPv6J6jfZa5OLtykXZ6VzUePS4SW4DLOW8M4xp2obDMXuxyWQbcX7QSjw3knwaCIUHP1TgzYOlrjeXFDVQ7zEXUg1MJMXLnv5cOPjToJY0tyUo+gNwtdTSeeU/VA+GDjMZ1fnAOEgTqb7ykK0TaWyoizukgh4bMVDcZRPmHDDOW0jlMwCcZJnxMMf52alsaT/0P8VxmLSH7UVwoOEurFnoi+FF/opmlGHzqFfeDQzf3VgMDXSAXIqtajhx0t1nS+tIjHGUsc61sBmtf2aQpowaGHPgQF+flG78aRDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87545d22-de67-4ba7-99e5-08d63e5eb6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 11:56:23.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

Thanks for the patch. We can't think of any such scenarios,=20
 where our device can corrupt meta data of the given context pointer as per=
 our usage in the device.=20
But having meta data in separate pointer prevents unexpected behavior.=20

Thanks
srikanth

________________________________________
From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.or=
g> on behalf of Wenwen Wang <wang6495@umn.edu>
Sent: Tuesday, October 30, 2018 12:07 AM
To: Wenwen Wang
Cc: Kangjie Lu; herbert@gondor.apana.org.au; David S. Miller; kstewart@linu=
xfoundation.org; tglx@linutronix.de; pombredanne@nexb.com; Greg Kroah-Hartm=
an; baijiaju1990@gmail.com; Srikanth, Jampala; Gadam, Sreerama; linux-crypt=
o@vger.kernel.org; open list
Subject: Re: [PATCH] crypto: cavium/nitrox - fix a DMA pool free failure

External Email

Hello,

Can anyone confirm this bug? Thanks!

Wenwen

On Thu, Oct 18, 2018 at 7:51 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In crypto_alloc_context(), a DMA pool is allocated through dma_pool_alloc=
()
> to hold the crypto context. The meta data of the DMA pool, including the
> pool used for the allocation 'ndev->ctx_pool' and the base address of the
> DMA pool used by the device 'dma', are then stored to the beginning of th=
e
> pool. These meta data are eventually used in crypto_free_context() to fre=
e
> the DMA pool through dma_pool_free(). However, given that the DMA pool ca=
n
> also be accessed by the device, a malicious device can modify these meta
> data, especially when the device is controlled to deploy an attack. This
> can cause an unexpected DMA pool free failure.
>
> To avoid the above issue, this patch introduces a new structure
> crypto_ctx_hdr and a new field chdr in the structure nitrox_crypto_ctx ho=
ld
> the meta data information of the DMA pool after the allocation. Note that
> the original structure ctx_hdr is not changed to ensure the compatibility=
.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_algs.c | 12 +++++++-----
>  drivers/crypto/cavium/nitrox/nitrox_lib.c  | 22 +++++++++++++++++-----
>  drivers/crypto/cavium/nitrox/nitrox_req.h  |  7 +++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_algs.c b/drivers/crypto/=
cavium/nitrox/nitrox_algs.c
> index 2ae6124..5d54ebc 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_algs.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_algs.c
> @@ -73,7 +73,7 @@ static int flexi_aes_keylen(int keylen)
>  static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
>  {
>         struct nitrox_crypto_ctx *nctx =3D crypto_skcipher_ctx(tfm);
> -       void *fctx;
> +       struct crypto_ctx_hdr *chdr;
>
>         /* get the first device */
>         nctx->ndev =3D nitrox_get_first_device();
> @@ -81,12 +81,14 @@ static int nitrox_skcipher_init(struct crypto_skciphe=
r *tfm)
>                 return -ENODEV;
>
>         /* allocate nitrox crypto context */
> -       fctx =3D crypto_alloc_context(nctx->ndev);
> -       if (!fctx) {
> +       chdr =3D crypto_alloc_context(nctx->ndev);
> +       if (!chdr) {
>                 nitrox_put_device(nctx->ndev);
>                 return -ENOMEM;
>         }
> -       nctx->u.ctx_handle =3D (uintptr_t)fctx;
> +       nctx->chdr =3D chdr;
> +       nctx->u.ctx_handle =3D (uintptr_t)((u8 *)chdr->vaddr +
> +                                        sizeof(struct ctx_hdr));
>         crypto_skcipher_set_reqsize(tfm, crypto_skcipher_reqsize(tfm) +
>                                     sizeof(struct nitrox_kcrypt_request))=
;
>         return 0;
> @@ -102,7 +104,7 @@ static void nitrox_skcipher_exit(struct crypto_skciph=
er *tfm)
>
>                 memset(&fctx->crypto, 0, sizeof(struct crypto_keys));
>                 memset(&fctx->auth, 0, sizeof(struct auth_keys));
> -               crypto_free_context((void *)fctx);
> +               crypto_free_context((void *)nctx->chdr);
>         }
>         nitrox_put_device(nctx->ndev);
>
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/c=
avium/nitrox/nitrox_lib.c
> index 4d31df0..28baf1a 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
> @@ -146,12 +146,19 @@ static void destroy_crypto_dma_pool(struct nitrox_d=
evice *ndev)
>  void *crypto_alloc_context(struct nitrox_device *ndev)
>  {
>         struct ctx_hdr *ctx;
> +       struct crypto_ctx_hdr *chdr;
>         void *vaddr;
>         dma_addr_t dma;
>
> +       chdr =3D kmalloc(sizeof(*chdr), GFP_KERNEL);
> +       if (!chdr)
> +               return NULL;
> +
>         vaddr =3D dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO=
), &dma);
> -       if (!vaddr)
> +       if (!vaddr) {
> +               kfree(chdr);
>                 return NULL;
> +       }
>
>         /* fill meta data */
>         ctx =3D vaddr;
> @@ -159,7 +166,11 @@ void *crypto_alloc_context(struct nitrox_device *nde=
v)
>         ctx->dma =3D dma;
>         ctx->ctx_dma =3D dma + sizeof(struct ctx_hdr);
>
> -       return ((u8 *)vaddr + sizeof(struct ctx_hdr));
> +       chdr->pool =3D ndev->ctx_pool;
> +       chdr->dma =3D dma;
> +       chdr->vaddr =3D vaddr;
> +
> +       return chdr;
>  }
>
>  /**
> @@ -168,13 +179,14 @@ void *crypto_alloc_context(struct nitrox_device *nd=
ev)
>   */
>  void crypto_free_context(void *ctx)
>  {
> -       struct ctx_hdr *ctxp;
> +       struct crypto_ctx_hdr *ctxp;
>
>         if (!ctx)
>                 return;
>
> -       ctxp =3D (struct ctx_hdr *)((u8 *)ctx - sizeof(struct ctx_hdr));
> -       dma_pool_free(ctxp->pool, ctxp, ctxp->dma);
> +       ctxp =3D ctx;
> +       dma_pool_free(ctxp->pool, ctxp->vaddr, ctxp->dma);
> +       kfree(ctxp);
>  }
>
>  /**
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_req.h b/drivers/crypto/c=
avium/nitrox/nitrox_req.h
> index d091b6f..19f0a20 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_req.h
> +++ b/drivers/crypto/cavium/nitrox/nitrox_req.h
> @@ -181,12 +181,19 @@ struct flexi_crypto_context {
>         struct auth_keys auth;
>  };
>
> +struct crypto_ctx_hdr {
> +       struct dma_pool *pool;
> +       dma_addr_t dma;
> +       void *vaddr;
> +};
> +
>  struct nitrox_crypto_ctx {
>         struct nitrox_device *ndev;
>         union {
>                 u64 ctx_handle;
>                 struct flexi_crypto_context *fctx;
>         } u;
> +       struct crypto_ctx_hdr *chdr;
>  };
>
>  struct nitrox_kcrypt_request {
> --
> 2.7.4
>
