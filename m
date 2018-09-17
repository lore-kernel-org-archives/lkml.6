Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18416ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0B9214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="L5NfdSUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0B9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeIQPiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:38:24 -0400
Received: from mail-eopbgr720077.outbound.protection.outlook.com ([40.107.72.77]:28141
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeIQPiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uo07E3CGl9WJXhHlicMI8mJ75hSznL0y5qQeLHfJSE=;
 b=L5NfdSUPBUxJKiK8khEVdYFBcIA4NkcfHePZZaDceEQLUTWFGgT+AGDdfbUqaXs/RLId9OB8J1nEr180YHRwPu9uHS4Y+xgNCd9geus9UZ7pN2/PvnfMi4tc6rUX5K+GzUXJ7c/c+QxMnDwmX5YcmiX1y/z4j/88CjYGCY7aTQI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB604.namprd06.prod.outlook.com (10.141.229.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Mon, 17 Sep 2018 10:11:34 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bcce:7cd3:196f:873b]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bcce:7cd3:196f:873b%4]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 10:11:34 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUScIbS1TZ18mxNk+bX7o71nYqoKT0KG4AgAAhooA=
Date:   Mon, 17 Sep 2018 10:11:33 +0000
Message-ID: <CF27AC45-B351-4AD9-956D-02EF4E05EF21@cnexlabs.com>
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
 <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
