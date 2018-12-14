Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A462148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A22IHm4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A462148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbeLNMTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:19:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbeLNMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:19:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so5236233wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eIUK5nWAn2uC36oRMKMidszRM7NyLisUmwIIpwhEcXE=;
        b=A22IHm4Q+hXBEj4BPJJAjwQ6leLGE+N4lM1uPslmiYg3WUg9Fs13QWDL7lGJfupMmL
         NyZi2JYiPErVjEkOaQKlOUWjbLQ1UGV9tC4T4JBb2XdTxYdhggYGPchhcSmQny7bJ7l9
         CGNO3CHr74M4xc131fSnW44UjV7MjwCCXajRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eIUK5nWAn2uC36oRMKMidszRM7NyLisUmwIIpwhEcXE=;
        b=Tf22jum9PVXRVtsYMXKqpxOvk7WDHI/2wPP4EoviCmFlW5lRnxsApHPGzqinuJv3h2
         Knoy/c2pFdTk9MPAtYZsQzMtsCb2sojJ6yAnXJl4pjYIqvY6zESUArRWO6qUynHq2bNM
         L8SC4KvyDeHZJ+P3v3B+/RIV9lKlM/o2dmRiZgaV27Y+psRlLJ0H0nnaJQm1jumhK56T
         pYfCw3jNKYQKJlwz3GmYi4vjNEhOgmGeNiZuq4YVimDipL7ileYj5U9grHaL2EmmzhOG
         9/sSVQjG+qkQPHk1S19Jff83ys0H1pP7ltKNhjEtMeMjnw9fkNGMQlMlOtWNNs6oL+Xy
         8fCg==
X-Gm-Message-State: AA+aEWYusARn+8ZI0gzwBtWa0g0QhVQbHmTcjdR5pBjhQxXn6T7Nvzjn
        mNTJgJgdfngi63bOKy8h29KOKA==
X-Google-Smtp-Source: AFSGD/VXPPCdsVeUdGfGoTg+IREPnXTGxCXT4yek2W4VlYUQch3G5mcw2e3nyJqqVzZ4MOSRvUNynw==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr2258181wrv.101.1544789990945;
        Fri, 14 Dec 2018 04:19:50 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id 129sm5334813wmd.18.2018.12.14.04.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:19:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:19:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Use of_node_name_eq for node name comparisons
Message-ID: <20181214121948.GS4497@dell>
References: <20181205195050.4759-15-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205195050.4759-15-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018, Rob Herring wrote:

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/max77620.c |  2 +-
>  drivers/mfd/stmpe.c    | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
