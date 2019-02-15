Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749B21900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qVO3bfwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405862AbfBOKvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:51:02 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:60541
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405780AbfBOKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT8PXBvMQ2o/jB2RD4yXdPQ4jpoMRif4rfi8S/RsEjE=;
 b=qVO3bfwAL3pRgDkQ6TOp/vydSYnXUI0I3ozLzZPpv2glxrhE37S3b1SAwWaVUTbJWt9hSs3bINc6iWIu0mdCr/m+vrcOg2JoBBW4x2MuMuB8zrEl/EWH5R34cBvrrjBLpTDcgMIhBmbtbwl3BygeNjeNpeNm+8TbajJLJNjppt0=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3010.eurprd08.prod.outlook.com (52.134.90.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 10:50:58 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 10:50:58 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Topic: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Index: AQHUt1KdPElFkHXe9k+icWeJGBgTbKXfqYyAgAEgeIA=
Date:   Fri, 15 Feb 2019 10:50:58 +0000
Message-ID: <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
References: <20190128214408.25442-1-afd@ti.com>
 <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
In-Reply-To: <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::17) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de846204-c81f-411f-7760-08d6933377ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3010;
x-ms-traffictypediagnostic: AM0PR08MB3010:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3010;20:c5NMItQXe7Rj00vqLTMy/0sywkgxS6yITk+S2s2nxcAuRknNUHNAlbepvLe+IADbdZhsMEVw/AG+OabN+O0pyJLEOahrqrM/fzSbW5xAwLPvHuxG7/06UyjJUN2GlgyMQYRSRN7p33Aw7zqzFQoxr5USuc2Ihe44dcwgx+Vrs4Q=
x-microsoft-antispam-prvs: <AM0PR08MB3010A0DFC9695944C9A4AA3CF0600@AM0PR08MB3010.eurprd08.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(105586002)(97736004)(52116002)(99286004)(76176011)(106356001)(7736002)(305945005)(256004)(4326008)(478600001)(72206003)(186003)(476003)(486006)(446003)(11346002)(6116002)(71200400001)(71190400001)(3846002)(81156014)(68736007)(81166006)(8676002)(6246003)(44832011)(8936002)(7416002)(25786009)(53936002)(229853002)(66066001)(6916009)(26005)(14454004)(6512007)(9686003)(6486002)(102836004)(6436002)(2906002)(54906003)(386003)(86362001)(6506007)(1076003)(58126008)(33896004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3010;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cw9AYvg86wum0ky0djFWydSa9tRAGl+EfiPTcKMM6x9saSS/zYzP0OmkCsoOTvVckAoTS4BFNsJEV7YKSG2PRia/Oo47AOb894XW+5Vk8lpBb+pSelcep1ANYN5pEWIwl5EJM96MNba8TCnBxGD3ZVGNv7PHQS78IPwv7hm0pLkNLA+u+l9gadcVihn8bFYjlbETfJnY20MIIqDJlpMquTVFYkTothxjtdJ7J/JaRqBZQaead8pF8CFGr37eMcxqCr1BpJukV3pChx0At/h0gLOwEGqx99KuBfKzgbkFYKnxakYbr5Hii8otY4qqsepNX5MoYq2957zvLUVUIV5pcuRIGD9Z9TIR5kZccVbwQ2IsUMMIeHdFwz9BwbPDkfe0L5Y81n2MIsKZkKqqMUYqGfOjtFQ1jz63x75bOmixLic=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <90592F78C404C547BAC59C42BE19E196@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de846204-c81f-411f-7760-08d6933377ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 10:50:57.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
>=20
[snip]

> Some thoughts, as this ABI break has the potential to be pretty painful.
>=20
> 1) Unfortunately, this ABI is exposed *through* libion via
> ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
> will have a wider impact to vendor userland code.

I figured libion could fairly easily loop through all the set bits in
heap_mask and call the ioctl for each until it succeeds. That
preserves the old behaviour from the libion clients' perspective.

>=20
> 2) For patches that cause ABI breaks, it might be good to make it
> clear in the commit what the userland impact looks like in userspace,
> possibly with an example, so the poor folks who bisect down the change
> as breaking their system in a year or so have a clear example as to
> what they need to change in their code.
>=20
> 3) Also, its not clear how a given userland should distinguish between
> the different ABIs.  We already have logic in libion to distinguish
> between pre-4.12 legacy and post-4.12 implementations (using implicit
> ion_free() behavior). I don't see any such check we can make with this
> code. Adding another ABI version may require we provide an actual
> interface version ioctl.
>=20

A slightly fragile/ugly approach might be to attempt a small
allocation with a heap_mask of 0xffffffff. On an "old" implementation,
you'd expect that to succeed, whereas it would/could be made to fail
in the "new" one.

Thanks,
-Brian

>=20
> thanks
> -john
