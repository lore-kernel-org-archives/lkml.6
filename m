Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44B0223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7UylKMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44B0223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeKNDMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:12:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38454 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbeKNDMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:12:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so5977862pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQFOYvKd7ujGq0kWl7JAh6wTAudeGvp6jbH2cWAtGXQ=;
        b=b7UylKMqQnF0T1eFa51fCkxNJajM8kX+TP1rZXvWIgDNo/vmb7ApDyzSNwqbjFrtGx
         h2yjT7jtFxCGYr2FzDUK1TyIqMYKC10/qUG33O/CZqdpXvzcDkSKPKlBhsIszNZjL/3E
         JHHzBiiqTvoTNRf0Q3xlTUGiHBlQbVdN3PDeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQFOYvKd7ujGq0kWl7JAh6wTAudeGvp6jbH2cWAtGXQ=;
        b=BqjF0ufAohYzwChWl0vDjsLukxISCnvthR0bFZwjQkyy4BhZC0gZJBTwYlzyTnmECp
         ypxthq+hPfwmfVX1stegWqd7kk9WcoIAEpSRaFWZRJJgf5kYL09MrpZoVNngV+H/KS6E
         Oi4ZnX8zRum7TdBeREDP1T08vWmrwY65UYdj5UZNppdlzvkBhPbnm5ZdzfSncD2qeEBL
         PSWG0o7yL2ujvpNs5SOXsspWUyxpjJhb2PriA1jflWVNFnIPeDiVJBi2zk1wMA1pefRp
         4rN2I2UWM6nnDG8j5vseNgVgs5r1k9R6zF+ve5bjVAw7uOsuf0oWoTwBm3A/tckWMN28
         97jA==
X-Gm-Message-State: AGRZ1gLCUhIo+2Ba01KspRZTQH4ZpwyHdQc/R5vwKo+kT3sifnityRpd
        pIeAzJJG/PHvRK+Fx/Gx2hacRb053c0=
X-Google-Smtp-Source: AJdET5cxEXgXvYmSz4Akc7FyjOzbqOCyiG7RzE4CzqqPK51ClmRaCmAmlfxF8nPiSyXy5LXFzV5hZQ==
X-Received: by 2002:a62:89d7:: with SMTP id n84-v6mr6027119pfk.255.1542129195336;
        Tue, 13 Nov 2018 09:13:15 -0800 (PST)
Received: from tuxbook-pro ([206.181.83.18])
        by smtp.gmail.com with ESMTPSA id z13sm20130388pgf.84.2018.11.13.09.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:13:14 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:13:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>, ohad@wizery.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
Message-ID: <20181113171311.GE10915@tuxbook-pro>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
 <20181112152342.6561-2-benjamin.gaignard@st.com>
 <20181113021337.GA7237@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113021337.GA7237@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Nov 18:13 PST 2018, Rob Herring wrote:

> On Mon, Nov 12, 2018 at 04:23:39PM +0100, Benjamin Gaignard wrote:
> > Add bindings for STM32 hardware spinlock device
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Linaro or ST? Please make the author email match.
> 

Thanks for the review Rob and thanks for spotting this.

@Benjamin, please resend the driver and dt-binding with matching author
and sob - or if you wrote this as ST and want to send it upstream as
Linaro add your new sob after the ST one.

Regards,
Bjorn

> > ---
> > version 3 :
> > - fix clock name in properties description
> > version 2 :
> > - change clock name from hwspinlock to hsem to be align with hardware
> >   documentation
> > 
> >  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > new file mode 100644
> > index 000000000000..adf4f000ea3d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > @@ -0,0 +1,23 @@
> > +STM32 Hardware Spinlock Device Binding
> > +-------------------------------------
> > +
> > +Required properties :
> > +- compatible : should be "st,stm32-hwspinlock".
> > +- reg : the register address of hwspinlock.
> > +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> > +	hwlock, so the number of cells should be <1> here.
> > +- clock-names : Must contain "hsem".
> > +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> > +	common clock bindings.
> > +
> > +Please look at the generic hwlock binding for usage information for consumers,
> > +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> > +
> > +Example of hwlock provider:
> > +	hwspinlock@4c000000 {
> > +		compatible = "st,stm32-hwspinlock";
> > +		#hwlock-cells = <1>;
> > +		reg = <0x4c000000 0x400>;
> > +		clocks = <&rcc HSEM>;
> > +		clock-names = "hsem";
> > +	};
> > -- 
> > 2.15.0
> > 
