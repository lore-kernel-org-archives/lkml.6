Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68853215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68853215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeI0RTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:19:48 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34986 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:19:47 -0400
Received: by mail-vk1-f193.google.com with SMTP id w193-v6so487158vke.2;
        Thu, 27 Sep 2018 04:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HJUfQz7O6e48xTUuJGMgp+ZT+lbPUT9KkUOBt+vzK0=;
        b=dr0x7cURRh99Vt4Emp7EFYWhoHtbJnvkf4M8JljbbfLocIt90p3sEeRnQHQpZhLCv0
         hpsp36xu9DlzVauOrmCPrL+ZojmE/EAIzYUconvK8G3P9FNofECgcT5UZx2NIyCrC1+L
         scocFjcPVhq2uoOBB9l69BoRAikjvaZSO7rVZSN+XH3eZSXpFzTTUCQUILrLvvavgmMf
         wx//Fm2Wf1v4x7QlzANf1/XCUVwPNkYEk3zl+2pm31RGPefs5GpWKbPAcCgrUhsslzyN
         x+SWdcdt1pBrPJJ16Jd0rKxN05Lltee9vYSkSk+idv51Odm6yAC+4czp9dweYmtnn9c+
         CfIQ==
X-Gm-Message-State: ABuFfohQF0J8z6H8yTtZuz/tWBDp6Gpb38IDZ7qFBkvHzTDkjgeqaHSZ
        32bqaAGMYOGM/qEA/u0peWJqilWFDJLUZxw5mm0=
X-Google-Smtp-Source: ACcGV632f+TVRrtufR5Tym8RX0A5aCMQQvLLztJCcbtkaLetrHt5l1n8pVTEB/XEN9IZPloYkaa8nEpjJYSXkrIFAGk=
X-Received: by 2002:a1f:2ad6:: with SMTP id q205-v6mr3318912vkq.83.1538046123270;
 Thu, 27 Sep 2018 04:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180924101150.23349-1-brgl@bgdev.pl> <20180924101150.23349-4-brgl@bgdev.pl>
 <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com> <9ad301dc-47ef-cd7d-699d-e51716d1703f@rasmusvillemoes.dk>
In-Reply-To: <9ad301dc-47ef-cd7d-699d-e51716d1703f@rasmusvillemoes.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Sep 2018 13:01:50 +0200
Message-ID: <CAMuHMdWi0TQfu093po9-TniiLa2=T1E1c5R0S0tr85F==GcaGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] devres: provide devm_kstrdup_const()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        vivek.gautam@codeaurora.org, Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, guro@fb.com,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Thu, Sep 27, 2018 at 12:55 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 2018-09-27 01:13, Kees Cook wrote:
> > On Mon, Sep 24, 2018 at 3:11 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >> Provide a resource managed version of kstrdup_const(). This variant
> >> internally calls devm_kstrdup() on pointers that are outside of
> >> .rodata section and returns the string as is otherwise.
> >>
> >> Also provide a corresponding version of devm_kfree().
> >>
> >> +/**
> >> + * devm_kfree_const - Resource managed conditional kfree
> >> + * @dev: device this memory belongs to
> >> + * @p: memory to free
> >> + *
> >> + * Function calls devm_kfree only if @p is not in .rodata section.
> >> + */
> >> +void devm_kfree_const(struct device *dev, const void *p)
> >> +{
> >> +       if (!is_kernel_rodata((unsigned long)p))
> >> +               devm_kfree(dev, p);
> >> +}
> >> +EXPORT_SYMBOL(devm_kfree_const);
> >> +
> >>  /**
> >>   * devm_kmemdup - Resource-managed kmemdup
> >>   * @dev: Device this memory belongs to
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index 33f7cb271fbb..79ccc6eb0975 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *dev,
> >>         return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> >>  }
> >>  extern void devm_kfree(struct device *dev, const void *p);
> >> +extern void devm_kfree_const(struct device *dev, const void *p);
> >
> > With devm_kfree and devm_kfree_const both taking "const", how are
> > devm_kstrdup_const() and devm_kfree_const() going to be correctly
> > paired at compile time? (i.e. I wasn't expecting the prototype change
> > to devm_kfree())
>
> Just drop devm_kfree_const and teach devm_kfree to ignore
> is_kernel_rodata(). That avoids the 50-100 bytes of overhead for adding
> yet another EXPORT_SYMBOL and makes it easier to port drivers to
> devm_kstrdup_const (and avoids the bugs Kees is worried about). devm
> managed resources are almost never freed explicitly, so that single
> extra comparison in devm_kfree shouldn't matter for performance.

I guess we can also teach kfree() to ignore is_kernel_rodata(), and
drop kfree_const()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
