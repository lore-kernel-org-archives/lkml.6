Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9357127F11
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9357127F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=padovan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936348AbeF2Mv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:51:56 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36805 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbeF2Mvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:51:54 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so4824419qkg.3;
        Fri, 29 Jun 2018 05:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJJ0ldFQTSe19k56pFFEU36NFdqi4tg8IezQFz7NGVE=;
        b=ikgY/EmEMXV0ZhjlWEsXe+ZEpN/a6n+WfWlCgpcxg725ilqFgwPhQddsFIZ1rUxPor
         yZcDuFa71uhXobFOmn6ELu9JW+/s7lf3+nHdFMs0dFmcxBnzChGtuVHFt5U1DqCBlNVM
         QdEtVLJVt1rvze5s51enREhSjwDjm3gdMjU3zIutw6pQs9Yr6q7ksexSCnf/WGi8fDje
         e33Q9DmL2Nqh8LcMiBop2Zq2/Rke6QLJ7eeB7dN56ouItdMnCVP1JNDXDL3tHaKaw+ym
         S81qfzMiXefS4BkOliiqkUwunTqvPaBn6khZGDfV/CjU6Sx3H/r3WFzYgt8D9djSv9oc
         HjnQ==
X-Gm-Message-State: APt69E31q3Ktfqh9wxASMVr9yRW9TqS3yui93hkCtWXuvb/WIVpUOKgy
        yMk4MyqV3CUzN1qtTiA/aUdJrLiG
X-Google-Smtp-Source: AAOMgpfNVTbLKJfySOdc+Whpj0J8aeJeFEG2Y5zodCDN0oolMpkNalmz7LpN3ngNCDmZCprPaGLcsA==
X-Received: by 2002:a37:2814:: with SMTP id o20-v6mr12523332qkh.245.1530276713899;
        Fri, 29 Jun 2018 05:51:53 -0700 (PDT)
Received: from juma ([2804:14c:181:9195:9419:3bed:192:1e62])
        by smtp.gmail.com with ESMTPSA id q15-v6sm557300qtl.39.2018.06.29.05.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 05:51:52 -0700 (PDT)
Message-ID: <b0fa4f70c85b77853a71282fcf7ae0fccf655827.camel@padovan.org>
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console
 takeover
From:   Gustavo Padovan <gustavo@padovan.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org
Date:   Fri, 29 Jun 2018 09:51:48 -0300
In-Reply-To: <3340294.YySDL1Tsl7@amdc3058>
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
         <2462549.rLSfW9kX99@amdc3058>
         <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
         <3340294.YySDL1Tsl7@amdc3058>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 12:08 +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi Gustavo,
> 
> On Thursday, June 28, 2018 07:44:38 PM Gustavo Padovan wrote:
> > Hi Bartlomiej,
> > 
> > On Thu, 2018-06-28 at 15:50 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
> > > > Hi All,
> > > > 
> > > > Here is v5 of my patch-set, to delay fbcon taking over the
> > > > console
> > > > (and
> > > > binding to fbdev devices) until there actually is some text
> > > > output
> > > > to the
> > > > console. This is intended for use with the "quiet" cmdline
> > > > option,
> > > > in
> > > > combination with a bootloader which leaves the vendor's logo /
> > > > EFI bootgraphics put up by the firmware intact on the EFI
> > > > framebuffer.
> > > > 
> > > > The end goal here is a boot where the firmware shows its boot
> > > > graphics
> > > > and these stay in place for a couple of seconds until the GUI
> > > > loads
> > > > and
> > > > the GUI then smoothly takes over the framebuffer without any
> > > > distruptions.
> > > > 
> > > > Bartlomiej, I believe that this patch-set is ready for merging
> > > > now
> > > > and
> > > > the first patch has Petr's ack, so can we get this merged now?
> > > 
> > > Done, thanks for patches (also for reviews & acks).
> > > 
> > > > Also please create an inmutable (or topic) branch for this, so
> > > > that
> > > > the
> > > > drm people can merge it into drm-tip for additional testing.
> > > 
> > > Daniel,
> > > 
> > > The following changes since commit
> > > 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> > > 
> > >   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> > > 
> > > are available in the git repository at:
> > > 
> > >   https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-
> > > deferred-console-takeover
> > > 
> > > for you to fetch changes up to
> > > 83d83bebf40132e2d55ec58af666713cc76f9764:
> > > 
> > >   console/fbcon: Add support for deferred console takeover (2018-
> > > 06-
> > > 28 15:20:30 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between fbdev and drm for the v4.19 merge window
> > > (contains the deferred console takeover feature)
> > > 
> > > ----------------------------------------------------------------
> > > Hans de Goede (3):
> > >       printk: Export is_console_locked
> > >       fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
> > >       console/fbcon: Add support for deferred console takeover
> > > 
> > >  Documentation/fb/fbcon.txt       |  7 ++++
> > >  drivers/video/console/Kconfig    | 11 ++++++
> > >  drivers/video/console/dummycon.c | 67
> > > ++++++++++++++++++++++++++++
> > > ----
> > >  drivers/video/fbdev/core/fbcon.c | 83
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/console.h          |  5 +++
> > >  kernel/printk/printk.c           |  1 +
> > >  6 files changed, 166 insertions(+), 8 deletions(-)
> > 
> > Pulled into drm-misc-next, thanks
> 
> Please also apply fixup branch:
> 
> The following changes since commit
> 83d83bebf40132e2d55ec58af666713cc76f9764:
> 
>   console/fbcon: Add support for deferred console takeover (2018-06-
> 28 15:20:30 +0200)
> 
> are available in the git repository at:
> 
>   https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-
> deferred-console-takeover-fixup
> 
> for you to fetch changes up to
> 334bb8972a131e604a741e9b284d8867190c723e:
> 
>   console: dummycon: export dummycon_[un]register_output_notifier
> (2018-06-29 11:46:19 +0200)
> 
> ----------------------------------------------------------------
> Immutable branch between fbdev and drm for the v4.19 merge window
> (contains build fixup for the deferred console takeover feature)
> 
> ----------------------------------------------------------------
> Hans de Goede (1):
>       console: dummycon: export dummycon_[un]register_output_notifier
> 
>  drivers/video/console/dummycon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/console/dummycon.c
> b/drivers/video/console/dummycon.c
> index 45ad925..0254251 100644
> --- a/drivers/video/console/dummycon.c
> +++ b/drivers/video/console/dummycon.c
> @@ -38,11 +38,13 @@ void dummycon_register_output_notifier(struct
> notifier_block *nb)
>  	if (dummycon_putc_called)
>  		nb->notifier_call(nb, 0, NULL);
>  }
> +EXPORT_SYMBOL_GPL(dummycon_register_output_notifier);
>  
>  void dummycon_unregister_output_notifier(struct notifier_block *nb)
>  {
>  	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
>  }
> +EXPORT_SYMBOL_GPL(dummycon_unregister_output_notifier);
>  
>  static void dummycon_putc(struct vc_data *vc, int c, int ypos, int
> xpos)
>  {
> 

Pulled. Thanks.

Gustavo
