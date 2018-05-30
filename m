Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937278AbeE3HQq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:16:46 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:59419 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937196AbeE3HQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:16:42 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Zeng Tao <prime.zeng@hisilicon.com>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: fix missing process for isoc
 descriptor dma mode
Thread-Topic: [PATCH] usb: dwc2: gadget: fix missing process for isoc
 descriptor dma mode
Thread-Index: AQHT99RV+ygzxPGq9EKuFvTgIUAiiA==
Date: Wed, 30 May 2018 07:16:36 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A59784A@am04wembxa.internal.synopsys.com>
References: <1527681676-44003-1-git-send-email-prime.zeng@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.165]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U7GqRk028192

Hi Zeng Tao,

On 5/30/2018 9:09 AM, Zeng Tao wrote:
> If it's the first request to queue, and we are using descriptor dma mode
> for isoc transfer, we only need to add the request to the queue, and it
> will be processed in the future nak interrupt handler.
> 
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>   drivers/usb/dwc2/gadget.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index f0d9ccf..48e3a48c 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -1365,6 +1365,9 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
>   			return 0;
>   		}
>   
> +		if (using_desc_dma(hs))
> +			return 0;
> +
>   		/* Update current frame number value. */
>   		hs->frame_number = dwc2_hsotg_read_frameno(hs);
>   		while (dwc2_gadget_target_frame_elapsed(hs_ep)) {
> 

Actually it considered in "[PATCH] usb: dwc2: Change ISOC DDMA flow" 
before checking is this request first or no:

+	if (using_desc_dma(hs) && hs_ep->isochronous) {
+		if (hs_ep->target_frame != TARGET_FRAME_INITIAL) {
+			dwc2_gadget_fill_isoc_desc(hs_ep, hs_req->req.dma,
+						   hs_req->req.length);
+		}
  		return 0;
  	}


Thanks,
Minas
