Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C24B20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="py5ZBkjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C24B20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeHTP2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:28:40 -0400
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:7296
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbeHTP2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQvGObMtKr78bBYSiDrhdvicLR9EBW760xEuHXTGpJc=;
 b=py5ZBkjx1vtLLL80R2SEJ8+YeEkpJ/ceW0sdTDjnqY5F9Se7AgkdZJTlOQyuGMM+AKZ1Mv+4Fle7juqYXQShPdfLwzkjxvkBUT6YkKU8oiF3tZEs7yYq7E7HcgxKTtTF7MDWNwP/7f/kcMhmu5BYMLFtamOH5wcVlcojkL7C7xI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB491.namprd06.prod.outlook.com (10.141.197.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Mon, 20 Aug 2018 12:13:12 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 12:13:11 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move bad block and chunk state logic to core
Thread-Topic: [PATCH] lightnvm: move bad block and chunk state logic to core
Thread-Index: AQHUNhuJZ/YeWZWFpUGuV7gcrs5rtKTIkhYA
Date:   Mon, 20 Aug 2018 12:13:11 +0000
Message-ID: <7189DEC2-B080-4ADB-85B6-0FCED1796FAE@cnexlabs.com>
References: <20180817111442.15827-1-mb@lightnvm.io>
In-Reply-To: <20180817111442.15827-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB491;6:qhmva1nJMbKLBUoGoGANEGe+uFMbXsc8AQp5Tmqxd8Vl21Wv3xJNC1PS33DnN9mmLDXbuu4G7+Tyw/2gTBZraVxlMBUKiTedPQhHjoZ1X6q826fth/hbrF29rc6OSSzjgeHTjF5umA213GiSc4mP4aCxeIEZ4u12MMB6uS0u5yCvbkfDCO9JqBkYRUyboiO0ea3jFl8Q3ljuFOKcBaUJvG6eb35mGzVDICUqZIdTZHbQCBsjXy79dUhzEMP4Ks/km6SUXmL40OYxeNM8tI8qIFLsnTssr9BJrNn+iz7Ji57/e3mvmK3sf8Os4IFtuzIvFom8jAYIVBZhoHPX0VNNHu0sntbc15Or0+YIUMbfROc947pD8q4FYtdRnbNrvSO/mwlV9SZy/68SnqzVYIKYy5QgiH+8CJWZ//KRB6wBSqd0g04Ohbzr5ygwOriYXzCfH9VvYBr1REz1WgOBCvqqNQ==;5:p1aTIcs9Wug+LmJ/pgCNftv9NC+/ZcsmU8FTx2esCPamJV9yvqD7OMQNNedKcA0aisBUJ/hWEpOl1YCZqrXOP/+MNTbGCpZKUtiE+J4mC6dIefeqp+7g/oqDLz9TEWjx0nm6nihQa7JbLe4EzmhhQSZA9sYVdciYa9mn/NszPCc=;7:LhyBRkfTQue2bnMWDLlfUXYPm9K2+eIQCGc18VbGH1VAtqRguzcAMIvYgfLy2jJ1e0qRk1oVBf7+oC5LJPVg100/WC9NYd2HPURLiFqVoXvVd9DK1SarYicXwtcSV9l6/TJh5+F+LhPmgdwvuaeiVFvh4jwCPizlSRokA06qg7rU+yRhsK1zZd+jgJixkUkWIXxoa5Yebb+SVkbJSswh50cFeDTp2jmpfROeoOlvGb7teQxBiuTMLsF6Lm7S20Cf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39830400003)(376002)(366004)(396003)(136003)(199004)(189003)(2900100001)(105586002)(68736007)(8676002)(33656002)(5660300001)(6246003)(14454004)(83716003)(106356001)(102836004)(81156014)(6916009)(6506007)(8936002)(14444005)(256004)(478600001)(82746002)(26005)(186003)(76176011)(6436002)(66066001)(97736004)(6486002)(81166006)(316002)(86362001)(3846002)(6116002)(25786009)(36756003)(53936002)(2906002)(4326008)(446003)(99286004)(2616005)(11346002)(7736002)(305945005)(99936001)(476003)(54906003)(486006)(5250100002)(229853002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB491;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f221d742-6f5c-4554-475e-08d606964c75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB491;
x-ms-traffictypediagnostic: CO2PR06MB491:
x-microsoft-antispam-prvs: <CO2PR06MB49180B19EF6C121897530A7BA320@CO2PR06MB491.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB491;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB491;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: udO9n9zz5fX4v0Q5b7HHdd8Kf3CAPt6zWbZWu0rtyLQUIhRi1tzt9g+KJw8vlvSuYzuX8RWCibPHvK1mi42w+qYGBYbdZFP/0/wj4YHLprmADoa8aEhc+zv7jWlOKFGnNAfP3+4o5H0tvyx4cHUo8xFsTgMDKFUbyTSKE8MX3RcH6PP8eaKTbS7UiwE/MNYaf5ZMynWBAv9W8V4eMCmIMJ/MQjDTO24anMhRQH2AT4+FsdHKfc+2CP3heRcUpzULxBrBj+sM91gU+76RH6rkvJCR0lLjwlD2POT3AlznozvC1NEbxEA1j1a3PMGlWLee6pNKgtS3YS7jFDlivznWAR6sIfVaN5mFbeWjKIcUNhY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f221d742-6f5c-4554-475e-08d606964c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 12:13:11.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> pblk implements two data paths for recovery line state. One for 1.2
> and another for 2.0, instead of having pblk implement these, combine
> them in the core to reduce complexity and make available to other
> targets.
>=20
> The new interface will adhere to the 2.0 chunk definition,
> including managing open chunks with an active write pointer. To =
provide
> this interface, a 1.2 device recovers the state of the chunks by
> manually detecting if a chunk is either free/open/close/offline, and =
if
> open, scanning the flash pages sequentially to find the next writeable
> page. This process takes on average ~10 seconds on a device with 64 =
dies,
> 1024 blocks and 60us read access time. The process can be parallelized
> but is left out for maintenance simplicity, as the 1.2 specification =
is
> deprecated. For 2.0 devices, the logic is maintained internally in the
> drive and retrieved through the 2.0 interface.

A couple of things from closer review.

>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c      | 310 =
+++++++++++++++++++++++++++++++++++--------
> drivers/lightnvm/pblk-core.c |   6 +-
> drivers/lightnvm/pblk-init.c | 116 +---------------
> drivers/lightnvm/pblk.h      |   2 +-
> drivers/nvme/host/lightnvm.c |   4 +-
> include/linux/lightnvm.h     |  15 +--
> 6 files changed, 266 insertions(+), 187 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 964352720a03..003fc073f496 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -717,46 +717,6 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
> 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
> }
>=20
> -int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct =
nvm_chk_meta *meta,
> -		struct ppa_addr ppa, int nchks)
> -{
> -	struct nvm_dev *dev =3D tgt_dev->parent;
> -
> -	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
> -
> -	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
> -						(sector_t)ppa.ppa, =
nchks);
> -}
> -EXPORT_SYMBOL(nvm_get_chunk_meta);
> -
> -int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr =
*ppas,
> -		       int nr_ppas, int type)
> -{
> -	struct nvm_dev *dev =3D tgt_dev->parent;
> -	struct nvm_rq rqd;
> -	int ret;
> -
> -	if (nr_ppas > NVM_MAX_VLBA) {
> -		pr_err("nvm: unable to update all blocks atomically\n");
> -		return -EINVAL;
> -	}
> -
> -	memset(&rqd, 0, sizeof(struct nvm_rq));
> -
> -	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
> -	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
> -
> -	ret =3D dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, =
type);
> -	nvm_free_rqd_ppalist(tgt_dev, &rqd);
> -	if (ret) {
> -		pr_err("nvm: failed bb mark\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
> -
> static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
> {
> 	int flags =3D 0;
> @@ -830,27 +790,159 @@ void nvm_end_io(struct nvm_rq *rqd)
> }
> EXPORT_SYMBOL(nvm_end_io);
>=20
> +static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> +{
> +	if (!dev->ops->submit_io_sync)
> +		return -ENODEV;
> +
> +	rqd->flags =3D nvm_set_flags(&dev->geo, rqd);
> +
> +	return dev->ops->submit_io_sync(dev, rqd);
> +}
> +
> +static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr =
ppa)
> +{
> +	struct nvm_rq rqd =3D { NULL };
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct page *page;
> +	int ret;
> +
> +	page =3D alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +
> +	rqd.bio =3D &bio;
> +	rqd.opcode =3D NVM_OP_PREAD;
> +	rqd.is_seq =3D 1;
> +	rqd.nr_ppas =3D 1;
> +	rqd.ppa_addr =3D generic_to_dev_addr(dev, ppa);
> +
> +	ret =3D nvm_submit_io_sync_raw(dev, &rqd);
> +	if (ret)
> +		return ret;
> +
> +	__free_page(page);
> +
> +	return rqd.error;
> +}
> +
> /*
> - * folds a bad block list from its plane representation to its =
virtual
> - * block representation. The fold is done in place and reduced size =
is
> - * returned.
> + * Scans a 1.2 chunk first and last page to determine if its state.
> + * If the chunk is found to be open, also scan it to update the write
> + * pointer.
> + */
> +static int nvm_bb_scan_chunk(struct nvm_dev *dev, struct ppa_addr =
ppa,
> +			     struct nvm_chk_meta *meta)

Keeping some name consistency would help nvm_bb_chunk_*

> [...]

> +
> +static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
> +			   int nchks, struct nvm_chk_meta *meta)
> +{
> +	struct nvm_geo *geo =3D &dev->geo;
> +	struct ppa_addr ppa;
> +	u8 *blks;
> +	int ch, lun, nr_blks;
> +	int ret;
> +
> +	ppa.ppa =3D slba;
> +	ppa =3D dev_to_generic_addr(dev, ppa);
> +
> +	if (ppa.g.blk !=3D 0)
> +		return -EINVAL;
> +
> +	if ((nchks % geo->num_chk) !=3D 0)
> +		return -EINVAL;
> +
> +	nr_blks =3D geo->num_chk * geo->pln_mode;
> +
> +	blks =3D kmalloc(nr_blks, GFP_KERNEL);
> +	if (!blks)
> +		return -ENOMEM;
> +
> +	for (ch =3D ppa.g.ch; ch < geo->num_ch; ch++) {
> +		for (lun =3D ppa.g.lun; lun < geo->num_lun; lun++) {
> +			struct ppa_addr ppa_gen, ppa_dev;
> +
> +			if (!nchks)
> +				goto out;

You should free blks here too.

> +
> +			ppa_gen.ppa =3D 0;
> +			ppa_gen.a.ch =3D ch;
> +			ppa_gen.a.lun =3D lun;
> +			ppa_dev =3D generic_to_dev_addr(dev, ppa_gen);
> +
> +			ret =3D dev->ops->get_bb_tbl(dev, ppa_dev, =
blks);
> +			if (ret)
> +				goto err;
> +
> +			ret =3D nvm_bb_to_chunk(dev, ppa_gen, blks, =
nr_blks,
> +									=
meta);
> +			if (ret)
> +				goto err;
> +
> +			meta +=3D geo->num_chk;
> +			nchks -=3D geo->num_chk;
> +		}
> +	}
> +out:
> +	return 0;
> +err:
> +	kfree(blks);
> +	return ret;
> }
> -EXPORT_SYMBOL(nvm_bb_tbl_fold);
>=20
> -int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr =
ppa,
> -		       u8 *blks)
> [...]



