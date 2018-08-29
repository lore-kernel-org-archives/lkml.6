Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0935C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="ftJwXIGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0935C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeH2RH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:07:59 -0400
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:60019
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJFSzlw7vv9B9Tx5+uIirD1o5AaVXQkhhulHPqNdCqQ=;
 b=ftJwXIGX5AC2YFikqtbajaQCAPC/jUDzv+P4rIyLjeqAg7N9CPN5PO9V42e8ksGjvJ8AROE1i5XXfLA2COAV82dZPcfnQok4zOIvBhauIgQ2uROGzIQxaT8lLPh4vc+QfsdBRQrvVbsSLkJyi3QNK7jMhs1EecedI6TFd4W3FW4=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB907.namprd06.prod.outlook.com (10.141.228.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:10:50 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:10:50 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: add helpers for chunk addresses
Thread-Topic: [PATCH] lightnvm: pblk: add helpers for chunk addresses
Thread-Index: AQHUP3OnYbHHjGUCukWsrlNaEv2qQ6TWqscAgAAJuIA=
Date:   Wed, 29 Aug 2018 13:10:50 +0000
Message-ID: <A4C9F089-0BCF-4753-B3C7-AE166A14D489@cnexlabs.com>
References: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
 <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
In-Reply-To: <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB907;6:1rBmWaHiStKGuy9FK5l/5hs7eamCwNTroRR5XaeY2ol0gHJ9MaX80X7wz/B/SCD4SWaYED1cx1I7CdYh3/yGNMhU8rsn2BgxvleeIh2lKCJl56e2JK93A3P9Eh5q7oL8RUS1u7pZjEIFAJoZOnhbBJJv9aDf8gsU/1Zj3DP9QhMgSkQZi3rYbbAO2evVg/cXzdJR5gPB+GE7wGi/ZtjChnHyPKaUXUjbF5icfGsIjn3uXIfPNyArIde8oeC04pVr2VgzIOO6V1m3Uz17hedSDVniM6TxBiBaMtCk8CINMwBz8q6lUt4pJZ8Um7niBGgUVEdgGu3GtCDdwFnKZiP4XvEykhojznVJ6c1dnJ3axy4Fq+qRvC0I9fBZBCWKMEs8TN6/cCnDMLPbMQKKmaaJajxSqzgmIE3AmcpekjEo/J+GMDmn7wmlwM5TsPm4SNYPMuWM6e8Wtl2iNVUQzqo4jA==;5:Kd3QR+R9H3omJhXOrYrqnVokyjJbIGG+wzg3Cbp7SIA+4uwEMA/7U0UQIJTnY4b4Upvlk6pPi51EvwGCdqTuFzscBsUgPgg1jfQl6DjRwkm2GLFjPcBtGFUzdPNVXZVf1fMas2kZs/kOXVPPG8Le2WeJnC6c3pskcmPikD6OJdE=;7:2x1dPx/s5qR0iEoFcKqhrj3G4UjQRrafppfstKFyRjO2pgdfY/Hfd7PZNeksR5sbJ0Lze7L3Dzd0QtIMAl+5AGj71OUMV38lASCyet9JwuqhJPYDwcFTsKjt2TQNd1AdGm30ym4QQEX9KR2EzhjOKK7iVQr22WPUMyb0TFolictstesvEfhiWp83sdSpsyj4vblTwJsRAUO/t/aJSo/O2kcLwSS6EU8hAAeWxzAa7pnJsvkl5V/kHMc5mV3nyYeE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9913999-d362-4136-26c9-08d60db0d79a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB907;
x-ms-traffictypediagnostic: CO2PR06MB907:
x-microsoft-antispam-prvs: <CO2PR06MB9072D94E23850EDAF66D7BABA090@CO2PR06MB907.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB907;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB907;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39840400004)(396003)(376002)(346002)(189003)(199004)(102836004)(54906003)(99936001)(2906002)(83716003)(36756003)(8676002)(105586002)(106356001)(6116002)(26005)(3846002)(186003)(6506007)(53546011)(305945005)(7736002)(5250100002)(4326008)(6512007)(25786009)(53936002)(6916009)(99286004)(76176011)(6486002)(6246003)(6436002)(14454004)(5660300001)(256004)(478600001)(2900100001)(66066001)(316002)(86362001)(575784001)(33656002)(82746002)(11346002)(446003)(229853002)(97736004)(68736007)(476003)(486006)(8936002)(2616005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB907;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IDE7CrMCLoafJMJ3lbYnSKZbn4jiMycGJRE+aP04XT6z4ws1UxEgu8cLHLtXsE4yURbvbDEgEanjptc1qtd7O5OPEoZ0d/vpidIWYKi92Wx/Hv7VNCYU6ceWw6XAfzdNC2c0p1LdqsGqYBquos+BPOkwS0WryyCpQK/HKguDDwnlHT+CuO3JWtVSVtJaw+gLtly0CEQZBzbDsyz/AgIXOpqV9Pvp/Mb3WxPvsmcLY9AAKJkosjjX4MFVifB35yZcvRet0/oIt9ig2rCKaqqXX4TidLZ98r7kK5+tzo/4NvwtgUHiRYnA+IgQsZSwg7XqOa8Uh1mWwZRozX58zk54OHsJH0ToO06TboVXPmbBALk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9913999-d362-4136-26c9-08d60db0d79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:10:50.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 14.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:37 AM, Javier Gonz=C3=A1lez wrote:
>> Implement helpers to go from ppas to a chunk within a line and an
>> address within a chunk.
>> These helpers will be used on the patches adding trace support in =
pblk,
>> which will be sent in this window.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index be67bbfa3d0a..1bfbd3315598 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1034,6 +1034,37 @@ static inline struct ppa_addr =
addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>>  	return ppa;
>>  }
>>  +static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct =
pblk *pblk,
>> +							struct ppa_addr =
p)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line *line =3D &pblk->lines[pblk_ppa_to_line(p)];
>> +	int pos =3D pblk_ppa_to_pos(geo, p);
>> +
>> +	return &line->chks[pos];
>> +}
>> +
>> +static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
>> +							struct ppa_addr =
p)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	u64 caddr;
>> +
>> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>=20
> Please move this into core.

