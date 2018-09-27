Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764F206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UUw97vf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeI0RM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:12:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33229 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0RM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:12:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id l19-v6so1979297ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5dSaq6nqL0GUtqykX2UvAZc43uMIT6lNzwgjsWybkU=;
        b=UUw97vf3XWC6fThzrgdIA965omDm3VsX8HyhKSka/R2ZIHZDQXewVaKmdf7GLZ/Uri
         SixfNaYwAJb0Atlsu7v0ia5tar7npk1edKAh996xoWcXPtn1APA86DsI6En9hltOB8TP
         C/kNgGtbPFL6QhYFXxpdKn6lisDKaLW5VKiLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5dSaq6nqL0GUtqykX2UvAZc43uMIT6lNzwgjsWybkU=;
        b=nUOfymwchx5B9a+nBo/eYyzAua6OBPinXX6ztVlm2CAE52+gNloUU11tsWvk2P+8rT
         YN0H6LW+QX8ha02I5pyHx9raAydWpjX+lPh5iQm2Z1y2kcGORnejhYMqcL3raCq9nhWO
         cYQq96vi024j2Lnc9QgtxUyOFTsdZXE5Xdc79cYbFmr8ApV8yfzGAjwoSaS+tILP+5rZ
         IWkWNLYJJMCqB9XaSJzjmusdb1GNmotKZDpOcFx6kz7bPPkjDqDrZKOOqsBJUoF/Joys
         O0kIfcUTXGHkLoAG+KyBccxviJThIalleLx39aR8Fmp6ZDJwwFdovyC33l+t+7dHSI29
         fYDQ==
X-Gm-Message-State: ABuFfohK3YashS4g1K5t9YgqXdBtwjN+kRIs3pmCGgxQ2cmG32Dyn10q
        xjUUAC7JQzH+HTS9n1WQihkvUQ==
X-Google-Smtp-Source: ACcGV60DCYdtp7f+qhNFomUqVyjJ/PXFJg9oufxU3BiYrypTIFcbGCrpcerzcOlkA4pVU/DZEmLSrQ==
X-Received: by 2002:a2e:2c15:: with SMTP id s21-v6mr161813ljs.162.1538045713061;
        Thu, 27 Sep 2018 03:55:13 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a15-v6sm357194ljf.92.2018.09.27.03.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 03:55:12 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] devres: provide devm_kstrdup_const()
To:     Kees Cook <keescook@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20180924101150.23349-1-brgl@bgdev.pl>
 <20180924101150.23349-4-brgl@bgdev.pl>
 <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9ad301dc-47ef-cd7d-699d-e51716d1703f@rasmusvillemoes.dk>
Date:   Thu, 27 Sep 2018 12:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 01:13, Kees Cook wrote:
> On Mon, Sep 24, 2018 at 3:11 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> Provide a resource managed version of kstrdup_const(). This variant
>> internally calls devm_kstrdup() on pointers that are outside of
>> .rodata section and returns the string as is otherwise.
>>
>> Also provide a corresponding version of devm_kfree().
>>
>> +/**
>> + * devm_kfree_const - Resource managed conditional kfree
>> + * @dev: device this memory belongs to
>> + * @p: memory to free
>> + *
>> + * Function calls devm_kfree only if @p is not in .rodata section.
>> + */
>> +void devm_kfree_const(struct device *dev, const void *p)
>> +{
>> +       if (!is_kernel_rodata((unsigned long)p))
>> +               devm_kfree(dev, p);
>> +}
>> +EXPORT_SYMBOL(devm_kfree_const);
>> +
>>  /**
>>   * devm_kmemdup - Resource-managed kmemdup
>>   * @dev: Device this memory belongs to
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 33f7cb271fbb..79ccc6eb0975 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *dev,
>>         return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>>  }
>>  extern void devm_kfree(struct device *dev, const void *p);
>> +extern void devm_kfree_const(struct device *dev, const void *p);
> 
> With devm_kfree and devm_kfree_const both taking "const", how are
> devm_kstrdup_const() and devm_kfree_const() going to be correctly
> paired at compile time? (i.e. I wasn't expecting the prototype change
> to devm_kfree())

Just drop devm_kfree_const and teach devm_kfree to ignore
is_kernel_rodata(). That avoids the 50-100 bytes of overhead for adding
yet another EXPORT_SYMBOL and makes it easier to port drivers to
devm_kstrdup_const (and avoids the bugs Kees is worried about). devm
managed resources are almost never freed explicitly, so that single
extra comparison in devm_kfree shouldn't matter for performance.

Rasmus
