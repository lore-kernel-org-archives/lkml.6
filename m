Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B127C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D12064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="oySQtodE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeHQNwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:52:33 -0400
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:59221
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkQnVQCP9BS1QQM2a738ApPQRhHQx4jhHBKdgl8s+GU=;
 b=oySQtodE7m2GwaBYhtaR9DZ/7dl816VI1STPJWBm+RNhaQJS80b0XRh19fA8dLh5Uo92F1l1VkQLTKmMy6sJRuyeaE1MeV94r4eBiVgVEqBD7EUoBW9/R7dBju131FXlsUdO4DBuwAmMC613B89OtzaRI15wycYdsb19sWBkaMo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB906.namprd06.prod.outlook.com (10.141.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Fri, 17 Aug 2018 10:49:29 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.021; Fri, 17 Aug 2018
 10:49:28 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Thread-Topic: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state
 logic to core
Thread-Index: AQHUNVUeXq4DdiVw8EyZjeI6nLyujqTCh+WAgAET/YCAAAZ2gIAADJYAgAABYoCAAAI0AIAAEr6A
Date:   Fri, 17 Aug 2018 10:49:28 +0000
Message-ID: <F3989C76-24EF-4E26-801A-DB3E1CC45981@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
 <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
 <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
In-Reply-To: <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB906;6:xWsk2NYK2gow+qsb3HoJk28ru/9zwdWLmCzj6OJOoLOjGV0ZBlyQIPugJ4Fz8oBn7dOPP41mIPEAKYmvZfJ01gOHSX2c+kBR5nNTROqruiilSTIrUftXramea44jRpnBEC2Lx6j+lKdstWRiFn0Tc8d1I044b1S3MVdL8fMo649x4m8O5SsN65VphuSEkwgNL/WXfVEmRounnlXyPQKN4FGOlJMC2CagzIYJhMWFzqLmra/YUd6Fcz7cN/T37euIaay23RZtMep7KlGrcxEbCLReCMdNe1Rzrot2NSdVxGq/gvWvYcmfACzyib/+1/q8942xr5Q/L8GqjotqNEHGHW43L9jsUFAUw8p63tgLmdpcQ+Ib0KMmdUf34rEexG6Qi7YSlbwdVpaO2cZMZB8gebUWy1LYxlx2+6eC1h7OAwzfb4LioB6HHnV7Fo/ew/YFk1V8vFP3d959bypybRn7Kg==;5:8fk8lZe1DcF6jFZOHDhM2HY2O97tSJXYYflTWJ3217TJeos+P6Z3CmxvXVP5d6AXyjz+YslqK0ellAmuJsB9Y7WJVTURm/SllfyWwBEnCb1aAOAxNbI00bJzCmeHUC0XbbZJeoLQR8GWOiAW5q+i96TGKw7Av/EusYmtPOg5fC4=;7:TVUVDJ6CvP853/ph+Cgg0p4pu4S8rlU67mXkYlyjDV4225WGmE+A1h6S4I2bVroITWx9oF0xtE563ZlmE+nz4Q49Xg/U/x3NdLSHUEts9QNWInRoGgrQJGApmjt5XZEndKnG7zSWipP8YZ+5w6+FgpM9CEQ7C//loh4HeYUmPPDwnLpMLG3fq16oKT+qa3JSgptfk8JkSSrLUDt92YmKvVfyfogcLS+iI7FqPT3yqLaFDdOdqMz6eOGMohzw4h+Y
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39830400003)(136003)(346002)(189003)(199004)(256004)(14444005)(102836004)(53546011)(105586002)(86362001)(106356001)(33656002)(6506007)(186003)(25786009)(26005)(2616005)(229853002)(2906002)(7736002)(305945005)(446003)(11346002)(81166006)(217873002)(6436002)(68736007)(82746002)(486006)(83716003)(5250100002)(93886005)(8936002)(6486002)(53936002)(8676002)(81156014)(6512007)(36756003)(66066001)(478600001)(97736004)(2900100001)(76176011)(476003)(5660300001)(6916009)(14454004)(6246003)(4326008)(6116002)(3846002)(99936001)(316002)(99286004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB906;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ea012a7f-204f-4850-f268-08d6042f1b1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB906;
x-ms-traffictypediagnostic: CO2PR06MB906:
x-microsoft-antispam-prvs: <CO2PR06MB90688ABD39DAB715F748199BA3D0@CO2PR06MB906.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301060)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB906;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB906;
x-forefront-prvs: 076777155F
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T+e/+N7uWIE92RD8nN80V/MR0+Ru57OrRkXkNKhT7nUWTIORYT8PgCcbVVLOWdnIEcwR4zGqheXtnlPaAuLUGuVO6O2uJeNDBwGoS7k4hc1G/xiGz20EDonSixqMl19I/xGUrN79yvVTmaPpab2U2sEOIkhiDgT0EIgJhUIQPbztnLqN9qxf+15EQLzT1UEzvj5nrdocsv17nWIhsS4rKF20pgiLbid45PA6/NhhheIEHspuifDpCGFTIqSJWJd3pDhv5LOPAJVMQTbLbIBiG7RULWPsOTnOTl1fc9dCdfqOF1qYK6hEpWdWe2AxCXXn7vp6B7K4ppA47OtffyRFoyX1JwhLAUkwV6uCwi1qsEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea012a7f-204f-4850-f268-08d6042f1b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 10:49:28.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 17 Aug 2018, at 11.42, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/17/2018 11:34 AM, Javier Gonzalez wrote:
>>> On 17 Aug 2018, at 11.29, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>>>> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>>>=20
>>>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval =
to
>>>>>>> core.
>>>>>>>=20
>>>>>>> Hi Javier, I did not end up using your patch. I had =
misunderstood what
>>>>>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>>>>>> first sensing the first page, then the last page, and if the =
chunk
>>>>>>> is sensed as open, a per page scan will be executed to update =
the write
>>>>>>> pointer appropriately.
>>>>>> I see why you want to do it this way for maintaining the chunk
>>>>>> abstraction, but this is potentially very inefficient as blocks =
not used
>>>>>> by any target will be recovered unnecessarily.
>>>>>=20
>>>>> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>>>>>=20
>>>>> Note that in 1.2, it is
>>>>>> expected that targets will need to recover the write pointer =
themselves.
>>>>>> What is more, in the normal path, this will be part of the =
metadata
>>>>>> being stored so no wp recovery is needed. Still, this approach =
forces
>>>>>> recovery on each 1.2 instance creation (also on factory reset). =
In this
>>>>>> context, you are right, the patch I proposed only addresses the =
double
>>>>>> erase issue, which was the original motivator, and left the =
actual
>>>>>> pointer recovery to the normal pblk recovery process.
>>>>>> Besides this, in order to consider this as a real possibility, we =
need
>>>>>> to measure the impact on startup time. For this, could you =
implement
>>>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>>>> recovering (i) asynchronously and (ii) concurrently across luns =
so that
>>>>>> we can establish the recovery cost more fairly? We can look at a
>>>>>> specific penalty ranges afterwards.
>>>>>=20
>>>>> Honestly, 1.2 is deprecated.
>>>> For some...
>>> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 =
have
>>> their own storage stack and spec that they will continue development
>>> on, which can not be expected to be compatible with the OCSSD 1.2 =
that
>>> is implemented in the lightnvm subsystem.
>> There are 1.2 devices out there using the current stack with no =
changes. >
>=20
> Yes, obviously, and they should continue to work. Which this patch =
doesn't change.
>=20
>>>>> I don't care about the performance, I
>>>>> care about being easy to maintain, so it doesn't borg me down in =
the
>>>>> future.
>>>> This should be stated clear in the commit message.
>>>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks =
per
>>>>> die, and 60us read time, will take 4 seconds to scan if all chunks =
are
>>>>> free, a worst case something like ~10 seconds. -> Not a problem =
for
>>>>> me.
>>>> Worst case is _much_ worse than 10s if you need to scan the block =
to
>>>> find the write pointer. We are talking minutes.
>>>=20
>>> I think you may be assuming that all blocks are open. My assumption =
is
>>> that this is very rare (given the NAND characteristics). At most a
>>> couple of blocks may be open per die. That leads me to the time
>>> quoted.
>> Worst case is worst case, no assumptions.
>>>> At least make the recovery reads asynchronous. It is low hanging =
fruit
>>>> and will help the average case significantly.
>>>>>> Also, the recovery scheme in pblk will change significantly by =
doing
>>>>>> this, so I assume you will send a followup patchset =
reimplementing
>>>>>> recovery for the 1.2 path?
>>>>>=20
>>>>> The 1.2 path shouldn't be necessary after this. That is the idea =
of
>>>>> this work. Obviously, the set bad block interface will have to
>>>>> preserved and called.
>>>> If we base this patch on top of my 2.0 recovery, we will still need =
to
>>>> make changes to support all 1.2 corner cases.
>>>> How do you want to do it? We get this patch in shape and I rebase =
on top
>>>> or the other way around?
>>>=20
>>> I'll pull this in when you're tested it with your 1.2 =
implementation.
>> Please, address the asynchronous read comment before considering =
pulling
>> this path. There is really no reason not to improve this.
>=20
> I'll accept patches, but I won't spend time on it. Please let me know =
if you have other comments.

