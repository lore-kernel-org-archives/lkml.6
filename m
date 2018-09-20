Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581CCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028112150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNKqHUsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028112150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeITVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:46:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39562 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeITVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:46:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so4559213plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4iEeziyhf7QGDfAjGIofnpv3iNGNnVid+o6WaSInbY=;
        b=MNKqHUsIY5EWpOI4JkgC5DebE4M6D4xCIJ+2SOXwSCeCTlozx4SG+/JfXBPu1DfQg+
         zeqwYlZXx49Ov6zx8VfTvQ4u0ch2IDAIYi7A7qzswA+z4EQQ3X/UXSi6pATrfztX8WHL
         PaPsBWBajRJggALko1vgrUw/vP2F/HrP2Q8gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4iEeziyhf7QGDfAjGIofnpv3iNGNnVid+o6WaSInbY=;
        b=jZJBxFzPXPUf2i+pJGdSk3bhHwnnaV0X5AA9h8Te5bWDnA1pjUMAvbCG89e5OGVZjc
         z0IJohUcvynKSAWw7y74L48IS5i00oOAAtOztmYP/FKEG+HQKKh6LZTtPgsDcVi8TZBA
         E6U/hXkvgf3DG38dMsFJTkdKNvO21sdC1t8orwdM739dsvAm3BMre20DAe8MHNyPhKYM
         AopyRz61B7XnFeH/N+/0bl5UrThOUusXpMxYP4X+b7fMooOuqBpCIpb0SvNsSgNJZmVU
         UYVYeqBI+dtAV3PtQl8913KXbn1DBTwPv9ZaOzYB5j4G3eSD9mAnYIUD4Qq6vlrJcg7z
         Mtrg==
X-Gm-Message-State: APzg51C1QmIPrERUDLRss3u9+bkoseMJPun7Qn6FwhM/ZkWVGS9ClgVa
        kLK83puCWx3EuZM3IjkJmT4eGQ==
X-Google-Smtp-Source: ANB0Vdasqjb2LcaycZNZwmHeeYIiejDEXxVisr6DDv2I6pGwjqMneAOEdyFMAW+SpDC6StgHoJ90Xg==
X-Received: by 2002:a17:902:204:: with SMTP id 4-v6mr36758041plc.281.1537459367709;
        Thu, 20 Sep 2018 09:02:47 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id e190-v6sm50224229pfc.81.2018.09.20.09.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:02:46 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:02:45 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ndesaulniers@google.com, natechancellor@gmail.com,
        ilia.lin@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180920160245.f4afwfyyz3nd4xvn@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
 <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
 <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-18, 00:45, Rafael J. Wysocki wrote:
> Because __init things go away at one point and calling them from the
> other sections is a bad idea.  OTOH, __exit things are simply not
> needed in built-in drivers and they are never there if the driver is
> built-in, so calling them from the other sections is a bad idea too.

I assumed that the driver is calling platform_driver_probe() and so probe() can
be marked __init. But it doesn't do that to make deferred probing work.

-- 
viresh
