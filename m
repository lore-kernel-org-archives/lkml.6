Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF33C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC92188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="q05bOwV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BC92188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeHQMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:37:34 -0400
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:23409
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbeHQMhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDaohGrDRe/DZdl2Z6CuNO6/c69RrZxZ4JLh/MDz/+g=;
 b=q05bOwV3NLS7xGwVmZyZMkUNUFOG5a0nbn6VeufORs4cZWV8eCl7GXWsSK8OcVGX+rHyGFyQrkLCYQQt/SywY+fm6j6ICnfkSVJ57P176CLX1CNdpBqFL77lGv21mts/5+Ds3lLiJMCw4tbifsm/9XaMWh1c6YYNuA9QxW5zjrw=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB667.namprd06.prod.outlook.com (10.141.227.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Fri, 17 Aug 2018 09:34:31 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.021; Fri, 17 Aug 2018
 09:34:31 +0000
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
Thread-Index: AQHUNVUeXq4DdiVw8EyZjeI6nLyujqTCh+WAgAET/YCAAAZ2gIAADJYAgAABYoA=
Date:   Fri, 17 Aug 2018 09:34:30 +0000
Message-ID: <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
In-Reply-To: <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB667;6:su3071EloJWggb/ogaYeIrpo4++NXmmPE4wHVLwaO0W9Uj0zQy1KLVQwa3C6yRM0xE+tTZcd9vmk0lBztX/BN0SoOY4H3/Cc/+NvDpQjFASc09yldC4ZixLuHiCdAgihkXgwjITIqcsA3kIukcwaFJyuj1j7gt4g/mz4vdl3lLANXJ5DFqCL/VCFNB810oFdr80q3/GtcoqVlFU7Kqj/yNTY+0ogZ5lVi/XtA5iAw6KkzwGBJd03RZ/EGAMpfDOntLvbXhhLnRuTJ3GtVY8MpLOxrUN0FexPVxEtthN/UK9Pmefs++W1cWpCK6Cr8GG1rMCxFzzCB9AKNmrLYrzEg9hwK1Hy1XZJeNigS96F/D9aregl9ikylayDcz0aCtql01TwbBnr8/haM6w4EOvgtfs/RtQzhU7FgRQzWgaSCdmxl3JzGsMwtmt8BO+dSiiBKI+tinckLszydVE0gm+6FA==;5:KzYbe0UqgVg28sx6MvasB2SlNEyECFT/C2E+OVcEg3z9NvvcIWX+WJuO74VMQN9yFrInsxDUArCV5QHu6FsXf1gH7Obf60ioG3VWk/FeuR5rVhAwIi/1Gf9FlF4ZA1copPfrm398dOJ2oLm+Typm81Dy6/MkFbdwiBUQQCaSZqs=;7:nTN9RQkUtrrCIvQlPNcxltukE7HZpUc85OLVg+Dm7N6QPgq3t/USvJa1EZehk51luJzHxvgW3YisEj4XxPlhyDdBTgdeO2qE+7+DMGCGhK96V6jx/5+GHGBM8qMX5FTyRrvVfvmeW+KdW3k6K2Ya6p+hYvlFNzNpoK+oSCT8/jrrnfif++D2Ofdu68kRK2+364tabr7gFGq0MVyFyiURZBHcnyDJ2cE2wciuVLrH84Yij/Upo/c3bfZMv2rgNC7P
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39830400003)(346002)(376002)(189003)(199004)(6436002)(6246003)(4326008)(305945005)(3846002)(186003)(6116002)(81166006)(8676002)(81156014)(25786009)(93886005)(53936002)(7736002)(76176011)(14444005)(217873002)(82746002)(102836004)(8936002)(256004)(6506007)(53546011)(6486002)(5250100002)(86362001)(26005)(6512007)(2616005)(33656002)(99936001)(11346002)(476003)(446003)(66066001)(478600001)(54906003)(99286004)(6916009)(106356001)(105586002)(97736004)(229853002)(36756003)(14454004)(316002)(2900100001)(83716003)(486006)(2906002)(68736007)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB667;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 9da4995d-6024-443f-a5a8-08d60424a282
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB667;
x-ms-traffictypediagnostic: CO2PR06MB667:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-prvs: <CO2PR06MB667D5A6C950011034200DAABA3D0@CO2PR06MB667.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301059)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:CO2PR06MB667;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB667;
x-forefront-prvs: 076777155F
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QtxDGpctXt6+/WHicBdWZ6btzm2Idp7dvFncRKU99EgUayLLghnbBvAQX3pEB5aWyZk2gGNHZXHPLUFmocUTe9R3u4uklgKWNJTvwjANPTuFR0+IOdfwbuHb7OMwA5cg7ZSrIl4ewLg4G7aH5TTCn7OkWunZA5F1AO/auDSRXF2dZ1nmXYkcn+TYn4m3ubmBVmQIOeW06N5OqCWeUAdeMQ8Aw1/S/5AfzHk1Uk1k+w+kcKcPLFXu4Mf1byaBKcUlR5nhvG5OHsSk94yKoAlJ35nqmgI10a06vhq+ilJAV8soY4IyZZ+vRJ5Z44v1z+6hFqN6XJp1kCs+eacdHKCzKiRVfguWhiXDpFJbf1Qmk9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4995d-6024-443f-a5a8-08d60424a282
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 09:34:30.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 11.29, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>> On 17 Aug 2018, at 10.21, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>>>> core.
>>>>>=20
>>>>> Hi Javier, I did not end up using your patch. I had misunderstood =
what
>>>>> was implemented. Instead I implemented the detection of the each =
chunk by
>>>>> first sensing the first page, then the last page, and if the chunk
>>>>> is sensed as open, a per page scan will be executed to update the =
write
>>>>> pointer appropriately.
>>>> I see why you want to do it this way for maintaining the chunk
>>>> abstraction, but this is potentially very inefficient as blocks not =
used
>>>> by any target will be recovered unnecessarily.
>>>=20
>>> True. It will up to the target to not ask for more metadata than =
necessary (similarly for 2.0)
>>>=20
>>> Note that in 1.2, it is
>>>> expected that targets will need to recover the write pointer =
themselves.
>>>> What is more, in the normal path, this will be part of the metadata
>>>> being stored so no wp recovery is needed. Still, this approach =
forces
>>>> recovery on each 1.2 instance creation (also on factory reset). In =
this
>>>> context, you are right, the patch I proposed only addresses the =
double
>>>> erase issue, which was the original motivator, and left the actual
>>>> pointer recovery to the normal pblk recovery process.
>>>> Besides this, in order to consider this as a real possibility, we =
need
>>>> to measure the impact on startup time. For this, could you =
implement
>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>> recovering (i) asynchronously and (ii) concurrently across luns so =
that
>>>> we can establish the recovery cost more fairly? We can look at a
>>>> specific penalty ranges afterwards.
>>>=20
>>> Honestly, 1.2 is deprecated.
>> For some...
> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 have
> their own storage stack and spec that they will continue development
> on, which can not be expected to be compatible with the OCSSD 1.2 that
> is implemented in the lightnvm subsystem.
>=20

