Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CAEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE0320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R92vinCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE0320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeKHPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:18:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:18:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so8383632pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 21:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PipJVY5sFU16Qb6+h/dT5wHv56gIrPYtITAPBUsnwyY=;
        b=R92vinCBec0veUAkmYgsV3/GSuERVmuaXKcrOjOgvspe6hA91dbk155Xj5Wx43yXfq
         Z1J56Gsw/+0JRHP27I9egv+ZF39k09rkScTnEgTIxRx9lH0G1s9juFPHAr1DiM3veOzA
         3EdZj9OCDR7XA35+vYHCWOU5tVmeXUZakDEGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PipJVY5sFU16Qb6+h/dT5wHv56gIrPYtITAPBUsnwyY=;
        b=lhYv1SYfK6Di5nnxldnpcoT1Tcr0cvlSgpJbEr9v0+wl3hfbpbTKy0/HWkkvbI3p+G
         Vmy9O+4+RE1F9W3lmfRpHZcu/JSA0q+/MS04QyiXotO5D2PuQ6BcHEf65ZkW6Y6AZEB+
         OBEYJLxvFfQcAhdD4fQUV2K4SndFgQOIW9rkJjCEnZiDaLHm7pLlumUZg43J7Wd4DfzW
         7P7m0VRePsoZ+v5CQLQ/WQ+YwYWwaQ6msUO6CcT8aB09u7f4BjnPS86F5hJB7ZR7oAFw
         NWZnnkBmiieLCMlImNJJOHpLsn9gv9GP2TfuyrukUJWOlq/nAJaifdl7/pr1H1O/vHQ8
         FunQ==
X-Gm-Message-State: AGRZ1gKvjy7Ug9aXERLmwFFM4cW/a4kgTWtxehXlyK4SRidDxvmJTHGD
        tWf+EFLqAz1sHLm3yErfAt904A==
X-Google-Smtp-Source: AJdET5f7IM3DZPEmaY2FffV5uY9Yxub4JKyeMLgK/k1xJ3iiICR9jQ0Hxjg8r7TqTmDD0zu22I7BQA==
X-Received: by 2002:aa7:8348:: with SMTP id z8-v6mr3228077pfm.81.1541655895681;
        Wed, 07 Nov 2018 21:44:55 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 3-v6sm3074259pfw.17.2018.11.07.21.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 21:44:54 -0800 (PST)
Date:   Wed, 7 Nov 2018 21:44:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: clk: Introduce 'protected-clocks'
 property
Message-ID: <20181108054452.GD2337@tuxbook-pro>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181105194011.43770-2-swboyd@chromium.org>
 <20181106010426.GX2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106010426.GX2523@minitux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 17:04 PST 2018, Bjorn Andersson wrote:

> On Mon 05 Nov 11:40 PST 2018, Stephen Boyd wrote:
> 
> > Add a generic clk property for clks which are not intended to be used by
> > the OS due to security restrictions put in place by firmware. For
> > example, on some Qualcomm firmwares reading or writing certain clk
> > registers causes the entire system to reboot, but on other firmwares
> > reading and writing those same registers is required to make devices
> > like QSPI work. Rather than adding one-off properties each time a new
> > set of clks appears to be protected, let's add a generic clk property to
> > describe any set of clks that shouldn't be touched by the OS. This way
> > we never need to register the clks or use them in certain firmware
> > configurations.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

Gave this some additional thought. The way this is blacklisting
protected clocks makes it impossible to be backwards compatible with an
older DT while adding new protected clocks to an existing driver.

I don't have better suggestion for handling this and the problem should
primarily be isolated to the beginning of the upstream life of a
platform, so perhaps we can just ignore this issue?

Regards,
Bjorn

> Regards,
> Bjorn
> 
> > Cc: Taniya Das <tdas@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../devicetree/bindings/clock/clock-bindings.txt | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > index 2ec489eebe72..b646bbcf7f92 100644
> > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -168,3 +168,19 @@ a shared clock is forbidden.
> >  
> >  Configuration of common clocks, which affect multiple consumer devices can
> >  be similarly specified in the clock provider node.
> > +
> > +==Protected clocks==
> > +
> > +Some platforms or firmwares may not fully expose all the clocks to the OS, such
> > +as in situations where those clks are used by drivers running in ARM secure
> > +execution levels. Such a configuration can be specified in device tree with the
> > +protected-clocks property in the form of a clock specifier list. This property should
> > +only be specified in the node that is providing the clocks being protected:
> > +
> > +   clock-controller@a000f000 {
> > +        compatible = "vendor,clk95;
> > +        reg = <0xa000f000 0x1000>
> > +        #clocks-cells = <1>;
> > +        ...
> > +        protected-clocks = <UART3_CLK>, <SPI5_CLK>;
> > +   };
> > -- 
> > Sent by a computer through tubes
> > 
