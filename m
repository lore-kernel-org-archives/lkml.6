Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED48C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2669920700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zRKtUr9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2669920700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLHTGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:06:31 -0500
Received: from mail-eopbgr790089.outbound.protection.outlook.com ([40.107.79.89]:49410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeLHTGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DDJhNUDFJbh6F5L0isJpCx94Qf/XGjPOc4j39dZ85I=;
 b=zRKtUr9mxAc0qlPgevvoeKJEVDSPX0ehAwS/sELVYEHuCCbkDufXch3z7Kk1V1YKfi3c5qscEGIBumU+0w6zAsm9odjqDLi1Dw322fwt0IclivOoU2HAoPk1Dl9csuXqjStH8OWZfUFRv3wFruZEtFt16//5RLo4l9mwXYzqgKs=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB5460.namprd02.prod.outlook.com (20.177.240.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sat, 8 Dec 2018 19:03:33 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1404.023; Sat, 8 Dec 2018
 19:03:33 +0000
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
Thread-Index: AQHUiWbqDI9WfI74TEmPyd+V2NlqDqVv4SkAgACgrWCAAlLUgIACXYXw
Date:   Sat, 8 Dec 2018 19:03:33 +0000
Message-ID: <BL0PR02MB56331B2ECFFEB96A99936C32A7AB0@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <875zw82vfj.fsf@linux.intel.com>
 <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
 <874lbpx3vg.fsf@linux.intel.com>
In-Reply-To: <874lbpx3vg.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB5460;6:/om0ml0EFaXfxFJiaXEgywGwwiLffTg6zzZVsVGCIp+Mk8XwMlOvfzbZ741hl3/URwpNoE+hLRUMEj6hw7jNZn0D3kUVy4vA3rovwLy4Hr+JsB97bDu9Z/TMhNKAMKuM6IKvjHpkfg2vkfgIAaSXFr7qFqpp51DNRrjfG0DY3qHnV1yUVxny2FBmW8f1EqXIEMT7xeEe5NoGyolOo4P2h7evq+OYwBZnnSRqXp4co7+UN/FXQG2aFXgeF59MtyqVFsivCyFXr7YgnLTWNuVZ4g7dNMBvXDIRWKCajnwngKupXCHiaEINe6HWnr8CQNwc6r5wyS1wiVfyrcP0SpQgiWExH6ED1Efk7njLFrLoXY92aNT2cLR/sQPU7CNTyut63q3TFy8+tWtIEsCZQnlG/3KcnlnGwlN9oJHxtwXcZLVyrMtqesEK6gVMBdYD3O/sgPGT1G0nRJNQtB5GmgaMdA==;5:Wh6NqtIWproQ7uSgwPvHLkVZ+JEG0pNYyJDoRZNv/RF6Ml5kRGjLNKXD96tzpEW5nSJVJvFsJFCtLNMqASxcJCSUuISpdCiOErDLfkK30Zckozv0G48VymKA/1cfIespqsL6eciw4X8L6oUqIVjUOf0qTI716djKCXh61wwgQeY=;7:fSkYESxU4BrLWNvS4sSNiRCcYKJ6+kzYwBHkPxy2KRTpaEPXH/qFgPDuQThPkHuar2uHJjKzoY7/2AK/NM2Kf90c0AnCvUeqEq4IwmB3SHWSnTJA0eAaV/6t3TOjTbrpoOQ/MGS9U+B51TaJqxZ0nA==
x-ms-office365-filtering-correlation-id: 9fa792ad-1cb2-4cfd-fe7d-08d65d3fd9bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB5460;
x-ms-traffictypediagnostic: BL0PR02MB5460:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB546074C04F934D6E050AA3ABA7AB0@BL0PR02MB5460.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB5460;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB5460;
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(13464003)(189003)(199004)(26005)(256004)(14444005)(4326008)(186003)(86362001)(3846002)(6116002)(97736004)(71200400001)(53936002)(55016002)(33656002)(93886005)(14454004)(9686003)(71190400001)(6506007)(102836004)(39060400002)(106356001)(105586002)(2171002)(6246003)(54906003)(316002)(110136005)(7416002)(107886003)(68736007)(478600001)(229853002)(8676002)(74316002)(305945005)(81156014)(81166006)(99286004)(486006)(8936002)(476003)(446003)(11346002)(7696005)(5660300001)(76176011)(25786009)(6436002)(66066001)(7736002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5460;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WNjZdJWlQd18DzIbghLzquO/tURcJY8XGEAxfgEDiK0GLtLLJzx0RE9w+CoWsUtNvR5U2cgY19xdMwth8sqehaZc42GGskbBW4C4kegRJOrfgsBzb/pc/4B8/NHLuGSWDbCfZBUtIuHFuvQ4BrqW8GlhxQDniAUSBOZSzQVhzqqbThpNg3QQSB7YbCVZ5o4zgGMGff1SufiZpf2rVE2KgajTdjJsqizpB503nPClaxjCLqkCr8eHleW6IFtRFLiL77uR1nq//vF+kAkpxTtkgFCKjS/VnRbB3aoh8p9r8G0tR5nut1ogYM7wdI1rgnCjwevBfACx/lQ2wKvBhFW27J5ZzMm6wKzZoAZGgB/PFHI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa792ad-1cb2-4cfd-fe7d-08d65d3fd9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 19:03:33.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Friday, December 07, 2018 11:42 AM
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
>>>> @@ -2286,7 +2286,12 @@ static int
>>>dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
>>>>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>>>>  		return 1;
>>>>
>>>> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
>>>> +	if ((event->status & DEPEVT_STATUS_IOC) &&
>>>> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
>>>> +		return 1;
>>>
>>>this shouldn't be necessary. According to databook, event->status
>>>contains the bits from the completed TRB.  Which means that
>>>event->status & IOC will always be equal to trb->ctrl & IOC.
>>>
>> Thanks for reviewing this patch. Lets consider an example where a
>> request has num_sgs > 0 and each sg is mapped to a TRB and the last
>> TRB has the IOC bit set. Once the controller is done with the
>> transfer, it  generates XferInProgress for the last TRB (since IOC bit
>> is set). As a part of trb reclaim process
>> dwc3_gadget_ep_reclaim_trb_sg() calls
>> dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
>> the event already has the IOC bit set, the loop is exited from the
>> loop at the very first TRB and the remaining TRBs (mapped to the sglist)=
 are left
>unhandled.
>> To avoid this we modified the code to exit only if both TRB & event
>> has the IOC bit set.
>
>Seems like IOC case should just test for chain flag as well:
>

Okay. Along with this logic the code for updating chain bit should also be =
modified I guess.
Since the IOC bit is also set when there are not enough TRBs available, the=
 code should be
modified to not set DWC3_TRB_CTRL_CHN bit when the IOC bit is set. I will u=
pdate below
changes along with your suggestions and resend the patches.

@@ -998,7 +998,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep,=
 struct dwc3_trb *trb,
                        (dwc3_calc_trbs_left(dep) =3D=3D 1))
                trb->ctrl |=3D DWC3_TRB_CTRL_IOC;
=20
-       if (chain)
+       if (chain && !(trb->ctrl & DWC3_TRB_CTRL_IOC))
                trb->ctrl |=3D DWC3_TRB_CTRL_CHN;
=20
        if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capab=
le)
@@ -2372,7 +2372,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struc=
t dwc3_ep *dep,
        if (event->status & DEPEVT_STATUS_SHORT && !chain)
                return 1;
=20
-       if (event->status & DEPEVT_STATUS_IOC)
+       if (event->status & DEPEVT_STATUS_IOC && !chain)
                return 1;
=20
        return 0;
@@ -2399,7 +2399,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_=
ep *dep,
                req->num_pending_sgs--;
=20
                ret =3D dwc3_gadget_ep_reclaim_completed_trb(dep, req,
-                               trb, event, status, true);
+                               trb, event, status, (trb & DWC3_TRB_CTRL_CH=
N));
                if (ret)
                        break;
        }

Thanks,
Anurag Kumar Vulisha

>modified   drivers/usb/dwc3/gadget.c
>@@ -2372,7 +2372,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(stru=
ct
>dwc3_ep *dep,
> 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
> 		return 1;
>
>-	if (event->status & DEPEVT_STATUS_IOC)
>+	if (event->status & DEPEVT_STATUS_IOC && !chain)
> 		return 1;
>
> 	return 0;
>
>--
>balbi