--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6sFIACgkQIX4xUKFR
nnQgWQ/7Bz+ogN7IUZQfo6nVTiiznWd9w3Jc/8LMjduCOBHTg1GQYL/2EKjSKhWx
nNSkuZDdZvo9kw7GJCIgMTn49t6HfEQ+9MN9LNYkzUwoN+p3YS5NnfUOMVGwiLKX
Viuzyq0Ld8mIMn9OM6ym9SBAlmBvjsdV5J5bVJp8baLLCYca6kgwu2jwH0QSDEni
e4qpcvn7RmekWlz8eUdjnjg38KxvZJ3uXlFxS+pGHhQIio6l/gUMTFzGcjfTc8sk
Y5AqqsAhDYEJpJbhMMlPHPtpURWlJevuYpNNwRSd0pl+tFZRH0ojL7EBwZWa0M5/
/V3dsYK+TQQDUb7oTzZGkxK8ysSryrvJYLN5HMDStBX7st6R7yTuZ3D+alxHGoPf
HlO6roU7TX7VJlOlB8BY0/65EYDU3x0Yox5Ykc3TrBv/dpBDDC+enlO379imxLRX
oSpWy2EWhb0QCSKKvuSkPZ8I4gWo2UZQzTJmKklEiBSLjnfF1u+i+wytxokAORiu
6RHKlCTcanPHKtutVWeOLnNwdrrVzibuebBXG3LbOIkJsDUFFtnWvoM1QL3fPHFf
g5OwxJYqxJ2V70yjALTXcHQuQpIvjaPy+ch6jqRWHIuRv0BPCQnFeWMAKpxotfn0
3PIYqooyUIB1dfp26Pznrt1uGPxxPuOuTIHAa+45n+KpBScuDA8=
=GhgV
-----END PGP SIGNATURE-----

--Apple-Mail=_C34A3629-1772-4BB7-93AB-B8FEC1A5F9F7--
