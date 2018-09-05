Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C67FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490620658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CQJXFAtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIEKa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:30:28 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:36912 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIEKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:30:28 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 64BDD10C0BFC;
        Tue,  4 Sep 2018 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536127316; bh=CDBpcVWTstnHnLgmd3Do+JEC1ndyXoI5ZCb83uKLnFo=;
        h=From:To:CC:Subject:Date:References:From;
        b=CQJXFAtnsBv8pp+q9bjpJGFGGD9AoQIM4BxX1xfyWMxWSiQzqpwJVra1Efl7Mqyfq
         7fRvIPxF4qoLrTQrNI82lhjRCUo49FAmGl6uAyw7hOHOM+pFyKKAHBDdF/WyD/d+q6
         zc1ODs2s8IGxQfyGUAk1ilZYUhwgLiG+5YIwa/yrAdfmzQVGzxHlnKpgeppHLJXdkk
         f81dPtOdtFl0UVqUvNdC9umPvRBdAhfqNQWLp/dmyfcz+o2XNN9+T04Btb8Kh/YoZu
         EyIVIa3Xq5VNfhsdaQPoYqtdYs2+2NYh0kES3m0qD01lZyXItrLzdMKCD8+l9/rzXL
         Zv2JfKa1kpcWA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 470463CED;
        Tue,  4 Sep 2018 23:01:56 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 4
 Sep 2018 23:01:56 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v2 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUNiViYa4ur+HBFkqoz8RVRrTaJQ==
