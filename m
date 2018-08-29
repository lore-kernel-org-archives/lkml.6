Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24ABC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC832084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeWDemmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC832084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeH2LuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:50:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41402 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:50:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so3498347lfc.8;
        Wed, 29 Aug 2018 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=exfC6yQvuC0XyuOW1k1cLm7trC1MtDmQCj+JF/9GGLE=;
        b=JeWDemmtdN1FfReIf8UalPHI3cwb30l0asn6nrUBrUWoEZMl5EGyz0NSwCXFBn09vC
         YRrphy9uKJwvwwe7fnnBH2HHJOjyMHC2WmMB+nPUL2GGEw2JT2ZLAtuCbaY53bmdV5J9
         js8vQhsVXNpk/jB6UJ2MylyEfcDmiitxEmc6LpUWLZ0osRbgnFlR5DxWKqOVFJubwD1/
         iBNWVgwC8EDe/lXB1H23njIALHK03UnZJiNieJOEQqxuRMdCHTZ2n1My3ylCDQKmxNGg
         S2EEZkrzsmbFXi1MOo93ucyY1orCwUg3D4Vt1VFxSLiHYwCrj2Ad+Dd09VHeOUSe+ZCK
         p0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=exfC6yQvuC0XyuOW1k1cLm7trC1MtDmQCj+JF/9GGLE=;
        b=JtpwGgmjZLO8sVBxKPCl6aJveC2wGVarpsjYsDX8opFrNOeRYWJvhQ+gXczafx8AC7
         eHyW7qqTdi2HKerP2MQ0JrkOEsG04tCBuFVT+AvXwr4C5uxIN1G8s9GsHWnhji/3LHPL
         +wOFBgrvmSbjtQihFMxm5UXZ58/KRJ0rzJVp3psrUVozwT5qOLw6f5j9ov8sWx6K9XhV
         +proUPOFhAUfQnZhvmAbPsSUMS3J4Ga+n+5JdYMU9b8hBtkKrqhsJl5ourEiUKUUKlp2
         sYrsGu4H9x2TXmFc6PZDgqIl6GjcGGq+PmisJKU/jcfEi/DlNcED3mEUKjfaNQDhZAEm
         pOOg==
X-Gm-Message-State: APzg51BYrmuMSvSE+9IAxPbMJKJi/qka9hhHZLlwqopLZDFLompqpsCK
        FIZEStXWsHHuT3nT4TLbG4g=
X-Google-Smtp-Source: ANB0VdZHEpbcH1CZ8vMbIuKsUFF3LC55jIOx4r9ettTsGrbpGJXuEc9j3sjIqL6380djLK0VARDjyw==
X-Received: by 2002:a19:1ac8:: with SMTP id a191-v6mr3405756lfa.54.1535529270235;
        Wed, 29 Aug 2018 00:54:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n23-v6sm572480ljh.77.2018.08.29.00.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 00:54:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuvJ7-0007a2-La; Wed, 29 Aug 2018 09:54:29 +0200
Date:   Wed, 29 Aug 2018 09:54:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        maxime.ripard@bootlin.com, wens@csie.org
Subject: Re: [PATCH v2 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Message-ID: <20180829075429.GD28861@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-8-johan@kernel.org>
 <20180828080624.GA25644@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828080624.GA25644@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:06:24AM +0200, Corentin Labbe wrote:
> On Mon, Aug 27, 2018 at 10:21:51AM +0200, Johan Hovold wrote:
> > Use the new of_get_compatible_child() helper to lookup the mdio-internal
> > child node instead of using of_find_compatible_node(), which searches
> > the entire tree from a given start node and thus can return an unrelated
> > (i.e. non-child) node.
> > 
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the mdio-mux node). Fortunately, this was inadvertently
> > balanced by a failure to drop the mdio-mux reference after lookup.
> > 
> > While at it, also fix the related mdio-internal- and phy-node reference
> > leaks.
> > 
> > Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
> > Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Cc: Jose Abreu <joabreu@synopsys.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> You should have CCed sunxi maintainers 
> Maxime Ripard <maxime.ripard@bootlin.com> (maintainer:ARM/Allwinner sunXi SoC support)
> Chen-Yu Tsai <wens@csie.org> (maintainer:ARM/Allwinner sunXi SoC support)

Yeah, I cut down the CC list somewhat (I think because they didn't seem
to be actively involved in the stmmac patch handling). Thanks for adding
them back.

> Since I am just back from holidays, I will test this patch this week.

Thanks, that would be great.

Johan