There are 1.2 devices out there using the current stack with no changes.

>>> I don't care about the performance, I
>>> care about being easy to maintain, so it doesn't borg me down in the
>>> future.
>> This should be stated clear in the commit message.
>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks =
per
>>> die, and 60us read time, will take 4 seconds to scan if all chunks =
are
>>> free, a worst case something like ~10 seconds. -> Not a problem for
>>> me.
>> Worst case is _much_ worse than 10s if you need to scan the block to
>> find the write pointer. We are talking minutes.
>=20
> I think you may be assuming that all blocks are open. My assumption is
> that this is very rare (given the NAND characteristics). At most a
> couple of blocks may be open per die. That leads me to the time
> quoted.
>=20

Worst case is worst case, no assumptions.

>> At least make the recovery reads asynchronous. It is low hanging =
fruit
>> and will help the average case significantly.
>>>> Also, the recovery scheme in pblk will change significantly by =
doing
>>>> this, so I assume you will send a followup patchset reimplementing
>>>> recovery for the 1.2 path?
>>>=20
>>> The 1.2 path shouldn't be necessary after this. That is the idea of
>>> this work. Obviously, the set bad block interface will have to
>>> preserved and called.
>> If we base this patch on top of my 2.0 recovery, we will still need =
to
>> make changes to support all 1.2 corner cases.
>> How do you want to do it? We get this patch in shape and I rebase on =
top
>> or the other way around?
>=20
> I'll pull this in when you're tested it with your 1.2 implementation.

Please, address the asynchronous read comment before considering pulling
this path. There is really no reason not to improve this.

Javier

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt2lqMACgkQIX4xUKFR
nnR1rRAAuSALuy7at1Tp4jDYVlxQg0petxvWeOSyP6RYS+HDQwhgQHzNF90Hbq6Y
o/5XOSS4ljBUHnWocYE7FJIz53Tqf8D2gQa52E24BrOH1ZSpwGoEB7RTrZWP0ML4
JVV+T7e48Wr5kLOUIGiCaNmPeQRCiz6jl61jzlkxRe9emNuihKO6EJHRY+IBiV6F
gXSpN3FdMqHk4zEKR7sLJcixupcvL2sGWHv5D8K5Dv8CmjcAhDBQmC0xSnNtIPxz
kwQwxnJ3/0fnROGNMhPD7nxYOWZqJBF+focwq4DJgkwYxjGXD1Q3TM6JJ8N0n/7r
E3aMu+LD1pI68XKaWarJ7Oii7o6vNxS+HtcltT3oPyd5Ckpos92gHqn/GL/h6OQL
6U3ehDzlNeE7Cs2QzVb1ATMlX01IJn6cZpEXU/LJjt2Oqrvk+RQBcXX7sJzrxkj8
1p2GdJ6nLHaQoViOFGahFcqwqjJ6zkwEOLhrilN+zSDgIfxHo+/456d5Wf5D0J/I
dn2TtePg22qDq5XjVzbMAmFdxfYRyKRfzbebHwfvJVHYKYn9pm4pGkcZdn6I62q5
OurQ1uIeuL0BBlgyzXgTwHxdvajNpbS0TIzbncGPBfbI/G/HZIqVUmXmv6UMbWYe
JDZ3VJ/ta+JLvHyfxzyOOogshgFIYSgPjqXyrrrcbu2/w+aGsS4=
=yFpk
-----END PGP SIGNATURE-----

--Apple-Mail=_EB966612-57E3-4AC4-BDE1-7D43196246E1--
