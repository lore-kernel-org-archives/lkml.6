Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C731E27A0F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731E27A0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=padovan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967457AbeF1Wou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:44:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43980 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967440AbeF1Wop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:44:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id c8-v6so6276843qtp.10;
        Thu, 28 Jun 2018 15:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOKjmY08TQCOWzO7t1S2J8OEJ4Ki3d6Zvi4FJXab84g=;
        b=WGOTAaDFqtIM/SZkhGrwSoX8Lu6d03fUGgBLDMEVCTAAlYjILH2amGM1wxaGccdd8R
         xH33YfKsx8wZqHgwSPpiTQMW6SkKJDuIfZeFRTCOIy19KgYit+pbYQs5XDAeV87ViEH+
         lYJ2u0OPOS+FffYwcBaFssxk0wg9J9gE17m7N1cRvlL8X1Z/ereccos0uGjhnj3PhGMo
         9mLj8xjXc5yIzSUuDXMyzNeuI3pKfCcwosKDtBn4l3jn8tCqXb+MLhzL1NIXYQWq2rmQ
         7d9fVjQAiJ3nWiDIAotJAfXJEej5LOt16B49AZSovm9fDwC3CkGyimVDBOO/tLyzeW98
         2BFQ==
X-Gm-Message-State: APt69E1X/78hk28U4lzisNPiOI9twrrpwebe3jjfOij8n6bkd//tRN7V
        tDiQd8rTJ3E+rqZaODWty2Q=
X-Google-Smtp-Source: AAOMgpd5WOqkUcBlNwlm2XLEp+rsZRkKPx1byP3LdQpzwAFl3He1tH9a7rvbVmVDZdhCEmUGqfBkUg==
X-Received: by 2002:a0c:8e43:: with SMTP id w3-v6mr10992863qvb.215.1530225884738;
        Thu, 28 Jun 2018 15:44:44 -0700 (PDT)
Received: from juma ([2804:14c:181:9195:9419:3bed:192:1e62])
        by smtp.gmail.com with ESMTPSA id c9-v6sm4465554qth.35.2018.06.28.15.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 15:44:43 -0700 (PDT)
Message-ID: <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console
 takeover
From:   Gustavo Padovan <gustavo@padovan.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org
Date:   Thu, 28 Jun 2018 19:44:38 -0300
In-Reply-To: <2462549.rLSfW9kX99@amdc3058>
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
         <20180628090351.15581-1-hdegoede@redhat.com> <2462549.rLSfW9kX99@amdc3058>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Thu, 2018-06-28 at 15:50 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
> > Hi All,
> > 
> > Here is v5 of my patch-set, to delay fbcon taking over the console
> > (and
> > binding to fbdev devices) until there actually is some text output
> > to the
> > console. This is intended for use with the "quiet" cmdline option,
> > in
> > combination with a bootloader which leaves the vendor's logo /
> > EFI bootgraphics put up by the firmware intact on the EFI
> > framebuffer.
> > 
> > The end goal here is a boot where the firmware shows its boot
> > graphics
> > and these stay in place for a couple of seconds until the GUI loads
> > and
> > the GUI then smoothly takes over the framebuffer without any
> > distruptions.
> > 
> > Bartlomiej, I believe that this patch-set is ready for merging now
> > and
> > the first patch has Petr's ack, so can we get this merged now?
> 
> Done, thanks for patches (also for reviews & acks).
> 
> > Also please create an inmutable (or topic) branch for this, so that
> > the
> > drm people can merge it into drm-tip for additional testing.
> 
> Daniel,
> 
> The following changes since commit
> 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>   https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-
> deferred-console-takeover
> 
> for you to fetch changes up to
> 83d83bebf40132e2d55ec58af666713cc76f9764:
> 
>   console/fbcon: Add support for deferred console takeover (2018-06-
> 28 15:20:30 +0200)
> 
> ----------------------------------------------------------------
> Immutable branch between fbdev and drm for the v4.19 merge window
> (contains the deferred console takeover feature)
> 
> ----------------------------------------------------------------
> Hans de Goede (3):
>       printk: Export is_console_locked
>       fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
>       console/fbcon: Add support for deferred console takeover
> 
>  Documentation/fb/fbcon.txt       |  7 ++++
>  drivers/video/console/Kconfig    | 11 ++++++
>  drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++
> ----
>  drivers/video/fbdev/core/fbcon.c | 83
> ++++++++++++++++++++++++++++++++++++++++
>  include/linux/console.h          |  5 +++
>  kernel/printk/printk.c           |  1 +
>  6 files changed, 166 insertions(+), 8 deletions(-)

Pulled into drm-misc-next, thanks

Gustavo
