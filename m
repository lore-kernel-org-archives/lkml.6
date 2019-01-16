Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C149C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3AF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p9TDkIVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394038AbfAPPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:19:59 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:9930
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391184AbfAPPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5dhCv3SkzQOtaf4t1jKidEcTe8iDDMM74NrgxDP7Yg=;
 b=p9TDkIVIIyTJLtsB1ktzRXn2a5Bc+OH51xkn8SiT5+cvLRSVIMHv7qOT4/NvbavMAgQtbAwEbI8FYDy4Q4PKcyIUSOp21Ek9G0VNZGuRdEjsXhnR/NQue7SlNbrUsQM+0bj4Jx19sXRiip76ZKl1oH4vP2JfLsdimKC+fpPu3xs=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3748.eurprd08.prod.outlook.com (20.178.22.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 15:19:53 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:19:53 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Topic: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Index: AQHUrQGAzRpl+6N4dEWaN50+01WrkqWwqYAAgAFaUAA=
Date:   Wed, 16 Jan 2019 15:19:52 +0000
Message-ID: <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
 <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
In-Reply-To: <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3748;6:wYTvbQMgrNDjhtNvx4molod2RsnuwuciWDG0MAetw6c+o7PetRH4PukMRWdkuOEMGCbpqXOcOxvFZS82ILAvN6DyVtcKOKQz7dfByWB778ucRwcv8zRMK44RapOT65IkpJqbT5Tj2zH25uOvrD9+e58jObEUL9uW96Gfikoy43eEtAypzB/Qta1T+Knn3Ic2DLZc0QgzBqCTVbK3NUnkRl8NMXuLNkSd/th5Z+Ib6YqgCfXYdpXX6SaRtuza4riOOdFEmQiuaBkGdfSzIOeE/vAHlns93cvtXzEqsQgUVByQLrrZClQattn3T+KvRDr+E2uOKz3uiROtGRtEGlz+Eb5tm7kDLV/u90z9+jHMhj4w5xxpX9s7x8E1w328BRZAkzWP6NxbWgecc3xtkPfLNqefhHyqcfYqjLopzhm7jUfohTM5PWu/HsjUkdSZYMGjrRkBKxaYzDIsRvcjLIzP9A==;5:ZIePYb11SvOENYwdXwaPBkEeWkTBHnNTBBTZSIFhMYKpuLezZC0J8q1/m2IlKDY8HxkfkbWjesEsDo4psSf0UzlcC30rK0JbvMoycW9DUNLAgjYbvXrMcqoGAzJvsXJBPduQbODCKIq/U1nyBrlvuWLRNG+AorHoVgvUUru0VI+J5PlMQSOdda9PQ3oHNN2mE4dWWt3dNCBlbiYjfJXSqQ==;7:SmRpZwx9enacVH8X2SYwoZPnyvjFUEzpEoOuMnrEwd3AfTkZEo1NQe0jHmv8HTPxM2bWENHoq4AJ2R6n3dieTzzt2K8C0ylZgp5oHzSao14lmhFgFAqnm1EKb7bfJVvhvc3I8EbQEM3h4zC6Zm1avA==
x-ms-office365-filtering-correlation-id: 6809cf22-0691-49ec-5229-08d67bc61010
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3748;
x-ms-traffictypediagnostic: AM0PR08MB3748:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3748D17DE2351C473926D1D5F0820@AM0PR08MB3748.eurprd08.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(1076003)(6486002)(6436002)(25786009)(229853002)(66066001)(93886005)(106356001)(105586002)(476003)(4326008)(3846002)(6116002)(26005)(8936002)(6506007)(6512007)(53546011)(9686003)(102836004)(68736007)(386003)(53936002)(7736002)(71190400001)(44832011)(305945005)(71200400001)(316002)(6916009)(14454004)(478600001)(186003)(5024004)(14444005)(256004)(54906003)(72206003)(81166006)(81156014)(76176011)(8676002)(33896004)(52116002)(99286004)(58126008)(5660300001)(86362001)(2906002)(446003)(6246003)(11346002)(486006)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3748;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVhqw/YGkrjyfgF2FZ5/KtvHuKtme352QitlTsmzSIbsqkf2zC8RBiAi+mU40RfwoWk5zkxMa8TTOJ+INZveUSQWtz8s7WDm1w58kISVFfJCeiCdRvkOy32peLnCgofZufjSrX5nOeNjptxR5hnEcf6ObiFMccvdYeajJYRd5bYjdbink+Xo/dLtgYI4ihlXa7KZYPUuMMqvV0QIF1P0CkZpZlcAGIStcgmSmH2cm/5e/418k+HcIhkNM0zBvV8T3+dVkb/1nkUHWBxLgWp/egj0fMcgG87KolL57cnRFeD6VQgVqqhQ5+W7C8T2DWoqygVFLe2ApNl6E2FEfd3PDDl8pcgGWCJohRxyAs0rtXR2iaY+ZcBdtzETjgqs/zMpg5WC1lD18AJYwJYaVdJNu3eIGVgiGyoDoA4RHwwbvhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DC46AD0742DE6A42A55A8C7FA273B3BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6809cf22-0691-49ec-5229-08d67bc61010
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:19:48.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :-)

