Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE866C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC9C20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2gF5iYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC9C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeKHOSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:18:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38706 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeKHOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:18:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so8746370pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xV9MY+QCgsbC06VkvFXZ/syTFu6zWUVr0mQ1PV7wA18=;
        b=F2gF5iYUQnkc/peq7+ZxuDpcip9l50BHXhs7k/CXmu0tR2b2/MQUlukT4gUWQZ8v0W
         VExXho3RWxyWrRmSwSxD5WWl4spAOStWWM9YSy8zKzKa8YC7sLT6QMiO/+wyiDRRR+dU
         oYIwQm3U5fudDG3dRt5zFzlBQzzzg3SqsGym8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xV9MY+QCgsbC06VkvFXZ/syTFu6zWUVr0mQ1PV7wA18=;
        b=Ou7W9EGXr+Ye51hLpQ5LAvjePRta7hoQG57FFVoybmEo2pnqILgdVm1062C/PuQCph
         rm8qDuS+aqVh9Az/j2X0ZKgM4WYn1yJB8A59rY7FQi/cO4wSpxTxRoU+xJb9pJIGJsu9
         g3d9EtUO9a9hAFsD51IiAtSLJzRM34sPlFnjTPqAEyuMDq6E05Gurzj/w3Qi7jjaKcia
         s9ZiWLdEaS0pqDS26nv9fCuJhLw/BQ82AjanFRhxdmMMt580coZ1fnaa7gzSJxjSj6fb
         Sfujg3ABLNdojlrvhmycGMyVKbly+ZFwYL4ywRIEt+kTgpAB0BH2Nv49cbuBCp0X9qQq
         5FTg==
X-Gm-Message-State: AGRZ1gIiSD3sqlnvTuYoNoMUflYaouqz4dqDdYbsEMQC5KdEeYosRjUM
        ESH2Ob2f0XjBTOMuvQQx4nnsrQ==
X-Google-Smtp-Source: AJdET5ezZASTNVceoUPAlHzRKfhzmR6BXvP36bnPwJPafcjLZVZ7mbbuC/ma7Mqd1kA/kCVw9v8Rnw==
X-Received: by 2002:a62:65c3:: with SMTP id z186-v6mr3186208pfb.206.1541652306276;
        Wed, 07 Nov 2018 20:45:06 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id o30-v6sm1949552pgm.89.2018.11.07.20.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:45:05 -0800 (PST)
Date:   Thu, 8 Nov 2018 10:15:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Message-ID: <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
References: <20181107161346.9887-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107161346.9887-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-18, 11:13, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c | 46 +++--------------------
>  1 file changed, 6 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> index 4d976e8dbb2f..0df87b6480fe 100644
> --- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> +++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> @@ -63,18 +63,7 @@ static int board_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_board_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, board_show, NULL);
> -}
> -
> -static const struct file_operations fops_board = {
> -	.open		= fops_board_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(board);
>  
>  static int info_show(struct seq_file *seq, void *p)
>  {
> @@ -105,18 +94,7 @@ static int info_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_info_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, info_show, NULL);
> -}
> -
> -static const struct file_operations fops_info = {
> -	.open		= fops_info_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> +DEFINE_SHOW_ATTRIBUTE(info);
>  
>  static int io_show(struct seq_file *seq, void *p)
>  {
> @@ -162,19 +140,7 @@ static int io_show(struct seq_file *seq, void *p)
>  	return 0;
>  }
>  
> -static int fops_io_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, io_show, NULL);
> -}
> -
> -static const struct file_operations fops_io = {
> -	.open		= fops_io_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -	.owner		= THIS_MODULE,
> -};
> -
> +DEFINE_SHOW_ATTRIBUTE(io);
>  
>  static int __init s3c_freq_debugfs_init(void)
>  {
> @@ -185,13 +151,13 @@ static int __init s3c_freq_debugfs_init(void)
>  	}
>  
>  	dbgfs_file_io = debugfs_create_file("io-timing", S_IRUGO, dbgfs_root,
> -					    NULL, &fops_io);
> +					    NULL, &io_fops);
>  
>  	dbgfs_file_info = debugfs_create_file("info", S_IRUGO, dbgfs_root,
> -					      NULL, &fops_info);
> +					      NULL, &info_fops);
>  
>  	dbgfs_file_board = debugfs_create_file("board", S_IRUGO, dbgfs_root,
> -					       NULL, &fops_board);
> +					       NULL, &board_fops);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
