Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G+P/sjf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfADOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:18:05 -0500
Received: from mail-eopbgr780052.outbound.protection.outlook.com ([40.107.78.52]:62073
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfADOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56ftSgZHMMz31aWNVrghKEmFBWpnZRBx1tF43YOnxkU=;
 b=G+P/sjf2+FyVsX9GsoJJInnlG8jnsdcxd1v62ai+ZBslaipfsL8lPIriI5WoREOMUJfLS1r4Ql3+wzQdoJFmROgV/HAZRysWS4ym2SbEfj8LcuW2rPiP7aVaDV3FpMKgBgA6jRKTV8YIsIPK02yOXBaXHe3yw/z+kPaWKd9Lfvs=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB5032.namprd02.prod.outlook.com (20.176.253.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 4 Jan 2019 14:17:57 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 14:17:57 +0000
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+AgACIUoCAAM7bwIAAWNWAgAAcRaCAABENAIABKdpQgAKsvYCAALl8AIAHtE1wgCQcExA=
Date:   Fri, 4 Jan 2019 14:17:56 +0000
Message-ID: <BYAPR02MB5591FB3CC4F14CAB3CE4204CA78E0@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <877eglx45o.fsf@linux.intel.com>
 <Pine.LNX.4.44L0.1812071158570.1560-100000@iolanthe.rowland.org> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5032;6:c/kSxGNb6TcRrwkJuyk8eq1BVOtgr2tCJ4zKDHwSZbET+BQ0xOqngrHK1Re8zzjcADIxNk8ESYCrnp+a25JXBjGqpfNERxqqM3goi9YyLpJVYo39QUXLfPvemkyntwcvUhphduRyP0KKtYRWAsK2z3/frM8i3XHNlAMVlsr0mS1omAKaPixLz3eENOPBE3KFZMNeT2qsR2CU84TwI4EubXBvYowTen/Hy9kOeNlRqxEWiukg01QxsZApWpGnrYgy0gUsJ/E9OtOMfHSydj+sUjpQRyKgA0jXXCXpjH1EnqBgCs2QxLeREQZAbAybsoW671Rce247dXJL4v00uRurlTkzCmpmqq5xbqEUhjg7hBuVxezzIVoB+ImAqrLZHoqyfzYf3Sr2QofQwsXzwySx+jObpoghKoZKYEF5xeKW5a7hEB7ONidLwC+E7FXGVg9qWp4W+0NEtctR1ZzumdCVsw==;5:ZjDUbxshLzaG6/hz6qM0s2zxk1chIjkx2x0iYSykYc1GPqL+Wxk/xZ9LNWAPadvKASTzMsw+ZNU1TsoArQF85d8RVKYa/SLzYmFjPK+QFbEzC/WWhTDrtKrOLos8kqZej8ixLSRh0Cz8Dm7456zgmRJlZwGP/tipqPL2b1kwZRRiYpJHURyRIMQDx5t2pIRYUFJFOQv6p15dJG9PHosAjQ==;7:pCkLBZJk/MHAHGnXIJqidegfhjlHZrIPhr8Ps5uY1TO3bMw0S5r9T3j3kDhiqZVIH8h3amDV2ADd8nXAPbyFC9S5Ky1aCbQVMtTZ6Bsuq+6RHRyZp6o+hSo4JOvwAHBUsh6R3W7grSrcrwK4OHQShg==
x-ms-office365-filtering-correlation-id: c324f894-1bdd-4a5c-afd4-08d6724f6cd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5032;
x-ms-traffictypediagnostic: BYAPR02MB5032:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5032CD9F81CE66812A8E3D6EA78E0@BYAPR02MB5032.namprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB5032;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5032;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(52314003)(189003)(13464003)(305945005)(26005)(316002)(106356001)(7736002)(8676002)(54906003)(68736007)(81166006)(110136005)(81156014)(105586002)(74316002)(102836004)(186003)(486006)(2171002)(97736004)(6246003)(478600001)(107886003)(39060400002)(9686003)(53936002)(6436002)(55016002)(25786009)(99286004)(6506007)(7696005)(76176011)(4326008)(6116002)(3846002)(7416002)(2906002)(71200400001)(8936002)(14454004)(71190400001)(66066001)(33656002)(86362001)(256004)(446003)(14444005)(5660300001)(229853002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5032;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0cuOrVYwnbI1QXMHe05jT//hqiIT1NREEuNsqvRlwB9ViB6S5VlQhwJnXwrEYngUYXTOnVCzKEamK0SI4t3LUr3nMd7eSfw4CdiJur83IEfOQ+5+TjWixqB+al5bzklkU7FfFSx3cIJZ8E1LO85CIVfiSR9zJxAV6O9oTgCPxFZ36f15BojDBcgJk+AEI9aEJWbHwOY1iT7DeWcGdGJUEj7RaNyJrglbwvC3744VTUKb7zEnwzQeLIxdbdKmhtXkXXprf2dwHvVYLxoP13RmJzBdUE9z5mpYBDXKcxgWG2uBLBC8AiImXS6lGFyDr7ws
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c324f894-1bdd-4a5c-afd4-08d6724f6cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 14:17:57.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Resending...

Since I am waiting on your suggestion,  thought of giving remainder.
=20
Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Anurag Kumar Vulisha
>Sent: Wednesday, December 12, 2018 8:41 PM
>To: 'Alan Stern' <stern@rowland.harvard.edu>; Felipe Balbi <balbi@kernel.o=
rg>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Shuah Khan
><shuah@kernel.org>; Johan Hovold <johan@kernel.org>; Jaejoong Kim
><climbbb.kim@gmail.com>; Benjamin Herrenschmidt <benh@kernel.crashing.org>=
;
>Roger Quadros <rogerq@ti.com>; Manu Gautam <mgautam@codeaurora.org>;
>martin.petersen@oracle.com; Bart Van Assche <bvanassche@acm.org>; Mike
>Christie <mchristi@redhat.com>; Matthew Wilcox <willy@infradead.org>; Coli=
n Ian
>King <colin.king@canonical.com>; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; v.anuragkumar@gmail.com; Thinh Nguyen
><thinhn@synopsys.com>; Tejas Joglekar <tejas.joglekar@synopsys.com>; Ajay
>Yugalkishore Pandey <APANDEY@xilinx.com>
>Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb =
requests
>
>
>Hi Felipe,
>
>>-----Original Message-----
>>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>>Sent: Friday, December 07, 2018 10:40 PM
>>To: Felipe Balbi <balbi@kernel.org>
>>Cc: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
>><gregkh@linuxfoundation.org>; Shuah Khan <shuah@kernel.org>; Johan Hovold
>><johan@kernel.org>; Jaejoong Kim <climbbb.kim@gmail.com>; Benjamin
>>Herrenschmidt <benh@kernel.crashing.org>; Roger Quadros <rogerq@ti.com>;
>Manu
>>Gautam <mgautam@codeaurora.org>; martin.petersen@oracle.com; Bart Van
>>Assche <bvanassche@acm.org>; Mike Christie <mchristi@redhat.com>; Matthew
>>Wilcox <willy@infradead.org>; Colin Ian King <colin.king@canonical.com>; =
linux-
>>usb@vger.kernel.org; linux-kernel@vger.kernel.org; v.anuragkumar@gmail.co=
m;
>>Thinh Nguyen <thinhn@synopsys.com>; Tejas Joglekar
>><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.c=
om>
>>Subject: RE: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb=
 requests
>>
>>On Fri, 7 Dec 2018, Felipe Balbi wrote:
>>
>>>
>>> hi,
>>>
>>> Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>> >>Does the data book suggest a value for the timeout?
>>> >>
>>> >
>>> > No, the databook doesn't mention about the timeout value
>>> >
>>> >>> >At this point, it seems that the generic approach will be messier =
than having
>>every
>>> >>> >controller driver implement its own fix.  At least, that's how it =
appears to me.
>>>
>>> Why, if the UDC implementation will, anyway, be a timer?
>>
>>It's mostly a question of what happens when the timer expires.  (After
>>all, starting a timer is just as easy to do in a UDC driver as it is in
>>the core.)  When the timer expires, what can the core do?
>>
>>Don't say it can cancel the offending request and resubmit it.  That
>>leads to the sort of trouble we discussed earlier in this thread.  In
>>particular, we don't want the class driver's completion routine to be
>>called when the cancel occurs.  Furthermore, this leads to a race:
>>Suppose the class driver decides to cancel the request at the same time
>>as the core does a cancel and resubmit.  Then the class driver's cancel
>>could get lost and the request would remain on the UDC's queue.
>>
>>What you really want to do is issue the appropriate stop and restart
>>commands to the hardware, while leaving the request logically active
>>the entire time.  The UDC core can't do this, but a UDC driver can.
>>
>
>I agree with Alan's comment as it looks like there may be some corner case=
s
>where the issue may occur with dequeue approach. Are you okay if the timeo=
ut
>handler gets moved to the dwc3 driver (the timers still added into udc lay=
er)?
>Please let us know your suggestion on this
>
>Thanks,
>Anurag Kumar Vulisha
>
>>> >>(Especially if dwc3 is the only driver affected.)
>>> >
>>> > As discussed above, the issue may happen with other gadgets too. As I=
 got divide
>>opinions
>>> > on this implementation and both the implementations looks fine to me,=
 I am
>little
>>confused
>>> > on which should be implemented.
>>> >
>>> > @Felipe: Do you agree with Alan's implementation? Please let us know =
your
>>suggestion
>>> > on this.
>>>
>>> I still think a generic timer is a better solution since it has other u=
ses.
>>
>>Putting a struct timer into struct usb_request is okay with me, but I
>>wouldn't go any farther than that.
>>
>>> >>Since the purpose of the timeout is to detect a deadlock caused by a
>>> >>hardware bug, I suggest a fixed and relatively short timeout value su=
ch
>>> >>as one second.  Cancelling and requeuing a few requests at 1-second
>>> >>intervals shouldn't add very much overhead.
>>>
>>> I wouldn't call this a HW bug though. This is just how the UDC
>>> behaves. There are N streams and host can move data in any stream at an=
y
>>> time. This means that host & gadget _can_ disagree on what stream to
>>> start next.
>>
>>But the USB 3 spec says what should happen when the host and gadget
>>disagree in this way, doesn't it?  And it doesn't say that they should
>>deadlock.  :-)  Or have I misread the spec?
>>
>>> One way to avoid this would be to never pre-start any streams and alway=
s
>>> rely on XferNotReady, but that would mean greatly reduced throughput fo=
r
>>> streams.
>>
>>It would be good if there was some way to actively detect the problem
>>instead of passively waiting for a timer to expire.
>>
>>Alan Stern

