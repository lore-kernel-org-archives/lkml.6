Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE640C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9679926742
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9679926742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934091AbeFZS3u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:29:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38168 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeFZS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:29:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so18221821wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZDn3qoo3IMjSUe/WmGnkdEjxeaYPLSrNkmO6pEqVmT0=;
        b=F4r476odD7nKfgOCLyynAUcb7vISTxa1u8P7xHdZhLoJPxJRyem376xqXi66l6JETF
         2fnaP79/016BKW9J+LhjiQq27Fb2WEM2MzxAfeqVig5cEjGJVuvsD544UyWtpdxNeQ1+
         0MJn206PINPl3jrJh5ptWNRT0l3bCz1HCYeD8CmrkvBkZ2s8UubZrfco6pUdV9CSO2WK
         lfD7J9lFcx2aHm6hz5lB0WFQe7q4MkYdAj4P5kwFpRGtOpy8hiiTHefSSPD8wSKbqJGr
         KrzQGJIA2X7/ZTjTx8H1JuK/UmixBBbFL+AIHi4LyUaDDGlJ3Vc4luMYFfUhL9EmTN/h
         hkWg==
X-Gm-Message-State: APt69E1if/egor+Mbt3O+IRpxp7sA77QF/J49SQoz7FkmXQwylxHm6Vh
        cOOl1SuNTpzDV29AXlVdNCaIIka1yU4=
X-Google-Smtp-Source: AAOMgpfyCMKiOBWYxdo5Svpl3tI4+jD2Df0GC1BB1NzmoUyIarMv63IiujkncXOztQWEejT7VBm8BQ==
X-Received: by 2002:adf:f5c3:: with SMTP id k3-v6mr501824wrp.219.1530037786158;
        Tue, 26 Jun 2018 11:29:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j131-v6sm3238029wmb.25.2018.06.26.11.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:29:45 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console
 takeover
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
Date:   Tue, 26 Jun 2018 20:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-06-18 19:12, Andy Shevchenko wrote:
> On Tue, Jun 26, 2018 at 4:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Currently fbcon claims fbdevs as soon as they are registered and takes over
>> the console as soon as the first fbdev gets registered.
>>
>> This behavior is undesirable in cases where a smooth graphical bootup is
>> desired, in such cases we typically want the contents of the framebuffer
>> (typically a vendor logo) to stay in place as is.
>>
>> The current solution for this problem (on embedded systems) is to not
>> enable fbcon.
>>
>> This commit adds a new FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER config option,
>> which when enabled defers fbcon taking over the console from the dummy
>> console until the first text is displayed on the console. Together with the
>> "quiet" kernel commandline option, this allows fbcon to still be used
>> together with a smooth graphical bootup, having it take over the console as
>> soon as e.g. an error message is logged.
> 
>> +       for (i = 0; i < FB_MAX; i++) {
>> +               if (registered_fb[i])
>> +                       fbcon_fb_registered(registered_fb[i]);
>> +       }
> 
> Simple git grep shows that we perhaps do
> 
> #define for_each_registered_fbcon(i) ...
> 
> (As an example see for_each_pci_bridge() how it's done there)

This is probably a worthwhile cleanup for all the fbdev related
code / drivers. But outside of the scope of this patchset.

Regards,

Hans
