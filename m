Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085EF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfBZQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:10:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:10:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so15465154qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 08:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QtUY5Tv1lyEiK8OfP83p1zoJMwRohlkPbiHE/lluIWc=;
        b=K2l6YoQSD/9WWlh0rK2fHlb9yydK2pIgMt2D0HbRuOJJ8NaGKCx7DsroFUtaJIhUuJ
         TwAwHqeGAL5DB9wslTSwDVOQR+jKvEVrV5Ghy9dvPvCMak4qjtmrqgr5Ya0C2zPuCw8u
         Mc+MWsdBrAJ9qfTfh2775FELz56YS88VttzzZ7qpuMp/xM1j+jW7IRVMweU+7qcGDSCD
         /4sHAJoYnzXcNAwLV0fuhr+Cde+9a0EOmphFlyvlngVn+lekRrzxNw1y+HkSSBqnKDIL
         rI7bkCX2yatukEvR2fNKJC7uV7NFZj7kPV8GGtvoA1/2DTbab0vylz9FqHkDBfGGVUbq
         fNcA==
X-Gm-Message-State: AHQUAuZYaBkoiphl8uiq6yCtYi6nsR9lKrGu3p+Ncurmo5u/PBQJdEAT
        3AY0gfRbSLltvQnUoVwE8FoGUg==
X-Google-Smtp-Source: AHgI3IaAujNxe1Om13JYaTeyF5FgbI82LN/puSAh6XAEssH+8BI1tp15VdWnlUcL22EoU99PiKchyA==
X-Received: by 2002:ac8:969:: with SMTP id z38mr18988900qth.49.1551197409510;
        Tue, 26 Feb 2019 08:10:09 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v131sm7511283qka.95.2019.02.26.08.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:10:08 -0800 (PST)
Date:   Tue, 26 Feb 2019 11:10:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, somlo@cmu.edu
Subject: Re: [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev sysfs
Message-ID: <20190226110934-mutt-send-email-mst@kernel.org>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226073159.13434-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
> to define the attribute.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 039e0f91dba8..a1293cbd7adb 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
> +			       char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>  }
> -
> -static const struct {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> -} fw_cfg_rev_attr = {
> -	.attr = { .name = "rev", .mode = S_IRUSR },
> -	.show = fw_cfg_showrev,
> -};
> +static const struct kobj_attribute fw_cfg_rev_attr =
> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>  
>  /* fw_cfg_sysfs_entry type */
>  struct fw_cfg_sysfs_entry {


Looks like this will change the name from "rev" to "fw_cfg_rev".
That's a userspace visible change which we should not do lightly.
> -- 
> 2.19.1
