Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C171C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14712077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEnhI+H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14712077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJLHTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:19:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeJLHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:19:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so4905988pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsEke3q7vDB4NkCT6Jw+DLcEdkMHhTAquA5LgV63JCU=;
        b=WEnhI+H/Iizlmp3ty6+6/gzChNFw+jXwPfvhxB1q5kDG/NTWg8X6fzGbvBPKOWjhz1
         trKxONGuxBDpjjxpNP0OSauEtUjGV0nmET/zua5H2SdolQkhEx9dEnVIqc+SZLzhAlka
         6sNVGj5dB/0gFJj8ylvBUjl3By9Ac+EHQlz1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsEke3q7vDB4NkCT6Jw+DLcEdkMHhTAquA5LgV63JCU=;
        b=P2WYGZvlKvwn/x3PDmcdx4ZT0TScwu03cxdFTi73u4jISZ2nPBC5gqUFou8nDGJ374
         HQTgGAg1duFX0be0PR638WQTsVbZqmmbphYypFz9S4T1i1ebxUUjZG5b4ScPNUT+UPbn
         KLQtKhmYQSOopB/mqp0q46aaqEMuQ/PuYJkxFW9uHZIUp8vm9bmA7JPSjz5UxROdcPZ5
         szHZZ4SlgQ4Xu4iwvAf5CoMD3y2sJ4QdHojUVukbRxLbs4Ho2ejQqLFS4BlADTIRbbkM
         D7mcdG2g/DJDh0Ha+RdL4XwAWA2A74PpPHuAexZiimLXrLflpHS2iCkCuQsVl98Q4sjv
         Ul0Q==
X-Gm-Message-State: ABuFfogoganpPcfu62O+FgxSS8pF4frraAssSPNVzpri3wjQ2o5z8ES8
        iBr5zlvF9+brqwhgMLn8LFa4PA==
X-Google-Smtp-Source: ACcGV60Pn737Q/ZLcsnfWI83DJwpukWXN+BhWOPC0FWKCPoFl1/AYdszvV9BuEpDNk7QvAcYImwOvA==
X-Received: by 2002:a62:6383:: with SMTP id x125-v6mr3602071pfb.13.1539301816501;
        Thu, 11 Oct 2018 16:50:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v190-v6sm44300668pgb.16.2018.10.11.16.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 16:50:15 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:50:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Message-ID: <20181011235015.GO22824@google.com>
References: <20180925210255.172734-1-mka@chromium.org>
 <153906464468.119890.12038987094612660933@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153906464468.119890.12038987094612660933@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:57:24PM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-09-25 14:02:55)
> > Add a global binding for the 'aliases' node. This includes an initial list
> > of standardized alias names for some hardware components that are commonly
> > found in 'aliases'.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/aliases.txt | 47 +++++++++++++++++++
> 
> Any chance we can get a documentation update for the devicetree spec as
> well?

I'm not involved in the DT spec process, but I'd certainly welcome an
update ;-)

> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/aliases.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/aliases.txt b/Documentation/devicetree/bindings/aliases.txt
> > new file mode 100644
> > index 000000000000..d64ed1c7eb34
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/aliases.txt
> > @@ -0,0 +1,47 @@
> > +The aliases node
> > +----------------
> > +
> > +The aliases node contains properties that represent aliases to device tree
> > +nodes. The name of the property is the alias name, the value is the path of
> > +a the device tree node that corresponds to the alias. The path may be
> 
> s/a //

ack

> > +specified as a string or a phandle.
> > +
> > +Alias names are often suffixed with a numeric ID, especially when there may
> > +be multiple instances of the same type. The ID typically corresponds to the
> > +hardware layout, it may also be used by drivers for a stable mapping of
> > +device names and hardware entities.
> 
> Indicate the numeric ID is a u32 or something like that?

ok

> > +
> > +Alias names
> > +-----------
> > +
> > +The devicetree specification doesn't require the use of specific alias
> > +names to refer to hardware entities of a given type, however the Linux
> > +kernel aims for a certain level of consistency.
> > +
> > +The following standardized alias names shall be used for their
> > +corresponding hardware components:
> > +
> > +  bluetoothN           Bluetooth controller
> 
> Can we use syntax like:
> 
> 	bluetooth<N>
> 
> to indicate that <N> is an unsigned integer?

sounds good

Thanks for the review!

Matthias
