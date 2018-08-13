Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C14C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE62170A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9pbvlgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDE62170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeHMMEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:04:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33847 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeHMMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:04:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so7416651pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BiRABVhNXPPylZTd61kZsGBkZP4yNAljwr1Htvt5QA8=;
        b=Y9pbvlgC9VQR3DDE9Ah1y1ddDEKkx8AZ5lV6tlqZWLQQzY+kgy3bw1QZSI1yiaZD1l
         f6SP3tByAtxw4atFFdzasyfmXv0J5ywDxjq6zy9jhqLyOMNG6MhXm+YCEGQqv+ZmNE5Q
         f++FONkXNP3jNmIYbHXWWH52AUF2dSFQxQl7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BiRABVhNXPPylZTd61kZsGBkZP4yNAljwr1Htvt5QA8=;
        b=Q53pTMdxktw6qLIe/zyL6OpWHg58eEGlGpqz3YY9C7U7ov2S5aLat9S6AVN/RYTXma
         BRQwrecwDb0e5Q1DM/7Gs52dfxCqzZhRunuAxpjFcXJiwCfH7ntiRK6vgkPy22eiAcfN
         vmi6x6qNWoRO2LL4C3HTPZvSf8ZW87jsqjcSHwoubEnrb5cJmrMkb/vs4m/Ie/ezdMDO
         SQnqbFG49Z2CEjS4uzhUHzym2/LUMALdQXxps5FayIt/xo1qwnwTZaZeZsEnFSuCB+jY
         XqvgbZ8In2SX6CVcYzcBtJVlu5OfQx2lpyp0LOwHaYXpNUykYr7Qy8tliZaW9COYRhLJ
         gFZA==
X-Gm-Message-State: AOUpUlEA2v79/pthIkpFyaa8KLCGIHu18fkO+imvrXcBasmaMJP4k/vm
        LC0hY3qcIVcJR0BFlJIynaWF
X-Google-Smtp-Source: AA+uWPx7s/U0f9/zm4GwLaS0kxYWsAPlteIhUdonFUQplgHyMERdaRUPgcw7ZTfTk8Uv/KbBO0Ix/g==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr18197692pfa.61.1534152200783;
        Mon, 13 Aug 2018 02:23:20 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id l85-v6sm28843696pfk.34.2018.08.13.02.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 02:23:20 -0700 (PDT)
Date:   Mon, 13 Aug 2018 14:53:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Parthiban Nallathambi <pn@denx.de>, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20180813092310.GA27215@mani>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
 <20180813043406.GA16275@Mani-XPS-13-9360>
 <f1043a48-6c8d-cf08-d6a1-582d84ea2530@arm.com>
 <20180813091547.GA22149@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813091547.GA22149@mani>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 02:45:47PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 13, 2018 at 08:51:54AM +0100, Marc Zyngier wrote:
> > On 13/08/18 05:34, Manivannan Sadhasivam wrote:
> > > Hi Parthiban,
> > > 
> > > On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
> > >> Actions Semi OWL family SoC's provides support for external interrupt
> > >> controller to be connected and controlled using SIRQ pins. S500, S700
> > >> and S900 provides 3 SIRQ lines and works independently for 3 external
> > >> interrupt controllers.
> > >>
> > >> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > >> ---
> > >>  .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
> > >>  1 file changed, 46 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >> new file mode 100644
> > >> index 000000000000..4b8437751331
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >> @@ -0,0 +1,46 @@
> > >> +Actions Semi Owl SoCs SIRQ interrupt controller
> > >> +
> > >> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> > >> +in which external interrupt controller can be connected. 3 SPI's
> > >> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> > >> +the following properties:
> > > 
> > > We should really document the driver here. What it does? and how the
> > > hierarchy is handled with GIC? etc...
> > 
> > Absolutely not. This should document the binding, irrespective of the
> > operating system. The word "driver" is completely out of place here.
> >
> 
> Oops, my bad. I meant to say that we should add it as a description in the
> commit message.
>

...commit message of the driver patch (to be more explicit)
 
> Thanks,
> Mani
> 
> > Thanks,
> > 
> > 	M.
> > -- 
> > Jazz is not dead. It just smells funny...
