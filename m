Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8736CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3244920856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="OIwkt/fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3244920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeH2RSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:18:48 -0400
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:24320
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8u2gVdmYhcozIyi+WDKQteD7asFCDZd3sNiHPBl6ew=;
 b=OIwkt/fV56hsILJJGxEJEbKiucw9vjNnsYFY9bk7a3WJwNgQMFk2yReNTzHEgz5LdfFwbFY610L4WO3wiHr8NVaC2L3YE7V9lgPwrv4opfrbKh7tVgeH+kKYijqii9bxzQRcjEQ8/4c3hgR0nRfkRY7Nj4LpVxqwTF6uoysBzJU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB474.namprd06.prod.outlook.com (10.141.197.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:21:50 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:21:49 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUP3Yv4QI4aVkrX0mHdIZUuHT6jaTWs74AgAADywA=
Date:   Wed, 29 Aug 2018 13:21:49 +0000
Message-ID: <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
 <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
In-Reply-To: <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB474;6:uMXHUfpM8qn2XmevjJQpHojTb3IwJ6Vh2oX+ONkblg96NDp1cbX+SqSAWp4zaJvEJAS1KzkV9QUaGn2hnMdiuPPwN1+HMnMEzyHRl7pn4sDDffrj4qF5k1RUFg/yVo3Ulgmt435+A2kfxRMWaavEoKjs56MS1/ebca+f6L3OxU45cQcZnIqc5jMTTQJEawZDM+ob9ooJVU9dP9aAfZremVMCJtax9weuNxmpUZw1UjX3FaFP6oSMZofmtisUVv8YCvgJEb8xDMHx3/bmVtaSE6+vZhJgSPuXZiMONRDWi1Upn3JTyAXLBzbjAEXuymJ2j1+m4G5yswYSt4bCUKnwL3qFxifEddsI+SdQ1jpyQVb2vUzBrDI1Jtk7IIIw1LxD1CgA4wal4vz0Dm4KBE7p8i1XdUgoy2QYN9msDrjZsrCRseiWVoccIlYoRQBGjEUwSEBzmn7WJpgINxPh7kVHWw==;5:TUAx84kBs0MSuLxUXAYFM9M6CCu5bpTVG5T1KltPjhhd2Ghu7zXWVrVIuSKLDlOjJ+s8HfGzU2dK8dc2eYjK3ASKaNUQmLHjHkrgQeY0dFJmxVv9SU/R70ljGTS/zez8LcGUTq90Y+F+NJb7JkO/7OGA2l/vvUyag3ZJ0cw+7gM=;7:m32/uaIZcvr7PiTlWLGU48EvT1jlmlhAm4rUIXENB7/d0ebX2/pqFsjQjEnFqlUUNv+wxCxPIWESYi16zyzj9XrzLvN4HFafuZnuoJMWxHnl93caISqLXRMBLIrbiNYxd4SKjaMsZQFIDqcY0p/h8E+fZHIsyNmF+tMoWt0QMvlwbqhWjElsvnBrZjHjSVRoTQHouJlFI0DKe0wIqL8Ci9oyv+uLCgZQIyunS7UlFKTOF4cklMMHCtAmoyP6mrQP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f10f3f35-3f55-4c6d-92aa-08d60db260ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB474;
x-ms-traffictypediagnostic: CO2PR06MB474:
x-microsoft-antispam-prvs: <CO2PR06MB474551AED9379C6B8C82F51BA090@CO2PR06MB474.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB474;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB474;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(446003)(575784001)(102836004)(305945005)(6116002)(6506007)(53546011)(76176011)(54906003)(86362001)(8936002)(316002)(7736002)(5660300001)(33656002)(6916009)(83716003)(6486002)(229853002)(68736007)(2906002)(99286004)(99936001)(53936002)(105586002)(3846002)(6512007)(106356001)(6436002)(36756003)(97736004)(4326008)(14454004)(6246003)(5250100002)(14444005)(256004)(66066001)(476003)(2900100001)(11346002)(26005)(2616005)(81156014)(186003)(81166006)(486006)(82746002)(25786009)(478600001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB474;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nu2hBl+d7t3BVPu/qhPl5gjFugN6nWJcv79sItylZwZguWPALyjGFU5BIswnZ7YL535dL1+f3Yy9+U58bdcO996QI+J7/Nav8MCglbtFGxvQOVn9GEzBlPauxzG5o+Ys2dv2jjGygKJrKLV5qD2nPsqirXCdijAcWZpheHz/w+xnpd6yhq1qJ5X2s+9FoEbrOhr7bs+jTeKHfWg6lgn1/iA8b95ZXdSXijUSXRtl+Mf7psZ1x69x77LYF6G+pcSrq1byWlxcJLFKPn7ztnRlx0I4lfmbjUnJthxRITb74pS3PK7Nfum8gRi9TX8HcyOnIn6wfIoPTlV9TReCmPc/k77zrduPyzMngWMAauAJIRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10f3f35-3f55-4c6d-92aa-08d60db260ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:21:49.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 15.08, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>> For the metadata I/O that is synchronous, the semaphore is not needed =
as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metadata scheme could =
cause
>> ordering issues.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>>  drivers/lightnvm/pblk.h      |  1 +
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 767178185f19..1e4dc0c1ed88 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  	return ret;
>>  }
>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +	struct ppa_addr *ppa_list;
>> +	int ret;
>> +
>> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
>> +
>> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>=20
> If the debug stuff is killed inside __pblk_down_page, then ppa_list
> and rqd->nr_ppas does not need to be passed, and this function can be
> inlined in its caller. Can we kill it? I'll make the patch if you
> like.

Sounds good. Sure, please send - should I wait to resend this series?


--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGneoACgkQIX4xUKFR
nnT5cg/+O6T6RDBtaD0dsFcwIHkjh0rWfKUWi2QZzc+gc0V5e42ddjGCY5xcWZI6
300rie/FRJr0iSzfSiulppR3/FK86VTmFym5Ye2LUqaLO4dXY39DP58fKNOaotBM
xq+4RT4PdK7+Tatbe+XkndW3+Kvdi6G5+2EQNir+yAFEXI33GZVuxwhb+3vxcej/
Jsz3QhjRXTOE1bGZX4PWFRWe0cChfVsi2Uith2jqBXVMeplDsLcjgmp/1vPRlZGC
xpTOzgegmS4UqfNX/u4/2wHt8ID9qA5KQjVFGl00kUIpzFf0pNDBjoiD/to1QU6d
y0oicYcb5WdTvxHKL1qEJxCiZbV7yx52HpWzzgAwXBtCMEKknbtutXLXmpzaZfLJ
fKcci1nsLJ0i+5QX0V4/18i0lBxp6o6BmnerlQYAIDRXf06u4nE6FtgOP4Bku8Om
Xwf1QEQhNTHNcbviiUQ+7x2oSjTyiLhZTtfax6SDlRNWxGlQkvesI+IdcWvWy09W
MZ/sk4TEOzaPz3DFC1cjEb848gstgPIQUnb5IQdsvIK82sLjiu2o9xcc7C+3715p
pDCs6/3JmrKt5xv+s0kqh675uzqUCJ2JxT/VWCxQCigPfT466btO76BAHDTAVm4F
42dZDOS7sEofbr3utCJknPIF2sSzEikCmdy6iyBJcWskDLF4/pg=
=6jS2
-----END PGP SIGNATURE-----

--Apple-Mail=_5EAEF27E-BF6A-4AC5-9593-2B3487445F49--
