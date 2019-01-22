Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A1C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE2B2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119720;
	bh=9lt1vCoC4yQAu0DWBBkHAsioGnxrBvjgawKWU/tV0dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hNkRb2yawjuBRP/3cdhu9inrgcom2edXtk5rYSXzFG4w4ZdZyCsbagipfb4LdlFgG
	 ZgFzXXdRCkOw/QXlCDdybylsVZx9xYaeWCkmiaMeSOAKgHTp7MHBSSTrbrP+tg/YZc
	 8IC+G7pxCQoSlLh4clMxnIM2alVsk2AxcojQrLUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAVBPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:15:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44140 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAVBPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:15:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so22176931otl.11;
        Mon, 21 Jan 2019 17:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/gjR/NWp6EgQXjxlk/R3J7/ZJMZ099PMFRbddeLNIc=;
        b=Zah3e/wtSl0fLlwMZMexm1l75w7E7WnWsjOP4MmrVfBrtxNXRqPCT/btPtl9C0Ou3t
         rDz2a2jlCrNEG4ma8XtXdzLwSAsyqmWZZQ0iyzsLM6OnyoBmfsv+jxlR9WJ0VqBI9Jto
         xGGcxY17Y6lFeDqH7RMfPwUfqx7D46RRzAmcxi6AEvjkqKTqS4TC2KD0Tryii41ZEAKw
         aAYGvUvGhG6Ht33thH8IzHNJixIWdBXuude5DvGIt94B2YpcHvkI80/pb4J7JDjq4jfn
         91mnCcK5rDStOWJ6buJAiNJ/8wrVmIoLTeFgvtlAwYvgIW0XH0FIBzEXqmFTD85dXI9j
         TKJQ==
X-Gm-Message-State: AJcUukei9M84/XZ/T2dp3eTwir23/x2jog3DZVAIjSrS9bpnwRTaimEs
        6XuACRoBEhkkzYsoAiLlCA==
X-Google-Smtp-Source: ALg8bN7/deIR3/+N2v+/2Xd2Hzj/vJv312ZCBxFrmpC6ODC6wYF5DLFikaC7CKMO0SqHo2DzVyCiWA==
X-Received: by 2002:a9d:6a41:: with SMTP id h1mr21189113otn.332.1548119717134;
        Mon, 21 Jan 2019 17:15:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm6071233otk.31.2019.01.21.17.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:15:16 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:15:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Message-ID: <20190122011515.GA4487@bogus>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 18:37:52 +0000, Fabrizio Castro wrote:
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3
> 
> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
