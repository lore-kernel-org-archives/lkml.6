Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3626DC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D22083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00D22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeHaP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:57:21 -0400
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com ([104.47.41.66]:21670
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbeHaP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mL7v5U7HsjpPc31Q4hElL07dehrBNtOJ2XgNaKpZXA=;
 b=NPEq6+CrssTDwkNW0WPxe4KU0D+JRJA7NtsKt6ssTONlNSK5BKqoqgvNI0G/c0DXMgud9kN2TKWWAW8QBJIT/ih5dYY+KWSJFgvNI7LIOu+1R2ZmIMvNlOzNiNhNrPmJ6U/VSOKTaiW56JO6Yd5lh7SW1VH1nec9gCbb6m34DBQ=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB666.namprd06.prod.outlook.com (10.141.227.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Fri, 31 Aug 2018 11:50:07 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Fri, 31 Aug 2018
 11:50:06 +0000
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
Thread-Index: AQHUNhuJZ/YeWZWFpUGuV7gcrs5rtKTZ1UiA
Date:   Fri, 31 Aug 2018 11:50:05 +0000
Message-ID: <EED79EDF-8391-4414-8DB6-79BF20B06F51@cnexlabs.com>
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
x-microsoft-exchange-diagnostics: 1;CO2PR06MB666;6:R15lwhSHipiHyNE68lF33S45qc/gdUeay91FQY2032vYMYKVJYJwctwqDSCRHfzNf67KTYtByXCiu7xj5oECJxAVi8FCWAw2MiGtkDFwUsUqImavuzO3Ye+KN7wCDGAzFrW07r0+MMw0P21K0xHN29OUnVoKRyPseLLkawldIK2qE7o6q7VFfM10yxomyE9aQf0ZixiRUf6v/jJFPKh3yA4foGu/Ux1SRAe2xz/eLYJVjiRS4KjoEgTrb7RHnqatYmfJSAl20LEzIVsLRONKHNUCwFQugqRhYWed6fR19ntLOCUsTOV5BMKydXzffwF0oNELCjsx2jfCGj5jmQX/YggmLdSohaIU/1NO8O4dFLnD1n5pBe0AXayZlY0KZ9x46Ocf3p78joE5IXva863Ml7M42zt9D218SLfP13r4dw9rgQ6b1GLhGCMcAaTaP0c3VLoQxc+Ymx/hpuh9FNTwDw==;5:UjJUz3/c8Tze4RcpUapNfAwWFbmd9zIcwsGLYUbIa11OzTAMa2PiokgTUI2E4RtDoHYIZRONPb9cVcRr9SI5wkjWo1Ce+9LG3AMHxqSxw0H+KIb6RdeJsCgGqnj7b8gN3Kh9H8nlCZnNKprdPmFHo+4bmk+jL24jwFS37tK5sYo=;7:7t0tlMwGrNfseNZAv4wx3/hB0UpEQkC0+1zBwNtepRY8lqY4b59TJe7Ihd2BysxAJXYM8PQzTbr1rqCR9mn0EE+B9OoqIdvtLEFicmnBkb0umyGa2SRJ5rlCqgP7mEBx6ujeuA71+NurhRQp4Jzma0eMLFb0cC1bDNUa2npH2K1pHOUq//onpzPQ+TYLPdwNhrhp8h4m8QfMb26Z2B5vX0Vi0bbCfIL+QoHReQH0354NMfoM1sd9nEEqJdgN9NaS
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39840400004)(366004)(396003)(136003)(199004)(189003)(5660300001)(82746002)(4326008)(106356001)(105586002)(97736004)(11346002)(86362001)(446003)(3846002)(6116002)(83716003)(478600001)(14454004)(6246003)(486006)(5250100002)(2616005)(476003)(8676002)(6436002)(229853002)(186003)(2900100001)(6916009)(6486002)(99936001)(14444005)(53936002)(305945005)(26005)(7736002)(6512007)(2906002)(256004)(36756003)(76176011)(68736007)(8936002)(81166006)(99286004)(81156014)(102836004)(25786009)(6506007)(316002)(54906003)(66066001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB666;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: cf6100f7-0643-4421-3beb-08d60f37e51e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB666;
x-ms-traffictypediagnostic: CO2PR06MB666:
x-microsoft-antispam-prvs: <CO2PR06MB6668DD565433071332C611CBA0F0@CO2PR06MB666.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:CO2PR06MB666;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB666;
x-forefront-prvs: 07817FCC2D
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: haCpRrKEQg6mVAbqpHFPsi0YYhihXgwLZeopra9DR3pyNU2CJYcLAzKePYNDaUjoCbKPaUCcfYrUq2mejYuJYJ6PfuN76lYBVkv1kk+HN21OOLKk8EbonaQ4ziu00xZOInOFbqnkeEWu5NAfdxg7WnopXkmf0wbMNwz5luNXNIpnIM494a24KfH9KO9SFeDiJRvog1mD3AYsoVoHphKxMEnDbUWr7+izj5jIGjVVO+TMHM83nV8VOn6QIU6ZR5v3ebwkV1XHa4TQb75BratcB+lLJGVwjohSx/GycaRrz1YW3vQ/MR+AKzPPmDtdvHGJW+za1XqIPqHFFgsWoumCpAkKIOMMOQf9x1wnbLlK8hM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6100f7-0643-4421-3beb-08d60f37e51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 11:50:05.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C
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
> +{
> +	struct nvm_geo *geo =3D &dev->geo;
> +	int ret, pg, pl;
> +
> +	/* sense first page */
> +	ret =3D nvm_bb_chunk_sense(dev, ppa);
> +	if (ret < 0) /* io error */
> +		return ret;
> +	else if (ret =3D=3D 0) /* valid data */
> +		meta->state =3D NVM_CHK_ST_OPEN;
> +	else if (ret > 0) {
> +		/*
> +		 * If empty page, the chunk is free, else it is an
> +		 * actual io error. In that case, mark it offline.
> +		 */
> +		switch (ret) {
> +		case NVM_RSP_ERR_EMPTYPAGE:
> +			meta->state =3D NVM_CHK_ST_FREE;
> +			return 0;
> +		case NVM_RSP_ERR_FAILCRC:
> +		case NVM_RSP_ERR_FAILECC:
> +		case NVM_RSP_WARN_HIGHECC:
> +			meta->state =3D NVM_CHK_ST_OPEN;
> +			goto scan;
> +		default:
> +			return -ret; /* other io error */
> +		}
> +	}
> +
> +	/* sense last page */
> +	ppa.g.pg =3D geo->num_pg - 1;
> +	ppa.g.pl =3D geo->num_pln - 1;
> +
> +	ret =3D nvm_bb_chunk_sense(dev, ppa);
> +	if (ret < 0) /* io error */
> +		return ret;
> +	else if (ret =3D=3D 0) { /* Chunk fully written */
> +		meta->state =3D NVM_CHK_ST_CLOSED;
> +		meta->wp =3D geo->clba;
> +		return 0;
> +	} else if (ret > 0) {
> +		switch (ret) {
> +		case NVM_RSP_ERR_EMPTYPAGE:
> +		case NVM_RSP_ERR_FAILCRC:
> +		case NVM_RSP_ERR_FAILECC:
> +		case NVM_RSP_WARN_HIGHECC:
> +			meta->state =3D NVM_CHK_ST_OPEN;
> +			break;
> +		default:
> +			return -ret; /* other io error */
> +		}
> +	}
> +
> +scan:
> +	/*
> +	 * chunk is open, we scan sequentially to update the write =
pointer.
> +	 * We make the assumption that targets write data across all =
planes
> +	 * before moving to the next page.
> +	 */
> +	for (pg =3D 0; pg < geo->num_pg; pg++) {
> +		for (pl =3D 0; pl < geo->num_pln; pl++) {
> +			ppa.g.pg =3D pg;
> +			ppa.g.pl =3D pl;
> +
> +			ret =3D nvm_bb_chunk_sense(dev, ppa);
> +			if (ret < 0) /* io error */
> +				return ret;
> +			else if (ret =3D=3D 0) {
> +				meta->wp +=3D geo->ws_min;
> +			} else if (ret > 0) {
> +				switch (ret) {
> +				case NVM_RSP_ERR_EMPTYPAGE:
> +					return 0;
> +				case NVM_RSP_ERR_FAILCRC:
> +				case NVM_RSP_ERR_FAILECC:
> +				case NVM_RSP_WARN_HIGHECC:
> +					meta->wp +=3D geo->ws_min;
> +					break;
> +				default:
> +					return -ret; /* other io error =
*/
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * folds a bad block list from its plane representation to its
> + * chunk representation.
>  *
> - * If any of the planes status are bad or grown bad block, the =
virtual block
> - * is marked bad. If not bad, the first plane state acts as the block =
state.
> + * If any of the planes status are bad or grown bad, the chunk is =
marked
> + * offline. If not bad, the first plane state acts as the chunk =
state.
>  */
> -int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
> +static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
> +			   u8 *blks, int nr_blks, struct nvm_chk_meta =
*meta)
> {
> 	struct nvm_geo *geo =3D &dev->geo;
> -	int blk, offset, pl, blktype;
> -
> -	if (nr_blks !=3D geo->num_chk * geo->pln_mode)
> -		return -EINVAL;
> +	int ret, blk, pl, offset, blktype;
>=20
> 	for (blk =3D 0; blk < geo->num_chk; blk++) {
> 		offset =3D blk * geo->pln_mode;
> 		blktype =3D blks[offset];
>=20
> -		/* Bad blocks on any planes take precedence over other =
types */
> 		for (pl =3D 0; pl < geo->pln_mode; pl++) {
> 			if (blks[offset + pl] &
> 					=
(NVM_BLK_T_BAD|NVM_BLK_T_GRWN_BAD)) {
> @@ -859,23 +951,125 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 =
*blks, int nr_blks)
> 			}
> 		}
>=20
> -		blks[blk] =3D blktype;
> +		meta->wp =3D 0;
> +		meta->type =3D NVM_CHK_TP_W_SEQ;
> +		meta->wi =3D 0;
> +		meta->slba =3D generic_to_dev_addr(dev, ppa).ppa;
> +		meta->cnlb =3D dev->geo.clba;
> +
> +		if (blktype =3D=3D NVM_BLK_T_FREE) {
> +			ppa.a.blk =3D blk;

This line should be moved above meta->slba assignment. Otherwise, the
slba address does not consider the block.

Also, since this is 1.2 specific, can you use g, instead of a?

I'll send a patch later today implementing chunk metadata retrieval on
erase which relies on this. I'll put it in a small commit in the series
fixing this; feel free to merge it into your patch.

Javier

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluJK2oACgkQIX4xUKFR
nnT5GQ/+Pa6dGkyLd3DBCaFHVRwAWDZD/cfYBK9590jeTpuKM1HLtIex2bmwhjLM
wA+gn8OooQN9Ltexx7MCM4d+Do1AamkW08U68S9vb4UMYawvVFNk2aJziWkESoaQ
IdWWw9UZwEeDcmbNgazoOsssTsQcM2PPxcAoxP4loOwQcueHENiqW4nmebsauI/1
6MpUOnl45ba/oe/jk3eQIfRvoSsceOPtnoAeqQ06sulGvVFDJhaPcw6Ta7q+RtGQ
U4lSwv1332k8tHWj5BTQSN4DVtHL6KLGudGuKIM03SwXeMSzth+5BQWVyugdP/Z0
Cb6UiRNopBCrzLMNoxsRDmOGoHxLyr8PZ9Z1HEBWWsLZMrDXPJJ1PLbtJNMoC5na
NxmsSY3H2an3ECxQQaSNUNpQHXO+CL7m1zcjlEAowK26xiUVKQu/+Dv1WLKIkicW
IeUjaT8okDV5+fE94MY5CdR/6kiSJbPlYaeMN8xWXnazzO9qukg5IH5UrB1Sjm49
CvmpjE3KCpoa+TTHFpQuhFyZtQIvICo3yM7+r7TmIblY5lPdRUf5RfnWfPOaiN2m
RldrTjdjyIaht9MESay9iqT3AwOVM7p1ZWvxmLLK9dO3PbHXhJoxV3GKHUPt2FUN
nc/fWLzVmrISm2R72r9OH953vVKktFm8+5TxQGPN/CRqbyxkWfA=
=LXC5
-----END PGP SIGNATURE-----

--Apple-Mail=_862ED8AF-D4F5-463F-AF41-90E8D023C59C--
