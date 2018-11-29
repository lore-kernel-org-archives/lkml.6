Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46891C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85A2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rPJy1qjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85A2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeK3BTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:39 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:11232
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728902AbeK3BTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQKAe95NCXTuAd8gLusSd8EGj4rFbjdJkx7vI9FnfnU=;
 b=rPJy1qjzRNg8CDPTtd3j6eq1xZh1pcGdbxS3sYtTne18NfkUbbDkiX5VVsc+zKZrC4kuW/kIAy3hoyaNMItqecTCWDnOGkTPGfTcofzAcQohkYXH3ZJq9rZSd8nSQ9zoYBPYmlT01opefigHXO/1EAAOXO0s+SGvBm/Wx1CcIw8=
Received: from AM6PR08MB3030.eurprd08.prod.outlook.com (52.135.163.139) by
 AM6PR08MB3717.eurprd08.prod.outlook.com (20.178.88.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Thu, 29 Nov 2018 14:14:05 +0000
Received: from AM6PR08MB3030.eurprd08.prod.outlook.com
 ([fe80::a15d:a644:5b69:2989]) by AM6PR08MB3030.eurprd08.prod.outlook.com
 ([fe80::a15d:a644:5b69:2989%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 14:14:05 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Liam Mark <lmark@codeaurora.org>
CC:     nd <nd@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
Thread-Topic: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
Thread-Index: AQHUcjBnSvenHVoYw0amObMa8s0GR6VY/NIAgAo60wCAAF3pgIABUiWAgABJ+ACAAU1AgIAAeD+A
Date:   Thu, 29 Nov 2018 14:14:05 +0000
Message-ID: <20181129141359.s2b5fafnj24oj2bv@DESKTOP-E1NTVVP.localdomain>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
 <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811272231460.20916@lmark-linux.qualcomm.com>
 <20181128111052.q2xokwcpuucynoft@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811282249350.28066@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1811282249350.28066@lmark-linux.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51
x-originating-ip: [217.140.106.50]
x-clientproxiedby: CWLP265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::32) To AM6PR08MB3030.eurprd08.prod.outlook.com
 (2603:10a6:209:45::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3717;6:LaJkTWjguUw0onTK3okru9QBmtDDTaEw6I6LqQlSkDpBDqxNravD2L41EtZRLrkroQiBuk2MfX2wTf2eKEHzsuAf6PKjIIlyuGBi+bnJgTUBUEo+hweh/QwPr741RIIicrgkSSOZAFtp4lTzPHKVJnkYS+2xpmrfiXsCzw4NEVQTT1EvmjvyPZupAPF71FCDtz+jp261GPmFJQBcIx9KoF/cK+jEttQVq3QoUtcfIyDMggcmd/g+MoEfdk6Xyrlng0GNo69YR+9Yxmut3mmM1AvyTg0pFc24Wx+oFdpvwgI5Lr/xHhTv4tJ9orinB/ns6mqGnKIlujtgaClzkMNOF5F85p1TRQK4oFxTz/JjC3nfPI9TwTAf7ctpPGk3p4uzNIIDySEjg2Me5dvBrN2nvBQLYTLqG2LdZ4aMFkVfhj9kauT4Snifnhhv6CnG45dRzTQUVfnqvJC19Gk+jNkrZg==;5:9mCcdeL52BqnKv5wzJTyiXkK2b7krhOwcMOOQJaIGAhdVWZapt2oBD2FhkLIdRZwAsSObcbFX9s8xmSHdgS94188jMRcCMmN2KjYR+G92KbG3gskq+IK1bxzm3Qokx1WGIaT3R/eNC/e1I8w8MbdOnaEn1R1yuP23HFR52sg72M=;7:eckaeHy+eglO3U7U/dk3LPCiezyNqUlM3YOx8mCnR+eIlIbEDflyNE1jBHR2SR9U/YDowCxk0S6kBrsbpxLSlqJw83sXgZ0kU+6ufXT/uCzcLVGWIZNyLuBG+wf03NZXVOzqmbASdyNPLXpjd37Z4w==
x-ms-office365-filtering-correlation-id: 12d4764e-a0a4-4a35-d41d-08d65604eb52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3717;
x-ms-traffictypediagnostic: AM6PR08MB3717:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB371745B2DB5E08F468695D54F0D20@AM6PR08MB3717.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3717;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3717;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(76176011)(7416002)(476003)(5660300001)(186003)(6512007)(71190400001)(71200400001)(86362001)(6486002)(2906002)(7736002)(6116002)(3846002)(305945005)(1076002)(6436002)(229853002)(9686003)(97736004)(68736007)(561944003)(54906003)(256004)(6916009)(5024004)(217873002)(58126008)(14444005)(106356001)(25786009)(66066001)(4326008)(316002)(81156014)(72206003)(8676002)(105586002)(81166006)(446003)(14454004)(8936002)(486006)(478600001)(11346002)(386003)(102836004)(33896004)(6506007)(93886005)(53936002)(52116002)(99286004)(6246003)(44832011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3717;H:AM6PR08MB3030.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g5RQ4HYTM5DCG/+qbEQc8ky6rOIHhfiTAvvtvQOlqWm16gsaBaZ14WFzF3AJLl/rKkyy+7KbnAD0MsjB+HTw8eEaPg4xcxMSn79TVnK/cjXiaOVX64/rkJU3sI6U04al19Wd8mDi192tQdKwTM6yGtOaUoB33FCNE0EOZix5nheECkeXKMrMnR3GgrbuYC77RuqIZSk4wxdqJaM/+DzxRhV2R7ktELm/wLXP668BB+pKHwbh+kqTozrnndvuvfoCEiELZUG85kCx2/3aezTyjijLaJxOwJlEbPGwS+2mwXlgapb5up2uc6z2Pzc6G01BqiRqsnH3dJ7LXLfaFKa7W1PDMHpHLED1Jyqr9AG2Juo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71534B3F7525504B8B47A731A1A188F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d4764e-a0a4-4a35-d41d-08d65604eb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 14:14:05.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:03:37PM -0800, Liam Mark wrote:
> On Wed, 28 Nov 2018, Brian Starkey wrote:
> > On Tue, Nov 27, 2018 at 10:46:07PM -0800, Liam Mark wrote:
> > > On Tue, 27 Nov 2018, Brian Starkey wrote:
> > > > On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> > > > > On Tue, 20 Nov 2018, Brian Starkey wrote:

[snip]

> > > >=20
> > >=20
> > > Sounds like you are suggesting using carveouts to support uncached?
> > >=20
> >=20
> > No, I'm just saying that ion can't give out uncached _CPU_ mappings
> > for pages which are already mapped on the CPU as cached.

Probably this should have been: s/can't/shouldn't/

> >=20
>=20
> Okay then I guess I am not clear on where you would get this memory=20
> which doesn't have a cached kernel mapping.
> It sounded like you wanted to define sections of memory in the DT as not=
=20
> mapped in the kernel and then hand this memory to=20
> dma_declare_coherent_memory (so that it can be managed) and then use an=20
> ION heap as the allocator.  If the memory was defined this way it sounded=
=20
> a lot like a carveout. But I guess you have some thoughts on how this=20
> memory which doesn't have a kernel mapping can be made available for gene=
ral
> use (for example available in buddy)?
>=20
> Perhaps you were thinking of dynamically removing the kernel mappings=20
> before handing it out as uncached, but this would have a general system=20
> performance impact as this memory could come from anywhere so we would=20
> quickly lose our 1GB block mappings (and likely many of our 2MB block=20
> mappings as well).
>=20

All I'm saying, with respect to non-cached memory and mappings, is
this:

I don't think ion should create non-cached CPU mappings of memory
which is mapped in the kernel as cached.

By extension, that means that in my opinion, the only way userspace
should be able to get a non-cached mapping, is by allocating from a
carveout.

However, I don't think this should be what we do in our complicated
media-heavy systems - carveouts are clearly impractical, as is
removing memory from the kernel map. What I think we should do, is
always do CPU access via cached mappings, for memory which is mapped
in the kernel as cached.

[snip]

> >=20
>=20
> I am not sure I am properly understanding as this is what my V2 patch=20
> does, then when it gets an opportunity it allows the memory to be=20
> re-mapped as uncached.

It's the remapping as uncached part which I'm not so keen on. It just
seems rather fragile to have mappings for the same memory with
different attributes around.

>=20
> Or are you perhaps suggesting that if the memory is allocated from a=20
> cached region then it always remains as cached, so only provide uncached=
=20
> if it was allocated from an uncached region? If so I view all memory=20
> available to the ION system heap for uncached allocations as having a=20
> cached mapping (since it is all part of the kernel logical mappigns), so =
I=20
> can't see how this would ever be able to support uncached allocations.

Yeah, that's exactly what I'm saying. The system heap should not
allow uncached allocations, and, memory allocated from the system heap
should always be mapped as cached for CPU accesses.

Non-cached allocations would only be allowed from carveouts (but as
discussed, I don't think carveouts are a practical solution for the
general case).

The summary of my proposal is that instead of focussing on getting
non-cached allocations, we should make cached allocations work better,
so that non-cached aliases of cached memory aren't required.

[snip]

>=20
> Unfortunately if are only using cached mappings it isn't only the first=20
> time you dma map the buffer you need to do cache maintenance, you need to=
=20
> almost always do it because you don't know what CPU access happened (or=20
> will happen) without a device.

I think you can always know if CPU _has_ accessed the buffer - in
begin_cpu_access, ion can set a flag, which it checks in map_dma_buf.
If that flag says it's been touched, then a cache clean is needed.

Of course you can't predict the future - there's no way to know if the
CPU _will_ access the buffer - which I think is what you're getting at
below.

> Explained more below.
>=20
> > > But with this cached memory you get poor performance because you are=
=20
> > > frequently doing cache mainteance uncessarily because there *could* b=
e CPU access.
> > >=20
> > > The reason we want to use uncached allocations, with uncached mapping=
s, is=20
> > > to avoid all this uncessary cache maintenance.
> > >=20
> >=20
> > OK I think this is the key - you don't actually care whether the
> > mappings are non-cached, you just don't want to pay a sync penalty if
> > the CPU never touched the buffer.
> >=20
> > In that case, then to me the right thing to do is make ion use
> > dma_map_sg_attrs(..., DMA_ATTR_SKIP_CPU_SYNC) in ion_map_dma_buf(), if
> > it knows that the CPU hasn't touched the buffer (which it does - from
> > {begin,end}_cpu_access).
> >=20
>=20
> Unfortunately that isn't the case we are trying to optimize for,  we=20
> aren't trying to optimize for the case where CPU *never* touches the=20
> buffer we are trying to optimize for the case where the CPU may *rarely*=
=20
> touch the buffer.
>=20
> If a client allocates cached memory the driver calling dma map and dma=20
> unmap has no way of knowing if at some pointe further down the pipeline=20
> there will be some userspace module which will attempt to do some kind
> of CPU access (example image library post processing).  This userspace=20
> moduel will call the required DMA_BUF_IOCTL_SYNC  IOCTLs, however there=20
> may no longer be a device attached, therefore these calls won't=20
> necessarily do the appropriate cache maintenance.

(as a slight aside: Is cache maintenance really slower than the CPU
running image processing algorithms on a non-cached mapping?
Intuitively it seems that doing processing on a cached mapping with
cache maintenance should far outperform direct non-cached access. I
understand that this isn't the real issue, and what you really care
about is being able to do device<->device operation without paying a
cache maintenance penalty. I'm just surprised that CPU processing on
non-cached mappings isn't *so bad* that it makes non-cached CPU access
totally untenable)

>=20
> So what this means is that if a cached buffers is used you have to at=20
> least  always to a cache invalidating when dma unmapping (from a device=20
> which isn't io-coherrent that did a write)  otherwise there could be a CP=
U=20
> attempted to read that data using a cached mapping which could end up=20
> reading a stale cache line (for example acquired through speculative=20
> access).

OK now I'm with you. As you say, before CPU access you would need to
invalidate, and the only way that's currently possible (at least on
arm64) is in unmap_dma_buf - so you're paying an invalidate penalty on
every unmap. That is the only penalty though; there's no need to do a
clean on map_dma_buf unless the CPU really did touch it.

With your patch I think you are still doing that invalidation right?
Is the performance of this patch OK, or you'll follow up with skipping
the invalidation?

It does seem a bit strange to me that begin_cpu_access() with no
device won't even invalidate the CPU cache. I had a bit of a poke
around, and that seems to be relatively specific to the arm64 dummy
ops. I'd have thought defaulting to dma_noncoherent_ops would work
better, but I don't know the specifics of those decisions.

If it were possible to skip the invalidation in unmap_dma_buf, would
cached mappings work for you? I think it should even be faster (in all
cases) than any non-cached approach.

Cheers,
-Brian

>=20
> This frequent uncessary cache maintenance adds a significant performance=
=20
> impact and that is why we use uncached memory because it allows us to ski=
p=20
> all this cache maintenance.
> Basically your driver can't predict the future so it has to play it safe=
=20
> when cached ION buffers are involved.
>=20
> Liam
>=20
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
