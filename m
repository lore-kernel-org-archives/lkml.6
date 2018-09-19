Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9EECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92152150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92152150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbeISRU5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:20:57 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55530 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727820AbeISRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:20:56 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 13820826-1500050 
        for multiple; Wed, 19 Sep 2018 12:43:14 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Chris Chiu <chiu@endlessm.com>, airlied@linux.ie,
        jani.nikula@intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180919112933.47382-1-chiu@endlessm.com>
Cc:     Chris Chiu <chiu@endlessm.com>, intel-gfx@lists.freedesktop.org,
        linux@endlessm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180919112933.47382-1-chiu@endlessm.com>
Message-ID: <153735739367.31835.11641995651905357659@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: re-check the hotplug with a delayed work
Date:   Wed, 19 Sep 2018 12:43:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Chiu (2018-09-19 12:29:33)
> I have few ASUS laptops, X705FD(Intel i7-8565), X560UD(Intel i5-8250U)
> and X530UN(Intel i7-8550U) share the same problem. The HDMI connector
> status stays 'connected' even the HDMI cable has been unplugged.
> Then the status in sysfs would never change since then until we
> do 'xrandr' to reprobe the devices. It would also cause the audio
> output path cannot correctly swicth based on the connector status.
> 
> This commit kicks off a delayed work when the status remains unchanged
> in the first hotplug event handling, which may not be the perfect
> timing in some special cases.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h      |  1 +
>  drivers/gpu/drm/i915/intel_hotplug.c | 35 +++++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index d51d8574a679..78e2cf09cc10 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -286,6 +286,7 @@ struct i915_hotplug {
>         } stats[HPD_NUM_PINS];
>         u32 event_bits;
>         struct delayed_work reenable_work;
> +       struct delayed_work recheck_work;
>  
>         struct intel_digital_port *irq_port[I915_MAX_PORTS];
>         u32 long_port_mask;
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index 43aa92beff2a..089a24588ec8 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -349,14 +349,15 @@ static void i915_digport_work_func(struct work_struct *work)
>         }
>  }
>  
> +#define HPD_RECHECK_DELAY        (2 * 1000)

Or just (2 * HZ)

>  /*
>   * Handle hotplug events outside the interrupt handler proper.
>   */
> -static void i915_hotplug_work_func(struct work_struct *work)
> +static void do_i915_hotplug_check(struct work_struct *work,
> +                                  struct drm_i915_private *dev_priv,
> +                                  struct drm_device *dev, bool do_recheck)

struct drm_i915_private == struct drm_device, no need for tautology

Local struct drm_device *dev = &i915->drm; are eliminated by the
compiler.
-Chris
