Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6BCECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2F020936
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIXhjVq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeGOOjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:39:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35093 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeGOOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:39:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so1028682plq.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZX6k29rDmksbIML9NARFMhOV3SoJSYC+ovWbTxzn7SQ=;
        b=LIXhjVq5bvsHrzuQeVUDHWUDWLsD1/KasfoD8VTZnvLrr+yvL6vPMjgyR1/bbEz43+
         +K1U1uRd1riQEeyqBSZ3uVgI8i9T6rJ4fw4g5LlxlW1pfOUTHJOVVivchrEiRkxaGWBZ
         bsFyQdPtlMfmLSe3nntzKsrrxPF8NnEM6syCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZX6k29rDmksbIML9NARFMhOV3SoJSYC+ovWbTxzn7SQ=;
        b=saTPRSvKFriav6NgLn3svukHyVRUYIk69iv/LTatuaJ0dFR1cuuKnl+QczersmKogH
         /CCENhIVSz+3GmtvSj8I8Ws73rRZkLSvDPjcCIG7KF1+g9C4zENVJL0N3CcAvHpwXdIU
         oTuJD8sdi5czZ3ledQbQjDJD8lXg+50RWEyzk2RZv1JeMmrIbPnm2xG0WqIlEABJ0jgn
         Cr6OwGiYa6BDYe94j4XFEdkNsMetBmTmUNcQOKrjT2SZCmdqDJRiIU4qwByb/ANEqZHl
         XBRtJM91BRwm6ceha/60Ypc5kxtsXe3SyX+qLmALXjVlAfOKpC2zgUtY+N3xvgXVKKBp
         flnQ==
X-Gm-Message-State: AOUpUlF8rGf+I1dTOeHvIxiA3tOmx3Qe7h3yJGGIdxj8yMunIbNVCP7R
        EmoTiC+W2HXzRiJqMmnetT66
X-Google-Smtp-Source: AAOMgpfq3KUA5SmZj3fecBaCqRm/XbEcPb1XhbpwuZuUVK5dGwEPaBsUupLH+xRISK3hoLAuu/Hp6Q==
X-Received: by 2002:a17:902:9690:: with SMTP id n16-v6mr13247953plp.94.1531664168024;
        Sun, 15 Jul 2018 07:16:08 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:71c5:dcf2:1082:c344:2c7e:f99b])
        by smtp.gmail.com with ESMTPSA id l3-v6sm6134043pff.8.2018.07.15.07.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 07:16:07 -0700 (PDT)
Date:   Sun, 15 Jul 2018 19:45:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Saravanan Sekar <sravanhome@gmail.com>, sboyd@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: Re: [PATCH v4 1/5] clk: actions: Add REGMAP as dependency
Message-ID: <20180715141551.GA9980@Mani-XPS-13-9360>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-2-sravanhome@gmail.com>
 <b0e29fe8-c16a-e783-8877-d01f052ba963@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0e29fe8-c16a-e783-8877-d01f052ba963@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 15, 2018 at 02:35:53PM +0200, Andreas Färber wrote:
> Hi,
> 
> Am 15.07.2018 um 14:31 schrieb Saravanan Sekar:
> > Add REGMAP as dependency to avoid undefined reference to regmap symbol
> 
> Is this a bugfix for S900? Then please add a Fixes: line. If not, why is
> it a separate patch and not in 3/5?
> 

Yes, this is a bug fix for S900 clk and should have Fixes tag.

Thanks,
Mani

> Also, the subject is fine as is, but please add a full stop at the end
> of the sentence in the commit message.
> 
> Regards,
> Andreas
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
