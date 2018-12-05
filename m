Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E970C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA1F20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qJyC1z8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA1F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeLETB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:01:27 -0500
Received: from mail-eopbgr780082.outbound.protection.outlook.com ([40.107.78.82]:9324
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeLETB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t/93saH7cFdXWSMTIAz5V0rKKd/CEFRQG0Vb9mVVm8=;
 b=qJyC1z8YMO6X5KRh0hrjY6zQ/vaY0W0prZ+gJUKNVBpXk4aLvALgTXq7DhFHSQ1otLnSFTOXhA5qXMWsOcFAZ0CzazzvDxZNmq0BMIoY/aqDQ8d2E9QR7KuozcyNGovkbGaHvKrKPpC9MVDEtPHFUtUrAHw3tSvgTObqt98Ntzk=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4964.namprd02.prod.outlook.com (52.132.14.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 19:01:13 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 19:01:12 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both
 event->status and TRB->ctrl fields
Thread-Topic: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both
 event->status and TRB->ctrl fields
Thread-Index: AQHUiWbqDI9WfI74TEmPyd+V2NlqDqVv4SkAgACgrWA=
Date:   Wed, 5 Dec 2018 19:01:12 +0000
Message-ID: <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <875zw82vfj.fsf@linux.intel.com>
In-Reply-To: <875zw82vfj.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4964;6:wWpvqMkuUxkJjxw70njNAYKfGODYs31zAgAy+H1/XORnfKvS3Mu/hC9/mSoVwq7QFMZoe/axyKUzx95zUetKtNSyFUTJNSyt7gdWSkkGDOSdFU4Y+NJ57VpHUEACDvgm0BV0FAKwe8nhfbNHnapZvbZXZeGGtfgxdim3b2X7c3nhYvtwQDqFwykSn44UVzcMSSg56FdPO0xhwmBuv+UgG7MM42GukYz2yin1zswSEfGKx54ujg+5FFwIR+UidyVphOd1IzcWiL5NyxLHdv0Km+haeOcMi3IhCANw3Xntzs0137GtvLr+E8wZxKPiW16dI99c8pM5rCUZW1ww0Rue2TilockD07U4cSafInnu71HD4ezSf4Ni4i4xJ5EymiLv6sbmVwqCWNz8wj/uRZHIu1ynAjZd88wJu2ytbiNUQP8PG8ay8tAJWKzMpPmp/y2rFkRD+aoBdRfMgnOLFAuWPQ==;5:0uJk40TtgI+4RylwOgbxKyrPjkTEpJ03yvSHAnuGiBqbf7DxUy8QlBa1B7eFKrKYQs6gv0I754oMMEN9swmXYw8uGTzTK6sAqqUNWuo3nT86KubGbUiv7+05ijh28ypYZCXD1MOjb0Yt059ziGbnpIQLrfUo5p7XRLnSoB3Onhg=;7:BMYhOG/LC9/IJ+SX64o4Y0FZUuW9NU6Os1X2DMOM9EAyw9aapDH+ecFzDUcxI17VDmBpaBcI5tXLCXLeHLdGtqh2Pytm8s8n7iXoWGbP0dAux+B82pGi6dJvwkNZ2HoeA0bnQxb1ejWIZWVguB1TKg==
x-ms-office365-filtering-correlation-id: 1b58e590-74db-4711-816a-08d65ae4069f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4964;
x-ms-traffictypediagnostic: BL0PR02MB4964:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB4964CBBF4BB8317F1B123356A7A80@BL0PR02MB4964.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4964;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4964;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(13464003)(52084003)(199004)(189003)(6246003)(39060400002)(229853002)(5660300001)(81156014)(7696005)(53936002)(2171002)(99286004)(33656002)(4326008)(7416002)(54906003)(9686003)(25786009)(2906002)(102836004)(81166006)(105586002)(106356001)(6506007)(26005)(186003)(8676002)(8936002)(71200400001)(71190400001)(107886003)(76176011)(68736007)(305945005)(256004)(486006)(11346002)(74316002)(55016002)(86362001)(446003)(476003)(66066001)(110136005)(2501003)(7736002)(14444005)(478600001)(316002)(3846002)(97736004)(14454004)(6116002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4964;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X5oSukz1tEeZQLr8aqEdSjOQqi0j3A4vBaASCoTR0PxWMwLFcuva9Ze7sdMqpU7tOsbiXWeYQ/zirbpy4E9g2DGCQ8hT2pY73mz6IDIWEKqSiOVcAK5p/5CyQY30zFM8BlELQ90SsMTM2aKJXLyQxZZtRdlGBUa32TBRmvjlOqujtYrbtrtQ9Xfn68x6huJzEgvKDayOReoZEamCWCHzpihWBh5jBj5rOUKWcT5h+GCAS6NZN1oaCfDfZtBuCuVqwnnAscM4KPbAbZ5UZF2l8DN5E8Bq3P/4R+98c185ZqNjqueQ5Hr4//yTfj7PzSI1Z9Pc00SFxQGcgzYUcuRkdtXiQXURVkuBvsTSyFzbAo0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b58e590-74db-4711-816a-08d65ae4069f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 19:01:12.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,
>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Wednesday, December 05, 2018 2:38 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Alan Stern
><stern@rowland.harvard.edu>; Johan Hovold <johan@kernel.org>; Jaejoong Kim
><climbbb.kim@gmail.com>; Benjamin Herrenschmidt <benh@kernel.crashing.org>=
;
>Roger Quadros <rogerq@ti.com>; Manu Gautam <mgautam@codeaurora.org>;
>martin.petersen@oracle.com; Bart Van Assche <bvanassche@acm.org>; Mike
>Christie <mchristi@redhat.com>; Matthew Wilcox <willy@infradead.org>; Coli=
n Ian
>King <colin.king@canonical.com>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Jogleka=
r
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>;
>Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both eve=
nt->status
>and TRB->ctrl fields
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
>> for IOC/LST bit in the event->status and returns if IOC/LST bit is
>> set. This logic doesn't work if multiple TRBs are queued per
>> request and the IOC/LST bit is set on the last TRB of that request.
>> Consider an example where a queued request has multiple queued TRBs
>> and IOC/LST bit is set only for the last TRB. In this case, the Core
>> generates XferComplete/XferInProgress events only for the last TRB
>> (since IOC/LST are set only for the last TRB). As per the logic in
>> dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
>> IOC/LST bit and returns on the first TRB. This makes the remaining
>> TRBs left unhandled.
>> To aviod this, changed the code to check for IOC/LST bits in both
>> event->status & TRB->ctrl. This patch does the same.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
>> Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
>> ---
>>  Changes in v7:
>> 	1. None
>>
>>  Changes in v6:
>> 	1. None
>>
>>  Changes in v5:
>> 	1. None
>>
>>  Changes in v4:
>> 	1. None
>>
>>  Changes in v3:
>> 	1. None
>>
>>  Changes in v2:
>> 	1. None
>> ---
>>  drivers/usb/dwc3/gadget.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 9ddc9fd..216179e 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2286,7 +2286,12 @@ static int
>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>  		return 1;
>>
>> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>> +	if ((event->status & DEPEVT_STATUS_IOC) &&
>> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
>> +		return 1;
>
>this shouldn't be necessary. According to databook, event->status
>contains the bits from the completed TRB.  Which means that
>event->status & IOC will always be equal to trb->ctrl & IOC.
>
Thanks for reviewing this patch. Lets consider an example where a request
has num_sgs > 0 and each sg is mapped to a TRB and the last TRB has the
IOC bit set. Once the controller is done with the transfer, it  generates=20
XferInProgress for the last TRB (since IOC bit is set). As a part of trb re=
claim
process  dwc3_gadget_ep_reclaim_trb_sg() calls
dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
the event already has the IOC bit set, the loop is exited from the loop at =
the
very first TRB and the remaining TRBs (mapped to the sglist) are left unhan=
dled.
To avoid this we modified the code to exit only if both TRB & event has the=
 IOC
bit set.
=20
>Can you further describe the situation here? Perhaps share tracepoints
>exposing the problem?

Sure, will capture the traces and reply back

Thanks,
Anurag Kumar Vulisha
