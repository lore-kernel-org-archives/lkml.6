Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3A620850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="JWZHUjLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3A620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeH2RQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:45 -0400
Received: from mail-eopbgr710064.outbound.protection.outlook.com ([40.107.71.64]:21424
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z06MPOafWBvIlWuqIkagnTDJNIlvs6hHwvv+RgXULK8=;
 b=JWZHUjLvcSsPcFg5zrUxYCqC9zRWz+kKyULVxEQ7wqoJqXrdsqq8dHDnVGmeDq9r8VUpyddLERHb8BlpryfiyFtBbDas16ojNw5SSsASYMPpoekZ103cFO5YHzgK+RhzIMfqV9GJzDGVOpg3eER7IEZrOawIV4xel/n10cfCnTU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB474.namprd06.prod.outlook.com (10.141.197.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:19:45 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:19:45 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] lightnvm: pblk: refactor metadata paths
Thread-Topic: [PATCH 1/3] lightnvm: pblk: refactor metadata paths
Thread-Index: AQHUP3Yy9So21ADSx0WXiRI7H95odaTWsh0AgAAE2gA=
Date:   Wed, 29 Aug 2018 13:19:45 +0000
Message-ID: <F7595311-472D-4250-9B88-F2186334B7C8@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-2-git-send-email-javier@cnexlabs.com>
 <e147e01b-8317-3ab5-497c-70f601a92a2a@lightnvm.io>
In-Reply-To: <e147e01b-8317-3ab5-497c-70f601a92a2a@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB474;6:pCdRSyo/sWh2k5mvdBkJpiEh4AifQKYg5niW+RufUCY25Y/y7yDF6ab36jywttF5xo3tlxD5LJgLbEi4aQFQP4mIbThafis9D9sRthmkov6Q/D7NCSuQf10P70322gceJisCga6UWCt1BBf86jQ82UQTti0a9vrGI5tkGSRpAanYSVcavt6y8/f7KtIvUcPO1DO7v4GUpNnrAGxpUhJtzixEtAK3/L4rYVTT4Zev1I5Xum3fANXrNLSFJBbPd6Yj08cnBSnE8eB9+xmqiYTWKGRa70rp12PqcB+ogrw0KFvetrb0q2wuZKrl64isr89AICRshKSeS7gAzzOyKQhXoFeNGQ+/1sPoPYVTcoyuhYcn/ea0Mjg9AnTCaK3BvwfbvvIrQGVazBJNqTVYPkq2P3HbI+lqXRfXMS9fgdshlzmAI0BhNW644K4g2NaeBXSB3ZdAwMXvFCPZNZ+CuMjkSQ==;5:ufAtHLwDEqnnsRSJkUA7mtyv7WTviXVLdPRK2M2soVOudna003HA1lt1GdctcVQcZvEwpQFPbkuHzE8fi6g0VotoyRIV1v0Ty7sTPA30JasdoZEIMOWQ+6OZmv8YVdxFvHW/JFX5rAKbuLgNyLRZawwicHf1n5yCxCmJG8UyEMw=;7:km9SS39G07r9tlUbhfb3SlaeGnWU3vVSHHTqO3MSy1pVlHd3JHc+4ePp6VXOyUgOVWFQtqMfwBcufUCcuUrv0vhXxBkcduwbBizPgzC8XRUnnv3JzQLRN0D1DhA2rcWp07Mde3paDQmTu5OBuhymjxiHILyB2QoN7RJaFm1AeRKCh4vqKXjAvm9Uwji7KiagQyeASyBcm97MVjrFcSMdcATq0xXsCSZLK6zh2dtMXkMtnvc0p15kfulFGOVjfC+O
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c82e37fe-b161-4955-f0da-08d60db216c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB474;
x-ms-traffictypediagnostic: CO2PR06MB474:
x-microsoft-antispam-prvs: <CO2PR06MB4747AC24FB32BEFC81A5ED1BA090@CO2PR06MB474.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB474;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB474;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(446003)(102836004)(305945005)(6116002)(6506007)(53546011)(76176011)(54906003)(86362001)(8936002)(316002)(7736002)(5660300001)(33656002)(6916009)(83716003)(6486002)(229853002)(68736007)(2906002)(99286004)(99936001)(53936002)(105586002)(3846002)(6512007)(106356001)(6436002)(36756003)(97736004)(4326008)(14454004)(6246003)(5250100002)(256004)(66066001)(476003)(2900100001)(11346002)(26005)(2616005)(81156014)(186003)(81166006)(486006)(82746002)(25786009)(478600001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB474;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ttz9jOGnXmzSFJupxO+tzbqUZ30upNgtfCEs30OhkuK1TgT+U1P0E+5FJRHscJdEHbv4FUxJIRH2ZvJX5vn8p4/hn1+HDTCNbjORc05XATnFgEOey4oPhupuHo3bLdGBrqPd78p/JIf0Wo8pkc7aeL7lgufjOacWeEdKRVDu7ncGT3j8OoqnJ9vvkCIZAv2yaKVBQjFFjK34k21g47xXKejZtQFcp6Vr4efNcdgHstYKkQ+B/D+mlqwReYdkO+YCtJpFKkFGA5/S8GQrV2YsLbB0bPfEEQXJTI78HobQxBhOUVomyQOYCVVo8PxuFRTQAhdN2m+qxkeXD/Eo0JawR4o+ClcC6xEhNclBDV79Nek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82e37fe-b161-4955-f0da-08d60db216c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:19:45.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>> pblk maintains two different metadata paths for smeta and emeta, =
which
>> store metadata at the start of the line and at the end of the line,
>> respectively. Until now, these path has been common for writing and
>> retrieving metadata, however, as these paths diverge, the common code
>> becomes less clear and unnecessary complicated.
>> In preparation for further changes to the metadata write path, this
>> patch separates the write and read paths for smeta and emeta and
>> removes the synchronous emeta path as it not used anymore (emeta is
>> scheduled asynchronously to prevent jittering due to internal I/Os).
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c     | 338 =
++++++++++++++++++---------------------
>>  drivers/lightnvm/pblk-gc.c       |   2 +-
>>  drivers/lightnvm/pblk-recovery.c |   4 +-
>>  drivers/lightnvm/pblk.h          |   4 +-
>>  4 files changed, 163 insertions(+), 185 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index dbf037b2b32f..09160ec02c5f 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -661,12 +661,137 @@ u64 pblk_lookup_page(struct pblk *pblk, struct =
pblk_line *line)
>>  	return paddr;
>>  }
>>  -/*
>> - * Submit emeta to one LUN in the raid line at the time to avoid a =
deadlock when
>> - * taking the per LUN semaphore.
>> - */
>> -static int pblk_line_submit_emeta_io(struct pblk *pblk, struct =
pblk_line *line,
>> -				     void *emeta_buf, u64 paddr, int =
dir)
>> +u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int bit;
>> +
>> +	/* This usually only happens on bad lines */
>> +	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
>> +	if (bit >=3D lm->blk_per_line)
>> +		return -1;
>> +
>> +	return bit * geo->ws_opt;
>> +}
>> +
>> +int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	struct bio *bio;
>> +	struct nvm_rq rqd;
>> +	u64 paddr =3D pblk_line_smeta_start(pblk, line);
>> +	int i, ret;
>> +
>> +	memset(&rqd, 0, sizeof(struct nvm_rq));
>> +
>> +	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>> +							=
&rqd.dma_meta_list);
>> +	if (!rqd.meta_list)
>> +		return -ENOMEM;
>> +
>> +	rqd.ppa_list =3D rqd.meta_list + pblk_dma_meta_size;
>> +	rqd.dma_ppa_list =3D rqd.dma_meta_list + pblk_dma_meta_size;
>=20
> If patch 2 is put first, then this is not needed.
>=20

