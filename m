Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091EAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CB827E2D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="U0P5LPyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CB827E2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965776AbeF2LW1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:22:27 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:46145
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935300AbeF2LWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHqPO4C1DgoglHoBoKawcCUuLcaQnpT2v/B9qb5dbtc=;
 b=U0P5LPyz5tCzqX1iHzfpcFsyMqXgCSqxwzGIyOxruegKxVVhjsOOxu2ZhmR5Kl/SOvT+kpOV2MvdKDmUwYrV8sxfOaedKVEievnDs/+FY/t4SyeSKnFFKVzjR8SeZo4PqU3Acj5BeNqUEPRhmkGxt/8amZGM+Wnm3YCBZOLpNfo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB506.namprd06.prod.outlook.com (10.141.198.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Fri, 29 Jun 2018 11:22:17 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2%5]) with mapi id 15.20.0906.025; Fri, 29 Jun 2018
 11:22:16 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Topic: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Thread-Index: AQHUDsAqECp4D0lQUUKx9mO19FFp2KR1YqSAgAG0kwCAAAIjgA==
Date:   Fri, 29 Jun 2018 11:22:16 +0000
Message-ID: <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
In-Reply-To: <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB506;7:CshuLpBCQO1h8z8Tm346bO4xouWni/wavjAyPtIICjhEVS38qujNMnpIh3UnzJ5obkTGagBEt0oHo0Id3VP1ItDnmZXOUxmE/wS+qfTckOJta+187UxhSc2hE/9ksUxpBAR9Q0G1g0pRooP6ITBTvxgiQd3eCpNaiTdNsKNYF5rghNDjGk+1rkuabIQXjNnUwm2/G3dsvlaWpNb/TBkE18uf9ynnOCFzUvsBTsw51k4h9PrmM3ZcbA9zglUSFv12
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39830400003)(136003)(366004)(189003)(199004)(102836004)(6506007)(14454004)(53546011)(476003)(33656002)(11346002)(6246003)(6916009)(14444005)(256004)(2616005)(486006)(66066001)(25786009)(446003)(6436002)(6512007)(6486002)(4326008)(105586002)(26005)(53936002)(5660300001)(97736004)(106356001)(229853002)(186003)(316002)(99286004)(86362001)(68736007)(83716003)(54906003)(2900100001)(305945005)(81166006)(478600001)(81156014)(99936001)(7736002)(2906002)(36756003)(8936002)(82746002)(76176011)(3846002)(6116002)(5250100002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB506;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c3a0d57b-8df8-4477-01b8-08d5ddb29201
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB506;
x-ms-traffictypediagnostic: CO2PR06MB506:
x-microsoft-antispam-prvs: <CO2PR06MB5063418359776881826C2DABA4E0@CO2PR06MB506.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB506;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB506;
x-forefront-prvs: 0718908305
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GD0QsXgWRWW9QAIE9P1tAt8QhIkQqkdaEHG+lL+4jsKJciHjl7gkN0lkWnRv9LIgN3uB4mqlQljfo+owsaNvOfqT0rfmNEDCHeijC9onNdiMRrAcqND8CzW6F8RkGA5Xo2RhYwvF+Q6afv1rZBiRxDyA1gn2VO8ArZfCA92Cx+D0KKhnDGKOeHLp09165Yf+Q3FVsC/XJjfzWbIjXIYot7/rLpCuRql8zlPIkcI7oaPjhAOyMKWOSAoiZZYf1ILcy8/5WFieCjrpfevAKtjl2hBw8knzlI9v5e7QjHk0jmq10zENip9Iyz9Sp4eLh4fym3ZjLG875JjtofhsxMI++pEHmhYAttm9IHkxQq+VDQY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a0d57b-8df8-4477-01b8-08d5ddb29201
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 11:22:16.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>> The Open-Channel 1.2 spec does not define a mechanism for the host to
>> recover the block (chunk) state. As a consequence, a newly format =
device
>> will need to reconstruct the state. Currently, pblk assumes that =
blocks
>> are not erased, which might cause double-erases in case that the =
device
>> does not protect itself against them (which is not specified in the =
spec
>> either).
>=20
> It should not be specified in the spec. It is up to the device to =
handle
> double erases and not do it.
>=20
>> This patch, reconstructs the state based on read errors. If the first
>> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), =
then
>> the block s marked free, i.e., erased and ready to be used
>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
>> written, it has to be erased in order to be used again.
>=20
> Should we extend it to do the scan, and update the write pointer as
> well? I think this kind of feature already is baked into pblk?
>=20

This is already in place: we scan until empty page and take it from
there. This patch is only for the case in which we start a pblk instance
form scratch. On a device already owned by pblk, we would not have the
problem we are trying to solve here because we know the state.

