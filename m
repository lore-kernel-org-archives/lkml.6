Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2AA2082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHDf6Oky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2AA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeLEPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:09:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37233 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:09:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so18663099lja.4;
        Wed, 05 Dec 2018 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8iLLBeQDhV8Tszwawl8dd2d7JvZqYxaJoo0YXAX88DI=;
        b=nHDf6OkyEQUX9D6ZbC4GNg7Vu4FwftZ/J8+I3MYIjkN+9MKNhRNJPRxq0kWW1ITk1J
         +OrrMKCbZjP+GPGR6IyOHevyNAx3FzYvVNYVgCFFzl8RIeqdnIJJwJvJHp2rjuoZKfAe
         APMIn+5etInFua28keWQnaDoic8iaDlHnucn7z89ypuUE1vLtDedZ+/mH21FPvXd349W
         z7bwTT2T1ZHERnBALUm7oTkK0+U4a7cy7z8lhMqcONT/m8yDf2lpyeRCcJbKLUm5PhBm
         H0SYeOgo+GV1keyXl0fBAAyQ6T5KSzOugb+6j7ujP1sYSaYbq5bvV9NFdJ31GO2DuiT/
         F3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8iLLBeQDhV8Tszwawl8dd2d7JvZqYxaJoo0YXAX88DI=;
        b=iDSgQPG+WVTPuCgjofrVIGoBSXU0HuBwsGUgFzRbscWmWnt7puH03qGg3zYksFPNyc
         jemB6TYEBKlMbLKeb80ZFXfpwhh1DjXCavsZbv2Dzl3d/+kGSJz9t3S+FrW++bwpL1EP
         NdXyZHRhfId27DBx1VzaWbgNG9RENHOpbBG0s/IqE1dag8KZxYfiRguSmLnYDUkt+RRx
         3lsQZhQ+HTmCY9FAxxUaUW3bXQNsyOJSYOJXOrVAMt1SAOjf7uZ9/n8/p3Ec89poqe2v
         dDpAcIAHgdYzcAsvqybPa8EjZfmL6Y9TdTXvqi+c+6NYInsWOh9+au5h4TPtp2s/gE8o
         LpmA==
X-Gm-Message-State: AA+aEWbVpzJAD7ZA6BUjFmrLmaZ5f/G1MP6cR+7sH9p++veTEfsdOxob
        noZAoY9BaCd1O9eVhd0oyoE=
X-Google-Smtp-Source: AFSGD/XosVtYTsUwirfVAaYSrWY6Sb+IeZX/Xma9iEcp3GuI5Nv2qalPNrtN8bTodzXUR8//yGEeDw==
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr16091313ljc.83.1544022578230;
        Wed, 05 Dec 2018 07:09:38 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id j12-v6sm3853504ljh.66.2018.12.05.07.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:09:36 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUYnz-00043A-9Y; Wed, 05 Dec 2018 16:09:39 +0100
Date:   Wed, 5 Dec 2018 16:09:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20181205150939.GI15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-6-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-6-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:58:01PM +0100, Andreas Kemnade wrote:
> Add lna-supply property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> index 1be7597ae884..9614774d14bc 100644
> --- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
> +++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> @@ -30,6 +30,7 @@ Optional properties:
>  - sirf,wakeup-gpios	: GPIO used to determine device power state
>  			  (pin name: RFPWRUP, WAKEUP)
>  - timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
> +- lna-supply		: Separate supply for a LNA

"Supply for external LNA"?

And please keep the entries sorted.

>  
>  Example:

Johan
