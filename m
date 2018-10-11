Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2940DC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AFF20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dHYCuegI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AFF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeJLAEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:04:06 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:15968
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729148AbeJLAEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnEQpk2xbvZeOXiPo756fNL5HC+Nwp6xJR4QBqfguj0=;
 b=dHYCuegI0ehniBEvi3eLTU4aRPyLQmXlGHvF/49R6A2H+X65/e83m8qwnpy1CRTd24xHfyoiaupJjN2q33TGP25ZlQTRMd4ZBgbiH/BQ/TseZRLgvJlTv9kmSVLcRhSeVk1P2VpxBE0pGZTAilufc62AEqpcOT26PBTkadf/wiI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 16:36:01 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 16:36:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] MIPS: memset: Fix `noreorder' issues
Thread-Topic: [PATCH 0/2] MIPS: memset: Fix `noreorder' issues
Thread-Index: AQHUWkYO0A6BEjhkeE26NbT1An8AaqUaTG0A
Date:   Thu, 11 Oct 2018 16:36:01 +0000
Message-ID: <20181011163558.r7yrje44erkkwo5l@pburton-laptop>
References: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:3:ed::13) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:TXjRrpcTvioMnujuxflgUln1PI2ussWpQWxh6axSL6+mxrG24aNVrcRLMRNJGburx5JkpetQQhMCDVhmx9y8nvmuuEyptdXGOW/1rNtPtFaDxBR+NK4lItsrNVeR9pLguqq5ScmmhIZOwnJBbtJYFyCWVqbVKDRK3JMERKh1OW/h74fo6jPHqS+09Rkzkl+dRjn6duf+9gUIOzM5jb/fiVLXn9OUm2PpUNs2TW9W0Ve5EdoM890SkZhZ2/zHeoWjYz16Q78q+G3kS3CZozKWnI3su6OZ337ej3lQkD916TYeeEU2/20wCdkACQOj5t9pzBV/0SC3blMC3xyLnlyHVNlIUNPIw3otPZPO+RpI31bCwKrwuihq/8qL6qwqkulG/6o6fxqs+lntPvm0SPbNHDD3RkVjJ8kKwBIODwayg6mxxiAzT+iAy19nCyeAF5CBlUKoE6VROWSwQlcrLNZB8A==;5:JSGJ7G542C2WVwTGSsrWOkq8MYUvlqEAZc13kvPuhrOp04BfT46ppzfdJsCUBRFb2FyfIZoeiAdtgHqeuSsRHgHB3uKbFTwwTlfyZFehfeOTkunmRPPdDeRFHeu7mg1YYdpApsCCWJpmQ3OQ1+wuTE0GfKTeEWwz289T9QpPcdc=;7:Atm+GzK3S9Xr718JJbfCMB3QHmrMfQ8ygpYLP4rtjZOtKjsKAozhN1zdg+0KGyqKPyQvPtU/rNrbcIA+TVzC3sM/cI48zAQX/7SdVSemgL2QucjpOfqlbfdAcEFLvPxIzPwj7td22q+prvDE5Bu7z1RmwCQdy/5ngZl1lslPeqcNMiJ3QsQuYjdGKbgthbzhkwyQV/LGhmhM80gG9wl4KeqtYzNLyRvkrHJaTaujvTmq+O6bOBWtPQEY2srlLv0o
x-ms-office365-filtering-correlation-id: 28544303-36f0-4edf-920c-08d62f97a115
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB171072A09E774B77114DE459C1E10@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991055);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(366004)(396003)(136003)(376002)(346002)(39840400004)(189003)(199004)(68736007)(5250100002)(486006)(81166006)(33896004)(6506007)(386003)(305945005)(7736002)(476003)(6436002)(106356001)(2900100001)(6116002)(186003)(105586002)(99286004)(1076002)(44832011)(8676002)(4326008)(46003)(6916009)(25786009)(42882007)(5660300001)(14454004)(6246003)(52116002)(11346002)(71200400001)(71190400001)(446003)(81156014)(6512007)(54906003)(102836004)(58126008)(76176011)(97736004)(9686003)(53936002)(508600001)(256004)(14444005)(6486002)(33716001)(316002)(229853002)(8936002)(2906002)(81973001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6czPl4uifPJr/+GVJJH9AwUaY8yloiut1tPHUDcMoEIQmeiMzsCqmCjC5c43M/rvhW/30g7RlyFcsZ1YO9aj4OD9Qi/cPWi8YbbJkrnxP4zIoaCdqe0hX4dEkULYkYXjKbJe2m8YFIy2PDdgsWXfmpfjB2/dBXpAqbQZsTjpZnKfPMNHL6UjiesRjN1i/kyHvSv+g9QDnPJhWWfr3euUxY7J2O1UJQoGxZeGHQzlE/vre1xsTlcySl1NmHFTvlo7g/Ju3RR2Xqs0EkgFWRENQ6/Jqoy8YKwFk1ergXyTkxbR5kQBF4wqq6e5mgm9D4V8BbkjaovvPiSsfk+9tfA6EXT+UWj/C2MYHKnppLwUwMM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C46A785DFC39384C9C889FE5AADA90FF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28544303-36f0-4edf-920c-08d62f97a115
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 16:36:01.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Tue, Oct 02, 2018 at 12:50:00PM +0100, Maciej W. Rozycki wrote:
>  A recent change broke CPU_DADDI_WORKAROUNDS support in memset.S, due to =
a=20
> delay-slot instruction expanding to multiple hardware operations for the=
=20
> affected configurations.
>=20
>  The underlying cause is the excessive use of the `noreorder' assembly=20
> mode, while it is only needed in couple of places where either there is a=
=20
> data dependency between a branch and its delay slot instruction, or there=
=20
> is a section switch involved that would prevent automatic delay slot=20
> scheduling.
>=20
>  These changes address both problems and for clarity, not to mix multiple=
=20
> conceptually separate changes and to make backporting easier I made them =
a=20
> small patch series.  See individual change descriptions for details.
>=20
>  This has been build-time and run-time verified with 32-bit and 64-bit=20
> DECstation configurations, build-time verified with big-endian and=20
> little-endian 64-bit SWARM configurations.  Build-time verification was=20
> made by running `objdump -d arch/mips/lib/memset.o' with a pristine and=20
> and a patched build to make sure there has been no change in machine code=
=20
> generation, except for the delay-slot multiple instruction with the 64-bi=
t=20
> CPU_DADDI_WORKAROUNDS DECstation configuration.

Thanks - I applied patch 1 to mips-fixes & it's already been merged to
master.

Patch 2 applied to mips-next for 4.20.

Paul
