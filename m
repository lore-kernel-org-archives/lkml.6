Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A58620659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ku/FTuQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeLDQS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:18:56 -0500
Received: from mail-eopbgr740052.outbound.protection.outlook.com ([40.107.74.52]:24107
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbeLDQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCrDFuBGYdo145PRGC78Td/OL+sQNGG5SxeIotVpaHw=;
 b=Ku/FTuQ57IZGLhFehfZtjez7Q78+Ygt8MqfknktGWfuKvtae9mWz09OENPrOEynmQv2xzSWIJod/1F2bDVFnhEOQxDk13xb1RoxkVjrHTY4E7/hlG2SFH2ZeFyUjBVlL1+tZ4qMYl8lbGG/ivEm8WNDzNareWKL5gpBf6gH8YF4=
Received: from SN6PR02MB5648.namprd02.prod.outlook.com (20.177.251.214) by
 SN6PR02MB4397.namprd02.prod.outlook.com (52.135.119.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 16:18:48 +0000
Received: from SN6PR02MB5648.namprd02.prod.outlook.com
 ([fe80::4914:f230:f0c8:5895]) by SN6PR02MB5648.namprd02.prod.outlook.com
 ([fe80::4914:f230:f0c8:5895%3]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 16:18:48 +0000
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+AgACIUoCAAM7bwA==
Date:   Tue, 4 Dec 2018 16:18:48 +0000
Message-ID: <SN6PR02MB564841A6B40602168325B434A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
References: <BL0PR02MB563382F544FBEA926452DCF1A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
 <Pine.LNX.4.44L0.1812031758080.31542-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812031758080.31542-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4397;6:FuHUPCCrbPJ0pGgXa6G/JjnfJ1yNG5v0MiCePV0Lyns4tRIOyF6YpEa/slthyHY+uGCNbdFRD4nCKWRw051hOz2XshcXqFMIEV0ivBVibUMRBgHZClIBKGFOAIJoEa2k3l1EGpxd3mIuCBtghf1ABnROUBcLLO7J+MaQeoqiYw7jZc/yUdQao/+ZHDkN5GD1Rnz6ecowRFNWpb/x+96DdIO7CAeNOWzoENrNpWzvexoksbSw2xYw7TKdMDAH3yww5hjqAlqfNFI9+jXMgpJv7P1ytofYoVZbuSJ7zw44SXbhl7Iq6dVIrB41miwUHADcrTycb6xciQ9t5mF6VqWpVnN02Y25CUtahk5E7I5RYwPQXwuT5s9uz4i+lE8m6kd+zPTRToL2B1cx8inEuZ32dwoFtxZk/uO/Rz4AoTK5QzaCP8dxNaAaouiLLd8Wgx4RGDM5bO4Ay0nHJUM0G6WQ/w==;5:lOwlo2lKG0TpRFbLco3hrUGKOq+ZTYiXWajQDIbSReAGrhAlbMQlLSBJZbrT2RSeBbExlx8UmHDr5saFYHRzGZLDXhAg6Nl4FeDE2vBfw+ZkOSwqQxmbCtuP4PcB1ZhcEm4JU4Rs0+5USChRGVJ1QbGPMVQvvtHB+SxmoexHGo0=;7:k6ecyo/+dyPHHsmpcHk9Y/u8VnJ2xO7BOBLak9fRBGsXkqwqr82In2uQXv5E0iWPU+Az845o6g3lAP9ZgfHiWCJYxmFLpL53SimToLYvk/XXMV6yzSRhwSAvvzTnMoKR0nzJXkQ+fh8D9shB/Z1gNw==
x-ms-office365-filtering-correlation-id: 9583d6b4-1390-4e2f-9842-08d65a042bdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4397;
x-ms-traffictypediagnostic: SN6PR02MB4397:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4397FE1B3901AB2ED5E0E370A7AF0@SN6PR02MB4397.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4397;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4397;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(396003)(376002)(136003)(199004)(189003)(13464003)(25786009)(7736002)(9686003)(486006)(6436002)(6306002)(39060400002)(476003)(55016002)(2171002)(6246003)(478600001)(966005)(4326008)(97736004)(6116002)(74316002)(53936002)(8936002)(3846002)(446003)(107886003)(11346002)(86362001)(305945005)(81166006)(81156014)(8676002)(6916009)(68736007)(105586002)(316002)(26005)(551934003)(33656002)(76176011)(6506007)(102836004)(7416002)(106356001)(99286004)(186003)(54906003)(7696005)(14444005)(229853002)(66066001)(5660300001)(2906002)(14454004)(71200400001)(256004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4397;H:SN6PR02MB5648.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hX2lREoilrkLfXH/pyGsCIIPGejJJsucQ5Rs4WAgLhTLFLSXwS9NyhRuWUKqNigFjwXsNJjlfaCpMbeyI/3uR4WC3zGfL+Mzgy9CPOwTzqSCf7nWECSZ+Nt9HW1hEwvtnbJWNLETCZAU07TkLtLJsozNdFqqqXzR/5Ka7tyl7CXKbvbYuua8oKsduXxDmZ+JI02sCFr0fWnAW5nzhGeokEEtqp8w5XhNaHII2ojHCHkI9VOUNXwmPDin0WDcmqJEiX4zXOMpDfPIRZLVpVgaUXZEwfV9V7KdwOHC8gtqfIHVzVd4Grhly5Xg97Dkbye6QKGHsoNejFPOZng2Y1SGWOlyAqvwPtBhHqLtZIyDNXo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9583d6b4-1390-4e2f-9842-08d65a042bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 16:18:48.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Tuesday, December 04, 2018 4:38 AM
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
>On Mon, 3 Dec 2018, Anurag Kumar Vulisha wrote:
>
>> >On Mon, 3 Dec 2018, Anurag Kumar Vulisha wrote:
>> >
>> >> >First of all, if some sort of deadlock causes a transfer to fail to
>> >> >complete, the host is expected to cancel and restart it.  Not the
>> >> >gadget.
>> >> >
>> >>
>> >> Thanks for spending your time in reviewing this patch.  The deadlock
>> >> is  a very rare case scenario and is happening because both the gadge=
t
>> >> controller & host controllers get out of sync and are stuck waiting f=
or the
>> >> relevant event. For example this issue is observed in stream protocol=
 where
>> >> the gadget controller is waiting on Host controller to issue PRIME tr=
ansaction
>> >> and  Host controller is waiting on gadget to issue ERDY transaction. =
Since
>> >> the stream protocol is gadget driven, the host may not proceed furthe=
r until it
>> >> receives a valid Start Stream (ERDY) transaction from gadget.
>> >
>> >That's not entirely true.  Can't the host cancel the transfer and then
>> >restart it?
>> >
>>
>> Yes the host can cancel the transfer. This issue originated from the end=
points using
>bulk
>> streaming protocol and may not occur with normal endpoints. AFAIK bulk s=
treaming
>is
>> gadget driven, where the gadget is allowed to select which stream id tra=
nsfer the
>host
>> should work on . Since the host doesn't have control on when the transfe=
r would be
>> selected by gadget, it may wait for longer timeouts before cancelling th=
e transfer.
>
>You're missing the point.  Although the device selects which stream ID
>gets transferred, the _host_ decides whether a stream transfer should
>occur in the first place.  No matter how many ERDY packets the device
>controller tries to send, no transfer will occur until the host wants
>to do it.
>
>In this sense, stream transfers (like all other USB interactions except
>wakeup requests) are host-driven.
>

I agree with you that without host willing to transfer, the transfer wouldn=
't have
started and also agree the host always has the capability of detecting the =
hang. But
we are not sure on what host platform and operating system the gadget would=
 be
tested and also not sure whether the host software is capable of handling t=
he deadlock.
Even if the host has a timer , it would be very long and waiting for the ti=
mer to get
timedout  would reduce the performance. In this patch we are giving the use=
r the
flexibility to opt the timeout value, so that the deadlock can be avoided w=
ithout
effecting the performance. So I think adding the timer in gadget is more ea=
sier solution
than handling in host. I have seen this workaround working for both linux &=
 windows.

>> >> Since the gadget
>> >> controller driver is aware that the controller is stuck , makes it re=
sponsible
>> >> to recover the controller from hang condition by restarting the trans=
fer (which
>> >> triggers the controller FSM to issue ERDY to host).
>> >
>> >Isn't there a cleaner way to recover than by cancelling the request and
>> >resubmitting it?
>> >
>>
>> dequeuing the request issues the stop transfer command to the controller=
, which
>> cleans all the hardware resource allocated for that endpoint. This also =
resets the
>> hardware FSMs for that endpoint . So, when re-queuing of the transfer ha=
ppens
>> the controller starts allocating hardware resources again, thus avoiding=
 the
>probability
>> of entering into the issue. I am not sure of other controllers, but for =
dwc3, issuing
>> the stop transfer is the only way to handle this issue.
>
>Again you're missing the point.  Can't the controller driver issue the
>Stop Transfer command but still consider the request to be in progress
>(i.e., don't dequeue the request) so that the gadget driver's
>completion callback isn't invoked and the request does not need to be
>explicitly resubmitted?
>

Yes , what you are saying is correct. My initial patches were following the
same approach that you have suggested. We switched to the dequeue
approach because there can be different gadgets which may enter into
this issue and it would be better to follow a generic approach rather than
having every controller driver implementing their own workaround.
Please find the conservation in this link  https://patchwork.kernel.org/pat=
ch/10640145/
  =20
>> @Felipe:  Can you please provide your suggestion on this.
>
>> >How can the gadget driver know what timeout to use?  The host is
>> >allowed to be as slow as it wants; the gadget driver doesn't have any
>> >way to tell when the host wants to start the transfer.
>>
>> Yes , I agree with you that the timeout may vary from usage to usage. Th=
is timeout
>> should be decided by the class driver which queues the request. As discu=
ssed above
>> this issue was observed in streaming protocol , which  is very much fast=
er than
>normal
>> BOT modes and it works on super speed .
>
>Although USB mass storage is currently the only user of the stream
>protocol, that may not be true in the future.  You should think in more
>general terms.  A timeout which is appropriate for mass storage may not
>be appropriate for some other application.
>

You are correct , this timeout may not be ideal. Since  I was not able to r=
eproduce this issue
on non-stream capable transfers , at  present the only user of usb_ep_queue=
_timeout() API
is the streaming gadget.  As we are not aware of the optimal timeout value,=
  instead of
hardcoding the timeout value we can add module_param() for it.  So that the=
 user can configure
timeout based on their use case. Please let me know your suggestion on this=
.

Thanks,
Anurag Kumar Vulisha=20

>>  More over the gadget controller decides
>> the selection of the stream id on which the host should work , so taking=
 all these
>into
>> consideration I kept 50ms timeout for stream transfers, so that the perf=
ormance
>may
>> not get decreased.
>>
>> Thanks,
>> Anurag Kumar Vulisha

