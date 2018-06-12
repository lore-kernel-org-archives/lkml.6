Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85A36C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F302089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRDcaEMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F302089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933505AbeFLECj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:02:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42383 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeFLECi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:02:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id w17-v6so13575059pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Us4zboOTlwSREDkqno3bOzEllZYgAKxt3XKOgkaSvHQ=;
        b=IRDcaEMj33qoI2OGBO/eKA2NSV+fMGxAw/jmwI32M8a5I7dgUQ2npSQcFOjDL1z35I
         S6EcVqH+BMJWFB2Zl+FAkE0cbuASkt2IRg+Tc03cckTkKxKhvoZz7ZPIF5Xz6jr0kEfD
         NfOJJ0sLqWffAy+aegSXC4NEWGdtIfixpTIfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Us4zboOTlwSREDkqno3bOzEllZYgAKxt3XKOgkaSvHQ=;
        b=gF6JCN+ssJF0rhksI2Bs5izM4pc6rcNlpjUqjJzrQdglDuAitmWrWjZVVO4xcDzieY
         XgQGfvuvDy9EutubJtU/nOEcDlcmfuYX+lIphDQHQ/s0IkqBSn6te3YgsOuP5ec5bTv+
         wTWexWxd78EB0vZ+g8KttwP9lqbJ2PqBQukZOtdW76Dzw1igK3wXA8ZUJLxAX7mFk4zo
         /Z2Xx+lhhHoxz/oISy6vKnbiSBdM9gqsFqCNGrpvavz61lSXe6QSy4mlo4mZZx7qh0PB
         7I7jw8oy4JEb3p/c5HX7BRNAca52nJmAc17H4EYH/nEag4MxkX8iiHmRp2n7Uig1zF95
         YrQA==
X-Gm-Message-State: APt69E0J3nwbL32dPDTXd2yU8lPQ3LTiFfSYKEED7rbcairlBwNozalq
        LAcdegDKlFe3FEmILO4JVoJcGw==
X-Google-Smtp-Source: ADUXVKK1Q9uDYEsNjolQN5QGB1sG9eb4hijGqbC2gU5u3L+2CjA6mq6ztHEj6gG7Dul+STOYzZCTqA==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr2208701plb.266.1528776157779;
        Mon, 11 Jun 2018 21:02:37 -0700 (PDT)
Received: from localhost ([106.200.251.98])
        by smtp.gmail.com with ESMTPSA id i127-v6sm112051200pfc.154.2018.06.11.21.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 21:02:36 -0700 (PDT)
Date:   Tue, 12 Jun 2018 09:32:35 +0530
From:   Vinod Koul <vinod.koul@linaro.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND v2] dmaengine: pxa: add a default requestor policy
Message-ID: <20180612040235.GJ2452@vkoul-mobl>
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
 <878t7oruya.fsf@belgarion.home>
 <20180611042125.GD2452@vkoul-mobl>
 <8736xtrtej.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736xtrtej.fsf@belgarion.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-18, 21:54, Robert Jarzmik wrote:
> Vinod Koul <vinod.koul@linaro.org> writes:
> 
> > On 09-06-18, 14:43, Robert Jarzmik wrote:
> >> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> >> 
> >> > As what former drcmr -1 value meant, add a this as a default to each
> >> > channel, ie. that by default no requestor line is used.
> >> >
> >> > This is specifically used for network drivers smc91x and smc911x, and
> >> > needed for their port to slave maps.
> >> >
> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> > ---
> >> > Since v1: changed -1 to U32_MAX
> >> Hi Vinod,
> >> 
> >> Could I have your ack on this so that I add this one to the dma slave map serie
> >> after the merge window is closed please ?
> >
> > Sorry I was thinking it would go thru dmaengine tree, please do
> > indicate if that is not the case. Nevertheless
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> Thanks.
> 
> As this is a dependency to the serie, I'd rather take it, unless you insist, in
> which case I'll rely on the fact that it will hit 4.19 cycle.

It fine if you take, just that it helps to indicate the route to take
for a patch :)

-- 
~Vinod
