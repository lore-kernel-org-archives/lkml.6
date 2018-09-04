Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B447CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA0420843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XWZrx337"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA0420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIDOIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:08:49 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:33698
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbeIDOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoRV/ZBQ6VEtrpMSJUiKQBeFV98h8RIW1LH9up7lTIw=;
 b=XWZrx337jj5vqPguwhOWY1Sffzr+8+PO0bEQhuFTawqXCvTQY/PatF0C2gIWZiksnXdx5M60FVHsN0iKt2gU89IBQg9wuc4reL4HSQnhhrV3k48R2eoyV2rpTxOtxEz0Uk0CZ1EvkFFi+BbuCtaHauYvaI0LE+4YCjlj56yQlgI=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0867.namprd02.prod.outlook.com (10.160.154.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 09:44:26 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 09:44:21 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Topic: [PATCH v2 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Index: AQHUNiVY1NTEvaV7Y06UyQ2thwt4kqTf9FBA
Date:   Tue, 4 Sep 2018 09:44:21 +0000
Message-ID: <BN3PR0201MB0993E68FA4A63D7CF2DFC136A7030@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0867;6:C7yRxCzsfHfHuiZ925xhLiS/10VQnCspgwgOHWZo357blzP7s8vr4wM8huOLChzjPxm3cROxy5U91ME/n5vUvvqPjC48CV3127iOiNMG/ryG8iKTpdG+pu0dJ09piikPg85Yz4/85Rgif5SBdYRPEkoxIHKb5mg2/Wfv6SjItKSXS7/k69lvDINbtfyWgnvqsNEradKND0hIuPTeziuVCI7cn8MHw0ckpj5rRkWV9rAe2auSVIM71/P0d1/YVAGc5dUjcdElHUGaPPvISQwvqKkSLwvqrKzfdBePPSC8m99ADfXuiNTobQkx7Q1d+6kvqr9MmQIgzKpCKkSfHKnK47rQy43I8M3P5+/kFBLceYzOjX5P0fTYlxugGiFjKac3NcCdnd06yaKR2iZLc/ePwlg49hn8vyNHbAvGa2BuuFOEWN/VteX+dbB5YdosTAzbea123wL6lYWWBSccQSr9AA==;5:NVcoEFj51qHas7jVrtW73+tcoxhHTB3s3cphfm07DaMb7DU3skuZ27rEiffSzYEXRxZomoKmQciHHIrJ59xuhDxHJBFAVpFf5APuKJxRJHWKdPXCL0ztnPOEqlAbKJMObsjCTu67mHrsJW8J/k1vki7bAQ9srZBV5EitZgseUsw=;7:M+JbDmvtgVdqWeQbblvWpWmIvo+Q0k30ew+UEkTwUrB1+PHVvLab22dm2ShHZBzN5oz5grw1JoUKx3J+HTrrZkEi0CviUbF63f21FLBXlGbjn+ZDL0WU69XHTggIbKzBtoafxCaT1+MzdNk7tQK+T+14tfl+ewYc4eEbHg5i1QmKS8B6jkoLM/ujG9tLwnRySmHNowdZiz0wbtH28bjxSYt34z9cprjzblIhBOyRrI0pTOYrsKkrmHnngmQnZvIb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8f53961c-6aef-42fa-ee44-08d6124afddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0867;
x-ms-traffictypediagnostic: BN3PR0201MB0867:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB086706292611D210BA4A61BFA7030@BN3PR0201MB0867.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN3PR0201MB0867;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0867;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(53754006)(199004)(189003)(13464003)(81156014)(6116002)(81166006)(8936002)(54906003)(6506007)(76176011)(68736007)(110136005)(3846002)(33656002)(8676002)(7736002)(305945005)(7696005)(74316002)(6436002)(476003)(11346002)(446003)(53936002)(99286004)(55016002)(9686003)(105586002)(106356001)(229853002)(5660300001)(102836004)(66066001)(2906002)(486006)(26005)(478600001)(316002)(86362001)(2201001)(2900100001)(256004)(39060400002)(14444005)(5250100002)(2501003)(25786009)(97736004)(6246003)(4326008)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0867;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EMqAmQqG3V131froJwYhBwHu0A31wzYnIkVHJvqAL29IuZ/HsVD9Pt6j8+DLdtHbhTFkiGXdzBSQb+pWx+gsT+ydzQrjHEwE06eQ2t3ZXFzJ2Sx7g20rTCkOtMm62Rv8eW5A+okhsqsYr2CJ7Ka2F48g1WV8vHWGZ7wOW0/CK2MaBk0zkiDzQ5a6wa2y3Cu4oWYuDIiiGMW1aTK8O3gtYR1ezHictvihnt6g+i8npO6lFeIkOgzSaLxQWtXo6AOvvkw+XCUEH7zO2BwniWcrCsvAy8jaPEoczd6+g1kiet78RqfdxdnakdUD3MtaLVahmsQkidCYU5OYad6AypM1VAYvlisWHPi8n7l5ZAVdpyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f53961c-6aef-42fa-ee44-08d6124afddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 09:44:21.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Ping!
Just thought of giving a friendly remainder for this patch series. Does the=
se patches looks okay, can we proceed with them? Please provide me your val=
uable suggestions.

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Anurag Kumar Vulisha [mailto:anurag.kumar.vulisha@xilinx.com]
>Sent: Friday, August 17, 2018 5:55 PM
>To: balbi@kernel.org; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: [PATCH v2 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 =
gadget
>driver
>
>These patch series fixes the broken BULK streaming support in
>dwc3 gadget driver.
>
>Changes in v2:
>	1. Added "usb: dwc3:" in subject heading
>
>Anurag Kumar Vulisha (8):
>  usb: dwc3: Correct the logic for checking TRB full in
>    __dwc3_prepare_one_trb()
>  usb: dwc3: update stream id in depcmd
>  usb: dwc3: make controller clear transfer resources after complete
>  usb: dwc3: implement stream transfer timeout
>  usb: dwc3: don't issue no-op trb for stream capable endpoints
>  usb: dwc3: check for requests in started list for stream capable
>    endpoints
>  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
>    fields
>  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
>
> drivers/usb/dwc3/core.h   |  7 +++++
> drivers/usb/dwc3/gadget.c | 78 ++++++++++++++++++++++++++++++++++++++++++=
-
>----
> 2 files changed, 78 insertions(+), 7 deletions(-)
>
>--
>2.1.1

