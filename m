Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDEFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F06221486
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FGuJ6YuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F06221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINCfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:35:18 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57696 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeINCfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:35:17 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CAF5710C0979;
        Thu, 13 Sep 2018 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536873842; bh=t5sKxQOCukM1SpVANJmvgH7hppO1v6hBoEPBCrNwF10=;
        h=From:To:CC:Subject:Date:References:From;
        b=FGuJ6YuSqeywHWTr/TKpDnKpkVzf/j1E+0hLr/Ln0pAG2E02gSb8Yxq9pnWUhIk96
         IBmFxKNIWye0ZxhmSxAuxRkRjZLD1vIi0GB2GDi20M/Gz2ngGjTaql1/SUebO2m87U
         RDueOjMgpjv6lui+5JKyVJawvbHf2IrEW3ALpz9s787LfPZ7mxIJcfsNUqA2bkhU7M
         Halsx0CeQ0itp/bHOZae4j0W3UAwzN8sXtWfz63oEHVEy/uQ9UFx3qInBi1SeihnsY
         vJ+moZwJPhUpHHCPXArm22CfYKKgQjQb/JTze17+30u2IAjpGZr2oCJ3Ws+E8fo46+
         izmAOSpw0xkNg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id B4A055176;
        Thu, 13 Sep 2018 14:24:01 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Thu, 13 Sep 2018 14:24:01 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v4 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v4 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUR4UYGRd2tOduQUWH9PDZzFD3BA==
Date:   Thu, 13 Sep 2018 21:24:00 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AECB6@us01wembx1.internal.synopsys.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536418986-16609-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
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

Hi Anurag,=0A=
=0A=
On 9/8/2018 8:03 AM, Anurag Kumar Vulisha wrote:=0A=
> According to dwc3 databook when streams are used, it may be possible=0A=
> for the host and device become out of sync, where device may wait for=0A=
> host to issue prime transcation and host may wait for device to issue=0A=
> erdy. To avoid such deadlock, timeout needs to be implemented. After=0A=
> timeout occurs, device will first stop transfer and restart the transfer=
=0A=
> again. This patch does the same.=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> ---=0A=
>  Chnages in v4:=0A=
> 	1. Added description for stream timeout timer as suggested by=0A=
> 	   "Thinh Nguyen"=0A=
>=0A=
>  Changes in v3:=0A=
> 	1. Added the changes suggested by "Thinh Nguyen"=0A=
>=0A=
>  Changes in v2:=0A=
> 	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by=0A=
> 	   "Andy Shevchenko"=0A=
> ---=0A=
>  drivers/usb/dwc3/core.h   |  7 +++++++=0A=
>  drivers/usb/dwc3/gadget.c | 45 +++++++++++++++++++++++++++++++++++++++++=
++++=0A=
>  2 files changed, 52 insertions(+)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h=0A=
> index 5bfb625..f62e8c4 100644=0A=
> --- a/drivers/usb/dwc3/core.h=0A=
> +++ b/drivers/usb/dwc3/core.h=0A=
> @@ -633,6 +633,11 @@ struct dwc3_event_buffer {=0A=
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
> @@ -656,6 +661,7 @@ struct dwc3_event_buffer {=0A=
>   * @name: a human readable name e.g. ep1out-bulk=0A=
>   * @direction: true for TX, false for RX=0A=
>   * @stream_capable: true when streams are enabled=0A=
> + * @stream_timeout_timer: timeout timer used by bulk streams=0A=
>   */=0A=
>  struct dwc3_ep {=0A=
>  	struct usb_ep		endpoint;=0A=
> @@ -705,6 +711,7 @@ struct dwc3_ep {=0A=
>  =0A=
>  	unsigned		direction:1;=0A=
>  	unsigned		stream_capable:1;=0A=
> +	struct timer_list	stream_timeout_timer;=0A=
>  };=0A=
>  =0A=
>  enum dwc3_phy {=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index 13ea282..306d4c5 100644=0A=
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
> @@ -574,6 +575,17 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep =
*dep, unsigned int action)=0A=
>  			| DWC3_DEPCFG_STREAM_EVENT_EN=0A=
>  			| DWC3_DEPCFG_XFER_COMPLETE_EN;=0A=
>  		dep->stream_capable =3D true;=0A=
> +=0A=
> +		/*=0A=
> +		 * When BULK streams are enabled it may be possible for the host=0A=
> +		 * and device become out of sync, where device may wait for host=0A=
> +		 * to issue prime transcation and host may wait for device to=0A=
> +		 * issue ERDY. To avoid such deadlock, timeout needs to be=0A=
> +		 * implemented. After timeout occurs, device will first stop=0A=
> +		 * transfer and restart the transfer again.=0A=
> +		 */=0A=
> +		timer_setup(&dep->stream_timeout_timer,=0A=
> +			    stream_timeout_function, 0);=0A=
>  	}=0A=
>  =0A=
>  	if (!usb_endpoint_xfer_control(desc))=0A=
> @@ -730,6 +742,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *d=
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
> @@ -1257,6 +1272,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3=
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
> @@ -2403,6 +2424,13 @@ static void dwc3_gadget_endpoint_transfer_in_progr=
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
> @@ -2487,6 +2515,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *d=
wc,=0A=
>  		}=0A=
>  		break;=0A=
>  	case DWC3_DEPEVT_STREAMEVT:=0A=
> +		if (event->status =3D=3D DEPEVT_STREAMEVT_FOUND)=0A=
> +			del_timer(&dep->stream_timeout_timer);=0A=
> +		else=0A=
> +			dev_dbg(dwc->dev, "unable to find suitable stream");=0A=
=0A=
This debug message is already printed in the driver tracepoint. There's=0A=
no need to print it here. Also, I don't think Felipe will accept adding=0A=
new dev_dbg() after removing all of them and converting them to tracepoints=
.=0A=
=0A=
Thinh=0A=
