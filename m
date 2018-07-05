Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5977C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0E24192
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="T8TWFBfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC0E24192
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGEHOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:14:45 -0400
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:40871
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752742AbeGEHOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93nOqgNqJzYGq0Xr2GBB0h5OIpIrV1E2AAbb2eZk7po=;
 b=T8TWFBfeyudSCvh2XMSgiQf+0sC7DEvONxnYV6NaVbUAu6hqfRecfCTYMIjWsy4glYdilQAzj7WMkhjEWg6YgYMs58q122yEM+0fzrj1wZyGMiipkZPi9WKzJwOmYbWG9560FxFwzBIR294MYv/vV7Fp5OfpmHKxaQqmkCSQiOs=
Received: from DM2PR06MB544.namprd06.prod.outlook.com (10.141.157.151) by
 DM2PR06MB879.namprd06.prod.outlook.com (10.141.104.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Thu, 5 Jul 2018 07:14:40 +0000
Received: from DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::45a7:a991:6196:1e6c]) by DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::45a7:a991:6196:1e6c%2]) with mapi id 15.20.0906.026; Thu, 5 Jul 2018
 07:14:38 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: limit get chunk meta request size
Thread-Topic: [PATCH] lightnvm: limit get chunk meta request size
Thread-Index: AQHUEdsSzTW28Ywxt0+HVRJbpGneyqR931SAgAABMACAAlttgA==
Date:   Thu, 5 Jul 2018 07:14:38 +0000
Message-ID: <FA6B99A4-5CDA-4F43-81B1-F05303F63EC1@cnexlabs.com>
References: <20180702080223.13214-1-mb@lightnvm.io>
 <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
 <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
In-Reply-To: <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [84.127.177.10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR06MB879;7:dCwTrQYJ7MmgD3WKrFbuIMv2lH3eJTZ9Tj8Rxvxon9rpcxwAAmSfm3U+RxKcJvimaY+G/fCFYOv7//GB/BEZrr4aKeuomj2ppLhMXdVQkKtqefnoALqNfrFmatGMICd6My198biU76L0UDgSAr1wr2NRBmQarNsxxQKAptlfL8IAZ/bNEen7NfyQ1TCfK1gypUXeiWvzXhRZ0DSyAAJp9jlJe2zFoKbrzG/k2iqAF+3eAKW9m2ss3xXMWEyu5j3T
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39830400003)(366004)(189003)(199004)(81166006)(105586002)(6512007)(99286004)(53936002)(82746002)(229853002)(99936001)(6486002)(305945005)(2900100001)(36756003)(54906003)(8676002)(81156014)(966005)(25786009)(6306002)(478600001)(6436002)(7736002)(6916009)(316002)(8936002)(68736007)(6506007)(106356001)(476003)(5250100002)(14454004)(33656002)(6246003)(256004)(26005)(11346002)(2616005)(446003)(76176011)(102836004)(53546011)(66066001)(4326008)(5660300001)(486006)(86362001)(14444005)(2906002)(575784001)(83716003)(6116002)(186003)(97736004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR06MB879;H:DM2PR06MB544.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 2b16b1c0-0e45-43bd-23c6-08d5e246f833
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM2PR06MB879;
x-ms-traffictypediagnostic: DM2PR06MB879:
x-microsoft-antispam-prvs: <DM2PR06MB87913C12EB75ADC61F38E39BA400@DM2PR06MB879.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR06MB879;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB879;
x-forefront-prvs: 0724FCD4CD
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TfDTeCjc28QeBKqwb6YSdGgFmsk/BePzEi/Z5aaLx4EpH7NCFpIpKYoFMxJTtMGzYX8wRcLK58ZpEK01pNRiyaeGuj2tWN5y6GPmAiWx3L5BqcpKLzJVP61mNlhX9dW4gS30D5aImVWCQuHmVIjfwwBfpJ1lJHp675RUkA39n/W2/f1sjhvQsB4gPyGaXYae676h1Uu6Th4RbV4FDpAaMRwjgm5LecskL5/cwopijkW1rDTxIq0YfeG8ozgAa3+SPJCcbdUrg22b7Dmnr4Dp6qIvN6z1SaddQz9vB3wNHyLKT0A/j4CAzXWcQsTpuCpXB7CQcjcj1wrw0rG4WK4mTTUblxe6Fcy5EVmxvaHk+ck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16b1c0-0e45-43bd-23c6-08d5e246f833
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 07:14:38.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Jul 2018, at 21.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 07/03/2018 09:10 PM, Javier Gonzalez wrote:
>>> On 2 Jul 2018, at 10.02, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> For devices that does not specify a limit on its transfer size, the
>>> get_chk_meta command may send down a single I/O retrieving the full
>>> chunk metadata table. Resulting in large 2-4MB I/O requests. =
Instead,
>>> split up the I/Os to a maximum of 256KB and issue them separately to
>>> reduce memory requirements.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 10 ++++++++--
>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>> index b9989717418d..3b644b0e9713 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
>>> 	struct ppa_addr ppa;
>>> 	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
>>> 	size_t log_pos, offset, len;
>>> -	int ret, i;
>>> +	int ret, i, max_len;
>>> +
>>> +	/*
>>> +	 * limit requests to maximum 256K to avoid issuing arbitrary =
large
>>> +	 * requests when the device does not specific a maximum transfer =
size.
>>> +	 */
>>> +	max_len =3D min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * =
1024);
>>>=20
>>> 	/* Normalize lba address space to obtain log offset */
>>> 	ppa.ppa =3D slba;
>>> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
>>> 	offset =3D log_pos * sizeof(struct nvme_nvm_chk_meta);
>>>=20
>>> 	while (left) {
>>> -		len =3D min_t(unsigned int, left, ctrl->max_hw_sectors =
<< 9);
>>> +		len =3D min_t(unsigned int, left, max_len);
>>>=20
>>> 		ret =3D nvme_get_log_ext(ctrl, ns, =
NVME_NVM_LOG_REPORT_CHUNK,
>>> 				dev_meta, len, offset);
>>> --
>>> 2.11.0
>> Is this a v2? I remember seeing this patch being posted before [1]. =
It
>> still looks good to me :)
>> [1] https://lkml.org/lkml/2018/6/12/466
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>=20
> I changed the title. Since it didn't touch pblk. Thanks.

