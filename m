Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeEaBRu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:17:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50893 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932563AbeEaBRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:17:49 -0400
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc2: gadget: fix missing process for isoc
 descriptor dma mode
Thread-Topic: [PATCH] usb: dwc2: gadget: fix missing process for isoc
 descriptor dma mode
Thread-Index: AQHT98sSWgQtoRHgW0O/P2+N+LQK6KRJCmLQ
Date: Thu, 31 May 2018 01:17:40 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C91A6BC@DGGEMM506-MBS.china.huawei.com>
References: <1527681676-44003-1-git-send-email-prime.zeng@hisilicon.com>
 <410670D7E743164D87FA6160E7907A56013A59784A@am04wembxa.internal.synopsys.com>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A59784A@am04wembxa.internal.synopsys.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4V1Hu3b032246

Hi Minus:

>-----Original Message-----
>From: Minas Harutyunyan [mailto:Minas.Harutyunyan@synopsys.com]
>Sent: Wednesday, May 30, 2018 3:17 PM
>To: Zengtao (B) <prime.zeng@hisilicon.com>;
>Minas.Harutyunyan@synopsys.com
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] usb: dwc2: gadget: fix missing process for isoc
>descriptor dma mode
>
>Hi Zeng Tao,
>
>On 5/30/2018 9:09 AM, Zeng Tao wrote:
>> If it's the first request to queue, and we are using descriptor dma
>> mode for isoc transfer, we only need to add the request to the queue,
>> and it will be processed in the future nak interrupt handler.
>>
>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>> ---
>>   drivers/usb/dwc2/gadget.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
>> index f0d9ccf..48e3a48c 100644
>> --- a/drivers/usb/dwc2/gadget.c
>> +++ b/drivers/usb/dwc2/gadget.c
>> @@ -1365,6 +1365,9 @@ static int dwc2_hsotg_ep_queue(struct
>usb_ep *ep, struct usb_request *req,
>>   			return 0;
>>   		}
>>
>> +		if (using_desc_dma(hs))
>> +			return 0;
>> +
>>   		/* Update current frame number value. */
>>   		hs->frame_number = dwc2_hsotg_read_frameno(hs);
>>   		while (dwc2_gadget_target_frame_elapsed(hs_ep)) {
>>
>
>Actually it considered in "[PATCH] usb: dwc2: Change ISOC DDMA flow"
>before checking is this request first or no:

Yes, it,s.  Thank you for pointing it out.
>
>+	if (using_desc_dma(hs) && hs_ep->isochronous) {
>+		if (hs_ep->target_frame != TARGET_FRAME_INITIAL) {
>+			dwc2_gadget_fill_isoc_desc(hs_ep, hs_req->req.dma,
>+						   hs_req->req.length);
>+		}
>  		return 0;
>  	}
>
>
>Thanks,
>Minas

Regards
Zengtao 