On Tue, Jan 15, 2019 at 12:40:16PM -0600, Andrew F. Davis wrote:
> On 1/15/19 12:38 PM, Andrew F. Davis wrote:
> > On 1/15/19 11:45 AM, Liam Mark wrote:
> >> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
> >>
> >>> On 1/14/19 11:13 AM, Liam Mark wrote:
> >>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> >>>>
> >>>>> Buffers may not be mapped from the CPU so skip cache maintenance he=
re.
> >>>>> Accesses from the CPU to a cached heap should be bracketed with
> >>>>> {begin,end}_cpu_access calls so maintenance should not be needed an=
yway.
> >>>>>
> >>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >>>>> ---
> >>>>>  drivers/staging/android/ion/ion.c | 7 ++++---
> >>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/an=
droid/ion/ion.c
> >>>>> index 14e48f6eb734..09cb5a8e2b09 100644
> >>>>> --- a/drivers/staging/android/ion/ion.c
> >>>>> +++ b/drivers/staging/android/ion/ion.c
> >>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct =
dma_buf_attachment *attachment,
> >>>>> =20
> >>>>>  	table =3D a->table;
> >>>>> =20
> >>>>> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> >>>>> -			direction))
> >>>>> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> >>>>> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
> >>>>
> >>>> Unfortunately I don't think you can do this for a couple reasons.
> >>>> You can't rely on {begin,end}_cpu_access calls to do cache maintenan=
ce.
> >>>> If the calls to {begin,end}_cpu_access were made before the call to=
=20
> >>>> dma_buf_attach then there won't have been a device attached so the c=
alls=20
> >>>> to {begin,end}_cpu_access won't have done any cache maintenance.
> >>>>
> >>>
> >>> That should be okay though, if you have no attachments (or all
> >>> attachments are IO-coherent) then there is no need for cache
> >>> maintenance. Unless you mean a sequence where a non-io-coherent devic=
e
> >>> is attached later after data has already been written. Does that
> >>> sequence need supporting?=20
> >>
> >> Yes, but also I think there are cases where CPU access can happen befo=
re=20
> >> in Android, but I will focus on later for now.
> >>
> >>> DMA-BUF doesn't have to allocate the backing
> >>> memory until map_dma_buf() time, and that should only happen after al=
l
> >>> the devices have attached so it can know where to put the buffer. So =
we
> >>> shouldn't expect any CPU access to buffers before all the devices are
> >>> attached and mapped, right?
> >>>
> >>
> >> Here is an example where CPU access can happen later in Android.
> >>
> >> Camera device records video -> software post processing -> video devic=
e=20
> >> (who does compression of raw data) and writes to a file
> >>
> >> In this example assume the buffer is cached and the devices are not=20
> >> IO-coherent (quite common).
> >>
> >=20
> > This is the start of the problem, having cached mappings of memory that
> > is also being accessed non-coherently is going to cause issues one way
> > or another. On top of the speculative cache fills that have to be
> > constantly fought back against with CMOs like below; some coherent
> > interconnects behave badly when you mix coherent and non-coherent acces=
s
> > (snoop filters get messed up).
> >=20
> > The solution is to either always have the addresses marked non-coherent
> > (like device memory, no-map carveouts), or if you really want to use
> > regular system memory allocated at runtime, then all cached mappings of
> > it need to be dropped, even the kernel logical address (area as painful
> > as that would be).

Ouch :-( I wasn't aware about these potential interconnect issues. How
"real" is that? It seems that we aren't really hitting that today on
real devices.

> >=20
> >> ION buffer is allocated.
> >>
> >> //Camera device records video
> >> dma_buf_attach
> >> dma_map_attachment (buffer needs to be cleaned)
> >=20
> > Why does the buffer need to be cleaned here? I just got through reading
> > the thread linked by Laura in the other reply. I do like +Brian's
>=20
> Actually +Brian this time :)
>=20
> > suggestion of tracking if the buffer has had CPU access since the last
> > time and only flushing the cache if it has. As unmapped heaps never get
> > CPU mapped this would never be the case for unmapped heaps, it solves m=
y
> > problem.
> >=20
> >> [camera device writes to buffer]
> >> dma_buf_unmap_attachment (buffer needs to be invalidated)
> >=20
> > It doesn't know there will be any further CPU access, it could get free=
d
> > after this for all we know, the invalidate can be saved until the CPU
> > requests access again.

