Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73B21480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73B21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeHVNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:30:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:49424 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeHVNai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:30:38 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Aug 2018 19:06:23 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 2AD9A180237;
        Wed, 22 Aug 2018 19:06:23 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 22 Aug 2018 19:06:23 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id CD7A8403A3;
        Wed, 22 Aug 2018 19:06:22 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 9B5491202F1;
        Wed, 22 Aug 2018 19:06:22 +0900 (JST)
Date:   Wed, 22 Aug 2018 19:06:22 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 01/14] ata: ahci-platform: add reset control support and the flag to specify using reset
Cc:     Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <1d221236-636e-962e-2e4e-3db228689c5e@cogentembedded.com>
References: <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com> <1d221236-636e-962e-2e4e-3db228689c5e@cogentembedded.com>
Message-Id: <20180822190622.9750.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Wed, 22 Aug 2018 12:34:30 +0300 <sergei.shtylyov@cogentembedded.com> wrote:

> Hello!
> 
> On 8/22/2018 10:36 AM, Kunihiko Hayashi wrote:
> 
> > Add support to get and control a list of resets for the device
> > as optional and shared. These resets must be kept de-asserted until
> > the device is enabled.
> > > This is specified as shared because some SoCs like UniPhier series
> > have common reset controls with all ahci controller instances.
> > > However, according to Thierry's view,
> > https://www.spinics.net/lists/linux-ide/msg55357.html
> > some hardware-specific drivers already use their own resets,
> > and the common reset make a path to occur double controls of resets.
> > > Now this add the flag to ahci_platform_get_resources() indicating
> > whether to use the resources, currently resets only, and existing
> > drivers set 0 to this flags.
> > > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> [...]
> 
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 1b0a17b..eaedca5f 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -30,7 +30,7 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
> >   int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
> >   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
> >   struct ahci_host_priv *ahci_platform_get_resources(
> > -	struct platform_device *pdev);
> > +	struct platform_device *pdev, unsigned int flags);
> 
>     That breaks all the users of this API. You should fix the callers in this same patch to avoid breakage.

Thank you for your point.
Indeed, these splitted patches break git bisect. I'll fix it.

---
Best Regards,
Kunihiko Hayashi


