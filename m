Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1E20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dWKBMB3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D1E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeK3C5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:57:46 -0500
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:50512
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728986AbeK3C5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l+J2+frWzBjx3Qm/iqA/sDsApKa2tWixbQPSP4vB3E=;
 b=dWKBMB3NfL58sGBrvSBVJ9lrlLth15YnNxAe4c+mZOl9fuqHGyVIRVn7NB4+NjaY+lh/Qy8rsjlqYPDW4pDDp8ALu+WIwaGv/JOLJ95ETLABDsx3Yvp504Rhtntc8JIfhBbHhxtminXUxL6gS3FgGGB2e/XDH64ja1v7BveTVqE=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4388.namprd02.prod.outlook.com (10.167.179.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 29 Nov 2018 15:51:48 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 15:51:48 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capable
 endpoints
Thread-Topic: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capable
 endpoints
Thread-Index: AQHUYvbRwEYgzRXr0k+ojhd/SBDozaVPfhoAgBXv3pCAAZCbAIAAMLaA
Date:   Thu, 29 Nov 2018 15:51:47 +0000
Message-ID: <BL0PR02MB563301AF77DA0EDE524F0774A7D20@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87k1lfiwx3.fsf@linux.intel.com>
 <BL0PR02MB563317DEAFAD7C06B52FC23DA7D10@BL0PR02MB5633.namprd02.prod.outlook.com>
 <87h8g0yrl7.fsf@linux.intel.com>
In-Reply-To: <87h8g0yrl7.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4388;6:9owxPUNfKYv0Bp0wGRgTY5kz4ng5scArnIUS/d7I2bJHsGIpETtc/ixqK96ZJhwYqmF1s5gKDWxQTXp7cftfJuoh5p/oQQ4amAc6WAGmMrwIu5LS8yLGEMVQTTbEpsKxVSQBJ1n9AubquLvMBMEzlyVba9O6FfchTDamDQQPAuWynkltaJkUg7iKe8wuo95pUDqA5g4M0lVT4cFFRFdQOC3j90Ya4BOriKDDPPtP01F8JZkMlObgIBTN01O+4Auyc2rPprPBQW8FZM46iAeBaBq1Nsj2Xk6YMP4Ip870NtDAhq6N8V+OIf8HRYmBdxsADbBUuEK8bsJdxa9C/g0BgrD9HIR7Sfv1xL9Xl6uak27dN9g1MrYLcWprmRpD1nJnklU3FTySAj4hZid0sgPdKpZvLvxcUHBFZ245ZF3+y1ooO/14Cv2s8xCCcP31lLPQ3MhyXhvpvlJE0x/cm6X0BQ==;5:caqaYYZUvycpET84s764Ob3pGtbTjxk+PKGotlTERGuM08FjvYOjRoFaA2GrxsyhZdmXtuaBPn42kNmzc0NcvoaCsYTp6JdpYnVxnZo7eEiqb4xeLtQ9OHI8Ziz/mbSzTWA7mTWqpVZmdGXY3rhUXGXfXo1QCfJDvaWe8gHWlPA=;7:UAyh4AWkuszV5aSwZBPxiGo+6Q3D7l8wZpKD/ZFnLbkwPoHXl6QrjNkZtyA2YFyHHgxJhMosFkQ5QYZFqgebKzbgF8rNfIFlfUqMrdGUrRY96v8SFzmbNlTwKUZ6WVqdWXD/kxrsGofvz/HGbLESsQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: dd13a72a-9a33-4d04-e489-08d656129224
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4388;
x-ms-traffictypediagnostic: BL0PR02MB4388:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB438869A07836B94401CD63B1A7D20@BL0PR02MB4388.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592)(35762410373642)(31051911155226);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4388;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4388;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(13464003)(55016002)(68736007)(26005)(74316002)(14444005)(76176011)(256004)(71200400001)(71190400001)(316002)(186003)(99286004)(53936002)(110136005)(9686003)(486006)(54906003)(478600001)(3846002)(6116002)(14454004)(33656002)(39060400002)(2906002)(7696005)(25786009)(107886003)(476003)(7416002)(105586002)(106356001)(81156014)(8676002)(5660300001)(81166006)(8936002)(7736002)(229853002)(6506007)(66066001)(93886005)(11346002)(97736004)(6436002)(86362001)(4326008)(446003)(6246003)(102836004)(305945005)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4388;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HUmEB4yiBWsu7WM4Q7OHRIOWYfmDrNFDCHZmwx7TbigjOJFpbtFXhhHiV4modwcgGr+DQAAW7txdkBL3X7fxtzbbJETJfpEbJ9S3BMNIPivyeu3PqtmtPBowGlm0aA+vhK6EihxazlzVIcpq9u+9LQH9Y17lq2hLWh1h1EoK2uBLYLNJszFqrb6Hj5ZIL/3hM+1Fis3c2ihRmvXA0mFGHK9/tCdA7AnotWFA5elvN0Wg0tdppusQq6UGB0FzZrvc950Rq+NHd9GmjVoSX6Tn0c0ORfG5nR7vGmo76tpACa548xtXQ7whpN/y3+hJHxPibh6hlkzGgFYBEeaM2YxgweaqHaF83CzN87TzuQ2YwLc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd13a72a-9a33-4d04-e489-08d656129224
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 15:51:47.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Thursday, November 29, 2018 6:22 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Alan Stern <stern@rowland.harvard.edu>; Joha=
n
>Hovold <johan@kernel.org>; Jaejoong Kim <climbbb.kim@gmail.com>; Benjamin
>Herrenschmidt <benh@kernel.crashing.org>; Roger Quadros <rogerq@ti.com>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Jogleka=
r
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>
>Subject: RE: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capab=
le
>endpoints
>
>
>Hi,
>
>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/co=
re.c
>>>> index af88b48..41cc23b 100644
>>>> --- a/drivers/usb/gadget/udc/core.c
>>>> +++ b/drivers/usb/gadget/udc/core.c
>>>> @@ -52,6 +52,24 @@ static int udc_bind_to_driver(struct usb_udc *udc,
>>>>  /* ------------------------------------------------------------------=
------- */
>>>>
>>>>  /**
>>>> + * usb_ep_stream_timeout - callback function for endpoint stream time=
out
>timer
>>>> + * @arg: pointer to struct timer_list
>>>> + *
>>>> + * This function gets called only when bulk streams are enabled in th=
e endpoint
>>>> + * and only after ep->stream_timeout_timer has expired. The timer get=
s expired
>>>> + * only when the gadget controller failed to find a valid stream even=
t for this
>>>> + * endpoint. On timer expiry, this function calls the endpoint-specif=
ic timeout
>>>> + * handler registered to endpoint ops->stream_timeout API.
>>>> + */
>>>> +static void usb_ep_stream_timeout(struct timer_list *arg)
>>>> +{
>>>> +	struct usb_ep *ep =3D from_timer(ep, arg, stream_timeout_timer);
>>>> +
>>>> +	if (ep->stream_capable && ep->ops->stream_timeout)
>>>
>>>why is the timer only for stream endpoints? What if we want to run this
>>>on non-stream capable eps?
>>>
>>
>> I have seen this issue only with stream capable eps between PRIME &
>> EPRDY. But this issue can potentially occur with non-stream endpoints
>> also. Will remove this stream capable checks in next series of patch.
>
>you're adding support for transfer timeouts, which some gadgets may want
>regardless of endpoint type. One use is to correct cases of streams
>going out of sync.
>

Thanks for making me understand, will implement your suggestions and resend
the patches soon.

Best Regards,
Anurag Kumar Vulisha
=20
>>>> +		ep->ops->stream_timeout(ep);
>>>
>>>you don't ned an extra operation here, ep_dequeue should be enough.
>>>
>>
>> I think issuing ep_dequeue() would be more trickier than calling ep->ops=
-
>>stream_timeout().
>> This is because, every gadget driver has their own way of handling ep_de=
queue.
>Some
>> drivers (like dwc3) may sleep for an event (wait_event_lock_irq) in the =
ep_dequeue
>routine.
>
>not anymore. There's, now, a requirement that ->dequeue can be called
>from any context.
>
>> Since we are calling ep_dequeue from timer timeout callback which is in =
softirq
>context,
>> sleeping or waiting for an event would hang the system. Also adding ep->=
ops-
>>stream_timeout()
>> would make the gadget drivers handle the issue in better way based on th=
eir
>implementation.
>
>no problems
>
>> Another advantage is the drivers which doesn't have this timeout issue d=
oesn't have
>to register the
>> timeout handler and can avoid the logic of deleting the timer for every =
request. So, I
>think
>> ep->ops->stream_timeout() would be better than having a generic handler =
which
>does
>> ep_dequeue() & ep_queue(). Please provide your suggestion on this
>implementation.
>
>call ep_dequeue()
>
>--
>balbi
