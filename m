Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267A42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r+y9wpEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267A42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLCQIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:08:36 -0500
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:19293
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbeLCQIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v43zDua4GLq9c6JErXxEgUi3BCZ6ChilDJIIPazEdNU=;
 b=r+y9wpEGlpOO6KZYHRcd5hMZEWAsfP5Q3oQlqknetRFYzXhzmdozJIkq1SWT6FX6w2PqWCBaQVhDBmuBPy5YiBwU7qKLy3LGWJCYBZyK9GR7ETct4VzoTiF8n+enS9W4vrEXU3X9eODj0xm62J/CmXK5UT4p3kCfz8lFCMNaAkw=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4788.namprd02.prod.outlook.com (20.177.144.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Mon, 3 Dec 2018 16:05:25 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 16:05:25 +0000
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+A
Date:   Mon, 3 Dec 2018 16:05:24 +0000
Message-ID: <BL0PR02MB563382F544FBEA926452DCF1A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <BL0PR02MB563334585C8E1EEFF91EAA39A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
 <Pine.LNX.4.44L0.1812030945440.21114-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812030945440.21114-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4788;6:YPCtVN7guMDf3Rd3Mi88YYrLUsqusxPwC8QAtHwLkuNLUf9QKTkh+7dRGh7nA9aSiLibGNxcOUbAg85uXpxDPDo0vKwz/Fla29m2q7fcEkUOqaIyE23kmXezAipyFdve5qnCse2r4tyjbHODrOR9/W5maEdZwqs+RNNoJwhg583yMH37mwGzCZ7u3CgCSXTsRXhTyG+19FOgrh88wa8UeTncb+Y5wnIUJsEeaHVh8/084n+unFF2gXQM9rAFdHDAeWl7FIjThgydfUfCkJ+Vj83XIZAcd8p8h/CTr+QVieLSkhND/VXmDZePJ+lz0lDrgHKS/pHKvTaYDjIexWb6kKwNa10cqoN2Hi1K3opMKfE+4DDYmax83SYptkqlq0qfgbFT+loi36y2XAXtNSSDd5TqI+fMh2Kr775fZCufIm2+Ulkg00NWCsxUT1FeFhp779K7d2rdPoEWQEtQmii5vQ==;5:6NCRO8PtOThxwZfXRh9t1QhJxGwpxWUBaemXYpdsZcHZkxJ2HD7zA6Qz7lS21RtA/tbhbcCRQjPBZ9Ax44Z6dgktB5q5Lia+1PuKBBqubN6ewDx9Z0W4+oPqvZMaKuJTdCYcs1wTys/WSL/EO+zlP4ABd1XdeIiJE+/xvKTvwdI=;7:dC0HipeiC7AiAUMPBZ/qgFYGNaKS6wlPOhYtKW9l58ygjPUDPaFj/RrO1d7LmkjEbOcNcAADKslg+QfetpVrr+gxBXnRJTDB5D89LpRiehJQ2ZnTMn+u35gbYBD1HgBeJoB/yNNaQE7cQBzjD/CWLQ==
x-ms-office365-filtering-correlation-id: e2a7c5fe-b12f-4acd-ec45-08d6593922bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4788;
x-ms-traffictypediagnostic: BL0PR02MB4788:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB478830B2A8E0E6126A0C92FCA7AE0@BL0PR02MB4788.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4788;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4788;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(13464003)(99286004)(551934003)(105586002)(26005)(106356001)(8936002)(14444005)(81166006)(81156014)(8676002)(55016002)(486006)(476003)(4326008)(53936002)(33656002)(102836004)(186003)(66066001)(97736004)(9686003)(256004)(2906002)(11346002)(446003)(229853002)(71190400001)(71200400001)(478600001)(316002)(3846002)(86362001)(54906003)(14454004)(6436002)(107886003)(2171002)(6116002)(7416002)(7736002)(305945005)(6506007)(76176011)(68736007)(6246003)(74316002)(25786009)(5660300001)(6916009)(39060400002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4788;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AFHIYrmnnmIfeG/52MQHLSd1iFpSclLDvVTd5vIw8AnxjZ8t844I2MAMe0k8kGMeUH12kzWp/Ots2OwPSn7pDu1qop4UVgnRiyNDckbXHiT1DmcQQbGmV4QcnsaqRrwKSkQ0sRNjNfbfRAcujxQ6oTFNFXPlByBxw2OHMjwPTOT7E2RXdkL5e6A4bKG+NP6CV4sgFAj59v2SZ3Yn6U+kPdAJNKEgtAgS/tYlEEtPEDr7nrcrWXu1xBjL5WncbtyJ3bBPHywCZZoH/2eOR+0+09gZdxgegsmH4PnzF+WsjDiNpRFtPIbN8G6fo3A9+hh0ymElwzR9/eqRlhm9xRSm8CRoUPa1Ov2sBLuXCrmGnSQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a7c5fe-b12f-4acd-ec45-08d6593922bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 16:05:24.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Monday, December 03, 2018 8:21 PM
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
>> >First of all, if some sort of deadlock causes a transfer to fail to
>> >complete, the host is expected to cancel and restart it.  Not the
>> >gadget.
>> >
>>
>> Thanks for spending your time in reviewing this patch.  The deadlock
>> is  a very rare case scenario and is happening because both the gadget
>> controller & host controllers get out of sync and are stuck waiting for =
the
>> relevant event. For example this issue is observed in stream protocol wh=
ere
>> the gadget controller is waiting on Host controller to issue PRIME trans=
action
>> and  Host controller is waiting on gadget to issue ERDY transaction. Sin=
ce
>> the stream protocol is gadget driven, the host may not proceed further u=
ntil it
>> receives a valid Start Stream (ERDY) transaction from gadget.
>
>That's not entirely true.  Can't the host cancel the transfer and then
>restart it?
>

Yes the host can cancel the transfer. This issue originated from the endpoi=
nts using bulk
streaming protocol and may not occur with normal endpoints. AFAIK bulk stre=
aming is
gadget driven, where the gadget is allowed to select which stream id transf=
er the host
should work on . Since the host doesn't have control on when the transfer w=
ould be
selected by gadget, it may wait for longer timeouts before cancelling the t=
ransfer.=20

>> Since the gadget
>> controller driver is aware that the controller is stuck , makes it respo=
nsible
>> to recover the controller from hang condition by restarting the transfer=
 (which
>> triggers the controller FSM to issue ERDY to host).
>
>Isn't there a cleaner way to recover than by cancelling the request and
>resubmitting it?
>

dequeuing the request issues the stop transfer command to the controller, w=
hich
cleans all the hardware resource allocated for that endpoint. This also res=
ets the
hardware FSMs for that endpoint . So, when re-queuing of the transfer happe=
ns
the controller starts allocating hardware resources again, thus avoiding th=
e probability
of entering into the issue. I am not sure of other controllers, but for dwc=
3, issuing
the stop transfer is the only way to handle this issue.=20

@Felipe:  Can you please provide your suggestion on this. =20
 =20
>> >Second, if a request timer expires and the request is cancelled, the
>> >gadget driver's completion handler will be called.  This is not what
>> >you want if the UDC core is going to resubmit the request
>> >automatically.
>> >
>> >Third, if a request timer expires and the timer handler calls
>> >usb_ep_dequeue() followed immediately by usb_ep_queue_timeout(), the
>> >resubmit will probably fail because the dequeue won't have completed
>> >yet.
>> >
>> >Fourth, the patch contains a race between the timer expiring and the
>> >request completing.
>>
>> Thanks for correcting, I agree with you on all the above 3 cases that th=
e
>> resubmission of the request should only be done from the class driver an=
d
>> the udc core should simply dequeue the request on timeout. I am not sure
>> why I haven't seen any issue while testing on this patch series. I will =
modify
>> the code to handle the resubmitting of requests properly.
>
>How can the gadget driver know what timeout to use?  The host is
>allowed to be as slow as it wants; the gadget driver doesn't have any
>way to tell when the host wants to start the transfer.

Yes , I agree with you that the timeout may vary from usage to usage. This =
timeout
should be decided by the class driver which queues the request. As discusse=
d above
this issue was observed in streaming protocol , which  is very much faster =
than normal
BOT modes and it works on super speed .  More over the gadget controller de=
cides
the selection of the stream id on which the host should work , so taking al=
l these into
consideration I kept 50ms timeout for stream transfers, so that the perform=
ance may
not get decreased.

Thanks,
Anurag Kumar Vulisha
