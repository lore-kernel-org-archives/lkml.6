Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AE7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3bqZnjWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AE7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeLEPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:43:54 -0500
Received: from mail-eopbgr710072.outbound.protection.outlook.com ([40.107.71.72]:48148
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbeLEPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxMeLJR5LzGWLz8rrBLP77nwhnHGFekipOEiqP2SHYs=;
 b=3bqZnjWlhQK1BWLMDSd810wcxuSiOGW6nMW7E+VJr9ddc3DMAEbQDlD3fUK5auXD+6zylpZhzuAL7wqWg0enlWbG2EE8OxhRt9y5hN63k5BJRXN6Xmph+dYnni+fuKFukVh1d62y1Y+M86InQflNPCnfozPg/5FmUOxumq8aJOc=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4276.namprd02.prod.outlook.com (10.167.172.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 15:43:42 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 15:43:42 +0000
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
Thread-Index: AQHUiWbrxVzoMt2EkU67+RgGKmmQY6Vrp4EAgAEXBVCAAF3jgIAAAp+AgACIUoCAAM7bwIAAWNWAgAAcRaCAABENAIABKdpQ
Date:   Wed, 5 Dec 2018 15:43:41 +0000
Message-ID: <BL0PR02MB563386B88BDC306AF44EE736A7A80@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <SN6PR02MB56484B8D1F891926DA7D7900A7AF0@SN6PR02MB5648.namprd02.prod.outlook.com>
 <Pine.LNX.4.44L0.1812041420200.1537-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812041420200.1537-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4276;6:q8z1nZ8PDsKXSuJCV6mRTC/dzV1UP+hrtxKPsU/jxBffHa3fNGr72OgnPduV9PCn2d80vmXP0emJMX2DD18TIcBUT6hobDrTa9d1ZpzYlq+PhMhESdHbIgh2UqP0O/4FbMf1NV0O9p8eEE2jTde2icJ7mTBBZ/mPZWaDYK1n/kGpgl/IDrWuvcFUd7AhYPgKLP3GZvMFVtHprNt5fsxCuCNYKniHx2DK9JJ2i/45w0bw/K5F1r+/z7cQJJjnb68D+gEp+JvVwcvatwlJiHVqyVglF/NpNlUlVs9j8Wq3a1jQCCAr3OZsRpfd/iap7UYeOiQKsF6JU6DMCHx+deT1onDVeifYNTVDTLM1aWrHL8IpUsLk/sdd3CcsUxO7F+HYKv3zK4bwV0vKpursv9HK7AWAOqFNqYobyV26x2454jPNoBFQoGeJELH4II79nkXK9CvGQJPKiMRB2M/qHqqrdg==;5:5nnAd8GOo+qxj33oyi1PmY9uWWadfiJIHWESA+4wyuTDTjo8HPIBuwfD3ubMIKoMf9jZNQP/3CbMuY39J3uKMJObFdA4xU2MQyCuXHUJDIvUTtsFH4UcKpwodIkVhg0eLWMPGJvqm7vr2OnreNO5akGwpN4Ay+65Zz/40QVMyIs=;7:im1nC5Rv+DF9ZNn/OHq+cX3xK1XHTlaxyLgseNPBkSifoN2sxN4o0YygHcbEUd5ViV1wf1XyUm65lBIYon4hiPO0XT/yuL96RGE4afnSbDPhXGuH6adK+0FASiSLZXo6ZfYiiwYc93PQfT/Rpm5HPw==
x-ms-office365-filtering-correlation-id: 670710c9-b766-4ed1-f107-08d65ac86ef2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4276;
x-ms-traffictypediagnostic: BL0PR02MB4276:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB42769DF4F21774263C216B84A7A80@BL0PR02MB4276.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4276;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4276;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(13464003)(189003)(199004)(55016002)(4326008)(2171002)(53936002)(66066001)(6116002)(446003)(3846002)(107886003)(9686003)(6306002)(6246003)(316002)(11346002)(39060400002)(5660300001)(74316002)(8676002)(105586002)(54906003)(6436002)(26005)(102836004)(305945005)(7736002)(99286004)(186003)(76176011)(2906002)(7696005)(106356001)(6506007)(7416002)(81156014)(8936002)(6916009)(229853002)(81166006)(33656002)(25786009)(486006)(966005)(256004)(71200400001)(14454004)(97736004)(478600001)(86362001)(68736007)(476003)(14444005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4276;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XWg10WdC8fp+bpG4V6z22Zw/HQrNPR/EWcRMWBdE81BDkNwTE4T7Ax9WrPv61zdrfMfDJqfwvSz7JZEeTVWAo06bpXLj4FgL5uNmZLihhN/pLojM71TfQArppuo/dQplO8TUFpwRYPLgom7tcOBg9BjnOJQq2+w7+c1lcuoi6qn/zQYax0TzSV/8WfciyFuemO4Q518SrileoqIL6EC8Okad6xlFsCUowyFDpj6rumh8i3vOFTN6QP8xgE1PHl0FA3auJ7Odlvp2h34Ofsf97wTgzInVENw2E3GbLWzVJCyrJwiV1F1pTppjY6dQXIKH5BLtG5PIqRDfzHjpn1aYBgeYsysdluzP07G3fBQmjJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670710c9-b766-4ed1-f107-08d65ac86ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 15:43:41.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern@rowland.harvard.edu]
>Sent: Wednesday, December 05, 2018 12:59 AM
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
>> >Is there any way for the device controller driver to detect the problem=
 without
>relying
>> >on a timeout?
>> >
>> >In fact, is this problem a known bug in the existing device controller =
hardware?
>Have
>> >the controller manufacturers published a suggested scheme for working a=
round it?
>> >
>>
>> Yes, this problem is mentioned in dwc3 controller data book and the work=
around
>> mentioned  is the same that we are doing , to implement timeout and if n=
o valid
>> stream event is found , after timeout issue end transfer followed by sta=
rt transfer.
>
>Okay.  But this implies that the problem is confined to DWC3 and
>doesn't affect other types of controllers, which would mean modifying
>the UDC core would be inappropriate.
>

Both host & gadget are equally responsible for this issue and it may potent=
ially occur
with other controllers also(which are incapable of handling this situation)=
 . Because of
this reason I would not call this issue as a dwc3 alone bug. One thing is t=
hat, with dwc3 the
issue is easily reproduced. Because of these reasons I feel that it would b=
e better to have
a generic udc timers rather than having driver specific workaround. We had =
this same
discussion earlier in this mailing list https://lkml.org/lkml/2018/10/9/638

>Does the data book suggest a value for the timeout?
>

No, the databook doesn't mention about the timeout value

>> >At this point, it seems that the generic approach will be messier than =
having every
>> >controller driver implement its own fix.  At least, that's how it appea=
rs to me.
>
>(Especially if dwc3 is the only driver affected.)
>

As discussed above, the issue may happen with other gadgets too. As I got d=
ivide opinions
on this implementation and both the implementations looks fine to me, I am =
little confused
on which should be implemented.

@Felipe: Do you agree with Alan's implementation? Please let us know your s=
uggestion
on this.

>> With the dequeue approach there is an advantage(not related to this issu=
e) that the
>> class driver can have control of the timed out transfer whether to reque=
ue it or
>consider
>> it as an error (based on implementation). This approach gives more flexi=
bility to the
>class
>> drivers. This may be out of context of this issue but wanted to point ou=
t that we
>may lose
>> this advantage on switching to older implementation.
>
>Class drivers can cancel and requeue requests at any time.  There's no
>extra flexibility.
>

I agree with you, but the class drivers have to implement their own logic i=
nstead of
having a generic logic to implement the timeouts.=20

>> >Ideally it would not be necessary to rely on a timeout at all.
>> >
>> >Also, maintainers dislike module parameters.  It would be better not to=
 add one.
>>
>> Okay. I would be happy if any alternative for this issue is present but =
unfortunately
>> I am not able to figure out any alternative other than timers. If not
>module_params()
>> we can add an configfs entry in stream gadget to update the timeout. Ple=
ase
>provide
>> your opinion on this approach.
>
>Since the purpose of the timeout is to detect a deadlock caused by a
>hardware bug, I suggest a fixed and relatively short timeout value such
>as one second.  Cancelling and requeuing a few requests at 1-second
>intervals shouldn't add very much overhead.
>

Thanks for suggesting. 1 sec timeout should be fair enough. I will change t=
his
in next series=20

Best Regards,
Anurag Kumar Vulisha

