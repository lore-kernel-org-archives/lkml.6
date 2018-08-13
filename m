Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F67C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1CD2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPWnE/8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1CD2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeHMRP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:15:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34500 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeHMRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:15:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id n96-v6so11407283lfi.1;
        Mon, 13 Aug 2018 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N8QsP45P9TyKOqlazk4KkUc5QJE+tPVRtLt4icyTMkE=;
        b=SPWnE/8fkXp/E4BFbrwpuud8JZFLgYM65ED84rLGR5/c4oS0zn96SdDL8APbsQphZ3
         iePxRPKQ2eq3CoC+OvE4z/KZl6sJMVkYD5w26Ysrc1CVsQ40nMSd4275qbXk9IkBogHs
         G7d0+90C4u/MmxxGI9DAIPabZSW6IB4rDm58cLzvJ/h6ZdTG1tnMjG9WOuGeVvdk4B3E
         2Hl3XZ/BjSGxc7PrAmnXJeaN45AgyNOefEjBTLb//TVdZ+Hwo/SLoR8PS3wT5pQsnzze
         MkE2qYrvm3/H9MrjsB1p+im7bxsQyxBbw2W9CsPx5h0sMm+jk2CymEeO/6pN+Cen4RoA
         T6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8QsP45P9TyKOqlazk4KkUc5QJE+tPVRtLt4icyTMkE=;
        b=HFqjhfHE4ZALlzchMoJjOzdRXafPE3EndIsCsIydPvwKbBDNbVjFWntx8f2oBRW8Sf
         o9mYqDXP9ksboNxrReL4pqg8Mh28AUaQ5g47/T52J8RCMC96gBeJtusTIGQg4Ktgy+zd
         S7GtiDhW/iyIz7BhFQg2wOTia9GSe+VtqbZXNtNtXooqMJLXYBZrhC3wGoqoAUWYjnc1
         rzM7jR7V/T1wFopx7QgHDrW9bV7wgOVNvkVCzrNliC7HGBytZH4eKDOJAPe9PRu5F4jb
         BXItpeZfws39/kNfUBZjWsa/NwbbmF3MS0Vx4ynBt4JwZHT+h92ISjGxJSoTTTgcyPpD
         czdw==
X-Gm-Message-State: AOUpUlH3N2ZxWsluHXdyWJ6RAiuUHpYEH0zmkkzE8U3/PbMMI5fAZGAi
        PC6eLImqnAGiB7k5Y6AZOV8=
X-Google-Smtp-Source: AA+uWPwX9UxaHNzcjhcVWmTngTD34oZyhXGp6+sBQp9ks/N1E2SAciTlatdjOHMVs15awLl1lPGvpw==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr10962726lfj.47.1534170802516;
        Mon, 13 Aug 2018 07:33:22 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h11-v6sm3075900ljf.27.2018.08.13.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 07:33:21 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fpDuH-0007Wk-2a; Mon, 13 Aug 2018 16:33:17 +0200
Date:   Mon, 13 Aug 2018 16:33:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: fix child-node lookup
Message-ID: <20180813143317.GI24218@localhost>
References: <20171115094458.31666-1-johan@kernel.org>
 <20180322142432.GA5853@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322142432.GA5853@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Thu, Mar 22, 2018 at 03:24:32PM +0100, Thierry Reding wrote:
> On Wed, Nov 15, 2017 at 10:44:58AM +0100, Johan Hovold wrote:
> > Fix child-node lookup during probe, which ended up searching the whole
> > device tree depth-first starting at the parent rather than just matching
> > on its children.
> > 
> > To make things worse, the parent pmc node could end up being prematurely
> > freed as of_find_node_by_name() drops a reference to its first argument.
> > 
> > Fixes: 3568df3d31d6 ("soc: tegra: Add thermal reset (thermtrip) support to PMC")
> > Cc: stable <stable@vger.kernel.org>     # 4.0
> > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/soc/tegra/pmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied, thanks.

I noticed this one still hasn't made it into linux-next. Looks like it
wasn't included in you 4.17 pull request and is still sitting in the
tegra for-4.17/soc branch.

Johan
