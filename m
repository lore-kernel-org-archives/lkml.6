Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E420AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A029321104
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fY2FmnHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A029321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeLLPOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:14:23 -0500
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:13111
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbeLLPOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7TLoZK68LoPHStpz9M0Z58wpdGRiiZZaU24Ysr3j8=;
 b=fY2FmnHqqbhxvdxbzulLcE4TylixV5pe4RuHSb4Wm8e/a2+Mhoqc8j9ecagavrqFJfC1gDodT/lCsOkNsYFTCEln65+sVkXZ6uGR+tNqWj0/13p5Yw8n+Qa5/P27eWuKgYU300aNqb/LrXPmonf9CtyKyB7C+CNbA3MG2rMBcRI=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB3828.namprd02.prod.outlook.com (52.132.9.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 15:11:25 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 15:11:25 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+AgACIUoCAAM7bwIAAWNWAgAAcRaCAABENAIABKdpQgAKsvYCAALl8AIAHtE1w
Date:   Wed, 12 Dec 2018 15:11:24 +0000
Message-ID: <BL0PR02MB5633B3B0A2BEC1272C0C8705A7A70@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <877eglx45o.fsf@linux.intel.com>
 <Pine.LNX.4.44L0.1812071158570.1560-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812071158570.1560-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB3828;6:Cc1dmIyQZ1bPX0pm+x+lBX46n8IhL15UYOkctokEdjUMm9HRdTXxtlkxUGaM6PlwIQyy1Upc4xGeFDLqCZ05SjJ59RakygyglWlbvOmzTZejO3fGrMTQrBeKvVEdeDjKmwDM6OgDVy6YMBbIM3/DIl25k14huxP3XowgXCH/kIWr5I7I2Liqw2hiQr7lVkxoxq/MPlNX6ub94FEeGmTYDMpN0dJnCn5nPy7GatlJ0M6ItPP6pbPtzE+kKYHH7CN7TMz6xJ+/DqTd+74xSabH2IJAQvpCqcyHICaWQXMb7Gl/YBKgNOYEbOdiN8fX0CO1fJJkPKbJ8mnLyMMN7EfDJH/3iUCIPV9TmjEbh98//P9qVhanu/BN7XhBIGJg0JMh4LMbS4uzG3Il9RZ3qcx2y064sPbl9a7qbIyuhM9twoD9gRJLRkN6jD/ljcq6F+2q/nSzI47i3lZwxgIdv/T4FQ==;5:vPP6TdFkKuW6tIaxFCiQ7K5FgVD4vVzufVAQ4j9b1jnNdkCqezcjecJMFjb2Ng1tp64OPW8n6d1q/nR3HR8k4K/SVssjONJBu9aA9P5dVipHgXWM7QHnRWnFal0fepw3kn5bWTlvFhBdtNW1p4XKKg/8oXN3M1wxtEgXmZ6Dzu0=;7:/RYeAyok/FTUWe1aOpxhGYycbhfOpva13O+grzB3lwubOQJupQYc55BX2IzvRyJSsb9g8oGdqz22korwsbTbEDqP1Q/Tbl5ATxe3FwDJ1D4Qw/SUaiR3kfUcc+9RR8GwWa36uAhrFjZcl5J1/G6r2w==
x-ms-office365-filtering-correlation-id: 23316872-1979-4e36-c090-08d660441549
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3828;
x-ms-traffictypediagnostic: BL0PR02MB3828:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB3828FCFA77ED5B24D7FF8BFBA7A70@BL0PR02MB3828.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB3828;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3828;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(52314003)(189003)(199004)(13464003)(33656002)(25786009)(3846002)(6116002)(446003)(55016002)(86362001)(71190400001)(71200400001)(486006)(11346002)(476003)(2906002)(7696005)(102836004)(6506007)(76176011)(256004)(186003)(14454004)(14444005)(26005)(54906003)(110136005)(99286004)(478600001)(7736002)(106356001)(105586002)(316002)(7416002)(107886003)(68736007)(6246003)(2171002)(74316002)(305945005)(66066001)(4326008)(39060400002)(97736004)(81166006)(81156014)(8936002)(8676002)(6436002)(53936002)(229853002)(9686003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3828;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0MbQKddhqITTP+qDPv+iINQey36dbyJ19KtNIUmy7kNsmfvpSpXzUfUrzFcnJb+4t3tMan31CWfhtVbLWFCiqO0pB9WEG43TP+wtgXzjPPmnjRX3cDgql3e32sz3SOmRIip1IHOQHJy8RKrFhwmlSx59gkw4/ZDx58/U3NmDhIi9MEUGqGd9w/MkEaQF8BXTmUlaqcLpJ3Yt/8b8zWiD4uDTXgBvMIa9cuMx/4lAm/GSgusu0ONoSnnbXdC5Vt+FYRaeG8I5vQsNW5bAloJBk9JlC7sAMz2Ob63TG2J/FT99Ov23agZuPuAFwDaR34X+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23316872-1979-4e36-c090-08d660441549
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 15:11:24.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3828
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Friday, December 07, 2018 10:40 PM
>To: Felipe Balbi <balbi@kernel.org>
>Cc: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
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
>On Fri, 7 Dec 2018, Felipe Balbi wrote:
>
>>
>> hi,
>>
>> Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>> >>Does the data book suggest a value for the timeout?
>> >>
>> >
>> > No, the databook doesn't mention about the timeout value
>> >
>> >>> >At this point, it seems that the generic approach will be messier t=
han having
>every
>> >>> >controller driver implement its own fix.  At least, that's how it a=
ppears to me.
>>
>> Why, if the UDC implementation will, anyway, be a timer?
>
>It's mostly a question of what happens when the timer expires.  (After
>all, starting a timer is just as easy to do in a UDC driver as it is in
>the core.)  When the timer expires, what can the core do?
>
>Don't say it can cancel the offending request and resubmit it.  That
>leads to the sort of trouble we discussed earlier in this thread.  In
>particular, we don't want the class driver's completion routine to be
>called when the cancel occurs.  Furthermore, this leads to a race:
>Suppose the class driver decides to cancel the request at the same time
>as the core does a cancel and resubmit.  Then the class driver's cancel
>could get lost and the request would remain on the UDC's queue.
>
>What you really want to do is issue the appropriate stop and restart
>commands to the hardware, while leaving the request logically active
>the entire time.  The UDC core can't do this, but a UDC driver can.
>

I agree with Alan's comment as it looks like there may be some corner cases
where the issue may occur with dequeue approach. Are you okay if the timeou=
t
handler gets moved to the dwc3 driver (the timers still added into udc laye=
r)?=20
Please let us know your suggestion on this

Thanks,
Anurag Kumar Vulisha

>> >>(Especially if dwc3 is the only driver affected.)
>> >
>> > As discussed above, the issue may happen with other gadgets too. As I =
got divide
>opinions
>> > on this implementation and both the implementations looks fine to me, =
I am little
>confused
>> > on which should be implemented.
>> >
>> > @Felipe: Do you agree with Alan's implementation? Please let us know y=
our
>suggestion
>> > on this.
>>
>> I still think a generic timer is a better solution since it has other us=
es.
>
>Putting a struct timer into struct usb_request is okay with me, but I
>wouldn't go any farther than that.
>
>> >>Since the purpose of the timeout is to detect a deadlock caused by a
>> >>hardware bug, I suggest a fixed and relatively short timeout value suc=
h
>> >>as one second.  Cancelling and requeuing a few requests at 1-second
>> >>intervals shouldn't add very much overhead.
>>
>> I wouldn't call this a HW bug though. This is just how the UDC
>> behaves. There are N streams and host can move data in any stream at any
>> time. This means that host & gadget _can_ disagree on what stream to
>> start next.
>
>But the USB 3 spec says what should happen when the host and gadget
>disagree in this way, doesn't it?  And it doesn't say that they should
>deadlock.  :-)  Or have I misread the spec?
>
>> One way to avoid this would be to never pre-start any streams and always
>> rely on XferNotReady, but that would mean greatly reduced throughput for
>> streams.
>
>It would be good if there was some way to actively detect the problem
>instead of passively waiting for a timer to expire.
>
>Alan Stern

