Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A3AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA312087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547808873;
	bh=FDCE/ap5i68GsdyBGLGre/2ZC65mOk2yCS9UABVG2NA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oi4DRWKS4ubkvOyPTqeraAw3BFmSZv6XlBjY7ufxljrcFdFF8SYS16T1VsIf6TAlf
	 8C/5+8T7KPejhaCzVILWF2+WkaqHmGoZOg2z3w8M4xzl1eDTxoa0UDQisqzCbG9OvZ
	 ZdQEqyW7aBXEnqbb7JRlQrUswc5VzS5JVEm0HK94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfARKyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:54:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44234 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfARKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:54:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so13965708otl.11;
        Fri, 18 Jan 2019 02:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUtcsl5RdiT1FO8j+Sv9VOFvTSFHeVEOuIghyx4MXVU=;
        b=Ik9vBYPio3FQB+wc4B/JfP4GtLWA2Stg+GmPkI+qg/CroIALQHtIywyO8RtqZeGRfo
         mYgBjfmKpIH/bZn5ZfS0erNrkrtJOSvU71Ub6myMr9AMAR6/89wjA49oGdbVur3c0QQY
         XqMW2pN+/1CHX8SJZCn19p8DiVNW1vmhv2+RhzHXSofP5G49pPW1UNrtE5fJIoYP3hRS
         aY46EqwYnJElgJcXLcW2mdqcui8gaHydlsKfdHi7zKSB0ZeIJUam2P640nnDYKl8eW+B
         FP7fZzah8T/oSnCNplfmlKRKD4Puwx5tl/4F5+ILWz/DBsmmpv+lXMdEyTWkTIKxT/Iv
         hDWA==
X-Gm-Message-State: AJcUukdsuQZNwVxQ2b1z1MBXDmG9rSGTuSsVCkqfJH3MeKXwOqIWrDD2
        ML1vEJ/za4QFKwvzNcwZFz6LirsF51PlUZZY7Y0dTg==
X-Google-Smtp-Source: ALg8bN6TCRwOUcc4CZHfG0mpDw/LB5jk7uOUauWsvqP29wy60EoOF3aIx+K0AisdrUieN3wEZi0WCFZ8DCeJzLOIegg=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr10960434otn.200.1547808870449;
 Fri, 18 Jan 2019 02:54:30 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org> <20190117221628.GA21979@roeck-us.net>
In-Reply-To: <20190117221628.GA21979@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 11:54:18 +0100
Message-ID: <CAJZ5v0gC-v=3etOE_PuBvvVCbiqwk6J4+2ZkssdGjJG0BkBk6A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > This patch replaces jiffies based accounting for runtime_active_time
> > and runtime_suspended_time with ktime base accounting. This makes the
> > runtime debug counters inline with genpd and other pm subsytems which
> > uses ktime based accounting.
> >
> > timekeeping is initialized before pm_runtime_init() so ktime_get() will
> > be ready before first call. In fact, timekeeping_init() is called early
> > in start_kernel() which is way before driver_init() (and that's when
> > devices can start to be initialized) called from rest_init() via
> > kernel_init_freeable() and do_basic_setup().
> >
> This is not (always) correct. My qemu "collie" boot test fails with this
> patch applied. Reverting the patch fixes the problem. Bisect log attached.
>
> With some added debugging:
>
> ...
> IRQS: 16, nr_irqs: 65, preallocated irqs: 65
> irq: Cannot allocate irq_descs @ IRQ1, assuming pre-allocated
> gpio gpiochip0: ############### pm_runtime_init() ############
> irq: Cannot allocate irq_descs @ IRQ33, assuming pre-allocated
> ############## timekeeping_init() ####################
> sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 582542222200ns^M
> ...
>
> This is with:
>
> void pm_runtime_init(struct device *dev)
> {
> +       dev_info(dev, "############### pm_runtime_init() ############\n");
> +
> ...
> @@ -1526,6 +1526,8 @@ void __init timekeeping_init(void)
>         struct clocksource *clock;
>         unsigned long flags;
>
> +       pr_info("############## timekeeping_init() ####################\n");
> +
>
> Guenter
>
> ---
> # bad: [a37d50ca3b837c19a297f349365d11a20c1087d0] Add linux-next specific files for 20190117
> # good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
> git bisect start 'HEAD' 'v5.0-rc2'
> # bad: [4edb817d29fdf19fb5d52784bb3c29c40e00f586] Merge remote-tracking branch 'pm/linux-next'
> git bisect bad 4edb817d29fdf19fb5d52784bb3c29c40e00f586
> # good: [6d95886720d306a1914a7c9a8aeb0bcbc7aef018] Merge remote-tracking branch 'omap/for-next'
> git bisect good 6d95886720d306a1914a7c9a8aeb0bcbc7aef018
> # good: [975b5cdd74430bc8a04f832d65a47cdb95b73fec] Merge remote-tracking branch 'fuse/for-next'
> git bisect good 975b5cdd74430bc8a04f832d65a47cdb95b73fec
> # good: [112386d2189fc54b979c3a8bf64b2908df91e123] Merge remote-tracking branch 'i2c/i2c/for-next'
> git bisect good 112386d2189fc54b979c3a8bf64b2908df91e123
> # good: [3943f059823b6e15884387f31618b84826e924b3] media: coda: Add control for h.264 chroma qp index offset
> git bisect good 3943f059823b6e15884387f31618b84826e924b3
> # good: [44970bbbbb5079ee100875b06e45db5d6e91a16e] Merge remote-tracking branch 'v4l-dvb/master'
> git bisect good 44970bbbbb5079ee100875b06e45db5d6e91a16e
> # bad: [599170c2b860aca3364574f833bb9cc801c9668d] Merge branch 'pm-core' into linux-next
> git bisect bad 599170c2b860aca3364574f833bb9cc801c9668d
> # good: [347d570919ca9a3a3653ce9cbb7399c7c0ba8248] Merge branch 'acpi-pci' into linux-next
> git bisect good 347d570919ca9a3a3653ce9cbb7399c7c0ba8248
> # good: [e0a9fde86ba1bc26dd754c733b32e70cd8f1c187] Merge branches 'acpi-tables' and 'acpi-apei' into linux-next
> git bisect good e0a9fde86ba1bc26dd754c733b32e70cd8f1c187
> # good: [3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567] drm/i915: Move on the new pm runtime interface
> git bisect good 3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567
> # bad: [c75c303933a68c547f3352d1d708843f9449d3f4] PM: clock_ops: fix missing clk_prepare() return value check
> git bisect bad c75c303933a68c547f3352d1d708843f9449d3f4
> # bad: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting
> git bisect bad 3982ab9ce433efc72ca31eb9ddc85d9355966444
> # first bad commit: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting

OK, dropping this one for now, we need a working replacement.

Thanks!