Date:   Wed, 5 Sep 2018 06:01:55 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AB8CD@us01wembx1.internal.synopsys.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2018 5:25 AM, Anurag Kumar Vulisha wrote:=0A=
> According to dwc3 databook when streams are used, it may be possible=0A=
> for the host and device become out of sync, where device may wait for=0A=
> host to issue prime transcation and host may wait for device to issue=0A=
> erdy. To avoid such deadlock, timeout needs to be implemented. After=0A=
> timeout occurs, device will first stop transfer and restart the transfer=
=0A=
> again. This patch does the same.=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> ---=0A=
>  Changes in v2:=0A=
> 	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by=0A=
> 	   Andy Shevchenko=0A=
> ---=0A=
>  drivers/usb/dwc3/core.h   |  7 +++++++=0A=
>  drivers/usb/dwc3/gadget.c | 39 +++++++++++++++++++++++++++++++++++++++=
=0A=
>  2 files changed, 46 insertions(+)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h=0A=
> index 285ce0e..f58640f 100644=0A=
> --- a/drivers/usb/dwc3/core.h=0A=
> +++ b/drivers/usb/dwc3/core.h=0A=
> @@ -619,6 +619,11 @@ struct dwc3_event_buffer {=0A=
>  =0A=
>  #define DWC3_TRB_NUM		256=0A=
>  =0A=
> +/*=0A=
> + * Timeout value in msecs used by stream_timeout_timer when streams are =
enabled=0A=
> + */=0A=
> +#define STREAM_TIMEOUT_MS	50=0A=
> +=0A=
>  /**=0A=
>   * struct dwc3_ep - device side endpoint representation=0A=
>   * @endpoint: usb endpoint=0A=
> @@ -642,6 +647,7 @@ struct dwc3_event_buffer {=0A=
>   * @name: a human readable name e.g. ep1out-bulk=0A=
>   * @direction: true for TX, false for RX=0A=
>   * @stream_capable: true when streams are enabled=0A=
> + * @stream_timeout_timer: timer used to aviod deadlock when streams are =
used=0A=
>   */=0A=
>  struct dwc3_ep {=0A=
>  	struct usb_ep		endpoint;=0A=
> @@ -691,6 +697,7 @@ struct dwc3_ep {=0A=
>  =0A=
>  	unsigned		direction:1;=0A=
>  	unsigned		stream_capable:1;=0A=
> +	struct timer_list	stream_timeout_timer;=0A=
>  };=0A=
>  =0A=
>  enum dwc3_phy {=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index b3e9e7f..8cef488 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc=
, unsigned cmd, u32 param)=0A=
>  }=0A=
>  =0A=
>  static int __dwc3_gadget_wakeup(struct dwc3 *dwc);=0A=
> +static void stream_timeout_function(struct timer_list *arg);=0A=
>  =0A=
>  /**=0A=
>   * dwc3_send_gadget_ep_cmd - issue an endpoint command=0A=
> @@ -574,6 +575,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *=
dep, unsigned int action)=0A=
>  			| DWC3_DEPCFG_STREAM_EVENT_EN=0A=
>  			| DWC3_DEPCFG_XFER_COMPLETE_EN;=0A=
>  		dep->stream_capable =3D true;=0A=
> +		timer_setup(&dep->stream_timeout_timer,=0A=
> +			    stream_timeout_function, 0);=0A=
>  	}=0A=
>  =0A=
>  	if (!usb_endpoint_xfer_control(desc))=0A=
> @@ -730,6 +733,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *d=
ep)=0A=
>  =0A=
>  	trace_dwc3_gadget_ep_disable(dep);=0A=
>  =0A=
> +	if (dep->stream_capable)=0A=
> +		del_timer(&dep->stream_timeout_timer);=0A=
> +=0A=
>  	dwc3_remove_requests(dwc, dep);=0A=
>  =0A=
>  	/* make sure HW endpoint isn't stalled */=0A=
> @@ -1257,6 +1263,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3=
_ep *dep)=0A=
>  		return ret;=0A=
>  	}=0A=
>  =0A=
> +	if (starting && dep->stream_capable) {=0A=
> +		dep->stream_timeout_timer.expires =3D jiffies +=0A=
> +					msecs_to_jiffies(STREAM_TIMEOUT_MS);=0A=
> +		add_timer(&dep->stream_timeout_timer);=0A=
> +	}=0A=
> +=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> @@ -2403,6 +2415,13 @@ static void dwc3_gadget_endpoint_transfer_in_progr=
ess(struct dwc3_ep *dep,=0A=
>  			stop =3D true;=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()=
=0A=
> +	 * for stream capable endpoints.=0A=
> +	 */=0A=
> +	if (dep->stream_capable)=0A=
> +		del_timer(&dep->stream_timeout_timer);=0A=
> +=0A=
>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);=0A=
>  =0A=
>  	if (stop) {=0A=
> @@ -2486,6 +2505,14 @@ static void dwc3_endpoint_interrupt(struct dwc3 *d=
wc,=0A=
>  		}=0A=
>  		break;=0A=
>  	case DWC3_DEPEVT_STREAMEVT:=0A=
> +		switch (event->status) {=0A=
> +		case DEPEVT_STREAMEVT_FOUND:=0A=
> +			del_timer(&dep->stream_timeout_timer);=0A=
> +			break;=0A=
> +		case DEPEVT_STREAMEVT_NOTFOUND:=0A=
> +		default:=0A=
> +			dev_err(dwc->dev, "unable to find suitable stream");=0A=
> +		}=0A=
Add break after this. Also, it's probably easier to read if we use=0A=
if-else case here.=0A=
=0A=
>  	case DWC3_DEPEVT_RXTXFIFOEVT:=0A=
>  		break;=0A=
>  	}=0A=
> @@ -2587,6 +2614,18 @@ static void dwc3_stop_active_transfer(struct dwc3_=
ep *dep, bool force)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +static void stream_timeout_function(struct timer_list *arg)=0A=
> +{=0A=
> +	struct dwc3_ep *dep =3D from_timer(dep, arg, stream_timeout_timer);=0A=
> +	struct dwc3		*dwc =3D dep->dwc;=0A=
> +	unsigned long		flags;=0A=
> +=0A=
> +	spin_lock_irqsave(&dwc->lock, flags);=0A=
> +	dwc3_stop_active_transfer(dep, true);=0A=
> +	__dwc3_gadget_kick_transfer(dep);=0A=
> +	spin_unlock_irqrestore(&dwc->lock, flags);=0A=
> +}=0A=
> +=0A=
>  static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)=0A=
>  {=0A=
>  	u32 epnum;=0A=
=0A=
Thinh=0A=
=0A=