Your choice to ignore my comment on a RFC at this early stage of the
4.20 window.

In any case, I tested on our 1.2 devices and the patch has passed
functionality.

Please do not add reviewed-by or tested-by tags with my name as I do not
back the performance implications of the current implementation (on an
otherwise good cleanup patch).

Javier



--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2qDUACgkQIX4xUKFR
nnTHsBAA2sBWCHyicdxggssMKimMN6V5OGI/VGbfo5PMiS2/vYssbm/j2ZoMgATa
CA6S0G3vMrHllyjeZSlV5LUImZ5j4zif+LpqJd/UnznO8wU8F25pHvrvWxcNb/Nq
L6AOVkNpfbEZT4ZUAAMqfToh60+mnq/E8F3WMshq+/nd6qJvuFC2dTDfOnnZBtIn
8Lm+Kx2FENhF0OogBcGj2sydLVS6bbgs4xeZ8zhCDzzYiUJ9xDRXUUvrKM/XiNMI
/qS+a/OCGzl89JVejCkaoMPnptjgTk2/NE+a/FHra4VDPiuYwgKCZPtoMQr7M77c
nI3PJZrnmgOzEGV/eC0wbRLV/yxOSV+I32SwTFCbw5zM83l7SgHA0Th8uh9gVFDS
EinkHk1e3AqJ7s4aVtOo67scrX3U6D4jnYgoM064AgnMNP2INOwbP05vyUduwFzU
5wmsuaqaHq9E15yes+W/wcRyq9qraENnn/EuPETCAI/2dMpwr7P2/KDouJmTnTtg
hv+LGb4GxsjGXyGjyuNlhVR0UBWKwxY2sY9uGADHCop7z8HuqRfrBfqONvNgsizU
X+NuDDMp9RLprK/EYVHhiILhNjXd0EPureIWjzLCMERAbzJR8hCDbD4SKAJmZx/h
IowLZM8Otw0moyp0QANOPf9YMLe2OHoOAUys5D3AoEvVJrQLlJE=
=cd2f
-----END PGP SIGNATURE-----

--Apple-Mail=_07142667-0F16-4C47-974D-D324BD09215B--
