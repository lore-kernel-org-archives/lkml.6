Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7CD20868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA0yc2Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeGUTpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:45:35 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33178 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeGUTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:45:35 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so5863507ybb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ob7IpPjwiR7MYsHjdsqjLcT6SYb30bWRaOTabcN4AHk=;
        b=aA0yc2KyrxnpxTnX2EiJElP337PRZcVvP7K8weenTnXUDfWUKbKcAYl7tW7u0bypGj
         yzz16QqdZaCbb7DDsZwBsYy0hZskVa4xgZftspxxA1mkZhPEwcHCBIKHz72JBx69eGyu
         2ikH8VktndHlGjuMESsVQ4QGhiKjho9FUaXp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ob7IpPjwiR7MYsHjdsqjLcT6SYb30bWRaOTabcN4AHk=;
        b=MHZvk3FRlONzyfhChRKd9KLKAg4msk3KkGiYDVVqPFULN40707xnFlbE8Mfgv1Yx3+
         CXfW5zI8DwyBIvbkjfOycRGR5h8hihbhvd7F7SavcueSHJq86nVvn9s9qO2L95w33HSx
         nlkikEOFfXvyi+g1FSFic1uUaNMxVB0kuRMBZVHRtVpGGxCNkyuLQkirQaRehIGRN+fy
         yg9fyFHTdQaJMPmsMpK4A+Eiuub2yFzV3A2SPMexEcXHF2nYrk+IPrWR+7aSQG1RzYf7
         9QPWZrbL8KoZdFkjAmPvzaS02rovOYjWBcuwbtvOg9JncY935e89B9P0mzY/TQ5Lrlu0
         JvDA==
X-Gm-Message-State: AOUpUlHIX7ugMfoiaUqzxw53YesYtR+XAZu85cpZXcv0KVfpPSv3OWbH
        0Efn0wcwtOzlyG0pn9pClV0lzw==
X-Google-Smtp-Source: AAOMgpfT7XPrT8qveIaw0Hy1Uo4hwgdi6TZquJtbhAujck2wQXhjuRS4BxbzVLSm6zimFHpq8frp3A==
X-Received: by 2002:a5b:5d1:: with SMTP id w17-v6mr3563708ybp.447.1532199112652;
        Sat, 21 Jul 2018 11:51:52 -0700 (PDT)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id m128-v6sm2406652ywe.100.2018.07.21.11.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:51:51 -0700 (PDT)
Date:   Sat, 21 Jul 2018 13:51:47 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: msm8916: drop legacy suffix for clocks used
 by MSM DRM driver
Message-ID: <20180721185147.GH7404@hector.attlocal.net>
References: <20180718145258.15254-1-niklas.cassel@linaro.org>
 <CAP71WjzPxxwNp-FkUsRAP4e_+Z_q12wcLeXryk-eYdLi-WJexg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP71WjzPxxwNp-FkUsRAP4e_+Z_q12wcLeXryk-eYdLi-WJexg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:53:04PM +0200, Nicolas Dechesne wrote:
> hi Niklas,
> 
> On Wed, Jul 18, 2018 at 4:53 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
> >
> > Drop legacy suffix for clocks used by MSM DRM driver.
> 
> I had the same patch locally, which I forgot to send.. so thanks for
> sending it ;)
> 
> you might want to add in the commit log:
> 
>     Since "720c3bb80235 (drm/msm: drop _clk suffix from clk names)",
> we can see such
>     messages when booting:
> 

I'll amend the log to contain that info Nicolas.

Thanks,

Andy
