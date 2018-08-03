Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1873C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE922175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="pUQ7vfo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE922175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHCPZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:25:27 -0400
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:35776
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728343AbeHCPZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRp6Ov+YSfevN4nFap2aDbLw0eGG+cQhrFzB3k2p+Rw=;
 b=pUQ7vfo6eceCjcsTpJQ5G1McSkwOk3M4gHLtxPuDJWI8fOQTAjBOWQnh8t3BmXiVhq/DL4Ug6AZBLhM04n5t5OlQV+X3uc3bb2RwAGTOC5Zo/HuQZD5JyR32tmVQC3CaRLZP0606CZji7OyPd1twMI/2sbTZlhH3aAveF3sAet8=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB604.namprd06.prod.outlook.com (10.141.229.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Fri, 3 Aug 2018 13:28:49 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 13:28:49 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [PATCH] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUKyJQe+3PaSCbSkm1sOFrOOSI6KSt+VaAgAAMM4A=
Date:   Fri, 3 Aug 2018 13:28:48 +0000
Message-ID: <DC0080D0-BB8B-45C6-9CF8-CAE451F6CEB4@cnexlabs.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
 <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
In-Reply-To: <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB604;6:VL1R8v5CKnFa//W+5dP25RxbGn1hXLsSck7tiPa2xYofH8kvlgoOjW+he3s+o0eDoHQIj3m3liMxoJdE7iv0BGhvyEgXodpubIbgGo37+OsPpsWTw8bg7qNi9Sj65tOwzOIcXwKVuSr4ukxKOC5SIpLrT6t/R7Q2UMrd367Smd2z3nGOwyI1i/6s1WoGGtj+W7966iQsXAytlabcqL1vjeaCVsKDpP65NTBjivo/pUjI+JqxcVQM4Ch8+FhoKH6dzXASbmvmDAoSrER5nvr6Pj7wbRBa+I1fzpq2Knfk+9cTrh4HvMVv7aCuqS4t8M4Xcy8rELP0ObSN6BaS++apEspMay4z3duoI3o0vw7J4sRRmV6hhOvS3Rk4f1DDNwcGyr1inxBCqYEGjHvu6sHtyickm5dipf8WFT/u8nNklv4+kdHoysN45IBkxoJllaWZRNevKZaBrirzannwW0ddPw==;5:PyaTXFG+3gqGz57vFO8k7ixhxs4aWUAH31PfFkjoOBy7Ufj+XDvXaqHWX6bx1zNXxgTtdnjEI97IhqaCcl/LLYf98Rsa1KQMO8Z05B9mUNoq9r4jCGrqoIt+j7JjmTiBsocw2HuIYSxu8fccBwIYYACuOyir77Bmy+LzRy7JC1k=;7:+kPIhdweDGYk/JuD1a2ilLqfompjHJvl+wtwEy3iNeUhnAS838jBubAkxeYIcFIYEcpWRFHVpeA45A3fvK+48f0xtyWr5D/rO7Oe43DFpZ7P34LUEvUN4eKCBQD1LEPxPor4cb/7RV0vokzMXKxFZ0ZrNCTCduAD4+crr9shSsxT4ji/aiudSigOLHMmDpDTXyPtiwwy2kxYO+0QR8bVtUzbVHTrco2sw691R/dvNgXHlByfLoGotlPew4ZWeG8n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 641f0c8b-dff0-4943-f09e-08d5f9450be1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB604;
x-ms-traffictypediagnostic: CO2PR06MB604:
x-microsoft-antispam-prvs: <CO2PR06MB60449349C0C7603B0BE3C7DBA230@CO2PR06MB604.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB604;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB604;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(102836004)(106356001)(7736002)(8936002)(81156014)(81166006)(33656002)(82746002)(6486002)(5660300001)(3846002)(2900100001)(68736007)(25786009)(6916009)(26005)(256004)(99936001)(305945005)(105586002)(66066001)(8676002)(6116002)(316002)(186003)(76176011)(36756003)(14454004)(97736004)(5250100002)(53936002)(6246003)(446003)(6512007)(476003)(83716003)(11346002)(14444005)(53546011)(6506007)(486006)(478600001)(6436002)(2616005)(86362001)(99286004)(229853002)(2906002)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB604;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: czm9fdZk2usksqpoggVphRt3r9qQurRnVu2Ay9wP3P5tDflB2OhixECbHNLe8G5oTFsT2RnsJwZ5PYh8+at6jGzacYEZQRWCWbbZXmvHjXZqjNS7A/+++Ih07PsIIRVDwd9kxfvocNglSnLf4vB/WyJO05O4lCDQeoZWXG4AEBnyv5DbdNhsthSWigAqaw8oFm4ex8dRK3pf5e2CVGKwH62tHKiDXkm27u7xVkvqPeBKmjgtIEz5gxOM/Mvcivdsjai4Iq3PnO46CqMUPTAEkTBIDIuBUGlAnf1/vbvmoRaaUKmQdOEuCW6XxF1LoKY2KXXEQN9moP4jBVLceefbImDH8x20WOiU+3jGNA9phzo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641f0c8b-dff0-4943-f09e-08d5f9450be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 13:28:48.9398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 3 Aug 2018, at 14.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:05 PM, Javier Gonz=C3=A1lez wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>> Since metadata I/O is synchronous, the semaphore is not needed as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metdatada scheme could =
cause
>> ordering issues.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>>  drivers/lightnvm/pblk.h      |  1 +
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 00984b486fea..160b54d26bfa 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  	return nvm_submit_io_sync(dev, rqd);
>>  }
>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +	if (rqd->opcode !=3D NVM_OP_PWRITE)
>> +		pblk_submit_io_sync(pblk, rqd);
>> +
>=20
> Why should the write be issued twice?
>=20