Wanted to wait until the rest of address conversions were moved, but you
can get a v2 for this.

Javier

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGm1cACgkQIX4xUKFR
nnTLvBAA0IB02fccBh8LAzNH9mgm3hVvwZD+k/EvxjrZQAoheRNHRd7qSegE90pO
b4OQdAGZns1wkljHnZAZpr94qKMC34lDL43DcMqHL15mLF0NeSHWr9W9Isqe454T
vR+8aq3+j2Qzzy3uUiEad8uscUUM12xFX2Ff+R4bpRAXR6D3WWtpw4m/z19TXe2m
2YMye629jp3IpB+wC3nn16PIWEml8JrDrEfk51lroaYkb8a9FlCjAq26p/i8fpqd
8nnwIPIZ+zsxs8Aw7Gf7xOjcIDVC4yKuTCIUgrrxXB2DYQxOciTMkaI3jJTG/xIF
N9V1wCzLTag8Nd48pvIpkrCAyz4fiwG/8MjAO9OAqRrbo4zQzRlS/na5S2sn7sp3
ckbaYuq3kdZqHGlM6/W6Vg56hG8UfmpYpfFCi/W7NjTJQqxHayirNxuQe+eQdVVh
phiUponvgsGqj7g8g4JYIC0aiOvKHXTFNa30CwKlCODRnUHjGZX+sFXOC8X9ICb0
WvAbsdmY/wXiZF2wRCKeaeuq0mH7DzCiHghgVSBbztUTkD5fasdG+BAp0mwHKTw0
FpVlk3XViSW+4FGxuawOV9PfU/NkPrFpb94Tx9mHho40iJ5B3BBMvRmB5hh8wpYE
nmh3eSaPtj6+ZWfVebYi5rWE7twZzu0IIQNpSC7MqyXgDmiEpPs=
=8zp5
-----END PGP SIGNATURE-----

--Apple-Mail=_13DE7CA4-87E0-4895-B6B1-0173F8920E7F--
