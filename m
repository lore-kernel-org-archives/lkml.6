Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0B206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="FvgMZgxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF0B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIDWSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:18:39 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:62176
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeIDWSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoSfmcEc2/69KiMsAERE3ENn+4DVilbLBYzZk9atUpU=;
 b=FvgMZgxfVTSyjp76XcsdP5/+R+4Dbdx+aGfpfRs7Ser5eZ99rVD/ng1hmw+gCq/znsaJziDc/cAG2svIxf53EGo2ZEYzI8KFNhUcbUhG47OJ01UK7pgbc3NHG3FrEbirhpPPGCnlebh0CJrTxgtZtVMltaPetVlOZBFz1oeunjA=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB458.namprd06.prod.outlook.com (10.141.196.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Tue, 4 Sep 2018 17:52:22 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 17:52:20 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
Thread-Topic: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
Thread-Index: AQHURDe3SmhXIzMDek6qSpKEUIQSfaTgZ5qA
Date:   Tue, 4 Sep 2018 17:52:20 +0000
Message-ID: <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
References: <20180901115318.30416-1-baijiaju1990@gmail.com>
 <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
In-Reply-To: <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB458;6:vFC1RgGwf871XT1DY6zIbTjrU5acDVfeXrO8Qx3zv5KEpi5DQrIxRZaivGRWEbFv9luVeBVZbgI84ksYbC48FtGNxAahWA/yZUcv9KWl5noaGMwuK/4E15Co4Iu0ePFnEIyU5+0bcxDV6jvKLvHQ8TMGd3XI4BVSnlBGVIDfZ0J0QLVZmU5dgToaJoihyK1luI8jsqgBFukkq+70xEf/cN+khflTNRjYT5zcDe4yLQN0TgN+pWVQiO96rT8ZvsMMRCsFnObtWlcWsQ6boetk+ASldCXE2xLRpN6cLEXelV+dZlar1sF+xYgJz49NowE0v5+72adJ6bRoFJ4876n4Z9RkFUzfvH5dTIFwYfceRIO7emc1AwJxDLyDor4ySu/cFbzo1fqjtMaHEfbeb37GmKLrKIe8u7YtBePGYbFoxIr4Jcl4/l5z0ro12mgesMKLEo0h/oXJ0NyfdUfd/j2Mxw==;5:SL2ngQXHu+1FA+nlJMPfcPzQ8Fa246LpxwibnOsHF8RnEUouBPMSCZ5gWwk93aNkaJcgTOG48fKRpp3hT0O7251wUtocU2l3FMWyV4P3P95vxPOgy6a0jNrk0UW+iaCSWxWfQm9LlAtUPaqAas+NiHp14UCjPKHJm1i5AtOr854=;7:2TGMsCvapmRNX8XbrVUgaNg6mWns42FTOJ2bcbTaoiKU/Hmbi2W3F8t/dqwqmyXls0H5bKIp+UsXcJE8cMC6/xtg6lsSaARL8RRGMG30ptBdIUHCCLaRkXJdT0CRurVqGqm4awXdoZBq0fh0SvIHqo9hAzJDMMFJm3qTiK9OSd7RuWBSEcP6Jg6G3u/KNt05mdhyBP5hBy/cxB1JDNy0I7Ac2d7KGtKEf9iA/J2gF00xDUG54cygBUfPReFbOMFv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(39830400003)(376002)(189003)(199004)(256004)(316002)(99936001)(99286004)(82746002)(2900100001)(81156014)(81166006)(68736007)(83716003)(33656002)(8936002)(3846002)(6116002)(76176011)(97736004)(2906002)(14444005)(105586002)(106356001)(54906003)(5250100002)(6436002)(39060400002)(107886003)(4326008)(6916009)(6486002)(5660300001)(6246003)(14454004)(6512007)(229853002)(486006)(446003)(2616005)(11346002)(476003)(53936002)(478600001)(186003)(26005)(53546011)(6506007)(102836004)(305945005)(66066001)(7736002)(36756003)(8676002)(25786009)(86362001)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB458;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b4cb7e6b-f885-48cb-0219-08d6128f2947
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB458;
x-ms-traffictypediagnostic: CO2PR06MB458:
x-microsoft-antispam-prvs: <CO2PR06MB45878B3FD879614FD2E0C45BA030@CO2PR06MB458.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB458;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB458;
x-forefront-prvs: 0785459C39
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2Um8/mfYmrKO1WMNGujGFOYQL9hteUpj5VBrL7CADDv+rOM/q9CkY55QQuleRYF00gKKQ2hJvutq3Nsf/0CTDadrXEciY4dRTplWjmIbGBFqfKjQjLiSMXD9umvO486FSQ2qQteSll++2+Nh3aaoXTdmagb5IgBjRjmxW8aKKv0mJtcU4NhU0bl67w4VVgdbnWy5ooEF1XJho6ihPYguyk6ynCWCfWFmVpEaZAIK3ziDLttnqzbtVqfXkwOJDJHOz+aHKk6NAtZzFQQvPENSzgEeMLwXbeUmcvsT4DhtWgjn5t8KJ8SBIPutmauOt2GzY/yBdaKOGC480c79vPPuV5/HdWNxPAANbiJ7pIn/fRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cb7e6b-f885-48cb-0219-08d6128f2947
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 17:52:20.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 03.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/01/2018 01:53 PM, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock.
>> The function call paths (from bottom to top) in Linux-4.16 are:
>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 754:
>> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>> [FUNC] bio_map_kern(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 762:
>> 	bio_map_kern in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>> 	pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>> 	pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>> 	spin_lock in pblk_recov_l2p
>> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
>> These bugs are found by my static analysis tool DSAC.
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index ed9cc977c8b3..5d915c93b6cf 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>    	memset(&rqd, 0, sizeof(struct nvm_rq));
>>  -	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>> +	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
>>  							=
&rqd.dma_meta_list);
>>  	if (!rqd.meta_list)
>>  		return -ENOMEM;
>> @@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>  	rqd.ppa_list =3D rqd.meta_list + pblk_dma_meta_size;
>>  	rqd.dma_ppa_list =3D rqd.dma_meta_list + pblk_dma_meta_size;
>>  -	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_KERNEL);
>> +	bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, =
GFP_ATOMIC);
>>  	if (IS_ERR(bio)) {
>>  		ret =3D PTR_ERR(bio);
>>  		goto free_ppa_list;
>=20
> Javier,
>=20
> What do you think? I'm OK with applying this, but one could also move
> the allocs outside the spinlocks?
>=20

Definitely better to take the allocation out of the spin_lock(), as all
line preparations are made to be lock free.

It is fairly simple to fix this, as it only occurs when calling
pblk_line_replace_data() from pblk_recov_l2p(). Here the lock can be
inside the if statement to only cover text_and_clear_bit() and to the
else statement to cover it entirely.

 Jia-Ju Bai: Do you want to send a patch for this?

Javier


--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOxlEACgkQIX4xUKFR
nnRo3hAA0ZGAPPnJxhW6SMjH5/yB8A5nabULhPizelMfCcqZz6wkCnkY9GHD1rXp
nqsxdwtgt29e9zkDviaJdAylwAtk2nhho1RoJWy4n4bp4HYq+NbQSpEt78P9rDTg
za9eGJ2jrx42rwgZZwVRIACMb0w6TSH8btMTv4yWFcXiD1vjBM1QEaX8W/S+wa46
JDuEfl6/aaOTgwZFsydr6JOiNq5AhUrU483oMHxdaqf5F2rqucoEyWfYiWBA5JBp
2khI89E+a00CJvPtOtRYTeUJiL9KePawWM8snR0BS3/KIrCsZXGhjH+xI6GxJAvU
OrBiYswX8zP7CjjVVh6csIBwcFvN+N7jxZyHpeub0rhaosMxPgP1g7GRABMEKnD/
uirEwWEC30z0myRYBLqG3rDjd50PcItqCWfN5G28NCAgDXdcQJof+DmQADcVhVb5
718umU/6LI7FMKlAS9MlqhJA+hYtK253kdWv+XIjH1rIIsnaiuqLOAg6XhAxDjmT
bFHU+lauDD7VSISRJHoeGMDXWkfPZWBxC5b41U9wrMyfGPCf3ecSVIMK9MVBYf8L
Kx+Xq7ixoBbLJm4gWRDNpjAAfa8oD7ND+v1dcy1axzYqlajQWuyiASgbulEYt2ls
wYOhK4GuM9uLZlurcjX3fv7Aeiu+sW8QKg2iwcXHD1JXGgUwWfs=
=tsYy
-----END PGP SIGNATURE-----

--Apple-Mail=_1744A098-40AB-4C92-B286-0BC782ED5CE4--
