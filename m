Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9686BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460B720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ShpcliKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460B720832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeK1WMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:12:22 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:19394
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbeK1WMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHdMR6oyTN3Och6XLJn65vW5isX8efDrsx+bvACW8Lc=;
 b=ShpcliKoBKmdtyTwn9WOuAv1YcU9uijTmUCIPWhNzbTfVtzNDB0x52LrinBcrCpIE4b2LrWHGgSFyO5825713nK5MFFXje7DMH3IRDQexCFOK1/zryon0IpsZ/r+imvjT+GAX/30OEQQzBOT6aBKv2n+dRsJ3U+dG752Tn3hBSI=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3428.eurprd08.prod.outlook.com (20.177.109.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 11:10:53 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::e84e:50fd:edd6:66e4]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::e84e:50fd:edd6:66e4%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 11:10:53 +0000
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
Thread-Index: AQHUcjBnSvenHVoYw0amObMa8s0GR6VY/NIAgAo60wCAAF3pgIABUiWAgABJ+AA=
Date:   Wed, 28 Nov 2018 11:10:53 +0000
Message-ID: <20181128111052.q2xokwcpuucynoft@DESKTOP-E1NTVVP.localdomain>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
 <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811272231460.20916@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1811272231460.20916@lmark-linux.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3428;6:tdIUbnaeQlSpf+wgCIFYriyFqAUgmNZ0bJsHOxQmXB2MEzyoH+AdZ3PYVIc8TTBftbR3UUytZRUlmhlpdMKUbA8PDsjOrBChop8QWg2bGqhI8MbPr3FnWb2E22y23RXoTo8yKr8p32hWn/XQ0BOkwr/VXJebxQ/R3aIRO/nqxXT1j6EDuoBBcLWAALhviIzZw0NiuPEil/IQR5e9xaObkrP9VQo/8hEm9BtBicqXqR5PmF5oFBGS7gqv104LOM6bPriPpdxdbJQbyhzpCxG/wQkY4M0b6pztLachtb5atlhO25R+LlLEzwb0Ird3i9dytH18/+Sa7R8ZYlsC7Ca2sPXbBlisuTxehuCVX9BYjXNyOhfKMPGCCrBdz3YXqD9xXg5upciAMSt8DB2gO6OD2lIveG+MSJcF3tC2/BEZEGkv4r0HfRLlr5sV4hT3rk5T1YDMHQqHvcsF4OO4ZYh5LQ==;5:rcsxuhkXOT8XHYLYLuks2kYjaM3/RPNmEGnmajO41ngGp0Ud1XPJurXUdjw3UBpq5F62e+cIOyzjPWAk/UPMI4CbjfrFbGqqlLl6YUy+OOd8OS9W9c9P84oRZqJEqjvzdoYzO4ZoOcmrGkR0ZOiv0I5Ckt55uYj5klTtGNU0DYs=;7:lpYsqFCzHU9wwmYV4+hKFH0esLf7XMzDRTrYL9XWCQ1yveQB+pXfq2PuXRLgZmuB8wGRFGMDLPObKI8nJ5Mbi2TSrHnPxXKtMfZ0yDZtMIojEjABJc1d5m/hQhVh6XObYFMTbJ7Yhp74dUtuAgHFFQ==
