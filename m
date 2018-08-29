Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B94C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95076205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h+yVQfl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95076205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeH2VDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:03:17 -0400
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:63948
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeH2VDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXa12f5O6MeqnYHfd+J2ol9D9uitpC0eNIi8NowIkro=;
 b=h+yVQfl6zgsJagGRd5RM1pye1Xf/LMsY30lw612HEF0NRxlVdSdmJOTm83pSJ+2Rgcb280JDZ+GC4JFnl2JnJCJRuHWa7Evihuz7GmiPiN0TaJ0yWMcuIYBEGtl41y2T7ywDh5ROFj2zhQa/3cDnf+IZ4mKuHqvDQnHWC6TgYhw=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3611.namprd02.prod.outlook.com (10.167.162.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Wed, 29 Aug 2018 17:05:23 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5%4]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 17:05:21 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Topic: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Index: AQHUJZfEjDnYw63wzE+wSwsRCwPdMKTKg7GAgArgSpCAAOqtgIAAyp+g
Date:   Wed, 29 Aug 2018 17:05:20 +0000
Message-ID: <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
In-Reply-To: <20180829040111.GD2388@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [183.83.212.199]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3611;6:PdA1RjiJRvmsuRq8dlRtvz6kFAZcxocDtLdcW3FYEyB4h+O6IKfyVgWgw8VMY+Rs1eUzaul14ZF/RVB+fozbcd7XBaA3VFzFhO2qqjD+JmhiCeYjhAl17Iz0F1ne9e1egXtWhnaMHyDsSBk4MtXweCBqek1Q3w6KqyDEpAox14eWyb7KINrGiXow8dVcheFyNeyPliTzDbVJdac487gkS7a9KeOYq5MKg5rcq8Iz9QlZISTnMzXKpMc1qOo/2JF4RhJ/3//YPFemN3L9E64NGCOQxbXqHNeh6jSRGY2re7idTxOC8cc4V2H/BMNW/eaLe04PkeJc2k9OGAMK7bDiD7JhE+JgT5PQnA0vzcV2MB93NjlLrSTOpBN/ls3IuADQzKOQ6rINPegzZcj16tFoUuCVX4CBaguhrCw1upRUj5G+cKsRvBwav17Uqt+aUimxTv69cWpdtcRQsl89vmEZfg==;5:QiVUcEcUPtFCUZpVIxDxME6CLMp5ASBsetjuqVDu+D6f4/sVeeq/OOg8fpFE5mUMQ7F6JwBLKhWYkEIFmslKx2T/gQ7taJlj0MEaTUB+pGT6hDzYwVrAQFoFKqEDUeuAxDncYbV2k7h/E6Znb5QZy27GQ/kQy8sY23XjNra1l58=;7:fpPZPk+zVy7yi9x1k5Z//j7ioC2sAp3IcBQIK4ZMwlremiPKCL0O14PYOcseS3jh426lgYmgyQgrqmq8Hrai5AMv80RTKVzjVKwPPbuk5NDpraDNwxf/DA7Tjf2rYQdZFjNsuD0u16eOSpBwOmlhCpDMvtjCwj2js62HrgerXS0t/SYcxoA/8J5WeTSe5hL+/S1padJFDh1GVl9qAnL734T4za5nCWyMFJ/xvTah/jN5kxOlFv9Hq0KnMkMOJHM+
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(13464003)(199004)(26005)(55016002)(14444005)(9686003)(76176011)(99286004)(8936002)(102836004)(186003)(6506007)(53546011)(2900100001)(6116002)(316002)(68736007)(446003)(81166006)(476003)(54906003)(3846002)(5250100002)(86362001)(7696005)(53936002)(6246003)(256004)(81156014)(229853002)(11346002)(486006)(4326008)(93886005)(97736004)(14454004)(305945005)(6916009)(66066001)(2906002)(6436002)(74316002)(478600001)(33656002)(105586002)(5660300001)(7736002)(106356001)(8676002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3611;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 57e8fdda-1716-4f01-680c-08d60dd19a8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3611;
x-ms-traffictypediagnostic: MWHPR0201MB3611:
x-microsoft-antispam-prvs: <MWHPR0201MB3611781089F6AD0043FC4FE1C7090@MWHPR0201MB3611.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(163750095850)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:MWHPR0201MB3611;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3611;
x-forefront-prvs: 077929D941
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 400YFRVqiRz4ihTwcPexUp0H+U//ZZymSu5y5VorwxAFhtL6rafrbnC3O18JysdCF+dUiCkLPofPIHu1qJkPMWwTrAegPNPirhm2uytB8JmSndXRykGnFTuxNJju8q2Ti/lJLDeVTl9OBJOqtI9FcPSOh6z6InGhfi/cl9B9AnqifVQaXbcHeZH2vOQqy76IaBiwSoL7wzSzt9H2Sf9gmCdoOWH2Bj2oJkdtrHlHkw/htoio/cRw/DpGG4A5vFBr+tBmDLBNLZPv1ZcSXFrOeRN5ohD2Vsq+8ie/Qeof9yDncvZpQJs0qNQ/BWQS0wWfoWI3V/lFDEbYCX99gn/1bhrEDfYfLTvoEqGARatChEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e8fdda-1716-4f01-680c-08d60dd19a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 17:05:20.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod <vkoul@kernel.org>
> Sent: Wednesday, August 29, 2018 9:31 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; lars@metafoo.de;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
> transfer
>=20
> On 28-08-18, 14:03, Radhey Shyam Pandey wrote:
> > > On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > > > In AXI CDMA simple mode also pass MSB bits of source and destinatio=
n
> > > > address to xilinx_write function. This fixes simple CDMA operation
> > > > mode using 64-bit addressing.
> > > >
> > > > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > > > ---
> > > >  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
> > > >  1 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> > > > index a37871e..2e15d86 100644
> > > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > > @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struc=
t
> > > xilinx_dma_chan *chan)
> > > >
> > > >  		hw =3D &segment->hw;
> > > >
> > > > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> > > >src_addr);
> > > > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> > > >dest_addr);
> > > > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> > > (dma_addr_t)
> > > > +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
> > >
> > > so this is:
> > >         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
> > >
> > > what is src_addr data type? I think its u32. It would be better to
> > > update xilinx_write() to take u64 and not dma_addr_t.
> >
> > Yes, src_addr_msb and src_addr BD fields are u32. To explain: There is =
no
> > prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit
> > depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a
> bug
> > i.e in the call to xilinx_write src_addr_msb 32 bits were not passed. T=
o fix
> > that combine MSB and LSB 32 bits before passing it to xilinx_write.
>=20
> Yeah that part was clear but the implementation can be better..
Thanks! Separate fields for source address are needed due to CDMA BD struct=
ure.=20
Please suggest if it doesn't look ok.

>=20
> --
> ~Vinod
