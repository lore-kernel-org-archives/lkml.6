Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC53C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00552077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00552077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeIGQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:48:44 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:48612
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbeIGQso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXtf6izYlgkyDzi1sXFVjq0bUvoj+RmCqyLQ7k0MUWQ=;
 b=X0t5kQGi14OEALhzU3FvxTEQXzfjuaBnkv0vE4Z6ct4U44cCC0xlvozoTRoEfc0M//97BFhiWO0ZgOlzWWtbpkwuc0u4TjMBQi/YwE0vPwQhh9J+2Dfw6NDcD/WBap5OfdzNgglpPBFVYYWV1H8OmosOcD6wLToD41JCOJFozqw=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3626.namprd02.prod.outlook.com (10.167.162.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 12:08:03 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::f07d:71f6:8592:497f]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::f07d:71f6:8592:497f%2]) with mapi id 15.20.1101.020; Fri, 7 Sep 2018
 12:08:01 +0000
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
Thread-Index: AQHUJZfEjDnYw63wzE+wSwsRCwPdMKTKg7GAgArgSpCAAOqtgIAAyp+ggA3bkzA=
Date:   Fri, 7 Sep 2018 12:08:01 +0000
Message-ID: <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
 <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3626;6:CzIihpF8eOhKrmOwA7nB6SV37Odd3BJqHviWtEAozmlBcuS/7S71bVTdQXeIfpNph4LOACp9cJbTXWGTMcBnQP7RW+Q0+ReGWEtZuwprCFwwb/4xbf/E4w41D4Azr7qWAtw2qyoNBo4dLLeHq6OSBYPE3/ZbkLdEfTAl+TFtfneNg9iG3yhbVAC7NJsiNTLs/ibEws8Cl3M79e+vPfNHewNY4iDWN6noNhx1wYzAZLT5BFp9CSI3u1/MsWSY/QC8FpvNk8lHbXNH11mYNATREBBihDlHaBAIaOChIXeRBW3sagtuStW1NuFs61BpE3q/I9G414xofr4M5gRm7lXqS/KfyJ2nby3bEUrK08eWepKWLUQF8hv7ErfZkzv11Zz4MTXSFaTkLZw/Gfikny2K1loDOpyCDeW/NSfeGG8LFveUIsxNKYB0xo+X/iaL3IzRYglhaqmobrPH9rEMDmm4Kw==;5:/N361Vl6EST10RkuUAGer/cu3RNeM/l0ZCeizBs5Jq/JEtCGQS1RB9j/v6JwI5TXX7a4Bc3B5yzIfKCwF5oAi/zrYwH5sDwPdCbMt7YUw3so1SJX7caqaGQDw0ropuRMemIGhpJ7XqpxPzH5UI8qGnAwYUuuHux2Dil6e6GbP1o=;7:HBoQYMVSHvSynFwhaK4/inE7rRfqmjsETY2fCSJzZnXnCCRn1i9zamkCgg0sA4nkHrm24r5h+gEokF0aG6I3CcA1ascQ1wPyoSzAEYZwD+yrw4n+xRpErp6RNkOrvar8T92Za4JFO71kxq70J13GcKDC9U2xIO1hbCEE8bXwIa7Fx4GkOKuNCuT5BPYZ0hBvLbvoyR2gIc6EKJrdr/2PH6naPN4Ep1NxzfDpMxcTMsoy2EDcLokR1DIIBPFIZw3W
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(5250100002)(229853002)(14444005)(25786009)(97736004)(55016002)(476003)(53936002)(256004)(3846002)(6116002)(9686003)(26005)(7696005)(86362001)(316002)(99286004)(68736007)(446003)(11346002)(6506007)(4326008)(102836004)(486006)(76176011)(54906003)(81156014)(81166006)(186003)(8936002)(5660300001)(478600001)(6916009)(93886005)(6246003)(33656002)(8676002)(2900100001)(2906002)(6436002)(7736002)(305945005)(14454004)(74316002)(66066001)(106356001)(105586002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3626;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: eb377c47-7fba-4f5d-d78c-08d614ba8f49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3626;
x-ms-traffictypediagnostic: MWHPR0201MB3626:
x-microsoft-antispam-prvs: <MWHPR0201MB3626FC5AAD5AF8C049D52B14C7000@MWHPR0201MB3626.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:MWHPR0201MB3626;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3626;
x-forefront-prvs: 07880C4932
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MHmaiNWyRV51Y0/nmM5LXS/JrC7ZLccCUicrr2OmAha+zvyU5e4n+1I/w93lKwBAq/8eevS94oy7kgJx1A6NEcasSJ2sAhocynE47y2Qhx1gQoivNF4WbRmUkqfxozGbmS9iRsHF3Pq58ujEuQHE7xKToj6avtCwbChWzxU46CLS2sYygd9VlSGayU5nlRagSYfJdjGLagMHgc62eqS6ro55GbeSCeinUINNdukzwLxDplqVaJCWac7pg5Jzk16FbeERW4ObBXt4gDKZ8w7SzP2d2DbjSYq5KIKz6/yriV3+ywR6bvYEJICF98GICTOVorPa9Tm4gRfA5vBp5WXwIaV1oJpWciVt4gr9roaM40g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb377c47-7fba-4f5d-d78c-08d614ba8f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 12:08:01.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> > > > > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> > > > >src_addr);
> > > > > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> > > > >dest_addr);
> > > > > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> > > > (dma_addr_t)
> > > > > +			     ((u64)hw->src_addr_msb << 32 | hw-
> >src_addr));
> > > >
> > > > so this is:
> > > >         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
> > > >
> > > > what is src_addr data type? I think its u32. It would be better to
> > > > update xilinx_write() to take u64 and not dma_addr_t.
> > >
> > > Yes, src_addr_msb and src_addr BD fields are u32. To explain: There i=
s no
> > > prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit
> > > depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a
> > bug
> > > i.e in the call to xilinx_write src_addr_msb 32 bits were not passed.=
 To fix
> > > that combine MSB and LSB 32 bits before passing it to xilinx_write.
> >
> > Yeah that part was clear but the implementation can be better..
I thought over it and it seems having a new interface dma_ctrl_write_64
taking lsb and msb bits input looks better and scalable. It will be similar
to existing vdma_desc_write_64 impl. I will send v2 if it looks ok.

Thanks,
Radhey
<snip>
>=20
> >
> > --
> > ~Vinod
