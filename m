Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE220869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nkvWXiye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EE220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeH1Qyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:54:52 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:43072
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727760AbeH1Qyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr1F9cyqrXWovlNosMM9r+WPEKKp3m3alFtOIgsEVgU=;
 b=nkvWXiyeLdabPjPRyPX1NKgVJKOlppFPPVB/nemvAXcPZ+FNV5Z3freRbZSLgLK0z4b5pnvzumcQTfLdS4Tj8NG73Ek4j8zY0muc16d3ylaG0kGCV1ai5oZ3GEeeOx8aGqSZkG28mF4F1ScreVLhBqShHN+2PkjelpPDsFrI9ck=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3466.namprd02.prod.outlook.com (10.167.161.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Tue, 28 Aug 2018 13:03:14 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5%4]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 13:03:12 +0000
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
Subject: RE: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Thread-Topic: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Thread-Index: AQHUJZfKCiAR7usVIk2uFdp1nYmBbaTKgigAgArO3NA=
Date:   Tue, 28 Aug 2018 13:03:12 +0000
Message-ID: <MWHPR0201MB36280726FBCF3A2BF07EB781C70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155024.GH2388@vkoul-mobl>
In-Reply-To: <20180821155024.GH2388@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [183.83.222.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3466;6:U6HnAFXjQhEk5vE+eAfcsmGLF/9BvugxEcSTivh8WsNaZsTypY0akDaW1rcDMPVWor/lDPebuT19Z9iG16vXK1KELycNJ6pMGuG/amk4sRNMvEooIamzqEWyDumvtOqiHAGEX57KRdgm3n8Sr28Nzv4FE+G8xaLJyMBH5POVaFDyZmxhsPiAUC8MK2EHOm2WLOHqoTWrDsAhZAU/+iEqVDv6o+6ExFFp6XeFiXOsk90ScST7uUMO1prmUF1UTyzKc6iyN+y4mcdaS3P9u3zdYqOGkeciwoRdH+lfTbOH9KjHqwM/x8ogLjBVrNyrigwu/z4dDOQ70DLeoSpYwxuDBnYHKrhQFYmuEuxU8nceFk8yMkJckS1Xa+yP3EBBlk8jXAxKaTyzL8XKucW77sdlTU7n0vXHNvzQVygT5qM3jhzT623Yep/q12Trn7GgMBZKcbFnqNG3vr5qtpvzggbslA==;5:JBu03HLkyMIfxZqk970rUCjzvHM2HqlEdsz8Z3FEzlhxr0O5G7wj7tnaWH05ofdI9oSWgIyrus+XpCTgD3alKgFEuOj3eLdYJjHwqYPHZkjM5mmlnD7j32L5fQgmexsLy/cBYEwh2Uo6AoL6cIIGkXCDWdfuuICB0QppKpFqXqU=;7:y5rK1GpyN5Lx+U2+Npi4JMnyR8Qy+86OoUyKBlaDrA+LjFrBaLD30YX86lB+OwbPb2OTyC8qb4UPdLvYITQp3Kuvj9kxFqhemESE1eCs7hh+cJ6w7Pr8w7C1f+zgq6RZkLM+hYvAVF7lxPsaqqXdCpU/8wJUl3hUJ3nVqwGghlKw4oHbX8v5wgRNucle2BkfE3sQYLSlAv+/2RYJf4A9ny1RDMG7RGhirvmY5je2hKqHmsq1RLXjOVsN9UT/A/+U
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(13464003)(8936002)(8676002)(305945005)(81156014)(33656002)(7696005)(26005)(6506007)(3846002)(76176011)(7736002)(81166006)(25786009)(6246003)(4326008)(53546011)(476003)(486006)(6116002)(446003)(54906003)(74316002)(99286004)(256004)(102836004)(14444005)(11346002)(186003)(5660300001)(6436002)(55016002)(2906002)(6306002)(9686003)(86362001)(97736004)(106356001)(14454004)(6916009)(105586002)(478600001)(966005)(68736007)(53936002)(316002)(229853002)(5250100002)(2900100001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3466;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 0e019a62-a958-47ae-e14f-08d60ce69c55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3466;
x-ms-traffictypediagnostic: MWHPR0201MB3466:
x-microsoft-antispam-prvs: <MWHPR0201MB3466AB1E1C7199445693F4F3C70A0@MWHPR0201MB3466.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(163750095850)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR0201MB3466;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3466;
x-forefront-prvs: 077884B8B5
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lLBZgt8G9urv5zvqRosTwCU3bOknJSYsiuc43XX2glLOY+APYdLAb5R+QoBfYj6mWtQGm54unuXChwZmsM0zIw2/idHPc8AiNB8i+iTuaGMJdFAfygcszgAgE1eMPLvTYKcQ9KvK1wXQzb0XLiOTC4uEiy6BS/haPmKSeJvNkigV8thkYevTb4gi+wuw6DpEyd/G/kNYW3a7sY+Gw9dyI+EyU07QREt/1LE8hVwXLkBNUGDrx7mNp2rD6LYmqKdNCtQ/kcy9kcolOhZxNFR1yJP8gfyQfVmDjEclwkFN2RdlBMDh+lrhaNm0aaTDo9za10fV3wAS/31xszHSXlYFXUSsVFqs92ZUtwKfvL5Z3po=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e019a62-a958-47ae-e14f-08d60ce69c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 13:03:12.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod <vkoul@kernel.org>
> Sent: Tuesday, August 21, 2018 9:20 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; lars@metafoo.de;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
> validation
>=20
> On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > In axidma start_transfer, prefer checking channel states before other
> > params i.e pending_list.
>=20
> and what that preference be?
There is no strict preference. I thought to group and first check channel
states(idle/error) and then look for pending list.

Thanks,
Radhey
>=20
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 06d1632..a37871e 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  	if (chan->err)
> >  		return;
> >
> > -	if (list_empty(&chan->pending_list))
> > +	if (!chan->idle)
> >  		return;
> >
> > -	if (!chan->idle)
> > +	if (list_empty(&chan->pending_list))
> >  		return;
> >
> >  	head_desc =3D list_first_entry(&chan->pending_list,
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> ~Vinod
