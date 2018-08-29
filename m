Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1494EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C73F2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="dBWaJnT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C73F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeH3A4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:56:46 -0400
Received: from mail-dm3nam03on0040.outbound.protection.outlook.com ([104.47.41.40]:45568
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeH3A4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz3bqZah19iGqdhYGms3FQaRwmxzw7zy9AiXxzPMqsU=;
 b=dBWaJnT1bckLC7z4IZMjaDEGUmesZCMwGyrK2z8ULcybKukymr8FsUNgzIu3cW/dcrdNZOtwNDhja0IzuVy1XtVt4I3xhfnMkHb2ZJpGF9FHN18w419svL/kHf9b9BWJmVrCH/nvr0+j6ZhZ6CEPOK3wyQH+y02iRmnDLzJvffE=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB620.namprd06.prod.outlook.com (10.141.228.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 20:27:58 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 20:27:58 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move ppa transformations to core
Thread-Topic: [PATCH] lightnvm: move ppa transformations to core
Thread-Index: AQHUP6JXMQHgsmGWcUG2JTf9O5+qOqTWyogAgABju4A=
Date:   Wed, 29 Aug 2018 20:27:58 +0000
Message-ID: <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
References: <1535551926-4731-1-git-send-email-javier@cnexlabs.com>
 <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
In-Reply-To: <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB620;6:zCHmFxJvwt/yECe0Oi3zT9/B4jR+csDfZSEeNWD9sKzoYwGhnnAxFAiSrtlD7oB4VxFw5ojn7U9spRK6QawGUa4bbS1wuveSFqilXs0838F29a+j8vT799zNpzcVJoEAV785+Kb9V5mY0ePH9c4JkRzjCyYcbi0wGkOI2/JJRJYTHBlwZyacNilC9QyE+igFamkHl+cFbSlnJRCG3IDo9XNHvuaZqMuJudiSL94unYczKvkyXwreLVztD3QvWrlBIBkInAJAP8pCBpuDkTfeeE8iyur1CvzZXnCjt0463hPThrw9RNjNB2/yqIXcsYsGhKkj8wMIUtU/wlch+uGaDt3JTe0oK88/S8VUNSKgMApuzv+jPqaIJ3T99LFwB9B+es1h73niMND8oMPaAykI17Z8YEXRgMHllwJmeukuvSABnZl/gGJuGAEEOzN/rUi5ucSaK8t5Rm/nX5PCG0iI6A==;5:7LGyMKYb16ehfAfT7apZxV3YqEmtEsRLaOO2dddrFeybUInhzmSB5Zn77f9FdqIjew8/xMNKK0NPXh3UQxtc64gwZS7B5VjB3trtop+Ofn6IiuxHlqUhk2PjXjre7RANR7X/4eGNy60VDi+f+541C86f9aDZmRkBqUBmAc4t5P0=;7:sfFXBd7fdPowxEAt/0cl33c2LOa61GS8YQCfH57+g8M5oN4U+DN7MyjBMMNo69qSg/Ouh9tDbXrnLv510kJfrZtnuxTa525V3qMMUoZW4Ixkfb29CdZszlIcB4nyUBmWMOAwHLJFMFI5aZWNv5Hjet+Gql9UMkuNRx3XGBYWd46KzoOCbIDZ3vUXP3KgIb/4Hy+6rAhPIxP32zLspXzesklDliV8LeZ4CvtByeqcNoV1ECCZkmsEyNslXUdDW8iN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 325e6320-bc22-4deb-060f-08d60dede8b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB620;
x-ms-traffictypediagnostic: CO2PR06MB620:
x-microsoft-antispam-prvs: <CO2PR06MB6201A6D2DC69C51EDA74D8DBA090@CO2PR06MB620.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CO2PR06MB620;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB620;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39840400004)(346002)(366004)(136003)(189003)(199004)(8936002)(5660300001)(11346002)(446003)(6512007)(99286004)(229853002)(8676002)(53936002)(97736004)(81156014)(81166006)(82746002)(76176011)(68736007)(25786009)(36756003)(26005)(6346003)(86362001)(575784001)(4326008)(256004)(102836004)(53546011)(14444005)(6506007)(186003)(7736002)(105586002)(99936001)(6246003)(83716003)(5250100002)(2900100001)(2906002)(478600001)(106356001)(66066001)(476003)(2616005)(54906003)(316002)(33656002)(486006)(305945005)(6436002)(6916009)(14454004)(6486002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB620;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-message-info: 6tSq2SWr38Ppv0PsJope6fLRiud/K+eMfko7jVjSZsySnc8L9uRXF8+XWioRDb1MZAgwOI/YiAxexEqBd6Gb72ZMEYZWdwZezZJu5B1U5WoVpyS2hxiQ+p6Kyf9FeeVZhAcmfnHFBROjoyLmO+MmdfyD5RIUa7p3WuPB2GEfL92oZBcA/IJiniIknRc5fGzLjudJwcc8gBXyjKOUE2rUh1TIero53OoxPQE49ZPzMOmomoBW8VEkWR22utw+0zmnUm6a+1ypb1ctTMOhQIa58x38ATKN3XDJ2phAwLuSavBjXwNBrqtchdDkOw1B6GDI65gTIu8MpHnAj68sACu0BVsoUJKS1P6puCtovrQT6J0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325e6320-bc22-4deb-060f-08d60dede8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 20:27:58.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 16.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 04:12 PM, Javier Gonz=C3=A1lez wrote:
>> Continuing the effort of moving 1.2 and 2.0 specific code to core, =
move
>> 64_to_32 and 32_to_64 ppa helpers from pblk to core.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk.h  | 78 =
+++------------------------------------------
>>  include/linux/lightnvm.h | 83 =
++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+), 74 deletions(-)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index f95fe75fef6e..88ff529290f8 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1086,86 +1086,16 @@ static inline u64 =
pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>>    static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk =
*pblk, u32 ppa32)
>>  {
>> -	struct ppa_addr ppa64;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  -	ppa64.ppa =3D 0;
>> -
>> -	if (ppa32 =3D=3D -1) {
>> -		ppa64.ppa =3D ADDR_EMPTY;
>> -	} else if (ppa32 & (1U << 31)) {
>> -		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
>> -		ppa64.c.is_cached =3D 1;
>> -	} else {
>> -		struct nvm_tgt_dev *dev =3D pblk->dev;
>> -		struct nvm_geo *geo =3D &dev->geo;
>> -
>> -		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> -			struct nvm_addrf_12 *ppaf =3D
>> -					(struct nvm_addrf_12 =
*)&pblk->addrf;
>> -
>> -			ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >>
>> -							ppaf->ch_offset;
>> -			ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >>
>> -							=
ppaf->lun_offset;
>> -			ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >>
>> -							=
ppaf->blk_offset;
>> -			ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >>
>> -							ppaf->pg_offset;
>> -			ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >>
>> -							=
ppaf->pln_offset;
>> -			ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >>
>> -							=
ppaf->sec_offset;
>> -		} else {
>> -			struct nvm_addrf *lbaf =3D &pblk->addrf;
>> -
>> -			ppa64.m.grp =3D (ppa32 & lbaf->ch_mask) >>
>> -							lbaf->ch_offset;
>> -			ppa64.m.pu =3D (ppa32 & lbaf->lun_mask) >>
>> -							=
lbaf->lun_offset;
>> -			ppa64.m.chk =3D (ppa32 & lbaf->chk_mask) >>
>> -							=
lbaf->chk_offset;
>> -			ppa64.m.sec =3D (ppa32 & lbaf->sec_mask) >>
>> -							=
lbaf->sec_offset;
>> -		}
>> -	}
>> -
>> -	return ppa64;
>> +	return ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
>>  }
>>    static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct =
ppa_addr ppa64)
>>  {
>> -	u32 ppa32 =3D 0;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  -	if (ppa64.ppa =3D=3D ADDR_EMPTY) {
>> -		ppa32 =3D ~0U;
>> -	} else if (ppa64.c.is_cached) {
>> -		ppa32 |=3D ppa64.c.line;
>> -		ppa32 |=3D 1U << 31;
>> -	} else {
>> -		struct nvm_tgt_dev *dev =3D pblk->dev;
>> -		struct nvm_geo *geo =3D &dev->geo;
>> -
>> -		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> -			struct nvm_addrf_12 *ppaf =3D
>> -					(struct nvm_addrf_12 =
*)&pblk->addrf;
>> -
>> -			ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
>> -			ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
>> -			ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
>> -			ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
>> -			ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
>> -			ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
>> -		} else {
>> -			struct nvm_addrf *lbaf =3D &pblk->addrf;
>> -
>> -			ppa32 |=3D ppa64.m.grp << lbaf->ch_offset;
>> -			ppa32 |=3D ppa64.m.pu << lbaf->lun_offset;
>> -			ppa32 |=3D ppa64.m.chk << lbaf->chk_offset;
>> -			ppa32 |=3D ppa64.m.sec << lbaf->sec_offset;
>> -		}
>> -	}
>> -
>> -	return ppa32;
>> +	return ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
>>  }
>>    static inline struct ppa_addr pblk_trans_map_get(struct pblk =
*pblk,
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 77743a02ec0d..7107a8b84039 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -506,6 +506,89 @@ static inline u64 dev_to_chunk_addr(struct =
nvm_dev *dev, void *addrf,
>>  	return caddr;
>>  }
>>  +static inline struct ppa_addr ppa32_to_ppa64(struct nvm_dev *dev,
>> +					     void *addrf, u32 ppa32)
>> +{
>> +	struct ppa_addr ppa64;
>> +
>> +	ppa64.ppa =3D 0;
>> +
>> +	if (ppa32 =3D=3D -1) {
>> +		ppa64.ppa =3D ADDR_EMPTY;
>> +	} else if (ppa32 & (1U << 31)) {
>> +		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
>> +		ppa64.c.is_cached =3D 1;
>> +	} else {
>> +		struct nvm_geo *geo =3D &dev->geo;
>> +
>> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> +			struct nvm_addrf_12 *ppaf =3D addrf;
>> +
>> +			ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >>
>> +							ppaf->ch_offset;
>> +			ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >>
>> +							=
ppaf->lun_offset;
>> +			ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >>
>> +							=
ppaf->blk_offset;
>> +			ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >>
>> +							ppaf->pg_offset;
>> +			ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >>
>> +							=
ppaf->pln_offset;
>> +			ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >>
>> +							=
ppaf->sec_offset;
>> +		} else {
>> +			struct nvm_addrf *lbaf =3D addrf;
>> +
>> +			ppa64.m.grp =3D (ppa32 & lbaf->ch_mask) >>
>> +							lbaf->ch_offset;
>> +			ppa64.m.pu =3D (ppa32 & lbaf->lun_mask) >>
>> +							=
lbaf->lun_offset;
>> +			ppa64.m.chk =3D (ppa32 & lbaf->chk_mask) >>
>> +							=
lbaf->chk_offset;
>> +			ppa64.m.sec =3D (ppa32 & lbaf->sec_mask) >>
>> +							=
lbaf->sec_offset;
>> +		}
>> +	}
>> +
>> +	return ppa64;
>> +}
>> +
>> +static inline u32 ppa64_to_ppa32(struct nvm_dev *dev,
>> +				 void *addrf, struct ppa_addr ppa64)
>> +{
>> +	u32 ppa32 =3D 0;
>> +
>> +	if (ppa64.ppa =3D=3D ADDR_EMPTY) {
>> +		ppa32 =3D ~0U;
>> +	} else if (ppa64.c.is_cached) {
>> +		ppa32 |=3D ppa64.c.line;
>> +		ppa32 |=3D 1U << 31;
>> +	} else {
>> +		struct nvm_geo *geo =3D &dev->geo;
>> +
>> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> +			struct nvm_addrf_12 *ppaf =3D addrf;
>> +
>> +			ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
>> +			ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
>> +			ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
>> +			ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
>> +			ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
>> +			ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
>> +		} else {
>> +			struct nvm_addrf *lbaf =3D addrf;
>> +
>> +			ppa32 |=3D ppa64.m.grp << lbaf->ch_offset;
>> +			ppa32 |=3D ppa64.m.pu << lbaf->lun_offset;
>> +			ppa32 |=3D ppa64.m.chk << lbaf->chk_offset;
>> +			ppa32 |=3D ppa64.m.sec << lbaf->sec_offset;
>> +		}
>> +	}
>> +
>> +	return ppa32;
>> +}
>> +
>> +
>>  typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
>>  typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>  typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk =
*,
>=20
> Thanks. Applied for 4.20. I've updated the global =
ppa[32/64]_to_ppa[64/32] to prepend nvm_.

