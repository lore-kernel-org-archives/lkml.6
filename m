Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LudyQvue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B67320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeKFU5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:57:41 -0500
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:22678
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729177AbeKFU5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWkSb5V0MNlMUu5OavzkAkrjq12ETtoaa2czSikW6JI=;
 b=LudyQvueUk1PIlOmCCfKReSOjf9Or6iXrQ4mxVq0b3VALJJOC4Ap08CNiguvhpfKd+Xn1nKzojJa2H0xVT0YkhBUyZ4flsN3S2cb8k+WAvz7JJzYAEojT1esFtRmRBUN/74+SwLZ9SfoAnnE0hskwNJg0gdjybJ0/nzTqdlBgxY=
Received: from DB7PR08MB3242.eurprd08.prod.outlook.com (52.134.111.16) by
 DB7PR08MB3290.eurprd08.prod.outlook.com (52.134.111.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 6 Nov 2018 11:32:50 +0000
Received: from DB7PR08MB3242.eurprd08.prod.outlook.com
 ([fe80::3098:ac7e:afcd:7031]) by DB7PR08MB3242.eurprd08.prod.outlook.com
 ([fe80::3098:ac7e:afcd:7031%6]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 11:32:50 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Mark Rutland <Mark.Rutland@arm.com>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        James Morse <James.Morse@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/arm64 : fix error in dump_backtrace
Thread-Topic: [PATCH] arch/arm64 : fix error in dump_backtrace
Thread-Index: AQHUdaEZgkgy/wm+NECQLbVu0iZ9pqVCbRKAgAAFRICAACI3gIAACRMA
Date:   Tue, 6 Nov 2018 11:32:50 +0000
Message-ID: <20181106113247.GF3500@e103592.cambridge.arm.com>
References: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
 <20181106083901.erezwtcomiijvdrk@salmiak>
 <20181106085751.hrp7qkp53cftgew6@holly.lan>
 <20181106110019.36ps3tyakvocwst4@lakrids.cambridge.arm.com>
In-Reply-To: <20181106110019.36ps3tyakvocwst4@lakrids.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::29) To DB7PR08MB3242.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3290;6:TyAnds1ktrLq15HfTAkDO2z9Y5V9yePBqKNNzDmcfFyvgoAvnFhhkubWSFt+VFzVv/H/7CfARL81Fvfm93lL2lhYfpdh9pH01oeX1G0uMemYdTQTSg/xH0LEYs7YDOxYf++OzQVTHkHHD7mRFOepj00rb4tzwgNqw97/HzR5F/P4VRFNkyRDsQfeovYtD89oyrSRarzx/9neRupHHFFSs6+qxasSzRdcK2tDXgQStK/j6EW3Fe4AxUVSJrMS5KOMY7pxkquniHLM+LjM2DuByNpLCVDdFWMgGz11ihmzcLzUZOQt7oJerKiMLsza88J84D3wKa6rGyr2ijdehAUNR2BKA55lPMfVvVkjS0DOOlVZ21J/jaIea773+1fuP9OXWbSWp0HxcEAWgcvMVqRGNdOtsMBGA9OphTj57uJjSUDpHaCg/bKJuBSCZ04KuRsh4ZijKvFewoTZ0JxaIFbImg==;5:Xwyux/Jpi6bvn1zdpypTIugoWCieCencmc6sF27ZvNM36IuE6TviK+8eZ6vW5HFKUS3jP22R+u1jvJqrZfB/XU1bHQrXQBCffR6wuOOYLa3zoqAK4eZ6hDtWfxWhEgoTpB530D4BTDUtSIJ1B9QPwIsgL5VIicIrtt7gExaN2zY=;7:924Itdx5B8zQBp9pSrmq7lkAdbEuOrWCAhBwFW0M8809mnfvt6kYo4q7HpUX5LMu/SZN0EaN2fvWsXxkko+wUejDI9Qji8fOnZqOADzMCvmmv143+eXICRk7J1WsxtPF/T0ud3i+uZMB1aFmr6N5jA==
x-ms-office365-filtering-correlation-id: 1505b39e-07fa-474a-7fac-08d643db9551
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3290;
x-ms-traffictypediagnostic: DB7PR08MB3290:
x-microsoft-antispam-prvs: <DB7PR08MB3290B94738D9B7756B86E614FECB0@DB7PR08MB3290.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3290;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3290;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(52314003)(199004)(40434004)(68736007)(1076002)(5024004)(256004)(2900100001)(66066001)(14444005)(316002)(58126008)(54906003)(186003)(52116002)(6436002)(86362001)(8676002)(53936002)(8936002)(76176011)(6506007)(6246003)(26005)(6512007)(386003)(81166006)(6862004)(81156014)(39060400002)(72206003)(102836004)(93886005)(7736002)(105586002)(106356001)(305945005)(25786009)(2906002)(99286004)(4326008)(71200400001)(14454004)(478600001)(6636002)(476003)(97736004)(11346002)(71190400001)(446003)(6486002)(486006)(5660300001)(229853002)(6116002)(33656002)(3846002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3290;H:DB7PR08MB3242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 48fScdgEORc/3fz+w1Y14ooAO2Sb6FliiOxnlp5hU+SSty0BLPjhlwTtgL2l2E8rsjPw8jkbFCDIzyc0VMFyclrSe8c19fFLs30ZaBkm0TA8i8Bnc4VrVguRymaI/Q1/SRtP7vtICYmh0ReDcjNh8djLMBAZHNG0aaVyFVTT0cMywb77AqdMbUqjGWLCdu1Bi15WO+dEppFlhzkPH71sdkEfUwnhAd5Z+81bXVJikUdsR3UHG8mULVjH3KnRINXcqd/XUYpDU2YofV2l4QWmiUr3JWlHC1JTC+WYL25DLIR8MEP1nwTgnuFUvSA1MTmTzcphX/NTN3o2TRxXuNpNWm6FZU2T5PNU14DgyORyPZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0C2F322E4DA23448C893B333A73F0A5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1505b39e-07fa-474a-7fac-08d643db9551
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 11:32:50.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:00:19AM +0000, Mark Rutland wrote:
> On Tue, Nov 06, 2018 at 08:57:51AM +0000, Daniel Thompson wrote:
> > On Tue, Nov 06, 2018 at 08:39:01AM +0000, Mark Rutland wrote:
> > > On Tue, Nov 06, 2018 at 03:19:35PM +0800, Zhaoyang Huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > In some cases, the instruction of "bl foo1" will be the last one of=
 the
> > > > foo2[1], which will cause the lr be the first instruction of the ad=
jacent
> > > > foo3[2]. Hence, the backtrace will show the weird result as bellow[=
3].
> > > > The patch will fix it by miner 4 of the lr when dump_backtrace
> > >
> > > This has come up in the past (and a similar patch has been applied, t=
hen
> > > reverted).
> > >
> > > In general, we don't know that a function call was made via BL, and t=
herefore
> > > cannot know that LR - 4 is the address of the caller. The caller coul=
d set up
> > > the LR as it likes, then B or BR to the callee, and depending on how =
the basic
> > > blocks get laid out in memory, LR - 4 might point at something comple=
tely
> > > different.
> > >
> > > More ideally, the compiler wouldn't end a function with a BL. When do=
es that
> > > happen, and is there some way we could arrange for that to not happen=
? e.g.
> > > somehow pad a NOP after the BL.
> >
> > It's a consequence of having __noreturn isn't it? __noreturn frees the
> > compiler from the burden of having to produce a valid return stack... s=
o
> > it doesn't and unwinding becomes hard.
>
> In that case, the compiler could equally just use B rather than BL,
> which this patch doesn't solve.
>
> The documentation for the GCC noreturn attribute [1] says:
>
> | In order to preserve backtraces, GCC will never turn calls to noreturn
> | functions into tail calls.
>
> ... so clearly it's not intended to mess up backtracing.

Which is a bit odd, since every call to a noreturn function is a tail-
call by definition, and other tail-calls are typically optimised to a B
(thus interfering with backtracing in all except the noreturn case).

Avoiding this would require a change to the compiler, and since there's
no obvious correct answer anyway, I guess we shouldn't hold our breath.

> IIUC we mostly use noreturn to prevent warings about uninitialised
> variables and such after a call to a noreturn function. I think
> optimization is a secondary concern.

Agreed.

> We could ask the GCC folk if they can ensure that a noreturn function
> call leave thes LR pointing into the caller, e.g. by padding with a NOP:
>
> BL<noreturn function>
> NOP
>
> That seems cheap enough, and would keep backtraces reliable.

-fpatchable-function-entry=3D1,1 does almost the right thing, by
inserting 1 NOP at the start of each function, and putting the function
entry point after that (1) NOP.

This works on gcc-8.1.  I haven't experimented with earlier compilers.

It could be considered an abuse, since we'd not quite be using the
option for its intended purpose.  It also causes every function
entry point to be misaligned due to the NOP insertion, which we may or
may not care about.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
