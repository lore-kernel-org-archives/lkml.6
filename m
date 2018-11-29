Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E143CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D308213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XKEWduc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D308213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeK3EjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:39:17 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:9444
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbeK3EjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVZ7Y8yJkUlpltZuYH3x9qCjhaVBt4+eKvcsewkQjPo=;
 b=XKEWduc8c1jBsG55UZTiC06snWb1gJd6Tsu0IYioXo2hE0atJ5d0ajMf9RzrH3PJ7iA+M7T8Sk9R7hky6yTWRFEVGshxMh2De2gxTjes+xcSxvo2J+3zuVmFduLw+V4NwknBizPX5w1EYg/V/+hhBdMun9ary9QDmbRKrzbOIv8=
Received: from AM6PR08MB3030.eurprd08.prod.outlook.com (52.135.163.139) by
 AM6PR08MB3957.eurprd08.prod.outlook.com (20.179.0.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 17:33:03 +0000
Received: from AM6PR08MB3030.eurprd08.prod.outlook.com
 ([fe80::a15d:a644:5b69:2989]) by AM6PR08MB3030.eurprd08.prod.outlook.com
 ([fe80::a15d:a644:5b69:2989%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 17:33:03 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "Clark, Rob" <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <Robin.Murphy@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Thread-Topic: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Thread-Index: AQHUiAmUr495p1h6JkW7FAgmR6hIrQ==
Date:   Thu, 29 Nov 2018 17:33:03 +0000
Message-ID: <20181129173301.rye77slpy27regi5@DESKTOP-E1NTVVP.localdomain>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de>
 <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de>
In-Reply-To: <20181129165715.GA27786@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51
x-originating-ip: [217.140.106.50]
x-clientproxiedby: CWLP265CA0329.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::29) To AM6PR08MB3030.eurprd08.prod.outlook.com
 (2603:10a6:209:45::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3957;6:7UTGNlAnK/ELSSAMuI8etGP33+z+zw4nA5PuV+iBpxyAN3hGP+7K455rMAOOK/4BhGKpUvpISHivi2wg5AUB0Bz7146fJWNxR2unHvEJUbOGDZ26eH9hWm1zNyL0QkGzolxdhy8M5ddu4ROgrh8XxUEdVVWhjbYsgzdQJODMvqmlt5Mb+23wt8IA+6BNZ5J51mEBHKEH9ey7OPCIqr57mZnG4NSXoa3IqRUDt77eMzgMtnukCM/Lycf58AZt3jr/YYHUWsH2/XMSNZCDZzOl+IM1lG+Hew1Ngc6TnC2rgWBgw08KGDj90KxXgAokDl6MmhakupPzyM0DqFRnOGxrg8ytWHXT5vSRX07YnkcqeiB3+P0YJ265J1SiEUVO1wKoIimTS6PHPykgGswbqqMhLJbxEhk9AwseAVGydJGe3N1w2N3STPDcKtwucvYPEpCoLiRtgBC/M4BlGgsNQqPilQ==;5:EgMTpyGoT13UXdjtCfCg/ABRpiNGc1zAx2MzRrrctA3HChEFOgJc48Fyx04Jo8+jPExM4TJcRPE+ppp1wckVNSRTVWvoIa3yPqnc7rxdP18dAkbKa1epgdvZQGvq8zs3+NrD+FVgKFX+gPXHGXnXP5Gvt9okNZ13AcRCDlKF3U0=;7:zc3HjSQa0YBOMw/kdwyl/QKFmE+8o4Xuehh0HzJ4zqNWhINxwLwGkiSseR4dFqv1lvkKcVGuLbpl87lPN0dpFsQogLm9UCTk/xCWjwkYrwkzf8XoPb2T+ahsqZWElC9bmY+vtHHK6IAsuxndcuFW/A==
x-ms-office365-filtering-correlation-id: d344f98d-7efe-4023-bbab-08d65620b700
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3957;
x-ms-traffictypediagnostic: AM6PR08MB3957:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB3957C90478ED962E3B38D5AAF0D20@AM6PR08MB3957.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231453)(999002)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3957;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3957;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(316002)(81156014)(14454004)(71190400001)(71200400001)(66066001)(86362001)(68736007)(44832011)(39060400002)(105586002)(52116002)(6246003)(8676002)(106356001)(476003)(486006)(478600001)(256004)(14444005)(72206003)(6116002)(446003)(11346002)(3846002)(81166006)(1076002)(2906002)(99286004)(4326008)(8936002)(93886005)(6506007)(33896004)(5660300001)(25786009)(97736004)(7416002)(7736002)(26005)(6486002)(386003)(6436002)(102836004)(229853002)(76176011)(6916009)(53936002)(305945005)(186003)(9686003)(58126008)(54906003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3957;H:AM6PR08MB3030.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wsC688zR/OJRJwxfBmoy2WlYAsATJpfC8lrPYBtXSLRPvggbavjLsK4QVxg4TM82rFnLJwvIoPyTyhvDGhVidNwDy780asljsdnCz/F7BwwexaKtrh3MoGuHB+7Fwa8bETfQVtaVeDq4Xeml9FSAbRgmMLQ7JfugeKTKnXez4gR+gR+qI7CqUIPCaxMQHpLMF3AGgWv04wwvL2/zfXsyEjLxnAl/mtUsGasLLk/hHmn382m9haTSwAKjbGoZr2u81AaMo6ixbotjVx2dtq+LVi4KAf8ugdeFur/e4hoGdC02+hTzGnrpJi/KIf4vSsCeXxcrY09+WfrYlIqp8gnCQx1jL+WjOds7McCBf3FS3Wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79138F810FDA1348BB17CA4285F5C59C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344f98d-7efe-4023-bbab-08d65620b700
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 17:33:03.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Nov 29, 2018 at 05:57:15PM +0100, Christoph Hellwig wrote:
>=20
> As for the buffer sharing: at least for the DMA API side I want to
> move the current buffer sharing users away from dma_alloc_coherent
> (and coherent dma_alloc_attrs users) and the remapping done in there
> required for non-coherent architectures.  Instead I'd like to allocate
> plain old pages, and then just dma map them for each device separately,
> with DMA_ATTR_SKIP_CPU_SYNC passed for all but the first user to map
> or last user to unmap.  On the iommu side it could probably work
> similar.
>=20
> I have done some preliminary work on this, and want to get it into this
> merge window, but there is a few other bits I need to sort out first.
>=20

This sounds very useful for ion, to avoid CPU cache maintenance as
long as the buffer stays in device-land.

One question though: How would you determine "the last user to unmap"
to know when to do the final "make visible to CPU" step?

Thanks,
-Brian