It is the read that is sent twice, that's why it does not fail. Rebased
the patch manually and messed up... should be return... I'll send a V2.

Javier

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkWI0ACgkQIX4xUKFR
nnSyZxAA3o90wct5QuotIp3eJs8dfDjyByXERkS6Xta3uPgW6Iw6RcnerT9wBXH8
Tz7pzC6ZiP2fSKKjo9RO/2RUBGeW5j1ERoe1BAsNac6CHJnMyNws1YtzXXKY2Hpa
2GlzIgtzlcEvGNWwjI0pz2C8+r1Z+033WstSKcOMDnl1EhuonsSD3jpRA0HSkGgu
gAHY4egE1YeMfuEzDVSH5aJOCH6v9ZJzSDMwpe9lVlfPNiWGbUw4mR0pcdOhNk+u
mleWXTENrw8uzhic1HhtosN/BrvcAr4W+9v/76KeHxjgLdZ9toIyD4qF1ASIhRpS
v2VcBnXckA+nURm4jFeHXrkeQEp1X03dCoTs/p1KwvKz9qWmdh8xMD9ADRmFchRN
IA3S4jEdVWLKZirM1bgYVQGiMqes+LN9BL2qEZq7lf747dthiciXYcOsz2u9E68d
w+A7OqM2GgJWbJ13SeS8ZVcgk0H/xhDyq853zs+QYmWJ9rxKR73gfKwlGH28YFib
hv6A5nGB/QcAlwmJoGHbNst6o2+/ELShq+HEHiWHInfJThAtQ1NLSyOJcGqOGN81
rbwruVXCDLxU9U/6H/3VSyIiKJ15/Y5r/3QJfLQDSgcpJPL8N8r1NhbIrWstdjlx
uKuQuP6YEqdVfJ0yuHayeTuaMNx1dDbgDrdbKKw8BL+bR++lz6w=
=scBG
-----END PGP SIGNATURE-----

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E--
