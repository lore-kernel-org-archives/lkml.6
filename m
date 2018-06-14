Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0FF8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55668208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixGk8OQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55668208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbeFNIb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:31:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40566 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeFNIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:31:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so8078707lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pkQYusjVpGAy+K+HJh/6A8FTJTW+3NJp75tnMGTCt0=;
        b=ixGk8OQZg2ntCFTwV/QCXReukp+PBM6uJomgSncGTh9alYV0SokxIJOUqortn/qKvN
         4pc0Yqv85b2bR+ncWMo3njhEEQXtFSUGNmVep+FOR6LPK9uQ/qclEeu+ETBBnVecQSs3
         dLLQaCNCih5SJIeMx/g4sx0i2Uy5diXo3+I18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pkQYusjVpGAy+K+HJh/6A8FTJTW+3NJp75tnMGTCt0=;
        b=mjI8Xb0giSKHb1PgaG83N/VvXiU6Wh74hTo20Kx4y5wvg6vzDWLNwncWNbExsgQjFv
         W9kfe4dk+KOspQ2+o4OtrdBNmsD3XuZBom0GNozb6puUaXI07tsyYo6vV/Uhv9qcr92K
         +B/Ob0w8gF2+c1Gt4hfotbWuJ98L9GOHbvbF46TiyxGvYdlSemlAk1DvOEKZQNZG4Ejl
         bpFOp94WGFdINnCkI4PyuABnAWH+aQSgy6wFmF5L2qx+B/Zfw5pkROPtiABnPAlGKQo0
         v/LC+ZJ9i05EdQ/JAvecAPq1qXysZjRzxbZetIoP8I7RXHWjDmH3uliYU8mIGnSBtqyS
         eKzA==
X-Gm-Message-State: APt69E1fWaNutq+MkwD8KvqyFMHJsGZlgc6wqVzFfr1tNeIjNnBFJTmR
        WiQZv3N42exGZgtn2FJhni1YZQ==
X-Google-Smtp-Source: ADUXVKKbmflijsmWSTMG8FL47fw2j4qpv5TRAxtcM9nYCep6zikwKAiLayDxegy7K2EJZzf7w7NbDw==
X-Received: by 2002:a19:e218:: with SMTP id z24-v6mr5126970lfg.132.1528965078593;
        Thu, 14 Jun 2018 01:31:18 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id f4-v6sm849507ljc.22.2018.06.14.01.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 01:31:18 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:31:16 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
Message-ID: <20180614083116.GA18093@centauri.lan>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
 <20180613125401.11734-6-niklas.cassel@linaro.org>
 <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
 <CAFp+6iEfd_iBCUtuYbe+vsc31BSC2UVee6YNNSGX5XxMMjJ=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iEfd_iBCUtuYbe+vsc31BSC2UVee6YNNSGX5XxMMjJ=aA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:08:10PM +0530, Vivek Gautam wrote:
> On Thu, Jun 14, 2018 at 12:05 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > On Wed, Jun 13, 2018 at 6:24 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> >> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> >> we unconditionally include the soc/qcom/Makefile.
> >>
> >> This opens up the possibility to compile test the code even when
> >> building for other architectures.
> >
> > Why do we want to do this when all of it is qcom specific?
> > Besides, wouldn't this increase the binary size for other platforms.

To be able to compile test drivers that select some of these Kconfigs,
even when building for other architectures.

The binary size shouldn't increase if they don't enable these Kconfigs.

> 
> Sorry, my bad. Send the message without completing.
> 
> Besides above points, the COMPILE_TEST flag should allow you
> to compile test all of these drivers. If COMPILE_TEST is missing
> in some of the configs, we should try adding that.
> Or, is there anything that I am missing here for the intention of this patch?

That is another alternative.
So either make sure that all these Kconfigs
have "depends on ARCH_QCOM || COMPILE_TEST",
or
remove ARCH_QCOM from these Kconfigs.

A third, and perhaps best alternative is to do like
drivers/soc/mediatek/Kconfig

menu "MediaTek SoC drivers"
    depends on ARCH_MEDIATEK || COMPILE_TEST

Make sure that our root menu entry depends on ARCH_QCOM || COMPILE_TEST,
that way we could remove ARCH_QCOM for all Kconfigs.

Thoughts?


Regards,
Niklas
