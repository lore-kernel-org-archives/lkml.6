Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF7720844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="dLuuhtji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF7720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeIFRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:45:00 -0400
Received: from mail-eopbgr720057.outbound.protection.outlook.com ([40.107.72.57]:55763
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbeIFRo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrU5uurxwug1Bgqw86iF9SN6Q0qhQD8JKM1oW37ME/4=;
 b=dLuuhtjimyPwSmokju5yzfObtZexk0F5iLmJrZhvpUtaMS8Fp5DcIHjpFQdNKXYux0J2UqndIu2QSkZqLAGOARaB29B+pV4c86aaIYQwspy/Ziia80AiFPfr7zy9RA7G5J5fDM9xveOl+jzmgbdps9xkh1TSAwJpyWsteh6MMfo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB539.namprd06.prod.outlook.com (10.141.199.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Thu, 6 Sep 2018 13:09:23 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Thu, 6 Sep 2018
 13:09:20 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC:     "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Thread-Topic: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Thread-Index: AQHURPQaxpk4kdQJu02c2mK8W4ZtVaTi4umAgABY3QA=
Date:   Thu, 6 Sep 2018 13:09:20 +0000
Message-ID: <C958C918-4EF4-4AB8-AFC2-4B5B76FCE9F3@cnexlabs.com>
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
 <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
In-Reply-To: <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [24.5.37.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB539;6:EDgFyg3GhgmvpSwwgGYdxiHD+wkHcm5Sv7wmrvPNaZdWKqmgUc9GHIfLQtSwNf3g3prJs0dMwsvSDtwSVzUtESboSrfnbD5WY6kKPGsxZWhANRMnhiROg3ba6GxTTaVPs9pPkr4x2peaIE92sUjMfxixBQaW7Lj3t97HUZk18UqNq1WI+Aj+awSuvHpYocu9XY+rmubVVZPdAWEDDkxjfestz1knJ1EzG6Oh9Wphp5pKlhxNc5W8dpFfLzhph1EYHrpebVmDspj4wOMllaBZzcewoOH+Q1B1rZFZkteXXjhTpTaqqQQ7luv8jg9goTgHtuxe2X+swuM/kYOUhhxk0Iv6DD5hGLg6Yrgdm62iwF1qoZvTJ82q0il+APnoF0ggraTeBQaP19yLt5CVw+8QOS4NRwfJw6mbKWKyP1F/0hkK5okfPSxVvOTIUGPSQ3wZe1smdnQrEstJPGSrvSAGjA==;5:cipQTzuoIar3ms3LkPKzi2k6ltAQW2RJIDRttw2C55ezwp/dyAHzU+MvtIi3JLpnJeZYdQLkP5tXpcLC+s1RnECVYstrU3crV38Yx/XxYBQzMUbBHIkS5CziCRLDuu8DnRhgb4FzrfM5KcB1f/ELY0wB7csishB+jTexIkTNDyg=;7:6KuFlKfYC9pMEbt7ox5RN1d5vVUOUewLkZun8GFWkpemIogcDFBMNSJ3R6q2WnYgVRtj772CgKS+Rq+pX+mL81ucqGi86jyRyuCQgblPuMiSRQnsNIMNW1qL/5NFXe3FaW0uL0UkCRta7F1UCJMYsSwYWtuDqvBBI2PWLEW361syRO4cS9fBM58tHBjwbqhonztWQrPM49Hw0oe/wI3L3xi5Qk2nEFQtpVf++fAbJnJ3UafuH7WWaevPnnHcByOP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02e5927d-28ce-4562-7259-08d613f9f5a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB539;
x-ms-traffictypediagnostic: CO2PR06MB539:
x-microsoft-antispam-prvs: <CO2PR06MB539C71BC619E7C6D552F385BA010@CO2PR06MB539.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB539;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB539;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39840400004)(396003)(346002)(376002)(199004)(189003)(66066001)(8676002)(54906003)(33656002)(5660300001)(36756003)(6916009)(6116002)(7736002)(305945005)(316002)(229853002)(106356001)(105586002)(83716003)(97736004)(5250100002)(26005)(6506007)(3846002)(53546011)(39060400002)(53936002)(4326008)(6436002)(99936001)(6512007)(6486002)(25786009)(2900100001)(14444005)(256004)(478600001)(76176011)(81156014)(8936002)(81166006)(82746002)(2906002)(14454004)(446003)(476003)(86362001)(99286004)(102836004)(2616005)(68736007)(11346002)(486006)(6246003)(186003)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB539;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HfNQjgJy7srI7QOV4opVT/Gc8wx3cab8W+M2I4yE2CS6JSb5EylTMIbU3E/HKKDB3+dipFo/pX5vDcw4LVhT23ghchy7rkN+BEQmxQo7y6l95AhqLzXTlRD3Py/Cdlj5KbmMPmJdhRYV1vUVfo2KxbRJgay7F4+3cMCSUPrakaEB+LG/K67/I+Y5Hciptt+oUw9YzBDTf4V/9/7sTQ12qM5ftIv78CTHpGGfQAQ1+g5zewx1JSHQ0ktq7p99LPLjMBmDvfosHzdznrwtbWO2wcpe5JP5BzcweEQEMMxt14glJfto48hbOLH/O9k+XqkMDLGmM64NWF1pDYkwByOK5hHqb1CLwqWSqrGiMfl0Cbw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e5927d-28ce-4562-7259-08d613f9f5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 13:09:20.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 6 Sep 2018, at 00.51, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Wed, Sep 5, 2018 at 10:40 AM Jia-Ju Bai <baijiaju1990@gmail.com> =
wrote:
>> The driver may sleep with holding a spinlock.
>>=20
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>=20
>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 754:
>>        nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>>        pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>>        pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>>        pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>>        spin_lock in pblk_recov_l2p
>>=20
>> [FUNC] bio_map_kern(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 762:
>>        bio_map_kern in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>>        pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>>        pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>>        pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>>        spin_lock in pblk_recov_l2p
>>=20
>> To fix these bugs, the call to pblk_line_replace_data()
>> is moved out of the spinlock protection.
>>=20
>> These bugs are found by my static analysis tool DSAC.
>>=20
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>> v2:
>> * Move the call to pblk_line_replace_data() out of the spinlock
>>  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>>  the calls to bio_map_kern() and nvm_dev_dma_alloc().
>>  Thanks Javier for good advice.
>> ---
>> drivers/lightnvm/pblk-recovery.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>> index 3a5069183859..5fde414d78bb 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>>                }
>>        }
>>=20
>> -       spin_lock(&l_mg->free_lock);
>>        if (!open_lines) {
>> +               spin_lock(&l_mg->free_lock);
>>                WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>>                                                        =
&l_mg->meta_bitmap));
>> +               spin_unlock(&l_mg->free_lock);
>>                pblk_line_replace_data(pblk);
>>        } else {
>> +               spin_lock(&l_mg->free_lock);
>>                /* Allocate next line for preparation */
>>                l_mg->data_next =3D pblk_line_get(pblk);
>>                if (l_mg->data_next) {
>> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>>                        l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
>>                        is_next =3D 1;
>>                }
>> +               spin_unlock(&l_mg->free_lock);
>>        }
>> -       spin_unlock(&l_mg->free_lock);
>=20
> Wouldn't the most straight forward solution here to not take the lock?
>=20
> As pblk is doing all the recovery sequentially during initialization,
> I don't see the
> reason for grabbing the lock.
>=20

