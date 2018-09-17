Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A830A20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPCVp1+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A830A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIQXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:20:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:20:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so8019844pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0n27Y0KZP4fcr2F3cJpINodKqAfHaS1XztjQGCdZxY=;
        b=MPCVp1+1qtJ834SiNiyVZvKqOeErCicVYqf8eka4+V5oe5ih83zuSCNr8pE9JT+KpN
         /VtYvEw3P6mOKn9V0Od1TvnwiqDspXKD3ry7n2J1cRH2q5tGa08XQweSqk20u6n3X8Oh
         ZwyNOEtBuKDHWMRYYF/NPbEuDQ7rLwCoXap8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0n27Y0KZP4fcr2F3cJpINodKqAfHaS1XztjQGCdZxY=;
        b=bKnowRh+x5/yNoe/S9mFrpzB+z6YBy/7GFW1RyAfYaYBbgZ6cfcKR/ba0du3ZyjqAo
         W/tXsfS7ufgIWngQypj2KBqisiJbBpVIgxdBjon/bjLgxlXpsFgqYAeJJVrkk+5E7CFV
         aNCBj1YAF1+BrkvVNNQzFrphghkJN+cUvDfiBRiOBHfF6m/Cf7Ipc4TMtmjBu9PwEFnt
         teEKqi0XKgHEPWnhXPUQNMTBeEsRkwN9PM/jXzHVltQIm9H7TXcKHzplS8ZA0fh8VNoi
         /kX1NLHIkn/qhGNzsi7hENAHisxNONrPxme5CiFS85dwMVZ5sdv7ZrxGlif6tUtR1Ouz
         lAUA==
X-Gm-Message-State: APzg51C5JNUkCjoNQleF18tUHdG26tg7wg0w1XMfoQIH0Z/GxxcgPU6W
        mrFFlzVcTChMmCgnQKjqK9i0tA==
X-Google-Smtp-Source: ANB0VdYaEz23obCZ12b4vyuVMiGJG5M8HqTdLXAyipRvHdThjEQfVvQYOoAtCQF5VGJ+QzT8MvnFQw==
X-Received: by 2002:a63:170b:: with SMTP id x11-v6mr23794197pgl.364.1537206742838;
        Mon, 17 Sep 2018 10:52:22 -0700 (PDT)
Received: from centauri ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id e73-v6sm29183901pfb.153.2018.09.17.10.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:52:21 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:52:19 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: use correct pci address for
 address translation
Message-ID: <20180917175219.GA4157@centauri>
References: <20180509120135.25940-1-niklas.cassel@linaro.org>
 <20180917112149.GE7239@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917112149.GE7239@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:21:49PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 09, 2018 at 02:01:34PM +0200, Niklas Cassel wrote:
> > For PCI, the second and third cell in ranges specifies the upper and
> > lower target address for address translation. This target address will
> > be used to program the internal address translation unit (iATU).
> > 
> > The current device tree configuration will program the iATU to translate
> > CPU accesses to 0x08000000 to PCI address 0x0 (with TLP type MEM).
> > The device tree configuration also specifies that CPU acesses to
> > 0x0fe00000 will be translated to PCI address 0x0 (with TLP type I/O).
> > 
> > We cannot have both I/O space and memory space at PCI address 0x0.
> > 
> > The PCI code already uses the CPU address when assigning addresses to
> > memory BARs, so for memory space the PCI address should be the same as
> > the CPU address. This also matches how all other device trees using
> > snps,dw-pcie are configured.
> > 
> > The existing configuration appears to work, even if it is incorrect.
> > For some reason the iATU doesn't obey the existing configuration,
> > and doesn't translate CPU accesses from 0x08000000 to PCI address 0x0.
> > 
> > The reason why the existing configuration works at all is probably
> > because the default behavior, when there is no match, is to use the
> > untranslated address. This happens to work for memory space, since
> > it's a 1:1 mapping. However, instead of relying on this behavior,
> > let's configure the iATU correctly.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Niklas,
> 
> what's this patch status ? Please let me know if I have to keep
> it in the PCI tree queue, I think, if ACKed, it should probably
> go via the arm-soc tree.

Hello Lorenzo,

This patch has been merged and is included in v4.18.

I CC:ed PCI just to get more eyes on it.


Kind regards,
Niklas


> 
> Thanks,
> Lorenzo
> 
> > diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > index 5341a39c0392..148cf7e565f6 100644
> > --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > @@ -1417,7 +1417,7 @@
> >  			#address-cells = <3>;
> >  			#size-cells = <2>;
> >  			ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
> > -				  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
> > +				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* memory */
> >  			interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
> >  			interrupt-names = "msi";
> >  			#interrupt-cells = <1>;
> > -- 
> > 2.17.0
> > 
