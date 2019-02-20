Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC235C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB6620685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuvqglkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBTLCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:02:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfBTLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GYhJeV+fLV9/dIUemPOV49aBd2YkkdKMheInEI2nw1s=; b=GuvqglkFSWsUrlL8ZB6LGtJGf
        l8QEQUoQyXiYwdI8fqrIcfMwTKZHCzV+sqj326Q93QbuOGnb1sXOllr0uAB5ugvhwrB52X5k3MS6T
        fqkIwlwRL3HTseC14GnR84aVO42LzNgte9bEcg9krQuDxPvWb4fGNjDipgfRtOA1twceluG2rSsO2
        j6rjFPTbCKwKZM4akzORehve5h9jTSAHFcWwS6g8eMtosmQuhaK/KZczo4AtMRdCi1fTrPYx2FT0i
        pQMUsD2rUVcJZmVj+nu+StvOkM7JQJ4cmZtCLFVUvM6vF/CNg2HolI24+LfhDAQQDEipAFzm12noi
        Dxd59YSyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwPda-0008Mn-Kl; Wed, 20 Feb 2019 11:02:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE6C5202BC402; Wed, 20 Feb 2019 12:02:00 +0100 (CET)
Date:   Wed, 20 Feb 2019 12:02:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
Message-ID: <20190220110200.GD17969@hirez.programming.kicks-ass.net>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:40:10PM -0500, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> On the new dual-die/package systems, the RAPL MSR becomes die-scope.
> Thus instead of one powercap device per physical package, now there
> should be one powercap device for each unique die on these systems.
> 
> This patch introduces intel_rapl driver support for new
> dual-die/package systems.
> 
> On the hardwares that do not have multi-die, topology_unique_die_id()
> equals topology_physical_package_id(), thus there is no functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 6057d9695fed..e004707283da 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_unique_die_id(cpu);
>  	struct rapl_package *rp;
>  
>  	list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_unique_die_id(cpu);
>  	struct rapl_package *rp;
>  	int ret;

And now your new function names are misnomers.
