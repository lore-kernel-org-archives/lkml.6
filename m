Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3273C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AAA2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lbfu8PCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391988AbeLUVQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:16:42 -0500
Received: from mail-eopbgr700106.outbound.protection.outlook.com ([40.107.70.106]:17766
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388463AbeLUVQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL4WbI1OumC5qCBQDt5UySwYhC7YQaH7rjPBBaqoZKg=;
 b=lbfu8PCXTtZOHjeAATcic5hcsGARmTjS8ueeM1xa8KKM0B3NiwIXebYiDQTAq5fDiO9iJrPVdBrSdI3S0RIFl+bb6vB7+yf+9MIwWyRl0Y+h3ZfBrGjSP0UCHEmK+21p4S3HUPfWZwWay7K4rgZQ286SmksY5fPsCfU4JkYv3jM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1024.namprd22.prod.outlook.com (10.174.167.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Fri, 21 Dec 2018 21:16:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 21:16:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Topic: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Index: AQHUmIvU0UY0CfycF02ZZK4s2JaOTaWIAqeAgAGxAoA=
Date:   Fri, 21 Dec 2018 21:16:37 +0000
Message-ID: <20181221211603.r7226vjkubi3lfzg@pburton-laptop>
References: <20181220174514.24953-1-paul.burton@mips.com>
 <20181220192616.42976218FE@mail.kernel.org>
In-Reply-To: <20181220192616.42976218FE@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1024;6:wCi/JzUkEggbyxA7fF413dJMR6lIkIR4mjqPARO907FUPk6lQt68Bg7/d7g7RE/C23xLcDm9WorPz3mAOlCCohuOyPPxObhAv+jctW6AywlBArxJYgM1In9QiKg3aJUuwIg4B8M2HIw4x/rbEeFNdkjBxQfLM729LEAj+SJuCj8qCaEnGgYTStkHr7OXmXWD9DbMxZOncwTtpyZsieLadNfVypCeR7c6ZLNYT5D537GPk87+aiVDZX4VFGK/58csaolUVkE3hDKDF+PbgU0lYFz4qXUzOj+iEb2/X6/zk8aRtIvj4hrU0dxf6veUreGPQiktLFD/lq62d6+MdzmrDjywozLnDn192yviKDCTDO9H5Cp8EMNwv4Wf3ANw4tLpBpLUTBXO2TnyQCG/FeGrnYtWX8vv0WQK5j9CuY6PHsvTrgftrymdOqoiPLpBzo7h4Emxe7fVPlO1f3UcpE7LsA==;5:P+Ybwm448T/mCoSXN0//T5zqcqkD3zpe7E0oOCC3bxudjYQxA4u4RZKRPP/Dz9MCPbLPBA0FAW3Bz3+fwpv6UThED+2zpQDBmdPO+CRro1hcP2WaToZL+7oFDwJkswE6CXOpe4INNAllB4TENffMAkp2zuj4bo3qjlcYrjcEdLc=;7:zFuEykRClEhsd9o5LJqifcVT/ABUOgNlrJFup9uog979eXihYKBIY4pqNh19FI95kAiQ175YozMSE+hHETkzIpypdjjH6FJoggzhPsYpMeG19SwYtQ4mMim8PTVxHRZOVpTaUkt58ofdLkP1dHfegg==
x-ms-office365-filtering-correlation-id: 914a27a6-055f-440a-95e2-08d66789976a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1024;
x-ms-traffictypediagnostic: MWHPR2201MB1024:
x-microsoft-antispam-prvs: <MWHPR2201MB1024113B01F1142EFEC42CB7C1B80@MWHPR2201MB1024.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1024;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1024;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39840400004)(366004)(376002)(346002)(136003)(189003)(199004)(81156014)(2906002)(305945005)(446003)(54906003)(11346002)(58126008)(97736004)(8936002)(8676002)(81166006)(575784001)(229853002)(5660300001)(476003)(6436002)(44832011)(6916009)(14444005)(256004)(99286004)(9686003)(6486002)(68736007)(508600001)(7736002)(106356001)(486006)(186003)(105586002)(42882007)(25786009)(4326008)(33896004)(76176011)(26005)(52116002)(6512007)(386003)(102836004)(6506007)(66066001)(3846002)(6116002)(6246003)(53936002)(71190400001)(14454004)(33716001)(1076003)(71200400001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1024;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7fOhqJi+wrh0THXJDujwcK31Qz7+83yRnMvXUf9E+qhP81tDKVlXu2L22awZS/9ThinFRjMF5sEiCgMD6Etu8oM6gq+DjENkzfgCMms5u2DwHNLCv5KME1r/nsXZjoKVAdngxDcdajT8qxZvsGuh9pMvHWg6PIFLp0wA4Mt/4AgDKSPnPfBh+wkEb1GfK1HtcfGcoUH8uXOgvDVPgVpKCFSSGzvf9r50BwbgBgG1xiO+6REsCpz0VYMb/051m6aVzdVtwI6w1ztIIc2nM14Simlfz9TWQmC16agaVoqsd9X6hTsW4beAWjzZlcYKcmcc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95513F17380BFA4F85AFB4722702AF81@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914a27a6-055f-440a-95e2-08d66789976a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 21:16:37.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, Dec 20, 2018 at 07:26:15PM +0000, Sasha Levin wrote:
> Hi,
>=20
> [This is an automated email]
>=20
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 432c6bacbd0c MIPS: Use per-mm page to execute branch delay=
 slot instructions.
>=20
> The bot has tested the following trees: v4.19.10, v4.14.89, v4.9.146,=20

Neat! I like the idea of this automation :)

> v4.19.10: Build OK!
> v4.14.89: Build OK!
> v4.9.146: Failed to apply! Possible dependencies:
>     05ce77249d50 ("userfaultfd: non-cooperative: add madvise() event for =
MADV_DONTNEED request")
>     163e11bc4f6e ("userfaultfd: hugetlbfs: UFFD_FEATURE_MISSING_HUGETLBFS=
")
>     67dece7d4c58 ("x86/vdso: Set vDSO pointer only after success")
>     72f87654c696 ("userfaultfd: non-cooperative: add mremap() event")
>     893e26e61d04 ("userfaultfd: non-cooperative: Add fork() event")
>     897ab3e0c49e ("userfaultfd: non-cooperative: add event for memory unm=
aps")
>     9cd75c3cd4c3 ("userfaultfd: non-cooperative: add ability to report no=
n-PF events from uffd descriptor")
>     d811914d8757 ("userfaultfd: non-cooperative: rename *EVENT_MADVDONTNE=
ED to *EVENT_REMOVE")

This list includes the correct soft dependency - commit 897ab3e0c49e
("userfaultfd: non-cooperative: add event for memory unmaps") which
added an extra argument to mmap_region().

> How should we proceed with this patch?

The backport to v4.9 should simply drop the last argument (NULL) in the
call to mmap_region().

Is there some way I can indicate this sort of thing in future patches so
that the automation can spot that I already know it won't apply cleanly
to a particular range of kernel versions? Or even better, that I could
indicate what needs to be changed when backporting to those kernel
versions?

Thanks,
    Paul