We don't have any API to allow the invalidate to happen on CPU access
if all devices already detached. We need a struct device pointer to
give to the DMA API, otherwise on arm64 there'll be no invalidate.

I had a chat with a few people internally after the previous
discussion with Liam. One suggestion was to use
DMA_ATTR_SKIP_CPU_SYNC in unmap_dma_buf, but only if there's at least
one other device attached (guarantees that we can do an invalidate in
the future if begin_cpu_access is called). If the last device
detaches, do a sync then.

Conversely, in map_dma_buf, we would track if there was any CPU access
and use/skip the sync appropriately.

I did start poking the code to check out how that would look, but then
Christmas happened and I'm still catching back up.

> >=20
> >> dma_buf_detach  (device cannot stay attached because it is being sent =
down=20
> >> the pipeline and Camera doesn't know the end of the use case)
> >>
> >=20
> > This seems like a broken use-case, I understand the desire to keep
> > everything as modular as possible and separate the steps, but at this
> > point no one owns this buffers backing memory, not the CPU or any
> > device. I would go as far as to say DMA-BUF should be free now to
> > de-allocate the backing storage if it wants, that way it could get read=
y
> > for the next attachment, which may change the required backing memory
> > completely.
> >=20
> > All devices should attach before the first mapping, and only let go
> > after the task is complete, otherwise this buffers data needs copied of=
f
> > to a different location or the CPU needs to take ownership in-between.
> >=20

Yeah.. that's certainly the theory. Are there any DMA-BUF
implementations which actually do that? I hear it quoted a lot,
because that's what the docs say - but if the reality doesn't match
it, maybe we should change the docs.

> >> //buffer is send down the pipeline
> >>
> >> // Usersapce software post processing occurs
> >> mmap buffer
> >=20
> > Perhaps the invalidate should happen here in mmap.
> >=20
> >> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO since =
no=20
> >> devices attached to buffer
> >=20
> > And that should be okay, mmap does the sync, and if no devices are
> > attached nothing could have changed the underlying memory in the
> > mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are.

Yeah, that's true - so long as you did an invalidate in unmap_dma_buf.
Liam was saying that it's too painful for them to do that every time a
device unmaps - when in many cases (device->device, no CPU) it's not
needed.

> >=20
> >> [CPU reads/writes to the buffer]
> >> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO since n=
o=20
> >> devices attached to buffer
> >> munmap buffer
> >>
> >> //buffer is send down the pipeline
> >> // Buffer is send to video device (who does compression of raw data) a=
nd=20
> >> writes to a file
> >> dma_buf_attach
> >> dma_map_attachment (buffer needs to be cleaned)
> >> [video device writes to buffer]
> >> dma_buf_unmap_attachment=20
> >> dma_buf_detach  (device cannot stay attached because it is being sent =
down=20
> >> the pipeline and Video doesn't know the end of the use case)
> >>
> >>
> >>
> >>>> Also ION no longer provides DMA ready memory, so if you are not doin=
g CPU=20
> >>>> access then there is no requirement (that I am aware of) for you to =
call=20
> >>>> {begin,end}_cpu_access before passing the buffer to the device and i=
f this=20
> >>>> buffer is cached and your device is not IO-coherent then the cache m=
aintenance
> >>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> >>>>
> >>>
> >>> If I am not doing any CPU access then why do I need CPU cache
> >>> maintenance on the buffer?
> >>>
> >>
> >> Because ION no longer provides DMA ready memory.
> >> Take the above example.
> >>
> >> ION allocates memory from buddy allocator and requests zeroing.
> >> Zeros are written to the cache.
> >>
> >> You pass the buffer to the camera device which is not IO-coherent.
> >> The camera devices writes directly to the buffer in DDR.
> >> Since you didn't clean the buffer a dirty cache line (one of the zeros=
) is=20
> >> evicted from the cache, this zero overwrites data the camera device ha=
s=20
> >> written which corrupts your data.
> >>
> >=20
> > The zeroing *is* a CPU access, therefor it should handle the needed CMO
> > for CPU access at the time of zeroing.
> >=20

Actually that should be at the point of the first non-coherent device
mapping the buffer right? No point in doing CMO if the future accesses
are coherent.

Cheers,
-Brian

> > Andrew
> >=20
> >> Liam
> >>
> >> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