Makes sense. Thanks!


--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls9xVsACgkQIX4xUKFR
nnQ9ExAAg/Pzp3qFuVQJ0rXvLCqter9ymRRB9tgqtvI1eroUvhMCF8S2P392N7FG
fm2Z+bO+0+BLhEFWbBhevlzhQCqsL/CpN4fMEVwhbG8tRZLLI6YF0mzoBGj3yiQd
k33nQHd0VF3bZW+w4BSo+ZLlg+A8ER8vpm/cXpBp7JiZVzj5msbSDVxX1/nP0E2f
izH4XmbcpBdS2UMblLcy2DrPB6zaH9q//JzM4x83vFGN3foNxeKMIty2LaA9tCe6
nAQMKFUaqyC4b/SpnylDKbWTnNoXiCRDnHyuLOjeG4Vh9pWW5de/WVMuoKy4OS2e
KJbhNYGMI0e7brobU8/DKw1+aZ/U+tMXf9RILrakCw4SkvyLvzHVO7ietMcgfmL7
e6i0Xm1/JwsqTUpz2+SCYW50Nv+otZzHlxWJoHEIXVAQ1zONlZhAjkSQRHfNNV7n
NTPX8sBfhKoaT2gUvoZHVxvL/VPo2AvfpWfte3Pyeusoj8pACyX18bUWUNR9b/xI
cD7BFDhR+SxgHQi6DXLdAPnQUmmZYZI6hPC/yk+AsAu2UVOvoyBNfFbZvrh0ESFd
nDhRe6+RwxFVo83oyJmg24RY6BzdaUkvyUMlTiw+WIjCfAUL0y9rb0jgEX7B3flK
4/RrOIWIabCd6G96XFdtkwOoRiAB+TcYmkXwvvkN64BGX98ug1o=
=3+q1
-----END PGP SIGNATURE-----

--Apple-Mail=_EDB34E46-187D-40C7-8019-C9BD3CBE9B05--
