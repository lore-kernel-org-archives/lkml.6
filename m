Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6769C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C79C208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="PJnMqNQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C79C208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHQLrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:47:10 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:27971
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQLrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtZo9WOB8j8DUX3s/Ow0pSF0CSSiRD+wsURhvaVAdWY=;
 b=PJnMqNQzku/+tbg3QXVfrPy/hMkqZlYGngr79og5b9QGbbD40KE23lYgao/SMnRuZxj1oot6hIAZnBhMj1YqTd/KgOT04LyPjiy6kCAdi2VYnDE8btJTOIhCntIjbxUe+a+0W4qQ7+EuqazbSRAWkP5hOg25IC78vNXWE2gtSog=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB667.namprd06.prod.outlook.com (10.141.227.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Fri, 17 Aug 2018 08:44:31 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.021; Fri, 17 Aug 2018
 08:44:30 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Thread-Topic: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state
 logic to core
Thread-Index: AQHUNVUeXq4DdiVw8EyZjeI6nLyujqTCh+WAgAET/YCAAAZ2gA==
Date:   Fri, 17 Aug 2018 08:44:30 +0000
Message-ID: <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
In-Reply-To: <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB667;6:GhERP6xNgYajOYCFtn7b1xQNb4Z/1bOPVz7wYPXWw8ETtawR1FSJAr7zB/92rIWjZ+aG35Uk1jJ/5pF4XbnSr/BB7NItFVK3A7/KLHnuTxhX565YGcEI6ixrsiKEmFXUC7538MUn1Jhjk5dLMyGEWcdTUeJ6aJoB629amwjMmuaEqK4fe54ErD0dfKM0OpE8hNhvKlGdnHjn1Ckt787lUVBvyktxFVW4Zwpd3r1Zw3+pLuENEpWlJquuFHem1Z/SD0S0Zz8RYjsjI15olh1iuXtXa5Wbhnn0/eT1Vb7QDpFIqKpoUV2WD1zbpIWKoSyUP12earK6AsruEQ3P6uCVVNJZCArTHtQcgbMM0UtQudNGty0+e5VDuTBAPbsK0K/bnBD9L1tLV0IHMBYXEw4VZ3cgNf8R6seZB01ncA1085TtPTi5KtZDMCxMLx2NgPn9OaiIihHkyEqR+6u3TNFn4A==;5:ILYqjOInnKXGqfG0OGaAr1Cg8dH+Rd9oO3QF36Xkg5qUfjR/9AqorT+6zCOk4BTT2VK/1wkINqVHj7XXvPOCevs2tw6oLrgj+bzav+YZnOY2vsbhiQvYCI/hp2saeKSCITbBFfXG5oUNP5heyV3Qwj3qCIypm+eX41H50OOZSMk=;7:vP7y6XwxCrhRaCs3Q1Dgg4QvnWn3/gKIXyvpFESiSebMfwLdkk3M7BYTJM1aONxy5Lx1mPKDEjj8MzDAoU8tAn+IJJFG2UmGXgrHpy+trQ4OiCG3JIlQMAj43sN+tuL9KgKX5EQAOkq0aA6Rcv368uzD6jUs4iv+KfI8TNkhUyhlMWXYL+gRzzMM4jo00lhFNLh6/YlMpwFt2JUmbDqsQcy8hB/8zz77PLOcFhkXmzXELdiSHcMAtRUkYvTZZiov
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39840400004)(189003)(199004)(6916009)(54906003)(478600001)(99286004)(106356001)(105586002)(2616005)(476003)(66066001)(446003)(33656002)(99936001)(11346002)(83716003)(486006)(68736007)(5660300001)(2906002)(14454004)(316002)(36756003)(229853002)(97736004)(2900100001)(25786009)(81166006)(8676002)(81156014)(7736002)(53936002)(305945005)(6246003)(4326008)(6436002)(6116002)(186003)(3846002)(6486002)(6506007)(53546011)(26005)(6512007)(5250100002)(86362001)(76176011)(14444005)(217873002)(8936002)(256004)(82746002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB667;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 7d3f07d3-d0b0-494d-13c6-08d6041da609
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB667;
x-ms-traffictypediagnostic: CO2PR06MB667:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-prvs: <CO2PR06MB667055276E24671D3479AB9BA3D0@CO2PR06MB667.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301058)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB667;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB667;
x-forefront-prvs: 076777155F
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cuwtzYHCwSuOpGWP6fzq1Vmv8oSqOsEE2ZBSyfEns+g3GOAsWeaUCLmVmd325/xAeGqJap/fsQ2lQ77pp27Ol9Zdi8YKIEP8pP42dwizgQEQdbZMgi+REmvsDt/EnFeGMYagZeVfOrRjno1VSNGu4iy+NtrXF+2QoqqVKCXCDajGExcbzlHqq3jR7UzzWpA3cHm0oy67SYdy49cYGEBe/guBX94yg9mjLPXmr7C+huakVdUqoBzpf+fhGpdjV8NcW4G53slblUatgHLXrDAkjac7bJN8tXc2iXVK0OTnK+lz6BBml87+VBZVN+MLxJZHiG7jGPZrlinWZvWlEnzkm17gv8/9bDGmjj/RfrDolU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f07d3-d0b0-494d-13c6-08d6041da609
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 08:44:30.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>> core.
>>>=20
>>> Hi Javier, I did not end up using your patch. I had misunderstood =
what
>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>> first sensing the first page, then the last page, and if the chunk
>>> is sensed as open, a per page scan will be executed to update the =
write
>>> pointer appropriately.
>> I see why you want to do it this way for maintaining the chunk
>> abstraction, but this is potentially very inefficient as blocks not =
used
>> by any target will be recovered unnecessarily.
>=20
> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>=20
> Note that in 1.2, it is
>> expected that targets will need to recover the write pointer =
themselves.
>> What is more, in the normal path, this will be part of the metadata
>> being stored so no wp recovery is needed. Still, this approach forces
>> recovery on each 1.2 instance creation (also on factory reset). In =
this
>> context, you are right, the patch I proposed only addresses the =
double
>> erase issue, which was the original motivator, and left the actual
>> pointer recovery to the normal pblk recovery process.
>> Besides this, in order to consider this as a real possibility, we =
need
>> to measure the impact on startup time. For this, could you implement
>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>> recovering (i) asynchronously and (ii) concurrently across luns so =
that
>> we can establish the recovery cost more fairly? We can look at a
>> specific penalty ranges afterwards.
>=20
> Honestly, 1.2 is deprecated.