We start doing GC as we recover and, even though right now there is no
interference, the code might change. For such a little change, I would
rather maintain lock consistency than being smart about where we can
avoid locking - specially when this is not the fast path.

Javier


--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluRJwgACgkQIX4xUKFR
nnQ4gg/+J8tfR2p9n1eE8pmXZrAz25yjjWJjiVOv7eaEFtfoSyY8QhG81EV5F+F1
64pLvb0zxcCUKw058ElNqtu3vzgMUXecLKL9G8sUhix2Toj9krq/GGbgw5/wEeJ6
fRLUhduUMhTcMc/8axYlfID74fca6ZOj8vRiIhY3NJO6bEZirAdJo9J/f5RLNiAi
vI1zXp9zTGsO+dEj3sgTWfKZlcvc+6ItHdW6q9R3TKKgYscQ/BtFQiaVeK8GoSkT
iQBcAeha/hUHt0TZ50+H4YT5d+/8IBPxKUsq5cnOyrnwfgqlmWVybUQFLzb6gj7t
9lvkXpq8Z0evQt5rZxyNffREoNyEMLqz4eyQOB/m2AE15VIUCqae6wbkxVf8lfGp
hkdCiYuTMYMcI35dyrbl42QafUzhahAfRDj3GU7VF5P1g334RC++X7o1+sDReDQE
K/ze2Jrmxh/FdORt3DKnyhuP00BL+31zrQO24XWc0KM2w7pLgpiu/Sp25A6WxTY7
QicQPbS42w2Ue+0c2x4x9EPf2A+S1SQ8iZfPlr2hgH22v01DT2CtW0o5wAmcDSP7
sDbIy9YjalCZCMLDcSzig+JQBSzxVdNqKne/pYcxZc+EpuOeVMr4VistpngSlqg5
o/D9Z26kv1zAhq9SKHN+IjiF1W1PYRFe8B9KsXH5KoBdsoUqOBQ=
=/hCW
-----END PGP SIGNATURE-----

--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC--
