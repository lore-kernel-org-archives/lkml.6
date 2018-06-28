Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C59C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5A424A1B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5A424A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967233AbeF1PYx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:24:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37458 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933863AbeF1PYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:24:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id v22-v6so5414814edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAnnEHVTUZqJ9eMK2P/xmFoT1/YuLqyeF+aEjWixCqw=;
        b=YURyRy6Ozqgrz3ZFBvt4KqfspCiHShF1rM6tWmO8p9T4YkTMskvsG/LicaGpwMeHMS
         Ar9PA/9Uho9tBY7tKlwHYm8eWzUNqPW8wyaIpXh3Us7YT2/XVtkrJAW95Tq0oP3PtZjy
         kHy9MpvXZ62cWNB+CZUsSGClvYJZl1qyxXZdZkxgAdweU6faBNgRzuvA5a1lmmfovyK+
         hd8pSMOwncYY8EBQc7rG/MNxUl48BOSQraVpgMnDHTF05uIUWi9h3nF2PXTkS9ugun38
         eR9wfoP/4oMsuOc3qzDkVNnlsndNEkEvPoazK1+j1nKsTAgZwkg0HDdimMfKeM3jWG8i
         V4Ew==
X-Gm-Message-State: APt69E3mtIkLi8MbNDyfNGk+ObwIRJEOxDTAtPu8hJSdEWUy6zGsY/Yd
        +prCddwAyGiL/FQ7qU1Qz9Vt7g==
X-Google-Smtp-Source: AAOMgpcMG/B3FfQ1xJ499GLv0lhNunMRDO99pBBK812o2AdH02OfjcRlle2kvX5QPA7nndsv+pehUA==
X-Received: by 2002:a50:c90b:: with SMTP id o11-v6mr9457588edh.193.1530199488205;
        Thu, 28 Jun 2018 08:24:48 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a38-v6sm2935862eda.32.2018.06.28.08.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:24:47 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console
 takeover
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
 <20180628090351.15581-1-hdegoede@redhat.com> <2462549.rLSfW9kX99@amdc3058>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <64555902-73df-3289-7bd9-0ea8a2caffbd@redhat.com>
Date:   Thu, 28 Jun 2018 17:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2462549.rLSfW9kX99@amdc3058>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 28-06-18 15:50, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
>> Hi All,
>>
>> Here is v5 of my patch-set, to delay fbcon taking over the console (and
>> binding to fbdev devices) until there actually is some text output to the
>> console. This is intended for use with the "quiet" cmdline option, in
>> combination with a bootloader which leaves the vendor's logo /
>> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
>>
>> The end goal here is a boot where the firmware shows its boot graphics
>> and these stay in place for a couple of seconds until the GUI loads and
>> the GUI then smoothly takes over the framebuffer without any distruptions.
>>
>> Bartlomiej, I believe that this patch-set is ready for merging now and
>> the first patch has Petr's ack, so can we get this merged now?
> 
> Done, thanks for patches (also for reviews & acks).

You're welcome and thank you for merging these.

Regards,

Hans


> 
>> Also please create an inmutable (or topic) branch for this, so that the
>> drm people can merge it into drm-tip for additional testing.
> 
> Daniel,
> 
> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>    Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>    https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-deferred-console-takeover
> 
> for you to fetch changes up to 83d83bebf40132e2d55ec58af666713cc76f9764:
> 
>    console/fbcon: Add support for deferred console takeover (2018-06-28 15:20:30 +0200)
> 
> ----------------------------------------------------------------
> Immutable branch between fbdev and drm for the v4.19 merge window
> (contains the deferred console takeover feature)
> 
> ----------------------------------------------------------------
> Hans de Goede (3):
>        printk: Export is_console_locked
>        fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
>        console/fbcon: Add support for deferred console takeover
> 
>   Documentation/fb/fbcon.txt       |  7 ++++
>   drivers/video/console/Kconfig    | 11 ++++++
>   drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++----
>   drivers/video/fbdev/core/fbcon.c | 83 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/console.h          |  5 +++
>   kernel/printk/printk.c           |  1 +
>   6 files changed, 166 insertions(+), 8 deletions(-)
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
