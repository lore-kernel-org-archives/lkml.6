Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74425C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157A720817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IzneEVU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157A720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeK0Vda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:33:30 -0500
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:16883
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728862AbeK0Vda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPjM6YEtIYXxcAokB9g9tC6KXYipnqttwuXYZU7k+7A=;
 b=IzneEVU7ztqnGdgEOYgG5AdhLSVCuWIKTsAn/lJn8PSxbKLSAxiM88N4y3A2q47TTahSBeDFs09Fz+ltXnsUWnKaZAtL7cfeJrskbEKgYeM7Dz8Wk38fItp+8bPfKRfibgMx/a/y8NjXmHmkzqwwsXmKY1mwnOZq2Oxf+ZlJEdk=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3842.eurprd08.prod.outlook.com (20.178.23.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 10:35:53 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::e84e:50fd:edd6:66e4]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::e84e:50fd:edd6:66e4%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 10:35:53 +0000
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
Thread-Index: AQHUcjBnSvenHVoYw0amObMa8s0GR6VY/NIAgAo60wCAAF3pgA==
Date:   Tue, 27 Nov 2018 10:35:52 +0000
Message-ID: <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
 <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::35) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3842;6:edNL9QSRpZ85zaoG866dotC0BlFs9q2Hw9tCOB26ANx/tgPobSMEw/ckX9JY8Om31coryiQ5IFAElx4mHog2x9rOo90b35kmwX16dA2/68A53Rg2qOnTYvBTRfTzBJuX95zvTpwMGD2JmQ0BO7opPYTtWEludFzNVcILC5fGdo4QjElx+HC+bSg5hC+QAywoU117R/z+CSPCRNSbxY7v6Yr+9VZ3LRc5jxWHR76+7wUX/5MhlNId6q/TWlW+609hSBe0Gt39MkMQ0dNXwbbvR1aW9/KUM2VOdRKQ/gGs3QoJOykptSlDZtMBmc0TZk16oByCnp8uDdnizWElm9qr399qh6BbIV+0HSQtHaL/2due8LQCcK6TIAH2liU1UCHdmLRdhAMRG3cQtPVJUd0QzpCeb9EkxrxI3odAxMrjcC5c4MD3brMqY48gg8+w/YvxXoipehRpezJm9t4F7TB1Mw==;5:KMWovoKpYef+TY5oYKT8JkfuMQnmHDn+OG27mUDyLmfcmgi6rf+S5TCXBs9u4pWkuEBTICMj5ElMvk723o0mElo3f8yR4PNo7agdp4knUXdjUZiZQpg83GdH5X8RM+SRnnCuQLEROqpoZNSwi8mSDpzluDuAXiiFhrYwSGmV168=;7:G+bgLW6E2M0KhdV/eyls9YAwLXGLIcIE6tPH9IDegfhEZ9sh4EeOOkKAthcVw/3kZBhkkMX1B/YQYoTU1AWKT2IrqVjHVJJtAkqCTOnVZgn47D99GAbFiYhcGDd1jjsigtg1uYPs8wCxG3pHkwl3JA==