>> One caveat of this approach is that blocks that have been erased at a
>> moment in time, will always be considered as erased. However, some =
media
>> might become unstable if blocks are not erased before usage. Since =
pblk
>> would follow this principle after the state of all blocks fall under
>> pblk's domain, we can consider this as an initialization problem. The
>> trade-off would be to fall back to the old behavior and risk =
premature
>> media wearing.
>=20
> The above is up to the device implementation to handle. We cannot
> expect users to understand the intrinsics of media.
>=20

Of course. The point is that with this approach, erases are left a bit
in the air and "preventable" write errors might happen, with the =
previous
the burden was put on the device to deal with double erases. It's a
tradeoff that I want to make clear before the path is taken.

>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-init.c | 138 =
++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 124 insertions(+), 14 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 3b8aa4a64cac..ce25f1473d8e 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -697,47 +697,138 @@ static void pblk_set_provision(struct pblk =
*pblk, long nr_free_blks)
>>  	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
>>  }
>>  +static void pblk_state_complete(struct kref *ref)
>> +{
>> +	struct pblk_pad_rq *pad_rq =3D container_of(ref, struct =
pblk_pad_rq, ref);
>> +
>> +	complete(&pad_rq->wait);
>> +}
>> +
>> +static void pblk_end_io_state(struct nvm_rq *rqd)
>> +{
>> +	struct pblk_pad_rq *pad_rq =3D rqd->private;
>> +	struct pblk *pblk =3D pad_rq->pblk;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line *line;
>> +	struct nvm_chk_meta *chunk;
>> +	int pos;
>> +
>> +	line =3D &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
>> +	pos =3D pblk_ppa_to_pos(geo, rqd->ppa_addr);
>> +
>> +	chunk =3D &line->chks[pos];
>> +
>> +	if (rqd->error =3D=3D NVM_RSP_ERR_EMPTYPAGE)
>> +		chunk->state =3D NVM_CHK_ST_FREE;
>> +	else
>> +		chunk->state =3D NVM_CHK_ST_CLOSED;
>> +
>> +	bio_put(rqd->bio);
>> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
>> +	kref_put(&pad_rq->ref, pblk_state_complete);
>> +}
>> +
>> +static int pblk_check_chunk_state(struct pblk *pblk, struct =
nvm_chk_meta *chunk,
>> +				struct ppa_addr ppa, struct pblk_pad_rq =
*pad_rq)
>> +{
>> +	struct nvm_rq *rqd;
>> +	struct bio *bio;
>> +	int ret;
>> +
>> +	bio =3D bio_alloc(GFP_KERNEL, 1);
>> +
>> +	if (pblk_bio_add_pages(pblk, bio, GFP_KERNEL, 1))
>> +		goto fail_free_bio;
>> +
>> +	rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>> +
>> +	rqd->bio =3D bio;
>> +	rqd->opcode =3D NVM_OP_PREAD;
>> +	rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> +	rqd->nr_ppas =3D 1;
>> +	rqd->ppa_addr =3D ppa;
>> +	rqd->end_io =3D pblk_end_io_state;
>> +	rqd->private =3D pad_rq;
>> +
>> +	kref_get(&pad_rq->ref);
>> +
>> +	ret =3D pblk_submit_io(pblk, rqd);
>> +	if (ret) {
>> +		pr_err("pblk: I/O submissin failed: %d\n", ret);
>> +		goto fail_free_rqd;
>> +	}
>> +
>> +	return NVM_IO_OK;
>> +
>> +fail_free_rqd:
>> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
>> +	pblk_bio_free_pages(pblk, bio, 0, bio->bi_vcnt);
>> +fail_free_bio:
>> +	bio_put(bio);
>> +
>> +	return NVM_IO_ERR;
>> +}
>> +
>>  static int pblk_setup_line_meta_12(struct pblk *pblk, struct =
pblk_line *line,
>>  				   void *chunk_meta)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	struct pblk_pad_rq *pad_rq;
>>  	int i, chk_per_lun, nr_bad_chks =3D 0;
>>  +	pad_rq =3D kmalloc(sizeof(struct pblk_pad_rq), GFP_KERNEL);
>> +	if (!pad_rq)
>> +		return -1;
>> +
>> +	pad_rq->pblk =3D pblk;
>> +	init_completion(&pad_rq->wait);
>> +	kref_init(&pad_rq->ref);
>> +
>>  	chk_per_lun =3D geo->num_chk * geo->pln_mode;
>>    	for (i =3D 0; i < lm->blk_per_line; i++) {
>>  		struct pblk_lun *rlun =3D &pblk->luns[i];
>>  		struct nvm_chk_meta *chunk;
>> -		int pos =3D pblk_ppa_to_pos(geo, rlun->bppa);
>> +		struct ppa_addr ppa =3D rlun->bppa;
>> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
>>  		u8 *lun_bb_meta =3D chunk_meta + pos * chk_per_lun;
>>    		chunk =3D &line->chks[pos];
>>  -		/*
>> -		 * In 1.2 spec. chunk state is not persisted by the =
device. Thus
>> -		 * some of the values are reset each time pblk is =
instantiated,
>> -		 * so we have to assume that the block is closed.
>> -		 */
>> -		if (lun_bb_meta[line->id] =3D=3D NVM_BLK_T_FREE)
>> -			chunk->state =3D  NVM_CHK_ST_CLOSED;
>> -		else
>> -			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> -
>>  		chunk->type =3D NVM_CHK_TP_W_SEQ;
>>  		chunk->wi =3D 0;
>>  		chunk->slba =3D -1;
>>  		chunk->cnlb =3D geo->clba;
>>  		chunk->wp =3D 0;
>>  -		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>> +		if (lun_bb_meta[line->id] !=3D NVM_BLK_T_FREE) {
>> +			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> +			set_bit(pos, line->blk_bitmap);
>> +			nr_bad_chks++;
>> +
>>  			continue;
>> +		}
>>  -		set_bit(pos, line->blk_bitmap);
>> -		nr_bad_chks++;
>> +		/*
>> +		 * In 1.2 spec. chunk state is not persisted by the =
device.
>> +		 * Recover the state based on media response.
>> +		 */
>> +		ppa.g.blk =3D line->id;
>> +		pblk_check_chunk_state(pblk, chunk, ppa, pad_rq);
>>  	}
>>  +	kref_put(&pad_rq->ref, pblk_state_complete);
>> +
>> +	if (!wait_for_completion_io_timeout(&pad_rq->wait,
>> +				=
msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
>> +		pr_err("pblk: state recovery timed out\n");
>> +		return -1;
>> +	}
>> +
>> +	kfree(pad_rq);
>>  	return nr_bad_chks;
>>  }
>>  @@ -1036,6 +1127,23 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
>>  	return 0;
>>  }
>>  +static void check_meta(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int i;
>> +
>> +	for (i =3D 0; i < lm->blk_per_line; i++) {
>> +		struct pblk_lun *rlun =3D &pblk->luns[i];
>> +		struct nvm_chk_meta *chunk;
>> +		struct ppa_addr ppa =3D rlun->bppa;
>> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
>> +
>> +		chunk =3D &line->chks[pos];
>> +	}
>> +}
>> +
>>  static int pblk_lines_init(struct pblk *pblk)
>>  {
>>  	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>> @@ -1077,6 +1185,8 @@ static int pblk_lines_init(struct pblk *pblk)
>>  			goto fail_free_lines;
>>    		nr_free_chks +=3D pblk_setup_line_meta(pblk, line, =
chunk_meta, i);
>> +
>> +		check_meta(pblk, line);
>>  	}
>>    	if (!nr_free_chks) {
>=20
> I'm okay with us doing this in pblk for now. Over time, someone may do
> the work move this (and other specific only-1.2/2.0 stuff) into the
> lightnvm subsystem. I don't think pblk should need to care about
> either 1.2 or 2.0.

That would be ideal.

Thanks!

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls2FmUACgkQIX4xUKFR
nnRkiRAAySagb+zN3SFmjGXDwec78EY7IKfm3U9kG5gJPfbPdW1QjqZBDeyAhSf2
L6yGkLxZowSa/Sk/nL8mBrkCOaeFXy9RBJ+8FOvCz0yB//6AAzdG1Z2VOZxhV9pd
2mpnhEZo0qo+lJDTCCYt3m3CvwLbudxxRs0jc0TperBTqpXv4ZGNk3sftyDuu91V
8kXJPVLWHAOabUpwvO+DvO63CHPDkrUjznbofGoP7JiGFqbnmXlD8rmJc00yB+mt
vb926LLeqwBJ8wU64C4iU6WXhiF9KUy3NOwtRtksOhA9kFEPNlIrj7FEACM9LQcl
YCdHeePmp95EFc9AyHBIGzevuVVf8Tt9j2s3T5dm6nU0iXXu4kA8K3nJ++l78ojV
hEgC6F8V34hF/H7KqS8ziML/WwiHW7U6TzEsFPkLi2dxRmFftpNBgDNa0WHuNOll
gbXQagyreYrr8AZ1iJQPSfSc/VRYCd2U9dVmqGzxwyBJ7ZmKQi/bR5hFydNXTAvM
n7L/rKSI+2R9Yx4pHqkmuZeQxYmWA6CEyfXR6hmI3+HBpBvduJmA9hV8ExTJTWkX
zJWOvhF7qnYrRp26pZQROelv4Wy1b/Y3PJ7GK6sZM0CfeAfjoUaXGZmT1Y1dNxpH
bQFJ4Y+/fA1lm3Mp+2Tv2DS0ctgXi4ZM25JwnWt3PzgMXvL+3rw=
=3n2W
-----END PGP SIGNATURE-----

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF--
