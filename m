Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB67C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED72081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CED72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeK2DSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:18:05 -0500
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:27282
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbeK2DSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfvVl/mv5gRuYTKpuk/qhcKiwc+P7gLS1voq+xZGzXo=;
 b=eJZJYLSeUeOmnZR6hkDbPvyJkX2hh5SlB7x9Nzszcm6mUuyXPpb2TsK72INBVZn7gmojlrn3WmdH/XZukhw/vKL8/13KLPYNnknYE/p3KIW0PiSsHz3s6dfDWBxnePFvJ9R3Qz72171hqFgA2Bm5BvuQ7DhYaLN9qKB9REFzqI8=
Received: from BL0PR02MB5633.namprd02.prod.outlook.com (20.177.241.80) by
 BL0PR02MB4420.namprd02.prod.outlook.com (10.167.179.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 28 Nov 2018 16:15:06 +0000
Received: from BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d]) by BL0PR02MB5633.namprd02.prod.outlook.com
 ([fe80::68ed:9ca9:c7da:d76d%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 16:15:06 +0000
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
Thread-Index: AQHUYvbRwEYgzRXr0k+ojhd/SBDozaVPfhoAgBXv3pA=
Date:   Wed, 28 Nov 2018 16:15:06 +0000
Message-ID: <BL0PR02MB563317DEAFAD7C06B52FC23DA7D10@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87k1lfiwx3.fsf@linux.intel.com>
In-Reply-To: <87k1lfiwx3.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4420;6:UOEkBcsyddr53y1MgUQImhwuJor0D5M+sAu6vnNgo6TFi8xpdtalRruQNVOHDyFgEU3SoqT7/dOATcyUG89sI0yJXBPUczR9tSvNFBAeU2HiWJlo2v/8f7MOalAbXgbm78MOWAUEcWUrjHMhK+ofsIjB82keSSYgWwmIzfrbZh4msgy7c16rPGwCPpvaTRGD+afvaURKrn3zDeDotAcxB05r9LASSwuJJuH2CTJv73EKLTC91NUAUDGQVKO/YnZUP88Hrhq5vg+48E7ClKB/BJrGdEWIMBaQhob/oXJDXMQZKaN4TuPu+yL/rziaLFAyVoLbRp/2DipUAGXe6s9sLh9CcZXRLhZNwn7G92uXsk9wFCMeU4vPDLHksqmt7OctYRPyVvXi0eLbsedenITke0XP1FgEHc0KNfD39R6QJoUxufQVzEq54raNuanH7Lsf/sBFeMsIRdNwZRvUFz+5kA==;5:iyu/Msz33hYMYUltnRSKMxZtzyxoUl6CefEQS086pIVmFBOOhc2xNFZOPUTgM7x4Ftz3M8Zux3Wj4uuIQV9ubobbfPqu7xL9TeWIxokjfQjII6hefaNfQGnw21PVXZIJuHkmuO/1S64Vly8CfYjSrxbZT/ceMJlRXacGT+pfhJg=;7:pDHScARCUSxZ38Y/wZdcjr/Xmy3cTojInCQ6dUbKrnp0fLAjuHRe7xbhBy4rY4vygRTL8rl/zLo0OnYOMJxjUpdAiCDbz7B/EVHFIccVYtd6GmQztvXL4+jqQigVqEU5M1JvILxdG0GbWKbkqGDQkA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 43445c24-abf5-4b61-3915-08d6554ca930
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4420;
x-ms-traffictypediagnostic: BL0PR02MB4420:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB442029509671CC7944FC0D3DA7D10@BL0PR02MB4420.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231443)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4420;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4420;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(13464003)(2906002)(6116002)(3846002)(68736007)(81156014)(81166006)(256004)(14444005)(305945005)(229853002)(8936002)(74316002)(8676002)(25786009)(478600001)(86362001)(105586002)(71200400001)(71190400001)(106356001)(6436002)(14454004)(186003)(26005)(5660300001)(486006)(476003)(54906003)(446003)(110136005)(11346002)(9686003)(4326008)(7416002)(39060400002)(66066001)(33656002)(102836004)(6506007)(99286004)(55016002)(76176011)(551934003)(7736002)(7696005)(53936002)(316002)(2171002)(97736004)(6246003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4420;H:BL0PR02MB5633.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OEh2/wFH5bLsL0qd+TPNdEvisiyCgvDSfX8xnbg58Ad6hsUAQeB5IEelnrx99jZpqihcYtefYJvPluws/oP1jqHmdC0zUJGhoh82Ab5KLhnCmUVx0pyJzkeo5Q07jTAEBp+kmG8616k+TG8LPIpptEaHYleTfAaQHUBZYOv4+hvzLTdE4/pfXjdZGjMrC9m6FUxr8oS4WuVYBPbO3BsW5lgLVTAZBkDrCz9gtCAmqT+6lvDjJT3+wAxOG47tpKKGqGnx2Hk/R/Ia9QISLtuaI8fplZ2NLigEeUR9c0bXsHQ0Y+/kGbtZ4YlO5WoE+SXP5gJC1zvOCgRapMRkJjYmBAqzLLMuxjKONLEpZUuZYZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43445c24-abf5-4b61-3915-08d6554ca930
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 16:15:06.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Thanks a lot for spending your time in reviewing this patch. Please find
my comments inline

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Wednesday, November 14, 2018 7:28 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Alan Stern <stern@rowland.harvard.edu>; Joha=
n
>Hovold <johan@kernel.org>; Jaejoong Kim <climbbb.kim@gmail.com>; Benjamin
>Herrenschmidt <benh@kernel.crashing.org>; Roger Quadros <rogerq@ti.com>
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
>v.anuragkumar@gmail.com; Thinh Nguyen <thinhn@synopsys.com>; Tejas Jogleka=
r
><tejas.joglekar@synopsys.com>; Ajay Yugalkishore Pandey <APANDEY@xilinx.co=
m>;
>Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capab=
le
>endpoints
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> When bulk streams are enabled for an endpoint, there can
>> be a condition where the gadget controller waits for the
>> host to issue prime transaction and the host controller
>> waits for the gadget to issue ERDY. This condition could
>> create a deadlock. To avoid such potential deadlocks, a
>> timer is started after queuing any request for the stream
>> capable endpoint in usb_ep_queue(). The gadget driver is
>> expected to stop the timer if a valid stream event is found.
>> If no stream event is found, the timer expires after the
>> STREAM_TIMEOUT_MS value and a callback function registered
>> by gadget driver to endpoint ops->stream_timeout API would be
>> called, so that the gadget driver can handle this situation.
>> This kind of behaviour is observed in dwc3 controller and
>> expected to be generic issue with other controllers supporting
>> bulk streams also.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>>  Changes in v6:
>> 	1. This patch is newly added in this series to add timer into udc/core.=
c
>> ---
>>  drivers/usb/gadget/udc/core.c | 71
>++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/usb/gadget.h    | 12 ++++++++
>>  2 files changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core=
.c
>> index af88b48..41cc23b 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -52,6 +52,24 @@ static int udc_bind_to_driver(struct usb_udc *udc,
>>  /* --------------------------------------------------------------------=
----- */
>>
>>  /**
>> + * usb_ep_stream_timeout - callback function for endpoint stream timeou=
t timer
>> + * @arg: pointer to struct timer_list
>> + *
>> + * This function gets called only when bulk streams are enabled in the =
endpoint
>> + * and only after ep->stream_timeout_timer has expired. The timer gets =
expired
>> + * only when the gadget controller failed to find a valid stream event =
for this
>> + * endpoint. On timer expiry, this function calls the endpoint-specific=
 timeout
>> + * handler registered to endpoint ops->stream_timeout API.
>> + */
>> +static void usb_ep_stream_timeout(struct timer_list *arg)
>> +{
>> +	struct usb_ep *ep =3D from_timer(ep, arg, stream_timeout_timer);
>> +
>> +	if (ep->stream_capable && ep->ops->stream_timeout)
>
>why is the timer only for stream endpoints? What if we want to run this
>on non-stream capable eps?
>

I have seen this issue only with stream capable eps between PRIME & EPRDY. =
But this issue
can potentially occur with non-stream endpoints also. Will remove this stre=
am capable checks
in next series of patch.

>> +		ep->ops->stream_timeout(ep);
>
>you don't ned an extra operation here, ep_dequeue should be enough.
>

I think issuing ep_dequeue() would be more trickier than calling ep->ops->s=
tream_timeout().
This is because, every gadget driver has their own way of handling ep_deque=
ue. Some
drivers (like dwc3) may sleep for an event (wait_event_lock_irq) in the ep_=
dequeue routine.
Since we are calling ep_dequeue from timer timeout callback which is in sof=
tirq context,
sleeping or waiting for an event would hang the system. Also adding ep->ops=
->stream_timeout()
would make the gadget drivers handle the issue in better way based on their=
 implementation.
Another advantage is the drivers which doesn't have this timeout issue does=
n't have to register the
timeout handler and can avoid the logic of deleting the timer for every req=
uest. So, I think
ep->ops->stream_timeout() would be better than having a generic handler whi=
ch does
ep_dequeue() & ep_queue(). Please provide your suggestion on this implement=
ation.

>> @@ -102,6 +132,10 @@ int usb_ep_enable(struct usb_ep *ep)
>>  	if (ret)
>>  		goto out;
>>
>> +	if (ep->stream_capable)
>> +		timer_setup(&ep->stream_timeout_timer,
>> +			    usb_ep_stream_timeout, 0);
>
>the timer should be per-request, not per-endpoint. Otherwise in case of
>multiple requests being queued, you can't give them different timeouts

I agree with you. Will correct this in next series of patch.

>
>> @@ -269,6 +321,13 @@ int usb_ep_queue(struct usb_ep *ep,
>>
>>  	ret =3D ep->ops->queue(ep, req, gfp_flags);
>>
>> +	if (ep->stream_capable) {
>> +		ep->stream_timeout_timer.expires =3D jiffies +
>> +				msecs_to_jiffies(STREAM_TIMEOUT_MS);
>
>timeout value should be passed by the gadget driver. Add a new
>usb_ep_queue_timeout() that takes the new argument. Rename the current
>usb_ep_queue() to static int __usb_ep_queue() with an extra argument for
>timeout and introduce usb_ep_queue() without the argument, calling
>__usb_ep_queue() passing timeout as 0.
>

Thanks for correcting and providing the steps for implementing. Will modify=
 as
suggested in next series of patch.

>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index e5cd84a..2ebaef0 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -144,6 +144,7 @@ struct usb_ep_ops {
>>
>>  	int (*fifo_status) (struct usb_ep *ep);
>>  	void (*fifo_flush) (struct usb_ep *ep);
>> +	void (*stream_timeout) (struct usb_ep *ep);
>
>why?
>

As discussed above, the common timeout handler with ep_dequeue() and
ep_queue() may not work for all the gadget drivers, adding the stream_timeo=
ut()
in ep->ops would enable the drivers to implement their own handler for
handling the stream timeout issue.

Thanks,
Anurag Kumar Vulisha
>--
>balbi