Cool, thanks. Should we do the same for the rest of the helpers =
dev_to_*?

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluHAcsACgkQIX4xUKFR
nnQbqxAAh1oQmOwBc0J+yrF7OIyrc5UuvHsfeDoVNu2dUE+VoFD8Rq/7ZuCWB6i1
3nbwQ87TW796rVJdeh6XpK8vgqLt+dK+QdZ/veR/rmqo4ld/1QjDlKzCXnCbIkZr
0Zo5JqalOzb1q4RelDvUUX4ydlWwsGytPkRML/nKHbhIRmLF+ieHqcppa6bTguUK
zHQ6XqabgtoUywDDbFAzAH5krzOyeJNFSr58w9RbWHxybX6Kd0b8wWae9t6wbQeu
Q+kNm3kNaQC/ReKerbdvcUcfV7ESU3OQWppKwqR4ceCYP4IeXnsqQkkfegpm7Vgp
vSAQ7NdaVA6A8OkgYTqCqDHu8JiOjTJBPJNlusCXY4urLkdaR6FNWlrglIKydq/H
WgrcLtBHkmQYu/7EELXjWZn005eyQeMzfyqEpkumsnOO0/jCVrJQEeajjf2LTjEG
X1F2C9sHzbKgHEgrV0gpuUUq6zyUxxNrTYH8kDhYNbvl2wTWf4TjGpPYsXVSFrNp
VQxS9/RB76GYvLT1LhgE8bQSukp+wxe5SvktV7oEtQTfErO9mh7fY0LcxRKa8mKf
Q7V6cik6VaDqvqwVjX2cAFxNzM1O1Y2V9xy10FFzj2R/Xx0d5JVPVd+Pq9rt/+SK
qpMKRd/SIxFk36I/vpkMk2J3F5M+FVT7fwJKyHX4QM3u6yKOmhA=
=bMcL
-----END PGP SIGNATURE-----

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A--