For some...

> I don't care about the performance, I
> care about being easy to maintain, so it doesn't borg me down in the
> future.

This should be stated clear in the commit message.

>=20
> Back of the envelope calculation for a 64 die SSD with 1024 blocks per
> die, and 60us read time, will take 4 seconds to scan if all chunks are
> free, a worst case something like ~10 seconds. -> Not a problem for
> me.
>=20

Worst case is _much_ worse than 10s if you need to scan the block to
find the write pointer. We are talking minutes.

At least make the recovery reads asynchronous. It is low hanging fruit
and will help the average case significantly.

>> Also, the recovery scheme in pblk will change significantly by doing
>> this, so I assume you will send a followup patchset reimplementing
>> recovery for the 1.2 path?
>=20
> The 1.2 path shouldn't be necessary after this. That is the idea of
> this work. Obviously, the set bad block interface will have to
> preserved and called.

If we base this patch on top of my 2.0 recovery, we will still need to
make changes to support all 1.2 corner cases.

How do you want to do it? We get this patch in shape and I rebase on top
or the other way around?

Javier

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2iusACgkQIX4xUKFR
nnR4ThAAv5nuGq6jJLoVggIyNEeBCyIWNeFX5hXc0GYokhpeq2RlHXiQc13BtKt1
39hDwMzyqE/0/fn02H++/L/Buk2teN85FezflIAcBLdUxNaK/VTDbKT7xgBBZGdY
R4uvFyM7pKP+E18ZcZy0hz91fgOYesHVe/V6WB+6ZjBk1cSjNGlYdoRUoxcuuCeh
933YNlH58d4Lpzg3yQT7vIXjNl5zGjCMhfMsAi4UxbKShBlDRUaxQe+yyRRCj4Je
3Rs6gTaqxcqmA2q81f3CVO7j8nbqquWfhZs0ps1sEDzvDUqXvnGay2bvjwcCDoEu
djXJpYSDRpIgiBp+RSL4juLh4Xhma5BUk/bwno0inGrDg1LqlBZRvMyw0gHumxWb
pF5mwELEGoVcHOZENdwcoNfYQRK5GGICIIn1moWDSmVteouOHT3RhjQJ06sQNBVN
lbUjTtTkD7sLjWTnW6LqDPAWRykpyIBp6jMPNVVNPVc5/rD+vFxp73jeFlBowpHp
Vi5Vfz/AP6330HrDff84Ae9wFUSch+tGy4gLbGxIwaCqgl7I5WfIqDnYmvRvvXJ2
9qOJkyxYzMKTOWLNHwMZ9CKa1aiet+jTtnm46lZS+/TfzxB/2vk67L02CR5khsvS
Zb3NZoFyvD7PwS+ezpvn8y1WnN0kad9KGy+pwhmQariFmPCMIJE=
=pTAb
-----END PGP SIGNATURE-----

--Apple-Mail=_7142A1B7-D2C3-4EEB-804B-12D816CAA67D--
