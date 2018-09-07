Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD20C20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rs/RHvn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD20C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIGM2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:28:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42946 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:28:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so11484063ljc.9;
        Fri, 07 Sep 2018 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSppJxZDLiYI5JwlJetfIps7a66u7/JgXK30mXlpI5s=;
        b=rs/RHvn32V0EpAE0CC1OkwtJVDegMIRIgN3TwFOCNCYSmp7jyU6hhTTn/HSR6bJrNG
         1CJ1gNhvWHj7fxOPIGQro/VtehuZxRU+wi0EduYyubbTAfQsrpmINy1C6iQijYilrazk
         a1c8ldZs2VVfnRV9bCwoZN4Js53uUXYFlqRSilV3rET9Qtx7u3xAVHrkspuPOlWMdYHo
         oyI1fxuLNHE01GtudKeFoNrp7J0PYVbXuK5XopkR4T4aleyvOAGsk5DZIAFE3xu1iKmu
         OgprE/RB/KqHrk2chH+LP0pXyG/txDY6Sx6FD1EgCSIcLZSu5qrtwOh9o8kLcjPDD0tT
         dF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSppJxZDLiYI5JwlJetfIps7a66u7/JgXK30mXlpI5s=;
        b=HsS6qgWg0/a/DCOwABUxX8fyjBww8T+DYSvIZXmDuk1/FAuyqO2v7VOkREiI7BweOT
         gxO9LRGCLIZgl/FRXeQvwGzKXCZZy0wfpE+B6PJ18YpTQ0Gh7JZQ28Z8foWWubX+PxpJ
         I+E43SKb9nEsm3l54M3uM4GFTwOAwI0KUr5wvl7ZVQZoCtUdBb/HZBtX878HPc2uGBqA
         dBOMbYSLZKNRWbpQFowEzwZWA681Jecx9GSIzfI8OP2dswmhGUGT/eZpY6fZ5kHTJmQj
         QmlAX5zR9eBDnarzDXzI/WEL/VeUt1G0xndX3TGjBiJA597KHaIb6dCxh9L8/a7spdQm
         qU6w==
X-Gm-Message-State: APzg51DHGEgEFVk+QNcBCHiHsKulhktWH5Aik+u8OVYN9m5M+dXKoBrh
        98m0+SW3J/1t3Nslx9khHcI=
X-Google-Smtp-Source: ANB0VdbESM6qK+NcxnAtLAuJ9ZxhC2VcQu2kYbiHPDVPqMSezArDLemfWyBpdGKo9gngMe4LqH70Ig==
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr3862644ljp.12.1536306499939;
        Fri, 07 Sep 2018 00:48:19 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1160631lji.80.2018.09.07.00.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:48:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fyBVG-0004AP-O4; Fri, 07 Sep 2018 09:48:30 +0200
Date:   Fri, 7 Sep 2018 09:48:30 +0200
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
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Message-ID: <20180907074830.GF1089@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-8-johan@kernel.org>
 <20180906200337.GA15390@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906200337.GA15390@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:03:37PM +0200, Corentin Labbe wrote:
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

> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks for testing.

Johan
