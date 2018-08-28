Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C9F2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1WQhfgkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C9F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeH1RzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:55:23 -0400
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:38000
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbeH1RzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sime/CpHTGdrzjcSQJYDl+VDi3Iv/p7g3DMb9rOcFIY=;
 b=1WQhfgkt/QpVIe08Cfviz1uSv9wzng5RwQehF6io9UABTS9i7GMLvfrL5VGiuu7K4+G6hr5/Zzp6NnjP5ztuorofepLMN2np6bDU0vZSNWkJElU9YgAEKNTPa7KC+H26X5eQULiDQf9aZRHwaUvGBB7VifF42YYaMiySZUn3lY4=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3530.namprd02.prod.outlook.com (10.167.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 14:03:31 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5%4]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 14:03:30 +0000
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
Thread-Index: AQHUJZfEjDnYw63wzE+wSwsRCwPdMKTKg7GAgArgSpA=
Date:   Tue, 28 Aug 2018 14:03:30 +0000
Message-ID: <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
In-Reply-To: <20180821155553.GI2388@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [183.83.222.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3530;6:pv9NNUxLIyp+H5vwlreMy3w7sOej2XBXWWcKOWNlRxuU4eIBnxqcY+5OkjZJ8b911jOMMZwXwVObtNk/K0KIZ82ekPW2k7sruKtcGY3NEvqjw7GWC1Pyu/oMDURHIxTJBQqwCAgBZMghukr9FMwAaGp+SbpUFZJU9kKTxwEonn3ADdPYYKWBxn+Dcu8m+shOLCt1aJI7bFxczr5khUqes5ZnkROwnk0L3OlYSnSQfY95uyRPNfpx4UAerhZWeMkeY4XakVyz8kqsn8igdvE4UmRdqQ8r3wFDqcJZo5XAR2sko1RiLloQgel8hbHCo/wP4Ufesh6f+BOpoIMEnN2yJBoqXs82XsnbgmCpt5QPxa/DUsXvDTwrTH6/Uc4hzIAN1uFJtjS36LLWWRFaO72FfPxhr66GqCCxevuW7BiRiC8GG+l3mM6Zloim4qj0hCEMzH4li10+GQTxQgyYInT1OQ==;5:sZEY1qLk9qQWcrB6pIjs/MjAk0I6rWP3UKPfmszxaTf+4y7Y8QUcFbyV4QCd1xYVmcMRPiNjFKqNdWe9qrPYZv90Wi6PQjdBHKEPUEj1vJ+2dzhRTBSmZSoZIWrDhLwXS4/Xfh75i+eZq3o0ZJG2drNLkR3yWKQfSmtevJpkU6k=;7:JOdILOv6q3orcvUgdyrsS/OuvNhtp5HogakUncINUe7ulpf3agMyEQUVV92DRb/IcbPmfvYtLilE9J5nv9LZu6+KrdTSMAkxtuXAQpMvN6Y0b8xAttdH42irgrBjbUsKHNE5ahwZmWY3IuiA5QbQOmw3WiNWzGJP+0ID4MMRg5hrP2l5ckhtPE3fVnP0b6Y09s3fh5Cqna+G0rsUzcyQXvxT5R5Qh10vUT6hDlEqKs8x8lJTVgfUzLVz3kCJlVGq
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(13464003)(66066001)(316002)(74316002)(106356001)(26005)(5250100002)(55016002)(6116002)(14454004)(305945005)(478600001)(3846002)(6916009)(6436002)(11346002)(99286004)(446003)(966005)(86362001)(9686003)(2900100001)(97736004)(8936002)(229853002)(76176011)(53936002)(68736007)(486006)(14444005)(256004)(102836004)(476003)(7696005)(2906002)(186003)(81156014)(81166006)(8676002)(6306002)(53546011)(4326008)(105586002)(7736002)(6506007)(25786009)(5660300001)(6246003)(33656002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3530;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 69f7de5c-3fe9-4f75-b61f-08d60cef090f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3530;
x-ms-traffictypediagnostic: MWHPR0201MB3530:
x-microsoft-antispam-prvs: <MWHPR0201MB3530CE7444F57BC69E306A8AC70A0@MWHPR0201MB3530.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(163750095850)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR0201MB3530;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3530;
x-forefront-prvs: 077884B8B5
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y7XAEfuW2ry1Gyfhs1iqoNbMnGcRc6/MdUUJAKKLyEZ36YsUzjcLiQD0AmXzn8hvKCfxphKZRSVYrJNk9NtFxoZkRrRmEHN7oicrjrf3TUxrt5zICAMggKVpFN9ErLCu/c/EJKO4JsYj6WdUxRtMe38wha7GBgCQC07DzdZOUGCJAaYy3ebdIgV/sSO7T7Y0sTPabm3Mhf2w1Raz5TAC78A2El+rbSxwWolyOdfzRgzLbZQFJs5KcBCp9XXbxVvuuFRWWUjgmgjLEJ1qwtetv+efF2C/luUa0FV5juo2lrw/s3Y5GUOApu46kzT+0sdh52Vr8s9BgJ88+9m4/Gsee9aVgQ+H2YoTIxOH8NN+Xmc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f7de5c-3fe9-4f75-b61f-08d60cef090f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 14:03:30.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod <vkoul@kernel.org>
> Sent: Tuesday, August 21, 2018 9:26 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; lars@metafoo.de;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
> transfer
>=20
> On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > In AXI CDMA simple mode also pass MSB bits of source and destination
> > address to xilinx_write function. This fixes simple CDMA operation
> > mode using 64-bit addressing.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilin=
x_dma.c
> > index a37871e..2e15d86 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct
> xilinx_dma_chan *chan)
> >
> >  		hw =3D &segment->hw;
> >
> > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> >src_addr);
> > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> >dest_addr);
> > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> (dma_addr_t)
> > +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
>=20
> so this is:
>         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
>=20
> what is src_addr data type? I think its u32. It would be better to
> update xilinx_write() to take u64 and not dma_addr_t.

Yes, src_addr_msb and src_addr BD fields are u32. To explain: There is no
prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit=20
depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a bug
i.e in the call to xilinx_write src_addr_msb 32 bits were not passed. To fi=
x
that combine MSB and LSB 32 bits before passing it to xilinx_write.

Thanks,
Radhey
>=20
>=20
> > +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
> (dma_addr_t)
> > +			     ((u64)hw->dest_addr_msb << 32 | hw-
> >dest_addr));
> >
> >  		/* Start the transfer */
> >  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> ~Vinod
