Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40523C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D9208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GrDME4wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8D9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeKKSgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:36:51 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:53106
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbeKKSgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/+K6wNq/ZQQjm7QMh3GqtwYiCis0abqdsqfzsCiAEM=;
 b=GrDME4wxVEKYbBoMhRuaB/EmqpdOtb24mPJqTX/ujqRevT3C/IbYVTxGdcYB/9/23rdXEWOE0ov8exLSTMht1aEKyY+p/WN6dslRG/Ww4Ud8Cl3Cr5FSAxXrq5akytbBd0oAbC2nJTvwPhFKc9TQY4D/WPoOu9VL6QUMdpRsXRE=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB5507.namprd02.prod.outlook.com (20.177.241.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Sun, 11 Nov 2018 08:48:43 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::10a6:cbf4:6c39:e88e]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::10a6:cbf4:6c39:e88e%3]) with mapi id 15.20.1294.044; Sun, 11 Nov 2018
 08:48:38 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH V6 00/10] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Topic: [PATCH V6 00/10] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Index: AQHUYvbNq06pH6AUO0uxr018eyuLVKVKbp9w
Date:   Sun, 11 Nov 2018 08:48:38 +0000
Message-ID: <BL0PR02MB5633E4948B5AA3C2B6F75D02A7C00@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB5507;6:dghQRtjeXf8U+erkve1oPiYB/rwUmKlhm6AoyyjRgJoPey2p6p+QvdypndRGGc+E/Z+kCC3YF7VoQMwZaM+pjDrJnMWWbnt3ezG2XECqQMq+/1mDOCRS8JhbooiinJeiuAhL315v+sSTj/ZTCV2/tLoWIqucxF1UkwdigGrhe+e6P6f1aSyNKBgeFzCw+Z6lnrUKoTc2uldHjtiqAHV2DlImz//uAJYuRcIHt3TcTy0FmxL5uZp4kRVwIGtn1giAoKH9MQ4lf5VxmhwFN7x1VD9v0MLQraQRksjBKYuIMN6xoWOTHxpuVLpzmGbCnixZesOiSabhoDqW//NIzj7YQvDWEojyWkCWUSDnKjrkotKZeiFutnBeQ2kodVKcao3fdfXi/GkFXkZNwb3LjCtkUy9L3Cvy9L2aoJPxyUBqxMFwTAHGZIM0hKzEkdot53JjH+Y+BygyeH7WuQYg16jKDg==;5:Tw2sWYEIevxGPrh44vAhgkWRGdser7JfYB0ZPOlxKg8cRzii7QBm6a1ttVyRmHh2PKtr2iJJt2K0zeRweDiN+/zWUKe8A768eTY8Z2eNYcoL7NCqe4h7YCbZRXLtTp+ZschEtBXjgUwH3exbtEBIFA1A9yS8CEXJHIAparAAV/s=;7:DVSEKWtW9qb++OfvNdHaxYvlEv1kOW5b6D0nerLZfHg+Uh2GM89xTOmulgx7GmdiiiDl7rClfd+3/40026U6KYss+mgiMllNtXysp2SR7Dl9JP7nPTB0Gx9cFkk20I5SIKQj/qIvcieydHmfbrK1DQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d73947e6-7fac-4b21-7cdf-08d647b27940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB5507;
x-ms-traffictypediagnostic: BL0PR02MB5507:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB5507A37C320AB8674115FA3BA7C00@BL0PR02MB5507.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(9452136761055)(85827821059158)(35762410373642)(31051911155226);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231402)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB5507;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB5507;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39850400004)(376002)(396003)(199004)(189003)(13464003)(186003)(33656002)(68736007)(55016002)(9686003)(4326008)(6436002)(105586002)(106356001)(39060400002)(6246003)(2171002)(53936002)(6116002)(3846002)(102836004)(7416002)(6506007)(81156014)(81166006)(8936002)(97736004)(8676002)(25786009)(316002)(110136005)(26005)(71190400001)(71200400001)(54906003)(107886003)(486006)(256004)(305945005)(7736002)(2900100001)(2906002)(446003)(11346002)(7696005)(476003)(14444005)(14454004)(66066001)(229853002)(86362001)(478600001)(5660300001)(99286004)(76176011)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5507;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /ZMh/WaBtkZbSHQoKzx+SjVkbtHsGJzPIg5mMjnAUKWb6cY4NJCMrxoFgJMUM2A3b00Dn7eg2upvMO2cFwoKgFQ8mTTsXc7bve+qem3BgdUo7TAuAp28qfX8Mds1SKzAPz00GnH+tSNECZO5nRWR+Inl6ZQKXk2Q+7oVa4YKTTNzBlgJZv80Yg5W8NPu/uFE3DjdcWI/TM0dlY6HUKYu/LQ+XpcDf+MT0ebAtCh//EqnFQ0ZQdcNzWJoO47SWb6VH+LW/5ERJqemGxsruBBq+dKf/O8A6Jgwiqpc1IzN2AJDYTufLFqdvxcvoMtJpSwqIVKoUTixoMrrRLfNukRu/t5gNJJngr/g9p1o3f/ldI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73947e6-7fac-4b21-7cdf-08d647b27940
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 08:48:38.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Please let me know if you have any comments on this patch series.
If you think patches are good, can we proceed with them ?

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Anurag Kumar Vulisha [mailto:anurag.kumar.vulisha@xilinx.com]
>Sent: Saturday, October 13, 2018 6:45 PM
>To: Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Alan Stern <stern@rowland.harvard.edu>; Joha=
n
>Hovold <johan@kernel.org>; Jaejoong Kim <climbbb.kim@gmail.com>; Benjamin
>Herrenschmidt <benh@kernel.crashing.org>; Roger Quadros <rogerq@ti.com>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Jogleka=
r
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>;
>Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: [PATCH V6 00/10] usb: dwc3: Fix broken BULK stream support to dwc=
3
>gadget driver
>
>This patch series fixes the broken BULK streaming support in
>dwc3 gadget driver and also adds timer into udc/core.c to avoid deadlock f=
or the
>endpoints which are bulk stream capable.
>
>Changes in v6:
>	1. Added timer into udc/core.c for stream capable endpoint
>	   as suggested by "Felipe Balbi"
>
>Changes in v5:
>	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"
>
>Changes in v4:
>	1. Corrected the commit message and stream timeout description
>	   as suggested by "Thinh Nguyen"
>
>Changes in v3:
>	1. Added the changes suggested by "Thinh Nguyen"
>
>Changes in v2:
>	1. Added "usb: dwc3:" in subject heading
>
>Anurag Kumar Vulisha (10):
>  usb: gadget: udc: Add timer for stream capable endpoints
>  usb: dwc3: gadget: Add stream timeout handler for avoiding deadlock
>  usb: dwc3: gadget: Remove references to dep->stream_capable
>  usb: dwc3: update stream id in depcmd
>  usb: dwc3: make controller clear transfer resources after complete
>  usb: dwc3: don't issue no-op trb for stream capable endpoints
>  usb: dwc3: check for requests in started list for stream capable
>    endpoints
>  usb: dwc3: Correct the logic for checking TRB full in
>    __dwc3_prepare_one_trb()
>  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
>    fields
>  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
>
> drivers/usb/dwc3/core.h       |  2 --
> drivers/usb/dwc3/gadget.c     | 67 +++++++++++++++++++++++++++++++++-----=
--
> drivers/usb/gadget/udc/core.c | 71
>++++++++++++++++++++++++++++++++++++++++++-
> include/linux/usb/gadget.h    | 12 ++++++++
> 4 files changed, 138 insertions(+), 14 deletions(-)
>
>--
>2.1.1

