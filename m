Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCUTJ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:09:28 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:46141 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752637AbeCUTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:09:25 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:981:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:3871:3872:4321:5007:6238:7208:7576:7903:8957:9113:9707:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12438:12555:12740:12760:12895:12986:13069:13153:13228:13311:13357:13439:14093:14097:14181:14659:14721:21080:21433:21451:21627:21740:30054:30055:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: money56_34d71c60e800d
X-Filterd-Recvd-Size: 3058
Message-ID: <1521659361.7999.27.camel@perches.com>
Subject: Re: [PATCH] drm/i915/gvt: don't dereference 'workload' before null
 checking it
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 12:09:21 -0700
In-Reply-To: <20180321190653.3829-1-colin.king@canonical.com>
References: <20180321190653.3829-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 19:06 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer workload is dereferenced before it is null checked, hence
> there is a potential for a null pointer dereference on workload. Fix
> this by only dereferencing workload after it is null checked.
> 
> Detected by CoverityScan, CID#1466017 ("Dereference before null check")

Maybe true, but is it possible for workload to be null?
Maybe the null test should be removed instead.

> Fixes: fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/gvt/scheduler.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
> index 068126404151..f3010e365a48 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -60,9 +60,9 @@ static void set_context_pdp_root_pointer(
>  static void sr_oa_regs(struct intel_vgpu_workload *workload,
>  		u32 *reg_state, bool save)
>  {
> -	struct drm_i915_private *dev_priv = workload->vgpu->gvt->dev_priv;
> -	u32 ctx_oactxctrl = dev_priv->perf.oa.ctx_oactxctrl_offset;
> -	u32 ctx_flexeu0 = dev_priv->perf.oa.ctx_flexeu0_offset;
> +	struct drm_i915_private *dev_priv;
> +	u32 ctx_oactxctrl;
> +	u32 ctx_flexeu0;
>  	int i = 0;
>  	u32 flex_mmio[] = {
>  		i915_mmio_reg_offset(EU_PERF_CNTL0),
> @@ -77,6 +77,10 @@ static void sr_oa_regs(struct intel_vgpu_workload *workload,
>  	if (!workload || !reg_state || workload->ring_id != RCS)
>  		return;
>  
> +	dev_priv = workload->vgpu->gvt->dev_priv;
> +	ctx_oactxctrl = dev_priv->perf.oa.ctx_oactxctrl_offset;
> +	ctx_flexeu0 = dev_priv->perf.oa.ctx_flexeu0_offset;
> +
>  	if (save) {
>  		workload->oactxctrl = reg_state[ctx_oactxctrl + 1];
>  
