Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA242C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEDC2609B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPZSv7Mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEDC2609B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965079AbeFYUDJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:03:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33560 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeFYUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:03:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so7329253plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sokIicXIPgBAhVOJKif+RO8kNxqKf/gf0LGtLUvwSZg=;
        b=BPZSv7Mh7seaiRARlwoyp+UhdzcqKOGN7dxt6SA/O3bCoV+J+1TsPmBcSEUS404OWj
         2BfcjhAPshT3if/5tvD2267002s1CnfKE4ZTWzI4BZdU1N1Wexpc8F8whK+cHbJNn1u9
         uOdBva6DN71/K80EMCOntx3/JL9qLL5gisFMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sokIicXIPgBAhVOJKif+RO8kNxqKf/gf0LGtLUvwSZg=;
        b=SppqlMhOdzihA1HiWVZ6b1XwUTyZyZd7so/QJDTsCJFTr5w3ox7bwy0POB6yp1ncR1
         CneemJELC+k60Siw4mCHZul09dw7j+kyzuqshVID0Gt6q0dZy4TOfbNbvt/CJlEAYAI8
         Z332HA7ffJbz1GlLPwf+Pujodh4L03OCh5eBKGwJf/uLucOxUiWpZrgijRb4zy+1NTb+
         ZDbDxFsUmLRvpkIYMhMBIgCCY4SyLQYYlffD0KSWIElYlQ/56+TMsLKw8urLvvnKaYN8
         pWD+42lfDk3QlFJl9QjWToyyFhP31wPIt4de1fYvLiqi/nzbRvaX3irIOWTOuIZtRAip
         8N7w==
X-Gm-Message-State: APt69E0Onu31FWFNCjoZolWDk5N5tsBHJ6U8fNuW2OhGPXKbwcxwiioS
        Ho4dXhGPX4yxoI49rLHMXAVV8g==
X-Google-Smtp-Source: ADUXVKLqJPPlwtLV9tqNcyd89XsntKuvItPA+ObjU5UgzBMMuRX9OoTkiMC6q6ahGZ1zNCkbNV1tKA==
X-Received: by 2002:a17:902:bc85:: with SMTP id bb5-v6mr3255732plb.229.1529956986188;
        Mon, 25 Jun 2018 13:03:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id y14-v6sm6236520pgo.22.2018.06.25.13.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:03:05 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:03:04 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers
 property
Message-ID: <20180625200304.GF129942@google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-10-mka@chromium.org>
 <20180625153341.GB23270@rob-hp-laptop>
 <20180625185037.GE129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625185037.GE129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:50:37AM -0700, Matthias Kaehlcke wrote:
> Hi Rob,
> 
> On Mon, Jun 25, 2018 at 09:33:41AM -0600, Rob Herring wrote:
> > On Wed, Jun 20, 2018 at 06:52:34PM -0700, Matthias Kaehlcke wrote:
> > > The optional opp-throttlers property is used to configure the throttlers
> > > (see drivers/misc/throttler/*) that use a given OPP to throttle the
> > > corresponding device(s).
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > Changes in v4:
> > > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > > 
> > > Changes in v3:
> > > - none
> > > 
> > > Changes in v2:
> > > - patch added to series
> > > ---
> > >  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > index c396c4c0af92..747e79740c75 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > @@ -170,6 +170,9 @@ Optional properties:
> > >    functioning of the current device at the current OPP (where this property is
> > >    present).
> > >  
> > > +- opp-throttlers: Array with phandles of throttlers that use this OPP to
> > > +  throttle the corresponding device(s).
> > > +
> > 
> > I think it would be better to make this a boolean for each OPP entry and 
> > then add "operating-points-v2" property to the EC node to point to the 
> > OPP table.
> 
> Thanks for your suggestion. "operating-points-v2" would have to be an
> array of phandles, a single thottler can have multiple throttling
> devices.
> 
> > Unless there is some need for a different throttler for each OPP entry?
> 
> Having the option to use different OPPs per throttler would be my
> preference. E.g. there could be configurations where one throttler
> only interacts with certain throttling devices and another one
> with others.
> 
> I see another option to achieve this, if you don't like the reference
> to the throttlers in the OPPs. The throttler could have a list of OPPs
> (as phandles, not frequencies as in v1). The main inconvenient I see
> here is that the used OPPs would need a label, which they usually
> don't have. Maybe this is no soooo bad, since the label could be added
> at device level, only on devices that use a throttler, so it wouldn't
> clutter the platform .dts files.
> 
> This could be a single array with all OPPs from different devices,
> or multiple arrays, one for each throttling device:
> 
> throttler-opps-0 = <&cpu0_opp_03 &cpu0_opp_05>;
> throttler-opps-1 = <&gpu_opp_02 &gpu_opp_04>;
> 
> My preference would be multiple arrays, because it's easier to read.

I take the preference back. The OPPs for each device (group) can be
clustered within the single array and if needed clarifying comments
can be added:

throttler-opps = <&cpu0_opp_03 &cpu0_opp_05  /* CPU0 */
	       	  &gpu_opp_02 &gpu_opp_04>;  /* GPU */

This is simpler algorithmically and there is no need for an additional
property indicating the number of OPP groups or probing.
