Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C281C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E9921D19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKPqFtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E9921D19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbeHIODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:03:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35494 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbeHIODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:03:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so2730491edr.2;
        Thu, 09 Aug 2018 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kE9cIDf0r+tmOCymHL+t2y5BWuLkyVrlD/KgpnZ9bNI=;
        b=nEKPqFtXOBLPne+YwI7hbmpcZ9iCeHtTmjoH5O3aWBhwXhVzDcnegbZ3Z9jV1WjVtl
         hXW9U1BcTgWS0KMkajwDuNXBk3sS+8Xbchv8EMrRj6bRhObqct3JVPAgxrYhTaeTbXY4
         lsdzloG4p30JuQ93liIg0teS2ufh/nyebrNH3t4mlDtDo8OlhJhitNaFiWHgy/U7Fgli
         8HtRsNJYi0UoHLYYr2hweFFUClwedJNLz5rXX6ZZ2JO1TfCy6Y/fP48/br4Wrl92EuMN
         lIDkMNznyYezQeMnyDzuAEsWwMH9Ajb4ONE4xS80vY+9PBfTe8mLSmgRvFCnOmUGm2T7
         5jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kE9cIDf0r+tmOCymHL+t2y5BWuLkyVrlD/KgpnZ9bNI=;
        b=PMG/5GELKeGwIRgiwAwv6u9SPMKM4TSx7FfTe3q6gcqDL2924FfxUpVJcpXkP5n+/F
         7Xfxa08sFTxJnAGG2bCqNk4Hs4g2lnoMwQaS+A+CAu9qnHg3iGcPuYNxu3M03PoR1s8/
         kzkTqLPOa6EnVxo2S+DyM9Xxwl7k7qSkhWFasTwyH4vtElaCc85qVEXO80RTNTlHPeTL
         Mho/SCgbsS0OslOPFsecmwwWb3RolAb9yLwB2hjWQGRLFioerH0/swWgJYk5WVGiBn/p
         UwBR3TL/Mi/8MbP5u8bn1VFYwL7P+U1JQr2rFBJwMpZw/0qAVEsD924F1VjY1DoPYuz+
         IlaQ==
X-Gm-Message-State: AOUpUlGoUxgCje0Vi80a/Z++zVWrbzVVrSujqmUZmNWf9Nyq/n17DzlZ
        oJxH9PlmoGxWFUY18ex29Hs=
X-Google-Smtp-Source: AA+uWPySY+/A9SbjyKXzrhG2cp8uHQ3tOittcuF48aNadb3AKCPw78rizlaOVHmDn81n8jHXuqPrag==
X-Received: by 2002:aa7:d786:: with SMTP id s6-v6mr2736789edq.228.1533814746003;
        Thu, 09 Aug 2018 04:39:06 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g28-v6sm8487459edg.67.2018.08.09.04.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 04:39:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory Controller driver
Date:   Thu, 09 Aug 2018 14:39:03 +0300
Message-ID: <16855111.9YhuyP46zb@dimapc>
In-Reply-To: <20180809111746.GG21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com> <20180804143003.15817-3-digetx@gmail.com> <20180809111746.GG21639@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > GART contain registers needed by the Memory Controller driver, provide
> > access to the MC driver by utilizing its GART-integration facility.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> > 
> >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > index a004f6da35f2..f8b653e25914 100644
> > --- a/drivers/iommu/tegra-gart.c
> > +++ b/drivers/iommu/tegra-gart.c
> > @@ -31,6 +31,8 @@
> > 
> >  #include <linux/iommu.h>
> >  #include <linux/of.h>
> > 
> > +#include <soc/tegra/mc.h>
> > +
> > 
> >  #include <asm/cacheflush.h>
> >  
> >  /* bitmap of the page sizes currently supported */
> > 
> > @@ -41,6 +43,8 @@
> > 
> >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > 
> > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > 
> >  #define GART_PAGE_SHIFT		12
> >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > 
> > @@ -63,6 +67,8 @@ struct gart_device {
> > 
> >  	struct device		*dev;
> >  	
> >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > 
> > +
> > +	struct tegra_mc_gart_handle mc_gart_handle;
> > 
> >  };
> >  
> >  struct gart_domain {
> > 
> > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
> > 
> >  	return 0;
> >  
> >  }
> > 
> > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> > +{
> > +	struct gart_device *gart = container_of(handle, struct gart_device,
> > +						mc_gart_handle);
> > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > +}
> > +
> > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> > +{
> > +	struct gart_device *gart = container_of(handle, struct gart_device,
> > +						mc_gart_handle);
> > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > +}
> > +
> > 
> >  static int tegra_gart_probe(struct platform_device *pdev)
> >  {
> >  
> >  	struct gart_device *gart;
> > 
> > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device
> > *pdev)> 
> >  	gart->regs = gart_regs;
> >  	gart->iovmm_base = (dma_addr_t)res_remap->start;
> >  	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
> > 
> > +	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
> > +	gart->mc_gart_handle.error_req = tegra_gart_error_req;
> > 
> >  	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
> >  	if (!gart->savedata) {
> > 
> > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device
> > *pdev)> 
> >  	do_gart_setup(gart, NULL);
> >  	
> >  	gart_handle = gart;
> > 
> > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > 
> >  	return 0;
> >  
> >  }
> 
> I see now why you've did it this way. We have separate devices unlike
> with SMMU where it is properly modeled as part of the memory controller.
> I think we should consider breaking ABI at this point and properly merge
> both the memory controller and GART nodes. There's really no reason why
> they should be separate and we're jumping through multiple hoops to do
> what we need to do just because a few years back we made a mistake.
> 
> I know we're technically not supposed to break the DT ABI, but I think
> in this particular case we can make a good case for it. The current DT
> bindings are plainly broken, and obviously so. Also, we don't currently
> use the GART upstream for anything, so we can't break any existing
> systems either.

IIUC, that will require to break the stable DT ABI of the tegra20-mc, which is 
working fine and does its job. I'm personally not seeing the slight lameness 
of the current DT as a good excuse to break the ABI. Let's then break DT ABI 
on all Tegra's and convert them all to genpd and other goodies like assigned 
clock parents and clock rate.