x-ms-office365-filtering-correlation-id: 7ebddd8c-3537-4f2d-7bab-08d654541afc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3842;
x-ms-traffictypediagnostic: AM0PR08MB3842:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3842CB5A8A259A89C570B88FF0D00@AM0PR08MB3842.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3842;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3842;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(54094003)(66066001)(3846002)(6116002)(93886005)(1076002)(6246003)(6512007)(316002)(14454004)(54906003)(9686003)(105586002)(72206003)(25786009)(53936002)(478600001)(2906002)(4326008)(58126008)(106356001)(86362001)(97736004)(575784001)(81166006)(8936002)(99286004)(6916009)(76176011)(81156014)(229853002)(446003)(14444005)(256004)(11346002)(68736007)(5024004)(6486002)(6436002)(44832011)(7416002)(217873002)(5660300001)(476003)(486006)(26005)(71200400001)(71190400001)(186003)(305945005)(52116002)(33896004)(7736002)(8676002)(102836004)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3842;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yBH6OueBCsSSa3BqJJiKqYopqnoFCWsKOZML6RT6sxdSJ5YJPhEGnA8iuR32viQ2TM1T+TFkekHqabLo2VRdqBBdPq20OaT9oogkV6O5QkUa/Qoj8JSoeilMzCcrhQrYdgZlqDWPpF/FalPE/veq/LBqYEY7aD2uxT11H5tkmFhw4xbpIzjsKwVD5fpQTrQmirDdE4ghTf3YLVBPEFMe64x6DEx9/Olx2lAEKtu1Yt6F2BIN2WpQBdag67iUiU8JP2Vkqfob4IKqMA+tmvQy14mLQRtszMkoC2A5XzgkV9+MsxbNVJNyrasCPaPReasYVeRk9JbF0Omn8jnM5Tb40KB+sxA35E7CYia+vTA90do=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F5BF6E662E2D4469BC60B4C9850307F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebddd8c-3537-4f2d-7bab-08d654541afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 10:35:52.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> On Tue, 20 Nov 2018, Brian Starkey wrote:
>=20
> > Hi Liam,
> >=20
> > I'm missing a bit of context here, but I did read the v1 thread.
> > Please accept my apologies if I'm re-treading trodden ground.
> >=20
> > I do know we're chasing nebulous ion "problems" on our end, which
> > certainly seem to be related to what you're trying to fix here.
> >=20
> > On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> > >Based on the suggestions from Laura I created a first draft for a chan=
ge
> > >which will attempt to ensure that uncached mappings are only applied t=
o
> > >ION memory who's cache lines have been cleaned.
> > >It does this by providing cached mappings (for uncached ION allocation=
s)
> > >until the ION buffer is dma mapped and successfully cleaned, then it
> > drops
> > >the userspace mappings and when pages are accessed they are faulted ba=
ck
> > >in and uncached mappings are created.
> >=20
> > If I understand right, there's no way to portably clean the cache of
> > the kernel mapping before we map the pages into userspace. Is that
> > right?
> >=20
>=20
> Yes, it isn't always possible to clean the caches for an uncached mapping=
=20
> because a device is required by the DMA APIs to do cache maintenance and=
=20
> there isn't necessarily a device available (dma_buf_attach may not yet=20
> have been called).
>=20
> > Alternatively, can we just make ion refuse to give userspace a
> > non-cached mapping for pages which are mapped in the kernel as cached?
>=20
> These pages will all be mapped as cached in the kernel for 64 bit (kernel=
=20
> logical addresses) so you would always be refusing to create a non-cached=
 mapping.

And that might be the sane thing to do, no?

AFAIK there are still pages which aren't ever mapped as cached (e.g.
dma_declare_coherent_memory(), anything under /reserved-memory marked
as no-map). If those are exposed as an ion heap, then non-cached
mappings would be fine, and permitted.

>=20
> > Would userspace using the dma-buf sync ioctl around its accesses do
> > the "right thing" in that case?
> >=20
>=20
> I don't think so, the dma-buf sync ioctl require a device to peform cache=
=20
> maintenance, but as mentioned above a device may not be available.
>=20

If a device didn't attach yet, then no cache maintenance is
necessary. The only thing accessing the memory is the CPU, via a
cached mapping, which should work just fine. So far so good.

If there are already attachments, then ion_dma_buf_begin_cpu_access()
will sync for CPU access against all of the attached devices, and
again the CPU should see the right thing.

In the other direction, ion_dma_buf_end_cpu_access() will sync for
device access for all currently attached devices. If there's no
attached devices yet, then there's nothing to do until there is (only
thing accessing is CPU via a CPU-cached mapping).

When the first (or another) device attaches, then when it maps the
buffer, the map_dma_buf callback should do whatever sync-ing is needed
for that device.

I might be way off with my understanding of the various DMA APIs, but
this is how I think they're meant to work.

> > Given that as you pointed out, the kernel does still have a cached
> > mapping to these pages, trying to give the CPU a non-cached mapping of
> > those same pages while preserving consistency seems fraught. Wouldn't
> > it be better to make sure all CPU mappings are cached, and have CPU
> > clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> > consistency where needed?
> >=20
>=20
> It is fraught, but unfortunately you can't rely on=20
> dma_buf_{begin,end}_cpu_access() to do cache maintenance as these calls=20
> require a device, and a device is not always available.

