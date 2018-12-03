Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E446EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C3E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AzfV/C30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C3E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLCKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:23:54 -0500
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:63118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbeLCKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tAKTXyQdwBbq1T01prcANl2VQZN/oeZtd43wFRegrg=;
 b=AzfV/C303dhvn7qfqwougIqmc1WrN2x4Bu1FAVmKG3ZGfSGRcznwAuvOseykPogq+LVpLuQXcTJfIDvsaaTJIs7lrTeW4GdtZBtvm+j728sNoLq8vsWonNMjmdvsneBucHt5nSkeaDQteTuRRJbi4a8ThrWIFsDYVzwq7UNcWf4=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4563.namprd02.prod.outlook.com (10.167.181.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 10:23:19 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 10:23:19 +0000
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVA=
Date:   Mon, 3 Dec 2018 10:23:19 +0000
Message-ID: <BL0PR02MB563334585C8E1EEFF91EAA39A7AE0@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <Pine.LNX.4.44L0.1812021128460.17451-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812021128460.17451-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4563;6:BxDzqqn2w6ZD7AuGhWj93ATP2dgl6jeYNjYZRI+wQqwBYV//hzWVhplfc+rBm/aWs1HseqQlPDZCPbwSVMxkOWGrIWorOTB86SC3FBthpUZQ89J9jCsw7CekE+P1A8l9LeQkr9nzFZWUNBegZSkkTcBzTCfWOrbi7iq3Kac00Pk2/CZy0lUhfTrH/PgPwNBo5F+tY+lEPNVRvKznsFHLW6anIkdM6KZfM2yDCr+SNgAlJxKxws7KRoUTOI6brOe+mrvXk/HOjhbAKqNHQn+SamIt1FHY6fDaL9FXnxUzwh/bupfRjh72lWW7+jp2+aUG68X1kVPHqvGSjKma7nnjTOtLq5SaCl/OKVvk3HM5nBZCuqxh26dtflckYST4MFxmN690iztWm93oXQluVaBCkisLj8FGqiuHsJtC6prmoWwmhIYwhCmWEcvgTjFxwdPztX+2eqiXDhW0a1GI+ijSqQ==;5:StEG3O85k482tbkm5odoXOItoVzh+/71KJxmjFzjS+gdz2dQDdJLEeB0BuzCBcjjWVa8CyMdMfVhNT0p0hQsQblK2pzLl2agH6WcRe6uqH6zFRJdsya04xknDb4RJgHjHRzVjsgL1jeKxO+O+oTh6Ho0r1CaOqhumLg1L258Fpk=;7:bsSNHog44v+uGKM8BXTeoX+4pG3lT/kRrfwZuQZJH4nw5WimFjHCtOwbGV6ktbTqmPoNJ5WEvH2ir8kMPpgBJVhHbCD0IP0Ml/hlwXei3NUu5W3czzukgXHCT+zb9OTFnw08SoFPKVtvRUDKVxXgRA==
x-ms-office365-filtering-correlation-id: edfd4391-ef21-48aa-7d4a-08d659095899
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4563;
x-ms-traffictypediagnostic: BL0PR02MB4563:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB45637FE3D9F425EB30E8F65CA7AE0@BL0PR02MB4563.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4563;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4563;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(13464003)(11346002)(26005)(99286004)(76176011)(106356001)(7416002)(7696005)(74316002)(316002)(71190400001)(53936002)(71200400001)(9686003)(55016002)(8936002)(8676002)(6916009)(81156014)(81166006)(305945005)(256004)(7736002)(229853002)(25786009)(551934003)(6116002)(33656002)(14444005)(5660300001)(6436002)(68736007)(3846002)(478600001)(14454004)(102836004)(54906003)(476003)(4326008)(39060400002)(186003)(66066001)(6506007)(105586002)(2171002)(6246003)(107886003)(446003)(2906002)(486006)(97736004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4563;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0FaQ4PPlJ6S3uYU3rpVWfjHG+k639GaXgoszi9co6X3VQC91vWYzlmj1Ek6VEqGUBKaeGv2NsTmPvruaCV0cgJ9TY7MYfrKiVX+lTqkoKuG0E6EmPVACGLVo+IumuXlEr6D8HG/8ClOJtmPTJ3GL+d7np6+49Gsi/X8sortL74oC14tB1nTNAW/7HexzK1RyWM08GaR3h61qjUEazMieHADMKKZ6dRu9L3D4NpnJw2/fevgkZRwMki+HRJEvuli/JWo9NX6ibskXKyOfxFmbQvb1kvn1QAcMiBPaM8ZO20guCqjisR1GEkqV22gdqOUf0TUtIm3FinF1ABpvLKZPGZnno8/092CT76p8QFwSvl8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd4391-ef21-48aa-7d4a-08d659095899
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 10:23:19.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Sunday, December 02, 2018 10:06 PM
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
>Subject: Re: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb =
requests
>
>On Sat, 1 Dec 2018, Anurag Kumar Vulisha wrote:
>
>> In some corner cases the gadget controller may get out of sync
>> with host and may get into hang state, thus creating a dealock.
>> For example when bulk streams are enabled for an endpoint, there
>> can be a condition where the gadget controller waits for the host
>> to issue prime transaction and the host controller waits for the
>> gadget to issue ERDY. This condition could create a deadlock.
>>
>> To avoid such potential deadlocks, a timer is started after queuing
>> any request for the endpoint in usb_ep_queue(). The gadget driver
>> is expected to stop the timer if a valid event is found (ex: stream
>> event for stream capable endpoints). If no valid event is found, the
>> timer expires after the programmed timeout value and a timeout
>> callback function registered would be called. This callback function
>> dequeues the request and re-queues it again, doing so makes the
>> controller restart the transfer, thus avoiding deadlocks.
>>
>> This kind of behaviour is observed in dwc3 controller and expected
>> to be generic issue with other controllers supporting bulk streams.
>
>I find this whole approach rather dubious.
>
>First of all, if some sort of deadlock causes a transfer to fail to
>complete, the host is expected to cancel and restart it.  Not the
>gadget.
>

Thanks for spending your time in reviewing this patch.  The deadlock
is  a very rare case scenario and is happening because both the gadget
controller & host controllers get out of sync and are stuck waiting for the
relevant event. For example this issue is observed in stream protocol where
the gadget controller is waiting on Host controller to issue PRIME transact=
ion
and  Host controller is waiting on gadget to issue ERDY transaction. Since
the stream protocol is gadget driven, the host may not proceed further unti=
l it
receives a valid Start Stream (ERDY) transaction from gadget. Since the gad=
get
controller driver is aware that the controller is stuck , makes it responsi=
ble
to recover the controller from hang condition by restarting the transfer (w=
hich
triggers the controller FSM to issue ERDY to host).

>Second, if a request timer expires and the request is cancelled, the
>gadget driver's completion handler will be called.  This is not what
>you want if the UDC core is going to resubmit the request
>automatically.
>
>Third, if a request timer expires and the timer handler calls
>usb_ep_dequeue() followed immediately by usb_ep_queue_timeout(), the
>resubmit will probably fail because the dequeue won't have completed
>yet.
>
>Fourth, the patch contains a race between the timer expiring and the
>request completing.

Thanks for correcting, I agree with you on all the above 3 cases that the
resubmission of the request should only be done from the class driver and=20
the udc core should simply dequeue the request on timeout. I am not sure
why I haven't seen any issue while testing on this patch series. I will mod=
ify
the code to handle the resubmitting of requests properly.

Best Regards,
Anurag Kumar Vulisha


