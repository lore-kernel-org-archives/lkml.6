Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35671C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089F206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvL6h+9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C089F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeI2PYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:24:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39258 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeI2PYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:24:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so5880238pff.6;
        Sat, 29 Sep 2018 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WrNjSkrTvVSOXF0kvG+iwHamDqeEruIlw21tecdDyNw=;
        b=tvL6h+9CDHBou8orczNxOoGjw9ML/RWoP458A8TJ4DvAJqulIZI4NPtRITgaJtgsfq
         mozU4+X/tNw5Q0P0Il5OqbBvBtsvOHXim8latxG/JLwcTelpwZdf4kvgHus1lcTdj2q5
         I7vjMnmTC4b4zf6T0nFl2jKqjJ6D1D7M2QINCpzWuYwH+Z5jVZjr+i0BtTW0WaVaio8S
         +J3/FdnfW9MvijZI61H/ubwKgt8KzjBo8DvI7YdnZxtyyoHcWUasQf1UcUp3t8h1YyLm
         HTXM2qyBDta8pdeJ2DvcdrgQC7oumSygZsSCjNiqS1ctiW0mcU6LgFv+mHYiU3xxkZfB
         bc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WrNjSkrTvVSOXF0kvG+iwHamDqeEruIlw21tecdDyNw=;
        b=MUSLsCpyF5boCPPcjORHyWq1f31eE3ShQmRU3qyeymq5HCXci6MGMaD/WC+L9i6ylI
         NMftSZiP0W8Zr5YAQGm6X/4msOwPsVwmTndXGJVnJDP8u7JeV5W62WRvUFEGdEwe6Fin
         z4yt/Cc9hQxyHDKyawaPEbaBUgSRS5UdIgSKwD9ZLa1fMhFVPTFlHQnFasANteQ5KfAG
         g81c85h8Cs5UBW4L7H3comDRR1ojM9EqzpI895OwJNoq1CLxE5DSX52L7JdO0dR9tdSV
         KJeIzivTq43rB6ipAabmk/eP40MUqrnVMiKon9Lz+n47o8JPQzHn1An5QlECetjgv2mC
         0xJQ==
X-Gm-Message-State: ABuFfogBEi0QQ98eAtW7OR5ppAduyonWFvupQTFi/RQSL3iAa6VFXL7f
        Mv+7058fuAsH7u+nFNmAH4OIoL2wfTA=
X-Google-Smtp-Source: ACcGV61zn0rfGYfCRSc3pycUtlwQXBil51Xdj+ST8SjX0DTEwRxKIpf9IFTCw4XJ0PpFGgsp0AsNbQ==
X-Received: by 2002:a17:902:9a48:: with SMTP id x8-v6mr2310125plv.72.1538211392717;
        Sat, 29 Sep 2018 01:56:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:6c55])
        by smtp.gmail.com with ESMTPSA id u1-v6sm53936pgr.61.2018.09.29.01.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 01:56:31 -0700 (PDT)
Date:   Sat, 29 Sep 2018 01:56:22 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
Message-ID: <20180929085622.GD270328@devbig004.ftw2.facebook.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
 <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
 <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com>
 <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:41:23PM -0700, Florian Fainelli wrote:
> On 09/25/2018 09:12 AM, Florian Fainelli wrote:
> > On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
> >> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
> >>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
> >>>> Hi Kishon, Tejun,
> >>>>
> >>>> This patch series adds support for the SATA AHCI and PHY found on the
> >>>> ARM-basd BCM63138 DSL SoCs.
> >>>>
> >>>> It would probably make sense for patches 1-3 to go through Kishon's
> >>>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
> >>>> two patches through the Broadcom ARM-SoC tree.
> >>>>
> >>>> Let me know if this is not a workable plan, thank you very much!
> >>>
> >>> Looks like I had left patches with the incorrect subject, please
> >>> disregard the following patches:
> >>>
> >>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
> >>> DSL SoCs
> >>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
> >>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
> >>>
> >>> since they have incorrect/inconsistent titles, the other patches are
> >>> fine though. Sorry about that.
> >>
> >> merged the first 3 patches to linux-phy tree.
> > 
> > Thanks a lot Kishon!
> 
> Tejun, are you good with picking up patches 4-7 and I take the last two?
> Can you make sure you pick up the ones that contain "ahci_brcm" in their
> subject, I had incorrectly formatted them initially, sorry again about that.

Jens is running the libata tree now.  Jens?

Thanks.

-- 
tejun