As above, if there's really no device, then no syncing is needed
because only the CPU is accessing the buffer, and only ever via cached
mappings.

>=20
> > >
> > >This change has the following potential disadvantages:
> > >- It assumes that userpace clients won't attempt to access the buffer
> > >while it is being mapped as we are removing the userpspace mappings at
> > >this point (though it is okay for them to have it mapped)
> > >- It assumes that kernel clients won't hold a kernel mapping to the
> > buffer
> > >(ie dma_buf_kmap) while it is being dma-mapped. What should we do if
> > there
> > >is a kernel mapping at the time of dma mapping, fail the mapping, warn=
?
> > >- There may be a performance penalty as a result of having to fault in
> > the
> > >pages after removing the userspace mappings.
> >=20
> > I wonder if the dma-buf sync ioctl might provide a way for userspace
> > to opt-in to when the zap/fault happens. Zap on (DMA_BUF_SYNC_WRITE |
> > DMA_BUF_SYNC_WRITE_END) and fault on (DMA_BUF_SYNC_READ |
> > DMA_BUF_SYNC_START)
> >=20
>=20
> Not sure I understand, can you elaborate.=20
> Are you also adding a requirment that ION pages can't be mmaped during a
> call to dma_buf_map_attachment?

I was only suggesting that zapping the mappings "at random" (from
userspace's perspective), and then faulting them back in (also "at
random"), might cause unexpected and not-controllable stalls in the
app. We could use the ioctl hooks as an explicit indication from the
app that now is a good time to zap the mapping and/or fault back in
the whole buffer. begin_cpu_access is allowed to be a "slow"
operation, so apps should already be expecting to get stalled on the
sync ioctl.

Cheers,
-Brian

>=20
> > >
> > >It passes basic testing involving reading writing and reading from
> > >uncached system heap allocations before and after dma mapping.
> > >
> > >Please let me know if this is heading in the right direction and if th=
ere
> > >are any concerns.
> > >
> > >Signed-off-by: Liam Mark <lmark at codeaurora.org>
> > >---
> > > drivers/staging/android/ion/ion.c | 146
> > +++++++++++++++++++++++++++++++++++++-
> > > drivers/staging/android/ion/ion.h |   9 +++
> > > 2 files changed, 152 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/drivers/staging/android/ion/ion.c
> > b/drivers/staging/android/ion/ion.c
> > >index 99073325b0c0..3dc0f5a265bf 100644
> > >--- a/drivers/staging/android/ion/ion.c
> > >+++ b/drivers/staging/android/ion/ion.c
> > >@@ -96,6 +96,7 @@ static struct ion_buffer *ion_buffer_create(struct
> > ion_heap *heap,
> > > 	}
> > >
> > > 	INIT_LIST_HEAD(&buffer->attachments);
> > >+	INIT_LIST_HEAD(&buffer->vmas);
> > > 	mutex_init(&buffer->lock);
> > > 	mutex_lock(&dev->buffer_lock);
> > > 	ion_buffer_add(dev, buffer);
> > >@@ -117,6 +118,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
> > > 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
> > > 	}
> > > 	buffer->heap->ops->free(buffer);
> > >+	vfree(buffer->pages);
> > > 	kfree(buffer);
> > > }
> > >
> > >@@ -245,11 +247,29 @@ static void ion_dma_buf_detatch(struct dma_buf
> > *dmabuf,
> > > 	kfree(a);
> > > }
> > >
> > >+static bool ion_buffer_uncached_clean(struct ion_buffer *buffer)
> > >+{
> > >+	return buffer->uncached_clean;
> > >+}
> >=20
> > nit: The function name sounds like a verb to me - as in "calling this
> > will clean the buffer". I feel ion_buffer_is_uncached_clean() would
> > read better.
> >=20
>=20
> Yes, that would be cleaner.
>=20
> Liam
>=20
>=20
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20
