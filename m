Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1424496
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="diOWSlmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1424496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeGDLUY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:20:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44806 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbeGDLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:20:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id h7-v6so4084684lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+rrrbhDY/04x8iQUhqT+kKgiA6cCoa1irOa9CsoG7J4=;
        b=diOWSlmbLfx2e8T9eSx6Oa/4MPxqVr76n+EDHsu2InEydmfJ5wtfOc4kD+NxXQMif7
         zJG5jmatxh1V1Znu7nkaODN1WV4px0xSrJqIunWk0y5QT6ofXqVE41bxRLugJs0VV4+q
         m1D0aqzvFy5Zgn9KGe0bJWMhZhHhfrWyl8FRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rrrbhDY/04x8iQUhqT+kKgiA6cCoa1irOa9CsoG7J4=;
        b=E3Q5lHion2QaxwPsXZsUvHzu9lcy2QNAybTDG9Az1aI5KYMmSjIjyuQwi9egR6FhmU
         JZNZTI08Do7U7kJ9cJci/2LOKMz+Zlm/Kov8jRwCRjQBbEBwu06wOE/0rtd0PwVUrFvQ
         zlPOjorzxy37NGeXbpPMhITwpJrBK7jkKrdRFUksEWOgnxbvMKwRPjRymhLXkH29lWKv
         eJ1cyHpLPHVHrhXdv6LM109BStPZouAnd842DSBc6cL1xWq+Mn0X3eETgJHT3Q3m+aEV
         HDoiOgqYQggtJIk5uqbR+70aEeCP2vcfjLWGCLZw+MLc0MK+DgsqxdhP+yRWSmEv9d5X
         Tqbw==
X-Gm-Message-State: APt69E3ey2xOzLvEOU/Rd/aoCDTE8t6d2YFkQIR9HzvTVu+K5vpH7FaG
        6W5NaLjN9cnMA402pY2DG1UjmQ==
X-Google-Smtp-Source: AAOMgpe5PWTI0hjasR3RKdKp0IrbT8AsdCxwh9Kj2kma9phENaIoIlbqQQ9+fyZNinYkRvzcmEIAaw==
X-Received: by 2002:a19:c301:: with SMTP id t1-v6mr1205075lff.45.1530703220975;
        Wed, 04 Jul 2018 04:20:20 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id k202-v6sm757981lfg.15.2018.07.04.04.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 04:20:20 -0700 (PDT)
Date:   Wed, 4 Jul 2018 13:20:18 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Message-ID: <20180704112018.GA15155@centauri.ideon.se>
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
 <20180704095913.772C9606AC@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704095913.772C9606AC@smtp.codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:59:13AM +0000, Kalle Valo wrote:
> Niklas Cassel <niklas.cassel@linaro.org> wrote:
> 
> > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> 
> Note to myself, I see these dependencies in linux-next (but not in Linus' tree yet):
> 
> 67cd0eec5b62 rpmsg: smd: Add missing include of sizes.h
> 376e1f304fc7 firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
> 
> These I don't see in linux-next yet:
> 
>   soc: qcom: smem: Add missing include of sizes.h
>   soc: qcom: smp2p: Add select IRQ_DOMAIN
>   soc: qcom: smsm: Add select IRQ_DOMAIN
>   soc: qcom: Remove depends on ARCH_QCOM

Hello Kalle,

You are correct.
I submitted a v3 of this just yesterday:
https://marc.info/?l=linux-kernel&m=153060245727472&w=2
So hopefully it will be in linux-next within 2 weeks.

Regards,
Niklas

> 
> -- 
> https://patchwork.kernel.org/patch/10460103/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
