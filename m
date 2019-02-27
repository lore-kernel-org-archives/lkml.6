Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806F220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfB0NvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:51:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37341 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfB0NvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:51:15 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so19215340qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YvlsXwhEZtRq1qXgXc294LMipa/7ELcsXAvtmhwAmH0=;
        b=C84vusKyx8qtGSgCjTLyC9o7zxsTpJ0fijmV5aGHHcOtplbsxslCC+P6eWiz/5T55b
         zcsmG5VII/xnLkfihSfChdaux8tr9gAanZ9LXOdvf6PpCGcDZ3V4ewOoDkS1LoUL8xgf
         C8T0RWXQrtovjbHOQv42zxzwA79ixtffCVXWbsG5clA9T2HVNmxXZN9NS4TTPoBbpyWT
         2i2nYhNE2ZtHHIIiHQcAgovdWuLNS6lKuXFn2op3BdE8b07U36CCApg4GsHNtBVp5iaN
         yqeSq+vCaKM4mnXlZrxNpMVRsq6bHJEZ9IImjldggrAYGYmzFXBsheKoKjXfml6uAd1D
         3gXQ==
X-Gm-Message-State: AHQUAubBHJGIPa+v19m19RckM3Io5eJ8IbrVMrz3/eqDINjfmpbzKKcC
        GDHIkV62k9YAOiGYwgodl1XaxhEfKLLo6g==
X-Google-Smtp-Source: AHgI3IZf9t3dteasKSmnI425pGrzutYqAiVJlYluv4WHt5o9pKxOKiIRY0H0FMWWumUaxyPWtYTweA==
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr1732201qtr.117.1551275474064;
        Wed, 27 Feb 2019 05:51:14 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id t129sm8304620qkd.16.2019.02.27.05.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 05:51:13 -0800 (PST)
Date:   Wed, 27 Feb 2019 08:51:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, somlo@cmu.edu
Subject: Re: [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev sysfs
Message-ID: <20190227084843-mutt-send-email-mst@kernel.org>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <20190226110934-mutt-send-email-mst@kernel.org>
 <20190227053319.GB5449@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227053319.GB5449@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:33:19PM +0800, Wei Yang wrote:
> On Tue, Feb 26, 2019 at 11:10:06AM -0500, Michael S. Tsirkin wrote:
> >On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
> >> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
> >> to define the attribute.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
> >>  1 file changed, 4 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> >> index 039e0f91dba8..a1293cbd7adb 100644
> >> --- a/drivers/firmware/qemu_fw_cfg.c
> >> +++ b/drivers/firmware/qemu_fw_cfg.c
> >> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> >> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
> >> +			       char *buf)
> >>  {
> >>  	return sprintf(buf, "%u\n", fw_cfg_rev);
> >>  }
> >> -
> >> -static const struct {
> >> -	struct attribute attr;
> >> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> >> -} fw_cfg_rev_attr = {
> >> -	.attr = { .name = "rev", .mode = S_IRUSR },
> >> -	.show = fw_cfg_showrev,
> >> -};
> >> +static const struct kobj_attribute fw_cfg_rev_attr =
> >> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
> >>  
> >>  /* fw_cfg_sysfs_entry type */
> >>  struct fw_cfg_sysfs_entry {
> >
> >
> >Looks like this will change the name from "rev" to "fw_cfg_rev".
> >That's a userspace visible change which we should not do lightly.
> 
> You are right, I should keep the interface untouched.
> 
> To keep it user un-visible, we could change like below:
> 
> -       __ATTR_RO(fw_cfg_rev);
> +       __ATTR_RO(rev);
> 
> Is this better for you?


Also why use 0400 and not S_IRUSR?

> >> -- 
> >> 2.19.1
> 
> -- 
> Wei Yang
> Help you, Help me
