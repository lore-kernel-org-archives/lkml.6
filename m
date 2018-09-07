Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204332077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NFcocSOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204332077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeIHEL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:11:27 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40664 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeIHEL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:11:26 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DCE4010C0CD3;
        Fri,  7 Sep 2018 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536362888; bh=4+VEKpQljccWILomvYXjluZ2PibuDIrWtBREtVtGODM=;
        h=From:To:CC:Subject:Date:References:From;
        b=NFcocSOH0BxwopDM2nmBzA77cObJ9HFwBsWZuLS1VfWD8tfQc18mKHWhtS01rn4MH
         ekWxeDplMfAcWsZFqZvp+HFol2AzGBXsUnDPuyD+sBa/d+3V2soguZTNBvvcENFukX
         l4IpNWKEaIi24JKSMf/G6IjDjDuWKtRkrKzbNp35uHAOxEyhT1Hw49mBf9nEmLM8wZ
         0qvO5WfQ96qOf+Lms3dAIvhdsd6CtYzL5GvFHPHQsB7G2O6ZpMqA3MpM6davbBnASy
         JWKYcoCEr8RXcQpCfdfwIcTP+OqZCLhFMBSXerhjVmay5okE632gAvUn+RcS7x+GNc
         QqenDoRMmruzw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BA10933D3;
        Fri,  7 Sep 2018 16:28:08 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri, 7
 Sep 2018 16:28:08 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v3 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH v3 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHURqy4/mMoK+M5zEyImU/x5ug6Dg==
Date:   Fri, 7 Sep 2018 23:28:07 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AD89B@us01wembx1.internal.synopsys.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536326029-16327-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
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

On 9/7/2018 6:14 AM, Anurag Kumar Vulisha wrote:=0A=
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
>  Changes in v3:=0A=
> 	1. Added the changes suggested by "Thinh Nguyen"=0A=
>=0A=
>  Changes in v2:=0A=
> 	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by=0A=
> 	   "Andy Shevchenko"=0A=
> ---=0A=
>  drivers/usb/dwc3/core.h   |  7 +++++++=0A=
>  drivers/usb/dwc3/gadget.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
>  2 files changed, 43 insertions(+)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h=0A=
> index 5bfb625..0b255e97 100644=0A=
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
> + * @stream_timeout_timer: timer used to aviod deadlock when streams are =
used=0A=
=0A=
Change aviod -> avoid. Also, the timer is being used when there's a=0A=
deadlock rather than to avoid it. You probably need to explain what=0A=
deadlock it is if you mentioned it here, but I think it's ok to simply=0A=
say timeout timer for streams (unless Felipe has any objection).=0A=
=0A=
Thinh=0A=
=0A=
