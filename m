Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB676C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0D720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZDxNjAsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0D720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLJI7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:59:40 -0500
Received: from mail-eopbgr800082.outbound.protection.outlook.com ([40.107.80.82]:34523
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbeLJI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWyfuf494Yi23nLZ4uJAKS9vwAmdLbl+zXsne46aF6Q=;
 b=ZDxNjAsCiiIKuaTT1wOFZE1kLrf73t8NoNTThNEyZAGBDQHT2+hHVqOZDB027H/ylc+cumv4sgcdCuiLRd1iT1DMYZWHaucENyA2EvLyYiWzMV0Zm/VmDWqzts0UiTsMN+JNSA9+VIAIzVy+dH+SCIuLeobstC2+I0TvpOYQAY8=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4579.namprd02.prod.outlook.com (10.167.181.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 08:56:43 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:56:43 +0000
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
Thread-Index: AQHUiWbqDI9WfI74TEmPyd+V2NlqDqVv4SkAgACgrWCAAlLUgIACXYXwgAJlVICAABFagA==
Date:   Mon, 10 Dec 2018 08:56:43 +0000
Message-ID: <BL0PR02MB56338A2EA4515527AA0EECF5A7A50@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <875zw82vfj.fsf@linux.intel.com>
 <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
 <874lbpx3vg.fsf@linux.intel.com>
 <BL0PR02MB56331B2ECFFEB96A99936C32A7AB0@BL0PR02MB5633.namprd02.prod.outlook.com>
 <87pnu927oq.fsf@linux.intel.com>
In-Reply-To: <87pnu927oq.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4579;6:cLCrQ+uvdWvO1hm0k49YXJibN+n4u2dd5OUTVO9k6lHH2tZ4aBQUddKAro+E759kp/Bjl44NKaS+3vabxc8sDkyBaCFkdhx9tHUaEwuPLo6qaZQ9xzHznO3EhlkmKxd05CvfrzgwORrGcfaTQiAetiVhskjp5QK39HNZzci0fEJTvPizyL78kCy4Dz93htHg9YRUV3RI6Cb7MiED2oaKwztHsZ5yDvJFJRgheHdAN5Q9yRWPTJRe8QUzpAqfz5ZTyhThTfKu0agL0YNAb7UuGcGQ1vrSbhwO4nikjI66FNHrJ0NwJ2R+jVJyOWQVRERd2gzEbhS754Hb2bEu3E8Uex6XYpZcnhDVub3c2qXQzEO6+Qfzu1GbVeIUUVS35b0khPynIfJPBO7CMHWNMJ1edIZeGvbzLGNavcZrNMMTfdYtqa49uy7pcjVIDnt0G9uthgQ/vYB1OwGPsSbccwmWYg==;5:On3KC+dA9XatyqOrILNO5Q52LB6CCSBRk58cz3WEtDDbEDgrcywbviQkXTzY9P2vAlNo332A2ecuAlXw5VS9RE7yBNSdXWX0cF4j8mu4GsTuGWtdt4pKy102KcAiIZovXlH4TvqCzD4GF90mWVGi10cPVwXeJ3pvaoJOvnI8//U=;7:QLZfI1qMHMGXRGSC5Fh8OSBWssHpwI0G3RzOlUc9lqbZf3TXX/PBGwujhfnayPGO5xBFe3sWIduYuWHPz/IcFAh2obYkAGK1YEemvbR3f35tG7w1JC67KsgWFaAcohOcgKBUsb9JDeB7SST4vvHBIA==
x-ms-office365-filtering-correlation-id: 6a5333d7-4545-49e7-5640-08d65e7d6872
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4579;
x-ms-traffictypediagnostic: BL0PR02MB4579:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB4579B447892742B28194B2E5A7A50@BL0PR02MB4579.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4579;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4579;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(13464003)(186003)(7416002)(93886005)(102836004)(14454004)(81166006)(81156014)(99286004)(71190400001)(71200400001)(2906002)(74316002)(26005)(7736002)(14444005)(6506007)(76176011)(305945005)(5660300001)(33656002)(11346002)(6436002)(4326008)(446003)(66066001)(476003)(486006)(229853002)(6116002)(86362001)(3846002)(9686003)(2501003)(39060400002)(106356001)(53936002)(68736007)(105586002)(97736004)(316002)(478600001)(8936002)(2171002)(7696005)(110136005)(54906003)(6246003)(107886003)(55016002)(25786009)(8676002)(256004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4579;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xyTAgZeC9M0MDyhqbUKf3Ti+HOiUsWg8NuBP92VceFSw4Aehz70lLwW5TwuRsr+tI/6BLnTvwqQYuBM/Hk4myxzBbV29rZ1kuAynlf7o0QeTOn9ST2LxHalTQl+m/n4bxhMRseUc5UhJfyvrMTq8Ud/x0sHbeT+34YZ8U2e7bZDz6rX89DeMdXFCXxGpMYZywjVTt6u0c44s6KgtXQIDD3c37rOeTSeUFdUOz7RmbOP/NCOcA6FU+vIMV6v/Lt3TguoDJILaSmqv27TdTG6szuqFM5xAQNYCV5BNqQmor7me4G+xcYi4jc2/v8KgkSsN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5333d7-4545-49e7-5640-08d65e7d6872
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:56:43.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Monday, December 10, 2018 12:24 PM
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
m>
>Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both eve=
nt->status
>and TRB->ctrl fields
>
>
>Hi,
>
>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>> HI Felipe,
>>
>>>-----Original Message-----
>>>From: Felipe Balbi [mailto:balbi@kernel.org]
>>>Sent: Friday, December 07, 2018 11:42 AM
>>>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
>>><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Alan Stern
>>><stern@rowland.harvard.edu>; Johan Hovold <johan@kernel.org>; Jaejoong K=
im
>>><climbbb.kim@gmail.com>; Benjamin Herrenschmidt <benh@kernel.crashing.or=
g>;
>>>Roger Quadros <rogerq@ti.com>; Manu Gautam <mgautam@codeaurora.org>;
>>>martin.petersen@oracle.com; Bart Van Assche <bvanassche@acm.org>; Mike
>>>Christie <mchristi@redhat.com>; Matthew Wilcox <willy@infradead.org>; Co=
lin
>Ian
>>>King <colin.king@canonical.com>
>>>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas
>Joglekar
>>><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey
><APANDEY@xilinx.com>
>>>Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both e=
vent-
>>status
>>>and TRB->ctrl fields
>>>
>>>
>>>Hi,
>>>
>>>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>>>>> @@ -2286,7 +2286,12 @@ static int
>>>>>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>>>>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>>>>>  		return 1;
>>>>>>
>>>>>> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>>>>>> +	if ((event->status & DEPEVT_STATUS_IOC) &&
>>>>>> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
>>>>>> +		return 1;
>>>>>
>>>>>this shouldn't be necessary. According to databook, event->status
>>>>>contains the bits from the completed TRB.  Which means that
>>>>>event->status & IOC will always be equal to trb->ctrl & IOC.
>>>>>
>>>> Thanks for reviewing this patch. Lets consider an example where a
>>>> request has num_sgs > 0 and each sg is mapped to a TRB and the last
>>>> TRB has the IOC bit set. Once the controller is done with the
>>>> transfer, it  generates XferInProgress for the last TRB (since IOC bit
>>>> is set). As a part of trb reclaim process
>>>> dwc3_gadget_ep_reclaim_trb_sg() calls
>>>> dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
>>>> the event already has the IOC bit set, the loop is exited from the
>>>> loop at the very first TRB and the remaining TRBs (mapped to the sglis=
t) are left
>>>unhandled.
>>>> To avoid this we modified the code to exit only if both TRB & event
>>>> has the IOC bit set.
>>>
>>>Seems like IOC case should just test for chain flag as well:
>>>
>>
>> Okay. Along with this logic the code for updating chain bit should also =
be modified I
>guess.
>
>not really
>
>> Since the IOC bit is also set when there are not enough TRBs available, =
the code
>should be
>> modified to not set DWC3_TRB_CTRL_CHN bit when the IOC bit is set. I wil=
l update
>below
>> changes along with your suggestions and resend the patches.
>
>no. Actually I don't think we're allowed to split a scatter/gather like
>that. I did that quite a while ago, but I don't think we're allowed to
>do so. What we should do, in that case, is not even queue that request
>until we have enough for all members of the scatter/gather. But that's a
>separate patch, anyway.
>

Okay. I have a doubt here, not pushing the request until all sgs are mapped=
 to enough TRBs
might remove the driver complexity but reduce the performance (since we are=
 waiting
until enough TRBs are available). Are we okay with that? =20

Thanks,
Anurag Kumar Vulisha =20
