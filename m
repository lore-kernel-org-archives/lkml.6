Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF103C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C272190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Tgc8sTSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbfBMKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:41:36 -0500
Received: from smtp65.iad3a.emailsrvr.com ([173.203.187.65]:49256 "EHLO
        smtp65.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfBMKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:41:36 -0500
Received: from smtp1.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 26C824438;
        Wed, 13 Feb 2019 05:41:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1550054495;
        bh=Y90WeKpzsveqeeHu5XAOw5R+1ye7Uv3Va4KxZvPyku4=;
        h=Subject:To:From:Date:From;
        b=Tgc8sTSqX8960LzywBVafhG5u3FWnFYw/OzuX2ynA3YNgewvsU8DuOgoRukVJJktV
         JDMGqxpA8sxD4/Tel+Zdve9uOWTG37eSkyd1Jc9bjcwHUwz8cyVl+HJqM5t/vQIvwf
         BIRu85Q+g5YT/aONtP0lML/e0AxGwsArK6dzrrKI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 627145B54;
        Wed, 13 Feb 2019 05:41:34 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 13 Feb 2019 05:41:35 -0500
Subject: Re: [PATCH v2] staging: comedi: ni_660x: fix missing break in switch
 statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190212184450.GA6927@embeddedor>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <c689e4bb-4b7f-75fe-fb43-bc0c690de118@mev.co.uk>
Date:   Wed, 13 Feb 2019 10:41:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212184450.GA6927@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 18:44, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to the default case and return -EINVAL every time.
> 
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: aa94f2888825 ("staging: comedi: ni_660x: tidy up ni_660x_set_pfi_routing()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>   - Fix Fixes tag.
> 
>   drivers/staging/comedi/drivers/ni_660x.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_660x.c b/drivers/staging/comedi/drivers/ni_660x.c
> index e70a461e723f..405573e927cf 100644
> --- a/drivers/staging/comedi/drivers/ni_660x.c
> +++ b/drivers/staging/comedi/drivers/ni_660x.c
> @@ -656,6 +656,7 @@ static int ni_660x_set_pfi_routing(struct comedi_device *dev,
>   	case NI_660X_PFI_OUTPUT_DIO:
>   		if (chan > 31)
>   			return -EINVAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> 

Thanks for the bug fix!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