x-ms-office365-filtering-correlation-id: f0607bf2-2301-4b39-899e-08d655222952
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3428;
x-ms-traffictypediagnostic: AM0PR08MB3428:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB34285361A3946DED8DF41619F0D10@AM0PR08MB3428.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3428;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3428;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(54094003)(199004)(189003)(99286004)(26005)(106356001)(561944003)(6512007)(102836004)(105586002)(6506007)(2906002)(7736002)(93886005)(9686003)(305945005)(58126008)(316002)(81156014)(54906003)(8676002)(8936002)(81166006)(97736004)(386003)(33896004)(1076002)(4744004)(6116002)(3846002)(76176011)(52116002)(6916009)(11346002)(66066001)(6436002)(14454004)(86362001)(476003)(6246003)(44832011)(4326008)(71190400001)(486006)(217873002)(478600001)(25786009)(446003)(71200400001)(6486002)(14444005)(229853002)(68736007)(72206003)(186003)(7416002)(53936002)(256004)(5024004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3428;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GanyHIJwAQECCIp7XCQvw8w0tWhLtJvspaJ89hftzhSNs6PjDjGNcJ25pK2Us5MQNOpJjCv4M2GUSb5MNUGB6rbIK5hic5QWsu5iOiOAXH8Zw4v3aC4XHXQKudtbRjeih5xQ2KFyH57vUmwOmiy5YdaB25EjJHT+1OMEF2RfoKMT4qXebopPr89kBCEUBdPY1rFrOMl6ZisVFW2juL4UMFAAmBD9c6ms4I/lKUECXz/E+7PJcQgXj4WMKW+lkSPmEA1IBG7FxPfBNZb9SqL85QT/Qk0IQ3qixzyO6Ht9Y5ZHAs0tQsnW6bR/4gjQTj3e2kCD4Z3YLDEY5pbdC/XMoltP3lPbskbsJo3qPopxJTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA3C61A6B9B2604F8DD994E4484BF6D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0607bf2-2301-4b39-899e-08d655222952
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 11:10:53.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Tue, Nov 27, 2018 at 10:46:07PM -0800, Liam Mark wrote:
> On Tue, 27 Nov 2018, Brian Starkey wrote:
>=20
> > Hi Liam,
> >=20
> > On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> > > On Tue, 20 Nov 2018, Brian Starkey wrote:
> > >=20
> > > > Hi Liam,
> > > >=20
> > > > I'm missing a bit of context here, but I did read the v1 thread.
> > > > Please accept my apologies if I'm re-treading trodden ground.
> > > >=20
> > > > I do know we're chasing nebulous ion "problems" on our end, which
> > > > certainly seem to be related to what you're trying to fix here.
> > > >=20
> > > > On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> > > > >Based on the suggestions from Laura I created a first draft for a =
change
> > > > >which will attempt to ensure that uncached mappings are only appli=
ed to
> > > > >ION memory who's cache lines have been cleaned.
> > > > >It does this by providing cached mappings (for uncached ION alloca=
tions)
> > > > >until the ION buffer is dma mapped and successfully cleaned, then =
it
> > > > drops
> > > > >the userspace mappings and when pages are accessed they are faulte=
d back
> > > > >in and uncached mappings are created.
> > > >=20
> > > > If I understand right, there's no way to portably clean the cache o=
f
> > > > the kernel mapping before we map the pages into userspace. Is that
> > > > right?
> > > >=20
> > >=20
> > > Yes, it isn't always possible to clean the caches for an uncached map=
ping=20
> > > because a device is required by the DMA APIs to do cache maintenance =
and=20
> > > there isn't necessarily a device available (dma_buf_attach may not ye=
t=20
> > > have been called).
> > >=20
> > > > Alternatively, can we just make ion refuse to give userspace a
> > > > non-cached mapping for pages which are mapped in the kernel as cach=
ed?
> > >=20
> > > These pages will all be mapped as cached in the kernel for 64 bit (ke=
rnel=20
> > > logical addresses) so you would always be refusing to create a non-ca=
ched mapping.
> >=20
> > And that might be the sane thing to do, no?
> >=20
> > AFAIK there are still pages which aren't ever mapped as cached (e.g.
> > dma_declare_coherent_memory(), anything under /reserved-memory marked
> > as no-map). If those are exposed as an ion heap, then non-cached
> > mappings would be fine, and permitted.
> >=20
>=20
> Sounds like you are suggesting using carveouts to support uncached?
>=20

No, I'm just saying that ion can't give out uncached _CPU_ mappings
for pages which are already mapped on the CPU as cached.

> We have many multimedia use cases which use very large amounts of uncache=
d
> memory, uncached memory is used as a performance optimization because CPU
> access won't happen so it allows us to skip cache maintenance for all the
> dma map and dma unmap calls. To create carveouts large enough to support
> to support the worst case scenarios could result in very large carveouts.
>=20
> Large carveouts like this would likely result in poor memory utilizations
> (since they are tuned for worst case) which would likely have significant
> performance impacts (more limited memory causes more frequent memory
> reclaim ect...).
>=20
> Also estimating for worst case could be difficult since the amount of
> uncached memory could be app dependent.
> Unfortunately I don't think this would make for a very scalable solution.
>=20