In-Reply-To: <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB604;6:aE+OpmrRbtU/SlrTxS7onyoolVFHGG+xAqQoXPQrQJdlrcEYcqu8XLLVzLvAHaCURAfZQvY3zxFLSLWT2lnau/Q7ajFIy6oaMbLJINcbLXPp+6Wh8hXHp+9fJ6I+RPzp3OLahfVwa4hTuMAy+Kktx9WuE+MKNmUFvfsoWsAi+X0lEj9eF0aR9TTWGXBYLtiW4Kpd2fkBA0FKn3bp4IWXshSQHFYVVnGYix9rWDpaGp1yVInLhLo61WL3IoMRiVFt6lvwxNbIyrCO9Wxw2hxsC5tgH6Q7cL4Edh7j70XQ38IeW4F8OJob86ycOkyihvvnk837NED58UVCIXrlIslQM+G6W7WIdh/b0I1h9JDFUo1IK8/GD460C3j9ZssaS9NGRds6Z+0k94duw3jp0Oq1xcGLQ/QuTBcCeOFBsvUHjZfyO8RgfA1Re+9A45/+kz9cmDr+jjEhSEN7DhUjy/ImSA==;5:zXXyXXbvVSRFnG+JIvUG+i6MfpoCEWX4bpZB7saSH7oWm5CTbzgSK2gsdWOb+WoN7ZZtAvRLMMRo20tfyIg9NdEsJPRf3ExiidOD0bfyWapu9+Yd/rGO9Gff8PS5D7TLKXwHwwOuTmNYxTSrN9/kJjXY2al8CkGCfsihNM5JqqM=;7:qU+GQ+qeU5WeaYhAZt9AhUC0N7897gAxQ1FVxT7kWiy9aSfN0K8vagkMgwThD9/StdGNYb8YedokujvvVjXlY/19e55neg/JKOzywu2W09Qy93WiDtdkLNZoJB8SsRfYUqSJBIOXvoEgoj42W/H+txSkoRiGlDR4blySIBwl9ARwz2KcKsL2jq7jWjHdvz6mNkzoYflyHCWGiW44Ln2vlTFEnxVY6jzREyjvc234jYuGEh3jrz8hOabW2d6d/mBF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b82e223-3591-49e5-bd8b-08d61c85f251
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB604;
x-ms-traffictypediagnostic: CO2PR06MB604:
x-microsoft-antispam-prvs: <CO2PR06MB604E8CFD2B509037FF12BC1BA1E0@CO2PR06MB604.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CO2PR06MB604;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB604;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(106356001)(99936001)(6506007)(3846002)(54906003)(5660300001)(26005)(486006)(66066001)(2900100001)(99286004)(6486002)(105586002)(6436002)(6116002)(25786009)(36756003)(316002)(6916009)(186003)(229853002)(102836004)(53546011)(83716003)(2906002)(476003)(86362001)(81166006)(81156014)(11346002)(6512007)(76176011)(8936002)(8676002)(14454004)(4326008)(305945005)(82746002)(68736007)(97736004)(6246003)(5250100002)(7736002)(446003)(33656002)(256004)(53936002)(478600001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB604;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cgvh+RKtj+xqMKcprVA84aw04Z9+HKOhRzO4NVYXfUbD00t4rQiXjERhFAzyg7eksQoTw+MahWUbd6GEbSgNgsE2+jtJO8ZdsaCyoZWrYVKw36DGpn8ttJUW6PRvTgj4m6AqsAG5q2G3yp4Ekj+UC0gOC+Ke3YSfeSMLM5SQG2kzWFcGRAK9G3O+8/th53VY28JR6zMd3JBPGZ4bxaT8lbS8IPtIdezqhu+j+4zeqobnrVBfOWqxfacitVEwQTNfsybvfXy3UisWQim4iPA/oEDp+DoTY1Xju5qcbTZEKC0PBIMh82STUdZV/ccqCvKwdKazRhwTOvgQPs1iPhqz467jf+67gIeux88k0jpyZdI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b82e223-3591-49e5-bd8b-08d61c85f251
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 10:11:33.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Sep 2018, at 10.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/11/2018 01:24 PM, Javier Gonz=C3=A1lez wrote:
>> # Changes since V4:
>>  - Rebase on top of Matias' core
>>  - Reorder patches to avoid in-patchset changes
>> # Changes since V3:
>>  - Encapsulate rqd dma allocations to reduce code replication (by =
Matias)
>> # Changes since V2:
>>  - Split the original patch between the metadata refactoring and the
>>    semaphore logic. This simplifies the write path, where the =
semaphore
>>    is taken.
>> # Changes singe V1:
>>     - Fix double I/O on the read path (by Matias)
>>     - Improve commit message (by Jens)
>> This patchset refactors the metadata separate write and read paths,
>> which simplifies how the semaphore is taken for writes.
>> Thanks,
>> Javier
>> Javier Gonz=C3=A1lez (3):
>>   lightnvm: encapsule rqd dma allocations
>>   lightnvm: pblk: refactor metadata paths
>>   lightnvm: pblk: take write semaphore on metadata
>>  drivers/lightnvm/pblk-core.c     | 376 =
++++++++++++++++++++-------------------
>>  drivers/lightnvm/pblk-gc.c       |   2 +-
>>  drivers/lightnvm/pblk-read.c     |  31 ++--
>>  drivers/lightnvm/pblk-recovery.c |  34 ++--
>>  drivers/lightnvm/pblk-write.c    |  15 +-
>>  drivers/lightnvm/pblk.h          |   7 +-
>>  6 files changed, 222 insertions(+), 243 deletions(-)
>=20
> Thanks. Applied for 4.20. I've renamed the first patch to "lightnvm: =
pblk: encapsulate rqd dma allocations".

Sounds good. Thanks!

Javier

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluffc8ACgkQIX4xUKFR
nnTKJQ/+OT2C2cAopVq8N8MRdhprjtIrLkfqf5gKj4zkLb0aNtiuApSQUPTwnnwF
9L546U6kUQo6t5tPmlesz91JK6RozitqUnzb1e5kCqmCOEOSmyayBS6wqI3zyjV7
Knd9pVD/cZ6mUoWl5dkyTadOGn3NX1ke1BSXcAseWi9JOPgnJFvpYubSL2TZK26h
ZRka8M76qSCJMkxiinyT1wvDY7OxYJDtO5j3S+RiEAl5dWzdvUapoQqTNExSj+Kl
ZBhTgn0LNrsjdgOV0/t9j9EQhA8OvnvL8GPEaP5w7YPskuXh8a4ec2ugbmjVd6f7
8pldIVFymhPxIhciRrPVexuQ7n1LNvmN/xjr7bszIulMosX/8xeYjrYVRWRU8I/N
bTb52N9LTsEgbLjsKFx1y8Et3dXRvsEhMl+rPG3wTlhku+qnZS7yTap5UlX+GYJG
jivHIPi4EcqXzsm5QXu5pRYhYjpOn3F8lhj8iPdZjv913skQoJRpV+O1taiUcVRv
OWIu312ZcQJx6zlmgcBk/4fQK4ZVygSFuAUyg9wgtQHz9+kL/HwaY3IsUqYo3D+H
fCxft7EMWQWRXg0sM7zFzYxa2GCkawmUumY9EAlQZSxatpgZYfWlAOiBOHTpz0Hj
dGfOkWFfm4XrDcJyPDtyQqTGM4ItpncOmbCiiOLCTKqoFvGcjnY=
=P9HD
-----END PGP SIGNATURE-----

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C--
