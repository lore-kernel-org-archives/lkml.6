Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C327420867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HP4/DIyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C327420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeLAJ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:27:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33892 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeLAJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:27:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so3468633pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9wVYqc8o/e2G1H2IPtIHLrZVxL0b+56hC6izUO5Mrdc=;
        b=HP4/DIyrRXfNpL3VXPo4MReUj0h/z+ISfGea2VyEm1o9T5jwNr+GjsmHnohMgVpGCS
         oEp0WQpBqYthiHwASlU5jsvKq00sKNGrn5XAV+uO5hG0bNhiA9SzFHxymsAD3z5wH74e
         xzf1mcH3E1Ex7MBzPkf0Vv+mJFdb/0fXoH28M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9wVYqc8o/e2G1H2IPtIHLrZVxL0b+56hC6izUO5Mrdc=;
        b=NDkPM0Xb2/GaA/j60lcC/x/ol69f6jCksRKtccLs9oVUOCEVgGz9iymp58BkgrDHYx
         PRz0YR7mWyF3RLcDbrumZyZHk8n83qiy9Xbm0OVNdfv0+4e25a3UayZ+v227la7MjmC7
         euKNdpLEQSZq+RbiGirqnydukY1sh5pS/L7dN/Pzasx/78HKO4y++RLugoLdEuzVS7pK
         9M7ID6yu54bo4wvwm3I8BZSmtHXwRPSSk2xnhy3wXu+haDmyLcK8pc6Uv9bV93Glr+Gc
         4/1QHd9ieHTxefO6fDDN6JCMJrN0n1mqkatASr+3DCjZUR0y/4MKsiG81/LZ3m3Ud3K8
         1KBw==
X-Gm-Message-State: AA+aEWaGlAZ4XgL3AahpOsDtYxkwBWkQLbHYCzRDeLgeNvPQyPXJpAJF
        5sWuDhTBaXC63K48R47ju5nU+A==
X-Google-Smtp-Source: AFSGD/X1yk3RJCA/+LYxoqBPASWBanT9bokBWLsaF9M6r/EgGBojn5Z3cY6DuyE/N4g9mRB+jXs8wQ==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr6220516pgn.205.1543616211329;
        Fri, 30 Nov 2018 14:16:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id r130sm10605534pfr.48.2018.11.30.14.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:16:50 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:16:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dsi: Add ref clock for PHYs
Message-ID: <20181130221650.GB22824@google.com>
References: <20181126231159.122298-1-mka@chromium.org>
 <20181126231159.122298-2-mka@chromium.org>
 <CAD=FV=WvXFpZDJGbdvvY=HL_=tDWyhKpTg7zu8s=gUuJgK1ebg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WvXFpZDJGbdvvY=HL_=tDWyhKpTg7zu8s=gUuJgK1ebg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:41:39PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Allow the PHY drivers to get the ref clock from the DT.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - add the ref clock for all PHYs, not only the 10nm one
> > - updated commit message
> > ---
> >  Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > index dfc743219bd88..b0485559a719c 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > @@ -106,6 +106,7 @@ Required properties:
> >  - clocks: Phandles to device clocks. See [1] for details on clock bindings.
> >  - clock-names: the following clocks are required:
> >    * "iface"
> > +  * "ref"
> 
> We can't quite make ref "required" because there are some old device
> tree files dating back to 2016 that would be broken.  It could be
> listed as optional, but I _think_ Rob is OK with it being listed as
> "required" for all new device tree files with the footnote that if
> it's not present then the code will still work.

Ok, will update the code to keep supporting old DT files and update
the description.
