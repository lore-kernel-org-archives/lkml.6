Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F83C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEA62082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="R8YZheDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEA62082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLDTHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:07:36 -0500
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:5856
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbeLDTHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gSTi9plvDufJZ0djB89Fc+MSmFuJSIyJ/mEJGrdjJ0=;
 b=R8YZheDtXnMafuF7blk75ERJ0jXNA8Un3kOB2X/B0SMMSINwN+aFoSX9uGeLhaAEumqBr6UeHMdWv5tWEeBhg6+KXBV0Z4WT/owoohEagTu4ezfvZKa8Pjx4CXdKM8PwFZKqavpBMVEoLlq+XRVzs3nl+x0II8Cc8kBiz5hxUoE=
Received: from SN6PR02MB5648.namprd02.prod.outlook.com (20.177.251.214) by
 SN6PR02MB5184.namprd02.prod.outlook.com (52.135.100.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 19:07:25 +0000
Received: from SN6PR02MB5648.namprd02.prod.outlook.com
 ([fe80::4914:f230:f0c8:5895]) by SN6PR02MB5648.namprd02.prod.outlook.com
 ([fe80::4914:f230:f0c8:5895%3]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 19:07:25 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb
 requests
Thread-Topic: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb
 requests
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+AgACIUoCAAM7bwIAAWNWAgAAcRaA=
Date:   Tue, 4 Dec 2018 19:07:25 +0000
Message-ID: <SN6PR02MB56484B8D1F891926DA7D7900A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
References: <SN6PR02MB564841A6B40602168325B434A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
 <Pine.LNX.4.44L0.1812041138440.1537-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812041138440.1537-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB5184;6:UdzN6hSTpu6SDPbbuklw8jshZpJrCmpzijDGdvfrifunWdbJ3azXm9KUUZhSaAxpvk4uLhW5pixC8gXRwtOtSzERpgGe7NmTZBFU3kE5f+SqMK8Rh3xy702o37DVo2Qu/iF6XXkldtyc6flOp1d+rDD7sns4MMzjx+YOsVVzvcRPoMwTLG0Q8I1NG+NJg7GP/Yhd/62P5QQ6i87f/+64NH36r/JA3Uj+fwoEyPvXWhb5VoSNzTNg8UF4r9ZBzZs/bWYQd9SyYlOjkVj2CKsJxZ+QL4NY6DjxWs7t1ZnMwV1+i3e4msIWwYxq85luB+ZjWftHroJoa9SFSxjRAb5Hlf0xMl+4YqOh+Bd2vPM0m8nrCsayJJx3mRGCZaUDeO1NGV0g6mPW/hqP5kCgUniyKv658frloLWzrOvy33r25nv+NKgru08mYKZTDlDwHZb79/VJcRBHmgsUrIT5x2uLtQ==;5:E8LzvS0llOPiC+cBuoVmPIeI7acXNimlX6iUPRfOnaqBMkhNN4OFDuLbWwktmhS7QaXcukHHx+no7b4Lu4tSnp8AQDWHAvUs53Rt8pMj+I6Lg6Bhi2ZH3TAdufFSL5vVxFA3pSrIM2ofgN8EnIPGLmdUPg4ae8u7543jMGWGkXc=;7:J2beToIpyxflEFMgCfUfd1vNPyMMERkSkF6maws3ckVy7C/jmApJn8wy9+LWHu6s6DoBb0WfpbF/ZGeKV057w9TFFANNWYapBTWUiveqRaHBSDvq58L0VUTtvRVGaZ4scpi5ooBoq7zHJynBF1oc6g==
x-ms-office365-filtering-correlation-id: 16d9de2f-200f-4950-3d90-08d65a1bba1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB5184;
x-ms-traffictypediagnostic: SN6PR02MB5184:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB51840E39C8B9331089145BBAA7AF0@SN6PR02MB5184.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB5184;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5184;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(13464003)(7736002)(476003)(76176011)(305945005)(2171002)(107886003)(26005)(486006)(25786009)(14444005)(256004)(105586002)(106356001)(7696005)(6506007)(7416002)(14454004)(186003)(102836004)(5660300001)(966005)(74316002)(6246003)(9686003)(11346002)(446003)(86362001)(55016002)(478600001)(97736004)(6306002)(99286004)(2906002)(6916009)(66066001)(3846002)(6436002)(6116002)(53936002)(71200400001)(68736007)(316002)(33656002)(71190400001)(54906003)(4326008)(8676002)(39060400002)(81156014)(8936002)(81166006)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5184;H:SN6PR02MB5648.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nkXSBQarCeybjaQAk6U82IsIMj/YLvnY5SnwvGjB1X52q7Z1185uVbve9F8I00XM8W3OHZbZs4WIljsThLTsP25NiiHonouaTmD8F6JCt79ieCoLBP0F48UP+mDkqWp8Luc4LCTQ3O9jWlLgYit0Yyg/EpDoHNwlaiQ4vjj88ubzSqx8TZuN3v2bB54X5Ti4l3gxGiOq3yEzR62Kz8XD+vkj8Bkq4lQ/xUATufxxct+xoIbNgEA81IfDYlOckufxYXnNoPgAwpWdr1RLKJxRbP2aCg7+iY3aFIv1xUNWd81zUYoGhZU40LP1aDMlKzwgFXQxL5piYd/coKRZ56QptEypKLcUeORzTJZ5XPuBtko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d9de2f-200f-4950-3d90-08d65a1bba1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 19:07:25.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Tuesday, December 04, 2018 10:17 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>Cc: Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Johan Hovold
><johan@kernel.org>; Jaejoong Kim <climbbb.kim@gmail.com>; Benjamin
>Herrenschmidt <benh@kernel.crashing.org>; Roger Quadros <rogerq@ti.com>; M=
anu
>Gautam <mgautam@codeaurora.org>; martin.petersen@oracle.com; Bart Van
>Assche <bvanassche@acm.org>; Mike Christie <mchristi@redhat.com>; Matthew
>Wilcox <willy@infradead.org>; Colin Ian King <colin.king@canonical.com>; l=
inux-
>usb@vger.kernel.org; linux-kernel@vger.kernel.org; v.anuragkumar@gmail.com=
;
>Thinh Nguyen <thinhn@synopsys.com>; Tejas Joglekar
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>
>Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb =
requests
>
>On Tue, 4 Dec 2018, Anurag Kumar Vulisha wrote:
>
>> >> Yes the host can cancel the transfer. This issue originated from
>> >> the endpoints using
>> >bulk
>> >> streaming protocol and may not occur with normal endpoints. AFAIK
>> >> bulk streaming
>> >is
>> >> gadget driven, where the gadget is allowed to select which stream
>> >> id transfer the
>> >host
>> >> should work on . Since the host doesn't have control on when the
>> >> transfer would be selected by gadget, it may wait for longer timeouts=
 before
>cancelling the transfer.
>> >
>> >You're missing the point.  Although the device selects which stream
>> >ID gets transferred, the _host_ decides whether a stream transfer
>> >should occur in the first place.  No matter how many ERDY packets the
>> >device controller tries to send, no transfer will occur until the
>> >host wants to do it.
>> >
>> >In this sense, stream transfers (like all other USB interactions
>> >except wakeup requests) are host-driven.
>> >
>>
>> I agree with you that without host willing to transfer, the transfer
>> wouldn't have started and also agree the host always has the
>> capability of detecting the hang. But we are not sure on what host
>> platform and operating system the gadget would be tested and also not su=
re
>whether the host software is capable of handling the deadlock.
>> Even if the host has a timer , it would be very long and waiting for
>> the timer to get timedout  would reduce the performance. In this patch
>> we are giving the user the flexibility to opt the timeout value, so
>> that the deadlock can be avoided without effecting the performance. So
>> I think adding the timer in gadget is more easier solution than handling=
 in host. I
>have seen this workaround working for both linux & windows.
>
>Is there any way for the device controller driver to detect the problem wi=
thout relying
>on a timeout?
>
>In fact, is this problem a known bug in the existing device controller har=
dware?  Have
>the controller manufacturers published a suggested scheme for working arou=
nd it?
>

Yes, this problem is mentioned in dwc3 controller data book and the workaro=
und
mentioned  is the same that we are doing , to implement timeout and if no v=
alid
stream event is found , after timeout issue end transfer followed by start =
transfer.

>> >> >> Since the gadget
>> >> >> controller driver is aware that the controller is stuck , makes
>> >> >> it responsible to recover the controller from hang condition by
>> >> >> restarting the transfer (which triggers the controller FSM to issu=
e ERDY to
>host).
>> >> >
>> >> >Isn't there a cleaner way to recover than by cancelling the
>> >> >request and resubmitting it?
>> >> >
>> >>
>> >> dequeuing the request issues the stop transfer command to the
>> >> controller, which cleans all the hardware resource allocated for
>> >> that endpoint. This also resets the hardware FSMs for that endpoint
>> >> . So, when re-queuing of the transfer happens the controller starts
>> >> allocating hardware resources again, thus avoiding the
>> >probability
>> >> of entering into the issue. I am not sure of other controllers, but
>> >> for dwc3, issuing the stop transfer is the only way to handle this is=
sue.
>> >
>> >Again you're missing the point.  Can't the controller driver issue
>> >the Stop Transfer command but still consider the request to be in
>> >progress (i.e., don't dequeue the request) so that the gadget
>> >driver's completion callback isn't invoked and the request does not
>> >need to be explicitly resubmitted?
>> >
>>
>> Yes , what you are saying is correct. My initial patches were
>> following the same approach that you have suggested. We switched to
>> the dequeue approach because there can be different gadgets which may
>> enter into this issue and it would be better to follow a generic
>> approach rather than having every controller driver implementing their o=
wn
>workaround.
>> Please find the conservation in this link
>> https://patchwork.kernel.org/patch/10640145/
>
>At this point, it seems that the generic approach will be messier than hav=
ing every
>controller driver implement its own fix.  At least, that's how it appears =
to me.

With the dequeue approach there is an advantage(not related to this issue) =
that the
class driver can have control of the timed out transfer whether to requeue =
it or consider
it as an error (based on implementation). This approach gives more flexibil=
ity to the class
drivers. This may be out of context of this issue but wanted to point out t=
hat we may lose
this advantage on switching to older implementation.
 =20
>
>> >> @Felipe:  Can you please provide your suggestion on this.
>> >
>> >> >How can the gadget driver know what timeout to use?  The host is
>> >> >allowed to be as slow as it wants; the gadget driver doesn't have
>> >> >any way to tell when the host wants to start the transfer.
>> >>
>> >> Yes , I agree with you that the timeout may vary from usage to
>> >> usage. This timeout should be decided by the class driver which
>> >> queues the request. As discussed above this issue was observed in
>> >> streaming protocol , which  is very much faster than
>> >normal
>> >> BOT modes and it works on super speed .
>> >
>> >Although USB mass storage is currently the only user of the stream
>> >protocol, that may not be true in the future.  You should think in
>> >more general terms.  A timeout which is appropriate for mass storage
>> >may not be appropriate for some other application.
>> >
>>
>> You are correct , this timeout may not be ideal. Since  I was not able
>> to reproduce this issue on non-stream capable transfers , at  present
>> the only user of usb_ep_queue_timeout() API is the streaming gadget.
>> As we are not aware of the optimal timeout value,  instead of
>> hardcoding the timeout value we can add module_param() for it.  So that =
the user
>can configure timeout based on their use case. Please let me know your sug=
gestion
>on this.
>
>Ideally it would not be necessary to rely on a timeout at all.
>
>Also, maintainers dislike module parameters.  It would be better not to ad=
d one.

Okay. I would be happy if any alternative for this issue is present but unf=
ortunately
I am not able to figure out any alternative other than timers. If not modul=
e_params()
we can add an configfs entry in stream gadget to update the timeout. Please=
 provide
your opinion on this approach.=20

Thanks,
Anurag Kumar Vulisha=20
