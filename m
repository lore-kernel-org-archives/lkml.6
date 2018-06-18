Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B382CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DDA208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyvmNVa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DDA208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeFRGDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:03:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53636 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeFRGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:03:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so11937116wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k6bnrIqU2WNDnd0azggyasmPkNN2l3o9lOrxHseHY1I=;
        b=AyvmNVa1V0e1ubyrhHZohwFHp6F9oW/Ji9HeRBcmG1QVq4MDQvcp8HXIg92yjPrKb1
         uGm0V28/h/tb+ZnfO03OAvWlEJk4kKELxWQVqoNAbaDCyxARjlsIwS7DIGsZwFQQM2Bz
         5fEIINC/cEXaH2wuvEX/hHQASybwFMrYSMxTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k6bnrIqU2WNDnd0azggyasmPkNN2l3o9lOrxHseHY1I=;
        b=BetDBtTHbLYz1MF053KPlZGt/uF229OphAcgy5XqbKKcOntGumWCz4d5iexWsVmFJB
         mENKmQX5NfYtJGCjjKeUNDHRKccFq1rNp6ohW52LEbdnTyl2duSlm6ybaN1NstdpmV6I
         BaXxqbEhRCKuw96yym/DiSLZyDbddWIIZQHHK5abJy7xWpwDh6byZ6EKMVaDN/FQ7/kj
         e9JD1lpsuJQqBD0QipAXyq2IgbYEezkiLCRamu1VnmHYGgCsLyn/3HHZVESVU0buYav9
         Pfjmk3/hWveNw8csY/dojNcwq/wAryKY1GDXYIYQ81oFm5TamvfDzIjr4KlgteU3AdS8
         2VWQ==
X-Gm-Message-State: APt69E1vRF4Sx16Te7GJNTwSLvpNYMwVvJkPxsOhtbk+gwv6590PA0w9
        W5J+xCVWgbzG/Q3ZTeBga2EjZw==
X-Google-Smtp-Source: ADUXVKK/2XoWVeLeUnp/dM0NDZQXEvwtEM7YVe3JmrNNl+crqnRJnkaLs2S79oZV+PVgrEYqT+Iydw==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr7064435wmd.48.1529301788633;
        Sun, 17 Jun 2018 23:03:08 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id q17-v6sm15008059wrr.7.2018.06.17.23.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:03:07 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:03:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH linux-next v5 07/13] dt-bindings: mfd: Add a document for
 PECI client mfd
Message-ID: <20180618060306.GD31141@dell>
References: <20180601182216.23894-1-jae.hyun.yoo@linux.intel.com>
 <20180613061637.GI5278@dell>
 <2b5bbf01-8c9c-bb06-4559-00dae61d95de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b5bbf01-8c9c-bb06-4559-00dae61d95de@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Jae Hyun Yoo wrote:

[...]

> > > +Example:
> > > +	peci-bus@0 {
> > 
> > 0?
> > 
> 
> Because the actual reg value of the peci bus is reg = <0x0 0x60> but
> anyway it's an example.
> 
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > 
> > No 'reg' property?

0 is fine, but you really should have a 'reg' property.

> This is the actual peci bus node which is a parent of this MFD node:
> 	peci0: peci-bus@0 {
> 		compatible = "aspeed,ast2500-peci";
> 		reg = <0x0 0x60>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		interrupts = <15>;
> 		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> 		resets = <&syscon ASPEED_RESET_PECI>;
> 		clock-frequency = <24000000>;
> 		msg-timing = <1>;
> 		addr-timing = <1>;
> 		rd-sampling-point = <8>;
> 		cmd-timeout-ms = <1000>;
> 	};
> 
> > > +		< more properties >
> > 
> > Remove this.
> 
> I dropped all other properties into < more properties > because I want
> to show the #address-cells and #size-cells to state its sub-nodes
> should have a single unique reg value. Should I remove this line or the
> whole parent node?

Just drop the properties which are unimportant for the example.  You
do not need to replace them with anything, especially with a non-DT
compliant string.

> > > +		peci-client@30 {
> > > +			compatible = "intel,peci-client", "simple-mfd";
> > > +			reg = <0x30>;
> > > +		};
> > > +
> > > +		peci-client@31 {
> > > +			compatible = "intel,peci-client", "simple-mfd";
> > > +			reg = <0x31>;
> > > +		};
> > > +	};
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
