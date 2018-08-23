Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277CF208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="vfuL7WHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277CF208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHWUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:10:05 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:4841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeHWUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEyYLNTBryMZ8Fulj+XdVliAufmfCuYdE+rt4Yo2sg=;
 b=vfuL7WHE5DDgepc4UoHzsdH5FgP+QnUA6RU8YbuCIHBYO2fz7Qmbve3dDQ93jYW3MBK1ROTz3LY7X8uTbqG/QoQb2ixUcsl8f8VdlO6ii0VKqCuPBSt1ULStTTQJbL8yqDFOdEcvlB2+buwODAr9khokRCEGQUGPvRvqhPvqXUM=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2687.eurprd05.prod.outlook.com (10.172.15.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Thu, 23 Aug 2018 16:39:29 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::95be:5f3e:5f50:9826]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::95be:5f3e:5f50:9826%4]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 16:39:29 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Eric Biggers <ebiggers@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dasaratharaman.chandramouli@intel.com" 
        <dasaratharaman.chandramouli@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
Subject: RE: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Thread-Topic: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Thread-Index: AQHTxJWJngQhcM4MiEyf8GrvXvpsbqPh3+iAgOvol4CAAJDbAIAAG9cA
Date:   Thu, 23 Aug 2018 16:39:29 +0000
Message-ID: <VI1PR0501MB22714BE9A34FA333671A0623D1370@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <001a1141551246502d056845782e@google.com>
 <001a1140f6ac1677460568489287@google.com>
 <20180823061630.GB736@sol.localdomain> <20180823145458.GC9366@ziepe.ca>
In-Reply-To: <20180823145458.GC9366@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [107.77.219.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2687;6:9DXT1luxjKZwfCcD2zfE5ypbrcIytkYd0cBAixKU5s683LsRnns0zzGVHRTtxaTIUvvU+pBDNmwLzuAZyLRlfIYDxzNzG1W+QAWQJFw4VfU+4/MSmFJV1Wir1mJ532VhSBpVxPVGLnNavKicuDNtK5QyNYWRhCKAQmRw+ysGS3MZ6rkJ6e6s5l4WRgK20thKbMDATjTXs7irbei0yG5D7D2phECcLlNKBqJeJMZFFwmCJiu4FmTggb2xT9JmDWSG3EKqY6uiW806+SR+Wg2UjxR67Xi+2DZ/UR/O3BT8l1agv5/90eDnETg0xSFGpA7gSKJRwHW/7rRRcA4VD2zgii2Ma3VmFmHW6Efz99UWmnQ9sQ8PmHt71+sihqwsM7uKX3hY920YZs0H4T2XHRtWQSva1LpOh2Txc1Z4SwybN7K7YmnZzvDxuPHRJiG9x1iNx/pPFZCCCccRMQuu25wuow==;5:Goc/qlpgWXBYbmFepZt5Ui/pgMM5onWGx/rSgmOI8RJror5CXnx87rR9dKWUFOm/Ou3OL4R8zkZ33xvoDQ55Map1us1LncRxl6rCRn/q4P2+nTQngKtIQPYPfZDpJX2adpQ16Pec4tnLykn0fwOWzL+uI3YuQ1MyZzOgHF8AsBI=;7:Pz51ig4l2Lg/U+4pHIY5xRGUmdAKmqv5Afl85yy6Nie5uhxlswfqmuWvN7UodZeIdrCjzQv1LVkkKw7oWIAJTAaU6h8ty5dZQIrHewYkVCynSbRUMilsDawT3lr+zyZHrrpanHba0iO0Ldeacg6dC38uBiVnCKRsGV0p6BNxVUbZzLWIRLx/wxPYPmaWfwbEUbQjdTpkau+wk6R0D9x/AE9pBgQ5udjpxP1S3qKQyzL88yuYea3hXtORShUBttdW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4100894e-ae33-4bfd-5f78-08d60916ff01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2687;
x-ms-traffictypediagnostic: VI1PR0501MB2687:
x-microsoft-antispam-prvs: <VI1PR0501MB2687DCF88C042B9B2E750746D1370@VI1PR0501MB2687.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR0501MB2687;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2687;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(13464003)(14454004)(68736007)(53546011)(76176011)(8676002)(14444005)(81166006)(256004)(229853002)(6116002)(7696005)(478600001)(3846002)(33656002)(446003)(476003)(66066001)(105586002)(102836004)(54906003)(2900100001)(6506007)(11346002)(316002)(99286004)(8936002)(26005)(5250100002)(55016002)(9686003)(110136005)(25786009)(486006)(186003)(5660300001)(74316002)(106356001)(97736004)(2906002)(575784001)(6246003)(7736002)(86362001)(81156014)(93886005)(4326008)(53936002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2687;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XDL+Z2B2e1aIdEBIM0B1V7I6J0e30JYRg7rRIX7CoT/UtRO/JzFSdqiI4+k6aH8q8P0lq6U8sa3H/n5YKOJrZYUybV1koHcj6Z/Vpf0GehK7uVz9YRNpKjYiu3RWY6i9T9vjOl4P2rVqKUL43zSxGHG+SsIVrTTrfahgqNP+x2Pq2yq+cQTrlNeuKZ0TUjiDRITtHDLwyYhThrAmd14q2eGhh9FmbteQgmAz4HD7vgGPE18FNyZn9gH7sSE2DzfGg8mEHFGVRo5j/SYF9UJCiacNy2AIQz9YfrL33bVtZqFIajDrokYHOHmn4+lYoEvtX038EtEYb2w0MnXHXQle/t1H6KpIsS0eu1Wks+oYMFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4100894e-ae33-4bfd-5f78-08d60916ff01
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 16:39:29.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, August 23, 2018 9:55 AM
> To: Eric Biggers <ebiggers@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; linux-rdma@vger.kernel.org;
> dasaratharaman.chandramouli@intel.com; Leon Romanovsky
> <leonro@mellanox.com>; linux-kernel@vger.kernel.org; Mark Bloch
> <markb@mellanox.com>; Moni Shoua <monis@mellanox.com>; Parav Pandit
> <parav@mellanox.com>; syzkaller-bugs@googlegroups.com; syzbot
> <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
> Subject: Re: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_va=
lid
> (4)
>=20
> On Wed, Aug 22, 2018 at 11:16:31PM -0700, Eric Biggers wrote:
> > Hello RDMA / InfiniBand maintainers,
> >
> > This is an RDMA bug and it still occurs on Linus' tree as of today
> > (commit 815f0ddb346c1960).
> >
> > I've also simplified the reproducer for it; see below after the origina=
l report.
> > Apparently it involves a race between RDMA_USER_CM_CMD_RESOLVE_IP
> and
> > RDMA_USER_CM_CMD_LISTEN.
>=20
> That is an amazing reproducer!
>=20
> I have a feeling this is the same cause as all the other syzkaller bugs i=
n this code:
> lack of any sane locking at all :\
>=20
> We've talked about chucking a big lock around this whole thing, but nobod=
y has
> done it yet.. It isn't so simple.
>=20
I had some code in which reduces three locks (handler_lock, qp_mutex, id_lo=
ck) to single mutex to protect the cm_id and protects every exported symbol=
 of rdmacm which works on cm_id.
But not ready enough to post it as patch yet. Lot of tests required before =
I get there and some refactor too before that.

> Jason
