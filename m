Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F061C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66E22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66E22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeICJs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:48:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41704 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeICJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:48:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so13105006edd.8;
        Sun, 02 Sep 2018 22:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhGmmpnGzP1NJgRkAEvFuEqstt1qNlInDAwLwpeR7pM=;
        b=PvYyrnfsV7KkIQj6GD8o01IuHN3GTS82yjSL8+pHOJpjUkWycuC7SCPvtdEMe3/hbY
         Y99EASAJKzv7+Jb12NAvie2DKB2nqZtxotYf5bh8wi21Cr5z80g3VaJTIvEJF+gs0l0R
         COEDw5fT6Ecpj20p6GG0DgUZvAH8zW/yufJahY0jXyYvl30UhtzcPyhcFFlG0JoanE0P
         P9qVQXepD2kt4zcaamIPf1QpBQkB8WXbejUNCJEVBIWViQrJrODHQFpf2kbhMCmHrhwa
         FaiFuE37LTeSCd9Lsux0RLiUlb4mFxQ+pRQeRTLo7G4gLOhtnK0YORdGaOiMrC0ULAL3
         xCXw==
X-Gm-Message-State: APzg51ByEMLU9OdGYSLtEysyPX2J2tmXO7ysGXvAAwUXv6CUBAMGvFPU
        BP7EW5YGiTHkBsGptqruQE4CPLBp2u8=
X-Google-Smtp-Source: ANB0VdYsTSF78+rDaKVQeOSwlxF9oc5S+w1GZ0Ly5rMyPbGUis6I32mOFcrD1vfRes8FJE61FPhHhw==
X-Received: by 2002:a50:b6e3:: with SMTP id f32-v6mr30209461ede.147.1535952592585;
        Sun, 02 Sep 2018 22:29:52 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id m35-v6sm7443569ede.14.2018.09.02.22.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 22:29:52 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id v90-v6so16458353wrc.0;
        Sun, 02 Sep 2018 22:29:52 -0700 (PDT)
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr16585453wrl.26.1535952592210;
 Sun, 02 Sep 2018 22:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-12-robh@kernel.org>
In-Reply-To: <20180828015252.28511-12-robh@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Sep 2018 13:29:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64axajQmvjt4Ht=3AG2Ybou_VP7v_m6mk4aa7CKyPDYbg@mail.gmail.com>
Message-ID: <CAGb2v64axajQmvjt4Ht=3AG2Ybou_VP7v_m6mk4aa7CKyPDYbg@mail.gmail.com>
Subject: Re: [PATCH] clk: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  drivers/clk/sunxi/clk-mod0.c        |  6 +++---
>  drivers/clk/sunxi/clk-sun9i-core.c  | 20 ++++++++++----------
>  drivers/clk/sunxi/clk-sunxi.c       |  4 ++--

For the sunxi bits,

Acked-by: Chen-Yu Tsai <wens@csie.org>
