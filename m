Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE693C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC51A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3417xV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGPmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:42:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37538 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:42:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so104101plr.4;
        Thu, 07 Feb 2019 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIgsqiuQR28DVR70vS/tR7cqO2gKsSLJxdOnp0Nf0dg=;
        b=h3417xV9nJRVKTGENqUROxdGpMPdwb4oZiIiJsujek4PMRDVtghhyD8VVgLODyfytN
         oDg+OB+gqmr92oNlQjtjjOlk2ySWEGo4cyD/H6rU8EH8FenTQQF+bIQ1fcJLsCyi+YZl
         qXxdiDm9mvwiXeHlFzqFBUW7PP+A4wuAC+9dNQr7WUfcVc9l0pf+Cey8BmiSeDA143lQ
         pkeU8UpPAKT2O//+OqW7IWgkUW3uqUDhULdZUFxQu7KHpjHa7FP131oP+aaQsRJs/Xoc
         wLauU0+l1YQsklC/7lwRpqGiL4KaNoxZV3k1py7CiD/rVZ3Y+ts4SurntkU480nbhQb5
         acTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIgsqiuQR28DVR70vS/tR7cqO2gKsSLJxdOnp0Nf0dg=;
        b=RhThiEqkwsiN6PGOOrKyufRrZn9IEHVQFq2035sJUHztIn/9FMofGTKK8sllWiPhv2
         3KuVLffSAh5ZrN36GmAMCk8ihOU09TklfK/AC/ICZ8mYdwwKjHQ1TJ+/jJxdoJpUmkz9
         495KDm6roDWhCBmiXgMOy/git5fUiVCIG2yVE3JJF4S+iojV8qvKBQ1JEGrmTx5k1yUB
         g27vXQ1oXgQMkVKUOoPxvHCE8w2/tAIWQ7k3OBOgmqs2ip9SmQmn+WX4AFV/hIzt925e
         XrQJiwJEcxY0DkxQdAaq5UNlX8gAmzYVTOuMAX1DaSBMiamBT4tnsS6/X/nNfEQaE711
         8r/g==
X-Gm-Message-State: AHQUAuaxCbIbVonhenNaxo74dvnIndFFW1/OgOcrbSAio1vIJhPMuNVj
        r8Ix6lTcbDg47wgsMFFOUJE=
X-Google-Smtp-Source: AHgI3IbicIP2yZbeFS7vGVKcZD3eNkaLdqvKjCk8gW7D89GUHUyn97SDf16i6XfIN2pgJBN0SgK7MQ==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr17534229plp.9.1549554151522;
        Thu, 07 Feb 2019 07:42:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm13088357pga.92.2019.02.07.07.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:42:30 -0800 (PST)
Date:   Thu, 7 Feb 2019 07:42:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Message-ID: <20190207154229.GA19277@roeck-us.net>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140418.GH20638@dell>
 <20190207153600.GA1920@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207153600.GA1920@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:36:00PM +0200, Matti Vaittinen wrote:
> Hello Lee,
> 
> Thanks for the reviews!
> 
> On Thu, Feb 07, 2019 at 02:04:18PM +0000, Lee Jones wrote:
> > On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> > 
> > > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > > drivers) and 4 GPIO pins which can be configured for I/O or
> > > as interrupt sources withe configurable trigger levels.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
> > >  1 file changed, 102 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > new file mode 100644
> > > index 000000000000..f80be7e40184
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > @@ -0,0 +1,102 @@
> > > +* ROHM BD70528 Power Management Integrated Circuit bindings
> > > +
> > > +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> > 
> > What's an Iq?
> 
> http://www.ti.com/lit/an/slyt412/slyt412.pdf
> Iq is an abbreviation of quiescet current. Do you think it's worth
> writing the whole words instead of an abbreviation?
> 
https://acronyms.thefreedictionary.com/IQ lists 23 definitions.
This one is not listed. Yes, I think it would be beneficial to use
the whole word.

Guenter

> Thanks for the rest of the corrections, I'll fix them in next version.
> 
> Br,
> 	Matti Vaittinen