True... I will reorder with the changes on 2/3.


--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGnW4ACgkQIX4xUKFR
nnRMxBAA3UHHV7sp2en8SK6wroILCBJkxK548KZAM0KtIIztiNgSKSCiR17C3CRz
4RYyRPsm9weZI6v0R18giE8oXJ00PbBPT+6qSm5pnQCFCCrUZPd+PxelvIUHaaeu
zq5F5OWLwSAVWZzO3j/0mn8dCjDYQEGAxhAWIzs+t9Ano0jMo4CsrSqIyDmRYs2N
nJUNXrVJZ6u6GjFVYyTNuG/879TNQOiqD2A3XJ1uT8WAyP3K6DiOMu9Q1vCEhWAo
s7OdCLxOpEuSlUtxkmXO4ZmaBqAXAVoGLuxwCrf2SmB0qauorNd5i/BdAXk+5YWt
kcJ1oQk2F9qDvi2OlsMlKX8A/uU2T10cbPqigzOQM8/KLZrh+P9d9eqZJEoGngJs
OU7WedbvWuBj/Wepb7bvZ3vwtLaHt1AnZhiKk8TyWDqCU2Sy0EqzoievxY2WkMzJ
y+nYV38DYQRXGz+RAFdXAIQbkzV9TJtsPE6M/wIiNuJVhG2Cll0TZOAngWNwft/Q
mYXuIdkNAUlIp8sqUffnIGzRquNsstxFsYka9Ww+AS/PBEtgf3nuv2ojNhDetqzL
8MrG9HcKJ1L4koHopn302vuJzepJWflIGebbvTxY01phwRRJPimOLCqhi8P7XvqI
dmtyHVIUr/QLSa+CvPa74YQC8Imaqd84DKymzNYu7atgw+2yZHw=
=H95m
-----END PGP SIGNATURE-----

--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827--
