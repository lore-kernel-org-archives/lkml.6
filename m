Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD531C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BEA2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usGrYJhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEA2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGIV5t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:57:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGIV5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q8rhAmH5S10cQkx57WW5PQ+cVTWWdyuTV97GW9Wfxfo=; b=usGrYJhlqJYySM5rl1A+1/Qtfg
        XOMDFsaM7D0xOAK5zy4DiHLaXq+0Komtr594xfdNecXUAwpQSYC+WCTT36WOrBaPYTsV33vdXGfPS
        OvNzaicwbDyh8wUYuaTRLaqFc+ml+vpWrfQO/v/PRx19Uc6RswUL4qjbjg+nM+NUx2/OKHzr31/6x
        p2SQN0t8FGsvS55kdZbQqGH0QVGnKPNqtDQNe7WeDtyKgnpjKsgK5MLMF7Twbj9CvWDTRf/9WM23w
        7PFij5Kt5rMjOqQiMDfGEGBChNkt36YtYE7p5xxa3sJuahpBbIX54Qh093e5RM2VTJEzyQtuvWsJG
        P5WE6LvA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fceAA-0001lu-RX; Mon, 09 Jul 2018 21:57:42 +0000
Date:   Mon, 9 Jul 2018 14:57:41 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Damien =?iso-8859-1?Q?Th=E9bault?= <damien@dtbo.net>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dell-laptop: Fix backlight detection
Message-ID: <20180709215741.GC30247@fury>
References: <20180708170220.35f40818@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180708170220.35f40818@anakin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 05:02:20PM +0200, Damien Thébault wrote:
> Fix return code check for "max brightness" ACPI call.
> 
> The dell laptop ACPI video brightness control is not present on dell
> laptops anymore, but was present in older kernel versions.
> 
> The code that checks the return value is incorrect since the SMM
> refactoring.
> 
> The old code was:
>   if (buffer->output[0] == 0)
> 
> Which was changed to:
>   ret = dell_send_request(...)
>   if (ret)
> 
> However, dell_send_request() will return 0 if buffer->output[0] == 0,
> so we must change the check to:
>   if (ret == 0)
> 
> This issue was found on a Dell M4800 laptop, and the fix tested on it
> as well.
> 
> Fixes: 549b4930f057 ("dell-smbios: Introduce dispatcher for SMM calls")
> Signed-off-by: Damien Thébault <damien@dtbo.net>
> Tested-by: Damien Thébault <damien@dtbo.net>

Thanks for the analysis and fix Damien.

I was unable to apply the patch. Apparently due to your Content-Tranfer-Encoding
being set to "quoted-printable". This converts "=" characters to =3D.
Please work with your mail client and try sending the patch
to yourself and applying it. Once that works, please resend.

I suspect you may need to do one or both of the following:

- Disable preferences->compose->"wrap pasted text" (or whichever applies to how
  you get the patch into the compose window)

- Set Preferences->Mail Handling->Sending->Transfer Encoding to 8bit to avoid
  "quoted-printable".

Other claws users who send patches have Content-Transfer-Encoding set to 7bit

Thanks,

> ---
>  drivers/platform/x86/dell-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c
> b/drivers/platform/x86/dell-laptop.c index f1fa8612db40..06978c14c83b
> 100644 --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2185,7 +2185,7 @@ static int __init dell_init(void)
>  		dell_fill_request(&buffer, token->location, 0, 0, 0);
>  		ret = dell_send_request(&buffer,
>  					CLASS_TOKEN_READ,
> SELECT_TOKEN_AC);
> -		if (ret)
> +		if (ret == 0)
>  			max_intensity = buffer.output[3];
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Darren Hart
VMware Open Source Technology Center
