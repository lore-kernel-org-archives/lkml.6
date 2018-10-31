Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67720ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heDiz94J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeJaTBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:01:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44787 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:01:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17-v6so15453873wre.11;
        Wed, 31 Oct 2018 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rMsNriSRIA0+IzNyblsxfRhJ5PS/9torhfa6Q14Ev60=;
        b=heDiz94JeNbHLB9Jbfq2S9RMKKgyx7RF4IP6d2hRtB5nZQZPet+gf9lJep9LvtS34p
         TBVksDRm/qIZr85s4mPkmvXoI3zkXfQLLtCHeHbccIgu/ENoAekivElownajEj7Q7KO2
         sYD9YGMHs62pqPdVl7tmmdyW61KlC/rJ3zPbXTnBM3sotuONDOyQ05rhAM/I64yCSgOU
         Nt5Y2JAlF5/WR2Q1coZdLKGDV61ai+dUwCN9UvcISdODXLJjXssUiedMOwiurE1z3grC
         zlE8Ka4dnDHPyjdNTtGih8GH19b5iG2bk5pFe2FLVACV89WRp2Gdz5TerWY8m5l7kXWj
         e9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rMsNriSRIA0+IzNyblsxfRhJ5PS/9torhfa6Q14Ev60=;
        b=nfsIdwLpOoTJjeliELDs4NQJbCrqX/sWsTYFVWXTD2zzfjq0c9l3ZtvUuxAXQ4lnJK
         CZLLtDfbAPCdZaJC31BqtBCTdbAeMgZEyeuNRhHYFIpGH/u6Tt38ce9RUEiZYRgv5InQ
         KNPUrN4fA9aY41FzA8iVwt9gW5tj1AddehqvZqgIR+MWffrqJHm+6By4CgiXbuUMhsNN
         RaVuJbxbQi1VjAcxNksJC9EB0gOf01fdsaoVCrps1yvn0YJbsu2cb99goIaC7x2PeJ3K
         F9gWdiERhCmIypQ/k06UolmRtHmgrAIaes6PNM4nFwz1zSl7TGddMG3hJHEy/oV2Pb1Y
         7kJQ==
X-Gm-Message-State: AGRZ1gLfm5v8XASaew4/XnGoL483xiPXhm316oQNxYXMw6ZuHQIsL8zO
        SQaKWmZTnwySGjmErZ5bTms=
X-Google-Smtp-Source: AJdET5c7Fd3odKbCKNcMzYdWjyG2h1S5g6WIwZLuQrM0HvPi0yKfw7+8Z55RxuA9mwThiV5nAswJyQ==
X-Received: by 2002:adf:9b84:: with SMTP id d4-v6mr1997082wrc.240.1540980225640;
        Wed, 31 Oct 2018 03:03:45 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id x18-v6sm14417205wrv.31.2018.10.31.03.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 03:03:44 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:03:43 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mogens Jensen <mogens-jensen@protonmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181031100343.74tsj4j3e23q6r7a@picard>
References: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.18.14-arch1-1-ARCH
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-10-18, Hans de Goede wrote:
> Hi,
> 
> On 31-10-18 07:02, Mogens Jensen wrote:
> > ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> > On Tuesday, October 30, 2018 7:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > 
> > > Hi,
> > > 
> > > On 30-10-18 19:56, Mogens Jensen wrote:
> > > 
> > > > ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> > > > On Tuesday, October 30, 2018 4:04 PM, Hans de Goede hdegoede@redhat.com wrote:
> > > > 
> > > > > Hi,
> > > > > On 30-10-18 16:46, Hans de Goede wrote:
> > > > > 
> > > > > > Hi,
> > > > > > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > > > > 
> > > > > > > In addition I am not aware of any baytrail device using plt_clk_0, so moving a common machine driver such a cht_bsw_max98090_ti to use plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking for both clocks to be on might work though,
> > > > > > 
> > > > > > Ok, so we need to have a DMI based quirk for the Swanky and maybe also
> > > > > > the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
> > > > > > one does not seem like a good plan.
> > > > > 
> > > > > Dean, Mogens,
> > > > > To write a proper patch for this I'm going to need DMI strings
> > > > > from your devices.
> > > > > Can you please run (as normal user):
> > > > > grep . /sys/class/dmi/id/* 2> /dev/null
> > > > > And reply with the output of this command?
> > > > > I have attached the output from a coreboot seabios based clapper.
> > > 
> > > Thank you.
> > > 
> > > > Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asoundrc from Dean? There seems to have been some development in the case since that request was made.
> > > 
> > > Yes please test that, I expect that to also fix things for the
> > > Clapper, but I need to have that confirmed before submitting a
> > > patch upstream adding a quirk for the Clapper to use pmc_plt_clk_0
> > > instead of pmc_plt_clk_3.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > Unfortunately I only have access to longterm kernel 4.14 for building/running on this system, and 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch does not patch against 4.14.78. Can a test patch for 4.14 be created?
> 
> Can you run (as root):
> 
> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done
> 
> When running a kernel with working audio?
> 
> Then I can confirm that the Clapper is also using pmc_plt_clk_0, so that I can
> fix this for the clapper for 4.18+
> 
> I've just checked the 4.14 sources and in 4.14 the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
> driver does not support mclk control yet, so for the 4.14 kernel the only way to
> fix this is to revert the 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> commit.
> 
> Regards,
> 
> Hans
> 

Hi guys,
Morgens, If you can't test a recent kernel on your Clapper, I might be able to
give you a 'live' usb to boot with the kernel on, so you can quickly
test.  It's basically just archlinux iso with xfce and tools, with arch's
LTS and latest stable kernels.  If it will help.
-- 
Dean
