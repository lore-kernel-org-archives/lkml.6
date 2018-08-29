Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597A220850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="j1Xg7sAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597A220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeH2Rjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:39:37 -0400
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:7824
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728075AbeH2Rjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNroGENkHWqOy+8y7rDPOTwzciGiZcMhakbOHDqKzDw=;
 b=j1Xg7sAxR6sJTs5SxCdEd1+B3i2fpxKZ+Ed1hsPEtAP7PtvKjngAtZ+1xhaaXneDi5NTysYqnzZendhoaHiAny8LbnsGAgOyLlxO+Qn3m2TS/gL9sXi9N6t4Z8ASqdIlXo4GpGrlHgbZJxFS6vkbqYd5Oizu1TyXRPUMwp3Xeg0=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB523.namprd06.prod.outlook.com (10.141.198.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 13:41:59 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:41:59 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUP3Yv4QI4aVkrX0mHdIZUuHT6jaTWs74AgAADywCAAAU5AIAAAGOA
Date:   Wed, 29 Aug 2018 13:41:59 +0000
Message-ID: <73B50ACA-C2CE-4A85-A352-94EBD5E6884C@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
 <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
 <0FD404FB-C660-412B-9658-454A9DCD7558@cnexlabs.com>
 <1911b06f-ddb5-40fd-f822-702ae725bade@lightnvm.io>
In-Reply-To: <1911b06f-ddb5-40fd-f822-702ae725bade@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB523;6:b/kYsn1jGmWYLaHpD6dJX16F0LuJ0Ht2U8P/s0+nKdlikI9qcXL8x7/8vXbIhgeMyPY7Nelr7iQYsjUqkbEX3YKHHm0IDYYkYLMYZoGfPEX36vAotyeV79dt/d7Fkb6TmLPW4wRKqph4KZ6djVxAdOmGARzykR+p9OZdj6AaAjMk1LOqiqwNfMR8w1w71EMKW6w+0TmECnByQUi4U8Vn3xBujKLNPO2U8A1AH7QFvrxubhN6fwlQQfG0WNwc+hZ5MgPkOy4C46h3uV40frcd3FrsdtEXHnZPpFojQyjv+l5xr1L5WhH/TPh8otHxfh/c3DIMLynbSmGkJPkX1Tznx3u9Iwb8ZkCiTtmFXSDV/572mFSGsep1jyhmnv2EMm68fDBD1jU/QUbDS9g7CLUmOELUYFXzhUtrtM4PkEgJ43FFioMnAArKCeM/TeEwpqszwD8W94lWjgB76a2YvYm8Kw==;5:C6PD8//bf5sml5uX3dZdp2R4vcUpmqrRza9T1/47Sy6JXK+8U9d0gDA//uDr/SOBd0Yl49Nm+UY/OB2iTII9vH3KEJRAfv1PCfISUIoltsNaRI7uEgi5YxmpiO9trfEQxm8r/G3z/r2A4bwIy903ZZZBPyBF6NY3WUbI53pwiyQ=;7:bgx5SCbGgPGJqcShEV1rmIaj2qpQ3PaRhuAqHcnfNJg05Jpix5imgV0av5P1w9+AIkx29aB7xMet5KI4wmXO5NpBcJUPgW4/dUnr35pfExMpANRKTjpFgm+QHa4Ow2qzqHv5J3EH3aL3ftBucAARFLluh4cHITWxRJ2Kb37Wo2N2qaZQeP85jjLSzLt9oVkOtOU/BrJ+q0xnZjvBQ5RFqdvvBWEyY1F1qqHJHUaf3tSS+0PMHuezpWVjjSAED4Q/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 880db43e-8ca8-4aa3-22ed-08d60db531b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB523;
x-ms-traffictypediagnostic: CO2PR06MB523:
x-microsoft-antispam-prvs: <CO2PR06MB523F01B8B7321F808D6B60CBA090@CO2PR06MB523.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB523;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB523;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(136003)(346002)(376002)(366004)(199004)(189003)(54906003)(186003)(26005)(53546011)(6506007)(68736007)(316002)(102836004)(14444005)(256004)(2616005)(486006)(11346002)(446003)(476003)(97736004)(3846002)(6116002)(5660300001)(6916009)(99936001)(105586002)(106356001)(93886005)(6246003)(33656002)(25786009)(86362001)(575784001)(4326008)(66066001)(8936002)(2900100001)(83716003)(81156014)(478600001)(82746002)(53936002)(8676002)(81166006)(5250100002)(6512007)(229853002)(6436002)(36756003)(305945005)(6486002)(7736002)(76176011)(99286004)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB523;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BPmNVDB6VjPh24qhV0JejAilFKHoSM3VyDcbsm4y010Uj8cclrUV9UxUgSCcfw3ct2PElW0Z8VncEM77yk35/dnlWW2KfMrcacmvFYkP8CfumPuOVcD7zjIHHJriBe8IVUCAqhtAZnpLn4CToy9eZLdtfSGqs2VyH7OAmWDMtz30UWsP9VNiDJhFjiza9R0feYFmCJ3di8Ce1RrW3U7xmkdH9XpozMbVlpehRT+jgFiAdq2TDDhknLZbWPGtX2+j3Hg5a7+zXWgOxEMFdAqIYFUSEnDhem05T5V3HuTc/x7vSOHLchf2EJK/+dmXnJBUsL0WXexRiAn11hOJprhSTDpB4q5pWfpEXbKDys6773I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880db43e-8ca8-4aa3-22ed-08d60db531b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:41:59.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.40, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 03:21 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 15.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>>>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>>>> semaphore. At this point, since we only have an open I/O stream for =
both
>>>> user and GC data, the semaphore is per parallel unit.
>>>> For the metadata I/O that is synchronous, the semaphore is not =
needed as
>>>> ordering is guaranteed. However, if the metadata scheme changes or
>>>> multiple streams are open, this guarantee might not be preserved.
>>>> This patch makes sure that all writes go through the semaphore, =
even for
>>>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>>>> simplifies maintenance since changes in the metadata scheme could =
cause
>>>> ordering issues.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>>>>  drivers/lightnvm/pblk.h      |  1 +
>>>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>> index 767178185f19..1e4dc0c1ed88 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>>>  	return ret;
>>>>  }
>>>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq =
*rqd)
>>>> +{
>>>> +	struct ppa_addr *ppa_list;
>>>> +	int ret;
>>>> +
>>>> +	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
>>>> +
>>>> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>>=20
>>> If the debug stuff is killed inside __pblk_down_page, then ppa_list
>>> and rqd->nr_ppas does not need to be passed, and this function can =
be
>>> inlined in its caller. Can we kill it? I'll make the patch if you
>>> like.
>> Sounds good. Sure, please send - should I wait to resend this series?
>=20
> Will do. Yes, wait a bit. I'll post asap.

No hurry. Thanks!

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGop0ACgkQIX4xUKFR
nnQVkxAAhf7eg7yCuhfAKee7f+/ggvjTOR2kijGo3WLX5SWbIJP47QIojHLt/3Hg
7D25WcW7pePOHPJZYjDHbtX6ytz824UnRggJlIt7s8kbJfFl1uauoaiU4D0yMn+R
8iK6w2jRTWsGUzqR3ZFx7EL2D10L65LO3aX8d8nDEza9dmjDzqgxTVlJScfVAZNG
EOAuS6vni8+7cuIEoGPcqL1d3Yk4y8X36eSE0ilZahfk/o1szSRShLHUJ32oBQ+7
UrGR8r64OgaaqOTu4dF2CVr4XIXD6ukyYCcoYhVERLK5dLSu2W0xIFvr0Lv1fs2i
ifanj08O4EWj5XM9+XT1iMAgvrGM7stADoPZCyf5Qo+fxKZuzZlCSgKz+F2yCfju
Nmp5q9MylavfAqX9sBED3vAnSp7RF7HgwCkgF9E/DaTTsCHTJqgIbpWyyBDkP864
r0TII37bzjRU3RUANk1KZiYrbvFB97wpCYU9PuQcVHP0Oj9NRvCbT6cSx2WowmzJ
gpL72/45BLnhoKC3eFJd+PDLwH+C/kBWSv66QPwS5+om9OpSzWeMUsB7+FiRVJHd
bdI1FBsoD1rfBNMhLbp+64XOCRq0zPdSb7wfdGV4SDoTC24G71gQMGZaJNp0QXX9
cckXY/fzDwWFqwMGrQqye9pgbx8ddFxUufkOMmHmvfdGDVQAshM=
=r0BM
-----END PGP SIGNATURE-----

--Apple-Mail=_105B497E-7AFF-4808-AEEC-204B0DF856DA--
