Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B829C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F520861
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FFUtOeKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77F520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIHIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 04:33:31 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:3480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeIHIda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 04:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKq9OLM7o6wFGBioi2TJblpvlLDCYQWKSqZ2RPECF0k=;
 b=FFUtOeKG3GEszupoFkg2CHC10dWq5tSxRc2xSotlfqR7nssyyihR37T15wLXVL3hlEHMPa4prCTiC7LSI/wAy712j1uTHYNBUZ8FmuSn4TILMzf2WD2IZUHpnL/ZHjcs+vTBqGvX9Hu2CKIp6xamdj6aMjiUVX9mhfjjL/Onobk=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0867.namprd02.prod.outlook.com (10.160.154.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Sat, 8 Sep 2018 03:49:00 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Sat, 8 Sep 2018
 03:49:00 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH v3 1/8] usb: dwc3: Correct the logic for checking TRB full
 in __dwc3_prepare_one_trb()
Thread-Topic: [PATCH v3 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Index: AQHURqyzVYJ0AH8Bgk2JYHnVleSimqTlv8OQ
Date:   Sat, 8 Sep 2018 03:49:00 +0000
Message-ID: <BN3PR0201MB0993DD67C50C11E054C2FDC3A7070@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536326029-16327-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AD8B3@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544AD8B3@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0867;6:bVnzKZCHrWnAQxFXsGluLsV13Nmq0rVUmOKMuULflIkiyubupjHj5F92G/8vnzlJTFVMYL/aFJgcn97XUQbrEnIqPKNp6xV3mi3hg+tImcyHnIACGMrAceuhgo+1GgkkAW/9REfYKkQL25TDLyXCDJiQEqc4vKg2p5u0/FVzMGLrBw4r6W7iGtHS8uI3ia0zIS6wL23wGPYF0zr54NISstmQ6rLZbSJ2kY1L9MY3iXLTQa0F+tXnrNmlhfYVdixdQtdK3y+Q+IkRK34ZtTkfq2pt2WwrqR6+83u1zBFXrV5JTpNKI3dM1+TbEyopUDerzgv2ubCmw+d3gxGEaI1nMwrVcqCC4aqAo5Ok/HY74H1W7oexsM3wSP7H4luTCyBszHF37oQw4026aBrFZbr3uJuq6DTECnrIhc4W77iX0Wk1WwG2vpJzcEBbZIZShjC/+swL7ybtEMnvyNVU7y+vNQ==;5:VtRYv0sv7henWvFB6A8T1LqoMgbXBojmOku/rRCQFO+1LpheDluBf2xOwOz5bZJmS0IYol5Aht5c+9rBxbFh8IY8tldXrvnJx93AQxRJD1FjDwFW+Cpz/vmiESfdglyJ5scjxNibo3MYNedbnLRxAtwgeo+pj3+sG/8CbbSZ2mY=;7:TgBHamu2s/D0yQng7beo1NF70xUEQZj8YzcUZM5tqz2/7nL8MIQ8UDdlOcuV+EjYedW3xBDCqidxQJ2hZmP3Xs8aAGw0z1DYWlZhlMvsFeAjdtIJiDKWZJo46Ael8g7dTedWqHPiu5pL7dOHn8EKq0EUneqA7k05+myyn0ZBiUKsT7XPS34GGInf6+DYOCOehh7mjrUzFRE3L230BX0UR7vpNJZQ/JX0PpHzQ1gCT5VstITi4DSlAK1j6BfmtnGf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ddebd046-0db2-4b33-d950-08d6153e0353
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0867;
x-ms-traffictypediagnostic: BN3PR0201MB0867:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0867FBE2E33594306437B6E4A7070@BN3PR0201MB0867.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN3PR0201MB0867;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0867;
x-forefront-prvs: 07891BF289
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(54906003)(2900100001)(106356001)(3846002)(6246003)(105586002)(68736007)(15760500003)(8676002)(256004)(33656002)(110136005)(6116002)(39060400002)(76176011)(7696005)(81156014)(2201001)(8936002)(14454004)(81166006)(86362001)(2906002)(99286004)(66066001)(2501003)(7736002)(305945005)(5660300001)(5250100002)(26005)(9686003)(186003)(53936002)(55016002)(316002)(476003)(446003)(11346002)(486006)(25786009)(97736004)(74316002)(478600001)(229853002)(4326008)(6506007)(102836004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0867;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TVGLrcAFs/FkUDq+ZbpRAsx+EErlrV27sJuxNMHl83Gmk+iLEldGmb/KmKLYBENd+Cos9Ndvw5oNNnIIP93/GMaB7Go+5Vvas/37/dE1eTGyZ4kZLb2LDtXCA9SdvpTgqdRw0fEJ15NnsGXkZJ8MCyqbKiachJ2vTuSaObCcvI1cxd+sz6CV4Dyg5NSWUB3e5MKZVufsHGsN9kPc2Cf63oCeAeJpSOQmNL/0821mRyHBmBQIS0+eqlK0E9MC1VPLhxbOgtHAhPk8NosCcuTIBmntD/s8t2GtlHdAul5M4KqvkPXVP8VfM25bTy48B2DsleloBmB9R6Obzm/530QMg426NeLF6XxDQVMzvLbmtck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddebd046-0db2-4b33-d950-08d6153e0353
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2018 03:49:00.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>On 9/7/2018 6:14 AM, Anurag Kumar Vulisha wrote:
>> Availability of TRB's are calculated using dwc3_calc_trbs_left(),
>> which determines available TRB's based on the HWO bit set in a TRB.
>>
>> __dwc3_prepare_one_trb() is called with a TRB which needs to be
>> prepared for transfer. This __dwc3_prepare_one_trb() calls
>> dwc3_calc_trbs_left() to determine total available TRBs and set IOC
>> bit if the total available TRBs are zero. Since the present working
>> TRB(which is passed as an argument to __dwc3_prepare_one_trb() )
>> doesn't have HWO bit already set, there are chances where
>> dwc3_calc_trbs_left() wrongly calculates this present working TRB as
>> free(since the HWO bit is not yet set). This could be a problem. This
>> patch correct this issue by setting HWO bit before calling
>> dwc3_calc_trbs_left()
>
>Please revise your commit message to reflect your new change.
>
Sorry , I missed updating the commit message. Thanks a lot for pointing, wi=
ll fix it in next version

Thanks,
Anurag Kumar Vulisha
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
>> ---
>>  Changes in v3:
>> 	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguye=
n"
>>
>>  Changes in v2:
>> 	1. Changed the commit message
>> ---
>>  drivers/usb/dwc3/gadget.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 032ea7d..8a1622b 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -911,8 +911,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>struct dwc3_trb *trb,
>>  	struct usb_gadget	*gadget =3D &dwc->gadget;
>>  	enum usb_device_speed	speed =3D gadget->speed;
>>
>> -	dwc3_ep_inc_enq(dep);
>> -
>>  	trb->size =3D DWC3_TRB_SIZE_LENGTH(length);
>>  	trb->bpl =3D lower_32_bits(dma);
>>  	trb->bph =3D upper_32_bits(dma);
>> @@ -991,7 +989,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>struct dwc3_trb *trb,
>>  	}
>>
>>  	if ((!no_interrupt && !chain) ||
>> -			(dwc3_calc_trbs_left(dep) =3D=3D 0))
>> +			(dwc3_calc_trbs_left(dep) =3D=3D 1))
>>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;
>>
>>  	if (chain)
>> @@ -1002,6 +1000,8 @@ static void __dwc3_prepare_one_trb(struct
>> dwc3_ep *dep, struct dwc3_trb *trb,
>>
>>  	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>>
>> +	dwc3_ep_inc_enq(dep);
>> +
>>  	trace_dwc3_prepare_trb(dep, trb);
>>  }
>>
>
>BR,
>Thinh
