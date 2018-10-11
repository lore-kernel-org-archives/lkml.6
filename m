Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303E20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAze/UyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8303E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeJLCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:40:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbeJLCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:40:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so4630564pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=++k8ifpE0Q65NzNF7h1RxzP6iJhJW0ZkTU9/8fMYaaU=;
        b=JAze/UyZvABjd6VjWwB83GTSMN516DY9yZu9RW4HggUnQdkJHKqK/hX9KLdUXjgVIC
         u5ROLtYbzIvsgpJO6QNUzBRek0iph0+KPqAKQ/j5RKP2ehkEB78GMX0cVwL7JLcvtTLA
         ov1/0bNoZGBvWrbezRAaWhsRszvBdiZ4hx6T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=++k8ifpE0Q65NzNF7h1RxzP6iJhJW0ZkTU9/8fMYaaU=;
        b=SF30VCAExAHXY/xwtwLgKP3b+UHSQ4uHTV3sLAODbuw6gJXG3wxaTSTDuNG5vALTZR
         2Fazq+e1qXdfmHKjXwv+MYCT0ctXPl8RU8nCj1FI/StbRC49W4WTalkXTOyvncM/inUg
         IpEFejZ5J8KT7famtXXjFJc3PQZkBvSBhV/6JyA1krFK66oXPhP+uIgWy0yfz7BTrh7Q
         tktnwZ9UgAW5Vc9ChGMIQxQjib0pPXglxD4FeB5XZf2F7VIGvzKY/JwuZWN3/9n0kem0
         j2+6qYwDdEAUVsQWw4hAYRKsE1bCWtFmwbfHPMmdWs7g8OjyIxMNgbTlEvlJPINW9LGQ
         1AsA==
X-Gm-Message-State: ABuFfohs90mLFvgdDCIU8NSefP2v9oODPHG5SyZUTH7FRzX3Xntt+Wn0
        C+4dfhGqbxVKr8MtMsA9SBwS1g==
X-Google-Smtp-Source: ACcGV62Kt5eJyLgQ7yRVle+LnmPFi5zrJH0Vz7p8uKksB0GNTZGWaUsQK4hpd3kmdRRI4vLtOZ+DUg==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr2767127pfe.236.1539285095867;
        Thu, 11 Oct 2018 12:11:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id c79-v6sm40722095pfc.92.2018.10.11.12.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 12:11:34 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:11:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181011191134.GM22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005204743.GA17135@bogus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > The node has a reg property, therefore its name should include a unit
> > address.
> > 
> > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > DT conventions.
> 
> This is ADC channels?

yes

> If so, then DT convention would really be "adc@...". 

ok, will update

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - patch added to the series
> > ---
> >  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > index d0c188e5c922..ff7aa5038ba6 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > @@ -112,7 +112,7 @@ Example:
> >  		io-channel-ranges;
> >  
> >  		/* Channel node */
> > -		usb_id_nopull {
> > +		usb-id-nopull@VADC_LR_MUX10_USB_ID {
> >  			reg = <VADC_LR_MUX10_USB_ID>;
> 
> Defines are generally used when there's not well defined numbering such 
> as clock ids. Interrupts and addresses are generally well defined and 
> don't need defines.

ok, I'll update this to use literals

Thanks for the review!

Matthias
