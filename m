Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4192A20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7sO3c9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4192A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJ3WF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:05:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43560 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeJ3WF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:05:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so13290371qtq.10;
        Tue, 30 Oct 2018 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWJjXJVwAptVkm5YP9dkz6BlJrXAb8LonUsQbKVNbUc=;
        b=Q7sO3c9fdvBBFOf/wtjKn6SAHnoM+i45kvYsi1l3wlr+GZxTahlqPz942/TXpkfrac
         gk/cy3CFdG11J7R1gh9cnVPl8tbzh6ffNmTF81Xt5XY6ZfU8jUr8inuWOMiE0hmZQvG3
         LrJUevzPrBlXe0qHtAh/RP6OR5zzNxsrD52lGoz0QScRp7K5t4qEMOPiiVG4XXukWdsT
         ir8XCdfAbVR+kK6GisP+LFEFoJh9o7W7gUjqKwTmsDqSb/AjamXFAUWFbgaxegHlTTay
         UfU+Ihl409wWNGoTb5X5pI8t0WO6wG7ceYBrPKYtnun/bBrl45rcUYhHs93yrF+RqRzz
         UoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWJjXJVwAptVkm5YP9dkz6BlJrXAb8LonUsQbKVNbUc=;
        b=GU4tICaIMe9TJcGI9eD88VhW6XzP1rGqNBgTMkdsr+ftfLtInN6SY8/Q4w5UL4MAs7
         wRuWyQWlsLvwLJaIBVuoVeESeVsp14nyghKwraVKkn6kyJuyMziujIkP7rt30QCy/q6l
         qMGqbvVu4CvjblLxOPIGF3QHtbBKuEKL0NbCP3FBcBLHMgOpgi1rGX6Qtjk1KxFE7f1M
         mpdusuEa7CBcduWoq1EMQqUJ66ioDanULO4jNQ1dvsfM8wgW5UV3oxl10JnzCuk64dyh
         TVQHoBVD0eu/qzJjpEBa5Yu+Z390bDGO59cqUH1P5YhBinLD0F0nnbzdTc+PE48eRPX9
         tlXg==
X-Gm-Message-State: AGRZ1gLfVloVl0ZUaT9ZhOrr0TSvCYo1St3Sm1afH3LQ/ETS5pASREyJ
        ovCBDUrTugZ6Dm+exvcAwV0G+hkqbAh7Qkwup0E=
X-Google-Smtp-Source: AJdET5fNGJS3qd1UQTqbgZ/n9vVC9D6e7VCfnfqKoQZ8ZxVYq7m456AQAqNkAFteTvy0g8y1FZode4vcf+5MQzwHoPc=
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr2106368qte.229.1540905153499;
 Tue, 30 Oct 2018 06:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <20181006065113.669-4-rajneesh.bhardwaj@linux.intel.com> <CAHp75VfS2cB3fh1R_iQk91skU-p+yZ_X1Jx2sBaiwHmtAZ0dpw@mail.gmail.com>
 <b1d972ce-6672-344c-e432-c8bc9bb20dad@linux.intel.com>
In-Reply-To: <b1d972ce-6672-344c-e432-c8bc9bb20dad@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 15:12:22 +0200
Message-ID: <CAHp75VfkW4PkgUj3yjyeUt8GVgQwbmQGB2GxN0Jj_appTPEi_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] platform/x86: intel_telemetry: report debugfs failure
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:41 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
>
>
> On 19-Oct-18 6:09 PM, Andy Shevchenko wrote:
> > On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> On some Goldmont based systems such as ASRock J3455M the BIOS may not
> >> enable the IPC1 device that provides access to the PMC and PUNIT. In
> >> such scenarios, the IOSS and PSS resources from the platform device can
> >> not be obtained and result in a invalid telemetry_plt_config which is an
> >> internal data structure that holds platform config and is maintained by
> >> the telemetry platform driver.
> >>
> >> This is also applicable to the platforms where the BIOS supports IPC1
> >> device under debug configurations but IPC1 is disabled by user or the
> >> policy.
> >>
> >> This change allows user to know the reason for not seeing entries under
> >> /sys/kernel/debug/telemetry/* when there is no apparent failure at boot.
> >>
> > Pushed to my review and testing queue, thanks!
> >
> > P.S. I appended one more patch against this file, please check if it's okay.
>
> Thank you Andy. I will check it when Infradead is online.

You may check our mirror on GH:
https://github.com/dvhart/linux-pdx86

>
> >
> >> Cc: Matt Turner <matt.turner@intel.com>
> >> Cc: Len Brown <len.brown@intel.com>
> >> Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> >> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
> >>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779
> >> Acked-by: Matt Turner <matt.turner@intel.com>
> >> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >> ---
> >> Changes in v2:
> >>   * Removed print and out label both as suggested by Andy.
> >>   * changed to pr_info.
> >>   * Other minor style fixes.
> >>
> >>
> >>   drivers/platform/x86/intel_telemetry_debugfs.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
> >> index ffd0474b0531..1423fa8710fd 100644
> >> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> >> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> >> @@ -951,12 +951,16 @@ static int __init telemetry_debugfs_init(void)
> >>          debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
> >>
> >>          err = telemetry_pltconfig_valid();
> >> -       if (err < 0)
> >> +       if (err < 0) {
> >> +               pr_info("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
> >>                  return -ENODEV;
> >> +       }
> >>
> >>          err = telemetry_debugfs_check_evts();
> >> -       if (err < 0)
> >> +       if (err < 0) {
> >> +               pr_info("telemetry_debugfs_check_evts failed\n");
> >>                  return -EINVAL;
> >> +       }
> >>
> >>          register_pm_notifier(&pm_notifier);
> >>
> >> --
> >> 2.17.1
> >>
> >
>


-- 
With Best Regards,
Andy Shevchenko
