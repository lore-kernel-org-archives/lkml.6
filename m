Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8430321479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5ClVASpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJSSo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:44:28 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com ([104.47.32.66]:40311
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSSo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSbh7+jyip6f/zp/JqAZi5Jj0f+V1AubnObhK8pxwn8=;
 b=5ClVASpYgYWtW4yU39KCxU4w2kLD/5qJPr6Z0+Jwrw+Ir9e7OojFwQxzrT2bz6uY3TifulQz5lE1KOdHq40AbS/ds4QVFyRUAGu4tllx2ZcdrJ+NoELycOFlPiNPtXTBZCMyHi92OV/UgHmW087MJhSzV7aUwYqOn83XLFHI3pY=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.173.137) by
 DM5PR02MB2313.namprd02.prod.outlook.com (10.168.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Fri, 19 Oct 2018 10:38:54 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::3df2:4226:79e9:b964]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::3df2:4226:79e9:b964%4]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 10:38:54 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Topic: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Index: AQHUWBhswmQQYXjAy0iJd8mLBbGGr6Umf3UQ
Date:   Fri, 19 Oct 2018 10:38:54 +0000
Message-ID: <DM5PR02MB218754E3827458E08060DDF2DCF90@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-5-git-send-email-radhey.shyam.pandey@xilinx.com>
In-Reply-To: <1538241480-13844-5-git-send-email-radhey.shyam.pandey@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB2313;6:uhhYeTnBsOSS8m8cwBSof8Tqr8vg2y/OcUagkkBnQJz8P7lSphkMDHCv/cpaQMxXJIrP/K7+YWSlQZQzfateyIrFpw8gBSIr+z7vRAZ+8t+Cccr2lF2urde/8s4xoqxtDIQ/tLpzaadgZ695+PodERs52Noq0OMZV43rphx/39oUZILZAbN/3dpfSAK1LQ8u10MIeYFmzb4vz95qN3ssLBSrTKIobrIV1RqGmEH+hGnpQXSfAG4tb8phEHPaU3fcV+RqSf736/K7t9UPYj4+p9kvsViJOCY08pqEmCRhuPSPvUQGftXAUm4FuWLFH1eAuwqT1mjYgnuh7bgm2O9my2schvAFaDzBBwPFrOQ7BoUu5cdxIxwxv59JVnTk6i1ioY/S/zWb5qO/7oCPifGVE+IhxVvOxf5/Fy09crurwV8p+cWcIf2YVSTe8oNpzMdhESewvlxOaLWHh6f1985TrQ==;5:lqa3UqwL2A5XtzaLcwf99bXWQBgaexgk+scp7eGhgqc9+heuHVUejK06ijWFLBHdY6gM4v/youCak2A+T/23f+npcMexopg93QeApsKkfZuJ6wBzddEKGfNMWCRRD3XeCXPdaxM3edNOJR4GZStDCa9w9wXPVcgq+Igp2asj1sA=;7:8xnQxmno5uaclKx8trgp37zd+SjaeLfa7JUOw6BLRJEs8kHVDZRcOTqwMKnuj1FXhKMLaY+iINDXohOJGG9kP3iF6StDT0ubJkqjNlFeo/DsgERYEWV3ELUnewUg7Cc+V/J3cyabQserbdc8BAgz57BQXXq1gG+P1Cjh5Viz7WmnUVvFs/EcdYXrpNjDZXqRDb8xKSil4ktxgzzUdudLMIow9jFo6zIbXYhEd/KGHrGlhqv5Jm6Wd3tlEEWTb41X
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b1503c74-a6c8-4c58-7a27-08d635af1169
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB2313;
x-ms-traffictypediagnostic: DM5PR02MB2313:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB231300B0730FA64BE8FB6F37DCF90@DM5PR02MB2313.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB2313;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2313;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(13464003)(76176011)(478600001)(2906002)(7696005)(99286004)(6636002)(66066001)(256004)(105586002)(106356001)(68736007)(6116002)(5660300001)(54906003)(2201001)(53546011)(3846002)(74316002)(6506007)(305945005)(7736002)(229853002)(6246003)(316002)(4326008)(476003)(55016002)(71190400001)(2900100001)(186003)(6436002)(110136005)(71200400001)(8676002)(53936002)(102836004)(486006)(9686003)(5250100002)(86362001)(81166006)(97736004)(33656002)(26005)(446003)(25786009)(14454004)(11346002)(81156014)(8936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2313;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hyHrTB9/bRnH/Mrt6RXgKWGEObA9VXDdkHzzXkrr6ftLyQLiYX7VnYp5LVYBzrmbfyoZId9gH/7834/8m+ye8lJfycIDqDpBCPzbOJGNfYj8tSvR5iemtyhuyaHHjk8mhBFluiyWPYdfCXJ6VHbz/TXcnJ2orPBT3G0cyRWPfgTGC4gMojMCBWKY0mnfjRUWQFYRv+OjCv8mTYAMh9bdUUvXWXzSui/vJ2ejIBp/5gKPDBG7z6fiYW1mbYcmr+gTUrTFMkRPd9Urp8lTPvokB8u3zgkSQmr7p7lemW80DfkdaZEt1QYjQBmcR1UtiBdFRPf25Xopg1TsAzWQB6gluawyxJCARhllrb6+Q0r5+WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1503c74-a6c8-4c58-7a27-08d635af1169
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 10:38:54.6396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Sent: Saturday, September 29, 2018 10:48 PM
> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Subject: [PATCH v2 4/4] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
> transfer
>=20
> In AXI CDMA simple mode also pass MSB bits of source and destination
> address to xilinx_write function. This fixes simple CDMA operation mode u=
sing
> 64-bit addressing.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Regards,
Kedar.

> ---
> Changes for v2:
> Use helper macro for preparing dma_addr_t.
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index c27ab64..d04ef85 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1247,8 +1247,10 @@ static void xilinx_cdma_start_transfer(struct
> xilinx_dma_chan *chan)
>=20
>  		hw =3D &segment->hw;
>=20
> -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> >src_addr);
> -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> >dest_addr);
> +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> +			     xilinx_prep_dma_addr_t(hw->src_addr));
> +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
> +			     xilinx_prep_dma_addr_t(hw->dest_addr));
>=20
>  		/* Start the transfer */
>  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> --
> 1.7.1