Sure, I understand the desire not to use carveouts. I'm not suggesting
carveouts are a viable alternative.

> > >=20
> > > > Would userspace using the dma-buf sync ioctl around its accesses do
> > > > the "right thing" in that case?
> > > >=20
> > >=20
> > > I don't think so, the dma-buf sync ioctl require a device to peform c=
ache=20
> > > maintenance, but as mentioned above a device may not be available.
> > >=20
> >=20
> > If a device didn't attach yet, then no cache maintenance is
> > necessary. The only thing accessing the memory is the CPU, via a
> > cached mapping, which should work just fine. So far so good.
> >=20
>=20
> Unfortunately not.
> Scenario:
> - Client allocates uncached memory.
> - Client calls the DMA_BUF_IOCTL_SYNC IOCT IOCTL with flags
> DMA_BUF_SYNC_START (but this doesn't do any cache maintenance since there
> isn't any device)
> - Client mmap the memory (ION creates uncached mapping)
> - Client reads from that uncached mapping

I think I maybe wasn't clear with my proposal. The sequence should be
like this:

 - Client allocates memory
   - If this is from a region which the CPU has mapped as cached, then
     that's not "uncached" memory - it's cached memory - and you have
     to treat it as such.
 - Client calls the DMA_BUF_IOCTL_SYNC IOCTL with flags
   DMA_BUF_SYNC_START (but this doesn't do any cache maintenance since
   there isn't any device)
 - Client mmaps the memory
   - ion creates a _cached_ mapping into the userspace process. ion
     *must not* create an uncached mapping.
 - Client reads from that cached mapping
   - It sees zeroes, as expected.

This proposal ensures that everyone will *always* see correct data if
they use the DMA APIs properly (device accesses via
dma_buf_{map,unmap}, CPU access via {begin,end}_cpu_access).

>=20
> Because memory has not been cleaned (we haven't had a device yet) the
> zeros that were written to this memory could  still be in the cache (sinc=
e
> they were written with a cached mapping), this means that the unprivilive=
d
> userpace client is now potentially reading sensitive kernel data....
>=20

This is precisely why you can't just "pretend" that those pages
are uncached. You can't have the same memory mapped with different
attributes and get consistent behaviour.

> > If there are already attachments, then ion_dma_buf_begin_cpu_access()
> > will sync for CPU access against all of the attached devices, and
> > again the CPU should see the right thing.
> >=20
> > In the other direction, ion_dma_buf_end_cpu_access() will sync for
> > device access for all currently attached devices. If there's no
> > attached devices yet, then there's nothing to do until there is (only
> > thing accessing is CPU via a CPU-cached mapping).
> >=20
> > When the first (or another) device attaches, then when it maps the
> > buffer, the map_dma_buf callback should do whatever sync-ing is needed
> > for that device.
> >=20
> > I might be way off with my understanding of the various DMA APIs, but
> > this is how I think they're meant to work.
> >=20
> > > > Given that as you pointed out, the kernel does still have a cached
> > > > mapping to these pages, trying to give the CPU a non-cached mapping=
 of
> > > > those same pages while preserving consistency seems fraught. Wouldn=
't
> > > > it be better to make sure all CPU mappings are cached, and have CPU
> > > > clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> > > > consistency where needed?
> > > >=20
> > >=20
> > > It is fraught, but unfortunately you can't rely on=20
> > > dma_buf_{begin,end}_cpu_access() to do cache maintenance as these cal=
ls=20
> > > require a device, and a device is not always available.
> >=20
> > As above, if there's really no device, then no syncing is needed
> > because only the CPU is accessing the buffer, and only ever via cached
> > mappings.
> >=20
>=20
> Sure you can use cached mappings, but with cached memory to ensure cache=
=20
> coherency you would always need to do cache maintenance at dma map and dm=
a=20
> unmap (since you can't rely on their being a device when=20
> dma_buf_{begin,end}_cpu_access() hooks are called).

As you've said below, you can't skip cache maintenance in the general
case - the first time a device maps the buffer, you need to clean the
cache to make sure the memset(0) is seen by the device.

> But with this cached memory you get poor performance because you are=20
> frequently doing cache mainteance uncessarily because there *could* be CP=
U access.
>=20
> The reason we want to use uncached allocations, with uncached mappings, i=
s=20
> to avoid all this uncessary cache maintenance.
>=20

OK I think this is the key - you don't actually care whether the
mappings are non-cached, you just don't want to pay a sync penalty if
the CPU never touched the buffer.

In that case, then to me the right thing to do is make ion use
dma_map_sg_attrs(..., DMA_ATTR_SKIP_CPU_SYNC) in ion_map_dma_buf(), if
it knows that the CPU hasn't touched the buffer (which it does - from
{begin,end}_cpu_access).

That seems to be exactly what it's there for:

 /*
  * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
  * the CPU cache for the given buffer assuming that it has been already
  * transferred to 'device' domain.
  */

The very first time you map the buffer on a device, you have to sync
(transfer to 'device' domain). After that, if you never touch the
buffer on the CPU, then you'll never pay the CPU cache maintenance
penalty.

> > >=20
> > > > >
> > > > >This change has the following potential disadvantages:
> > > > >- It assumes that userpace clients won't attempt to access the buf=
fer
> > > > >while it is being mapped as we are removing the userpspace mapping=
s at
> > > > >this point (though it is okay for them to have it mapped)
> > > > >- It assumes that kernel clients won't hold a kernel mapping to th=
e
> > > > buffer
> > > > >(ie dma_buf_kmap) while it is being dma-mapped. What should we do =
if
> > > > there
> > > > >is a kernel mapping at the time of dma mapping, fail the mapping, =
warn?
> > > > >- There may be a performance penalty as a result of having to faul=
t in
> > > > the
> > > > >pages after removing the userspace mappings.
> > > >=20
> > > > I wonder if the dma-buf sync ioctl might provide a way for userspac=
e
> > > > to opt-in to when the zap/fault happens. Zap on (DMA_BUF_SYNC_WRITE=
 |
> > > > DMA_BUF_SYNC_WRITE_END) and fault on (DMA_BUF_SYNC_READ |
> > > > DMA_BUF_SYNC_START)
> > > >=20
> > >=20
> > > Not sure I understand, can you elaborate.=20
> > > Are you also adding a requirment that ION pages can't be mmaped durin=
g a
> > > call to dma_buf_map_attachment?
> >=20
> > I was only suggesting that zapping the mappings "at random" (from
> > userspace's perspective), and then faulting them back in (also "at
> > random"), might cause unexpected and not-controllable stalls in the
> > app. We could use the ioctl hooks as an explicit indication from the
> > app that now is a good time to zap the mapping and/or fault back in
> > the whole buffer. begin_cpu_access is allowed to be a "slow"
> > operation, so apps should already be expecting to get stalled on the
> > sync ioctl.
> >=20
>=20
> I think we have to do the zapping when have a device with which we can
> then immediately clean the caches for the memory.
>=20
> The dma_buf_map_attachement seems like a logical time to do this, we have
> a device and the user should not be doing CPU access at this time.
> There is no guarantee you will ever have a device attached when the ioctl
> hooks are called so this could mean you never get a chance to switch to
> actual uncached mappings if you only try to do this from the ioctl hooks.
>=20

You can always zap in the ioctl. You just might end up having to
create a cached mapping for userspace again if a device doesn't attach
before the next time it calls the SYNC_START ioctl.

So yeah, with your approach of trying to switch userspace over to
non-cached mappings, I think map_attachment is the best place to do
the whole shebang, to avoid unnecessary work.

> The one-of hit of having to fault the pages back in is unfortunate but I
> can't seem to find a better time to do it.

That part you really could do in the SYNC_START ioctl, it's just not
symmetric.

Thanks,
-Brian

>=20
> Liam
>=20
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
