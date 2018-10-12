Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD44C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF682086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJLQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:42:53 -0400
Received: from smtp65.ord1c.emailsrvr.com ([108.166.43.65]:56620 "EHLO
        smtp65.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbeJLQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:42:53 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2018 12:42:52 EDT
Received: from smtp25.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp25.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 9F44B2024B;
        Fri, 12 Oct 2018 05:04:04 -0400 (EDT)
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B769A20229;
        Fri, 12 Oct 2018 05:04:03 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 12 Oct 2018 05:04:04 -0400
Subject: Re: [PATCH] staging: comedi: tio: fix multiple missing break in
 switch bugs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E. Olson" <olsonse@umich.edu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181011190520.GA12609@embeddedor.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <aeb0ea08-86bc-3ce7-ea93-a68b2d522ed0@mev.co.uk>
Date:   Fri, 12 Oct 2018 10:04:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011190520.GA12609@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 20:05, Gustavo A. R. Silva wrote:
> Currently, there are multiple missing break statements in two switch code
> blocks. This makes the execution path to fall all the way down through
> to the default cases, which makes the function ni_tio_set_gate_src() to
> always return -EINVAL.
> 
> Fix this by adding the missing break statements.
> 
> Also, notice that due to the absence of the break statements,
> the following pieces of code are unreachable:
> 
> 1078    if (ret)
> 1079            return ret;
> 1080    /* 3.  reenable & set mode to starts things back up */
> 1081    ni_tio_set_gate_mode(counter, src);
> 
> 1098    if (ret)
> 1099            return ret;
> 1100    /* 3.  reenable & set mode to starts things back up */
> 1101    ni_tio_set_gate2_mode(counter, src);
> 
> So, by adding the missing breaks, this patch also fixes the problem
> above.
> 
> Addresses-Coverity-ID: 1474165 ("Missing break in switch")
> Addresses-Coverity-ID: 1474162 ("Structurally dead code")
> Fixes: 347e244884c3 ("staging: comedi: tio: implement global tio/ctr routing")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/staging/comedi/drivers/ni_tio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_tio.c b/drivers/staging/comedi/drivers/ni_tio.c
> index 838614e..0eb388c 100644
> --- a/drivers/staging/comedi/drivers/ni_tio.c
> +++ b/drivers/staging/comedi/drivers/ni_tio.c
> @@ -1070,8 +1070,10 @@ int ni_tio_set_gate_src(struct ni_gpct *counter,
>   		case ni_gpct_variant_e_series:
>   		case ni_gpct_variant_m_series:
>   			ret = ni_m_set_gate(counter, chan);
> +			break;
>   		case ni_gpct_variant_660x:
>   			ret = ni_660x_set_gate(counter, chan);
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -1090,8 +1092,10 @@ int ni_tio_set_gate_src(struct ni_gpct *counter,
>   		switch (counter_dev->variant) {
>   		case ni_gpct_variant_m_series:
>   			ret = ni_m_set_gate2(counter, chan);
> +			break;
>   		case ni_gpct_variant_660x:
>   			ret = ni_660x_set_gate2(counter, chan);
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> 

Thanks for catching that bug!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
