Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C20C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A482087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ui2TU2ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A482087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJHWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:48 -0400
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:57984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeJHWhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eRHRWS7iIeKIyfLwScsLzrWaWmouqzQKBOYfA3AtKQ=;
 b=Ui2TU2nykefrezG6qcCS5YWMOcPrhxtjYQGG+ZSvyRDvHHlK/Gv44G/D8Y1Nb8adiRUjerT753HFccoeZGCHr4BZAdC6S5WDKiB7AecJfY/u7jsHdKKLsiEXAW/ApzfjoFxmt9MA71zCJgVDh55EAZ/GetVwM9tk9howVgjxPKo=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4689.namprd02.prod.outlook.com (20.177.144.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.25; Mon, 8 Oct 2018 15:25:29 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::8cbf:c901:e10:b871%4]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 15:25:29 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3
 gadget driver
Thread-Index: AQHUTQCoBCMdjS6uDUqQ64x43Vb2OaUVlfeg
Date:   Mon, 8 Oct 2018 15:25:29 +0000
Message-ID: <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4689;6:qIpzDtaqdwLUEhIS4CrMDv1tAgw8lsk8aGmnnnDha2i7WR95A56SPsKiC+Orw7mY+JiZ2pt+8hTHCbbYaC2RtDtHhCz42QA1rAX1lN9wO/yhpv59FUVGiJgtNm5BkeDs0nXfPeE9ijuVH+s+xAqUHDMT6Ic6ntikfA2HkTs28poJETFKh6bDKNuUOaWcRgvvDaEktIGku/9teypfyqhLFKI1kc3vjnMR2KcMdtzWz0oQVZl8ce+U8fyYVLg7+7zhZ4Hli5s09EAhH3uhxeo6h4y6sEdfvEpD67nfdpx0D2MXpuTIeWy5Mo7prkFq1CVOi+tUbVPteRguoFKvhBbHCEPXZX9qK+DwyX6wMhYcfCmbtFUfRIbPwIMM6tEDDUSfY5j50kkoLh0uU/2G68EDY9TYakmwmyOMB0CKxsW2URYqEUu+W1jsBaeW0Oz/g86yDqjyy8ZWJqRO4hoPmMo9EA==;5:CAyjltfs+4EJORxTrWrtSu8h7SGJ8thB/CPIcJdGxC4T9Em80NmtfUPBgnPyhLUemw8o7+w2NsHMs/jr6h1NbKCZmuuii7iZa9gFayw0aGpgcZO8YHjS7NIR3kPNhUa5hJC3mpHyCzKiNytziGPxLTZ0RvY/zavSSSgV9uDELfg=;7:+17WIMq7fejSooASBrulHG39AeDaKKYguCJOzuCl/comR6Fa/PKu9XhqWUtgHqzTlruaMZ468HkLWmFiLrEDo9bvYKuCGesmufDZkmyKpAMWWsY7OrFQZe+zsWdEsd55pET8T2ygBjt0TtflFGJOQUSWUI2inE0M6d6tJWQC+5MoxY9h6PktkNcGRH5ztpkVh0bw0tqFLAN5zN8LaktSrSVlS9vLvdZFScz67nXJjcQbucoBxmJATpZrNA8Qxl1L
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: bcea2e14-46e0-42cd-0fa2-08d62d3247ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4689;
x-ms-traffictypediagnostic: BL0PR02MB4689:
x-microsoft-antispam-prvs: <BL0PR02MB4689744FAD53E8FBFE5905C8A7E60@BL0PR02MB4689.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(85827821059158)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:BL0PR02MB4689;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4689;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(13464003)(199004)(66066001)(6436002)(107886003)(2906002)(86362001)(9686003)(110136005)(68736007)(6346003)(25786009)(6506007)(55016002)(39060400002)(99286004)(186003)(53936002)(486006)(3846002)(6116002)(54906003)(2201001)(478600001)(2900100001)(316002)(14444005)(256004)(8676002)(8936002)(14454004)(74316002)(26005)(33656002)(71190400001)(71200400001)(81166006)(5250100002)(6246003)(305945005)(5660300001)(105586002)(4326008)(476003)(11346002)(446003)(81156014)(76176011)(7696005)(106356001)(2501003)(229853002)(97736004)(102836004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4689;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-microsoft-antispam-message-info: wl0eb/AVQEO4O2gwC5JNgwis8ufQ/gh/2dK5pZK0+FUbietcsGe9ad30u7qpko10yVNsoCXG+V8ypG9sj5mtSy1VsWRW/j440yf7xarePx9qZvHDanlyCuRpi16rmIBpQIBktayD/DxsEpMpBTZvqQ68Zpe/ol6ffBDxonyuHN5wfQfSqsigZ7RsuFIlpV0NYJgTLcMs6TM9dcNOOeYavT4YA/yky4sAAsSk01Djot05OCTniQfmOedSqIBEymy27MMII8Nij2uUevIMfuRoUr/Jnu7n9kwLlDcFqoqfaVBgNXHSZvMumUNyFH1msnnCEvRtf2D3vtKQYxIrTuwp6auGyAKV6HgvKnMrH3f/eW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcea2e14-46e0-42cd-0fa2-08d62d3247ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 15:25:29.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

Please let us know if you have any suggestions / comments on this patch ser=
ies.
If you feel this patch series are okay, can we proceed with them?

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Anurag Kumar Vulisha [mailto:anurag.kumar.vulisha@xilinx.com]
>Sent: Saturday, September 15, 2018 8:00 PM
>To: balbi@kernel.org; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Thinh.Nguyen@synopsys.com; Ajay Yugalkishore Pande=
y
><APANDEY@xilinx.com>; Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 =
gadget
>driver
>
>These patch series fixes the broken BULK streaming support in
>dwc3 gadget driver.
>
>Changes in v5:
>	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"
>
>Changes in v4:
>	1. Corrected the commit messgae and stream timeout description
>	   as suggested by "Thinh Nguyen"
>
>Changes in v3:
>	1. Added the changes suggested by "Thinh Nguyen"
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
> drivers/usb/dwc3/core.h   |  7 ++++
> drivers/usb/dwc3/gadget.c | 85 ++++++++++++++++++++++++++++++++++++++++++=
-
>----
> 2 files changed, 84 insertions(+), 8 deletions(-)
>
>--
>2.1.1

