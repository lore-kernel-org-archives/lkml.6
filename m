Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4DD21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfAWJmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:42:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfAWJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:42:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so1609852wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwAAqvJT9N3NStH/aQvsXyjV9S5c+31FqNJh677rm8w=;
        b=QEp1ml3A+XuDVX2tx5pb4tcMRdKUpkcQadQc6jUpnzNbnYmDbJDuyIBiZJRYw0WGfH
         PjE+pCSbBx3BV9m/tVbgP0na0Jbyer9WaEZeIHIOh0viUcXquIV0nkUhLMr1Q0xD5h3V
         EFL4H3veFDuRh/igpP+VyMV49pI9aLZd7J+UzbAsD7EnNjHSH8H4vJV4+LaFqq6sltBP
         UEsfSINSTsUnRj/atBxQxq41cWClKjKl0zkG/sSnqwxlVIEP5jvi3twp8bsn6WhqLQvh
         wLJ2m0bceC4VY66vk7MTW9yK1QnoE+H55biXdgwNEN8YmttxZVn/RbyJ8PeyL7JuzLVv
         5pAQ==
X-Gm-Message-State: AJcUukejOJpXSpZ++fGI5O4X+0Ik4WU6XsYrdH8MQt90VrWs8sIONFBH
        L1ZOvcUpGOO9q5DtaKUY7IJ2kQ==
X-Google-Smtp-Source: ALg8bN6Z8xYEd94pbnVQW2xw+r9i6sbB1rON1vRhzANgRjLt+xlHjWidTs1ed1fitLjVoOCRInrJJQ==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr1843831wrv.121.1548236534444;
        Wed, 23 Jan 2019 01:42:14 -0800 (PST)
Received: from [10.200.139.106] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id w18sm95376173wru.54.2019.01.23.01.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 01:42:13 -0800 (PST)
Subject: Re: [PATCH 2/4] arm: dump: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-3-gregkh@linuxfoundation.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <7022c531-e3df-73e9-824f-11a623252045@redhat.com>
Date:   Wed, 23 Jan 2019 10:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122144114.9816-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 6:41 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jinbum Park <jinb.park7@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>

Acked-by: Laura Abbott <labbott@redhat.com>

> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   arch/arm/include/asm/ptdump.h | 9 +++------
>   arch/arm/mm/dump.c            | 4 ++--
>   arch/arm/mm/ptdump_debugfs.c  | 8 ++------
>   3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> index 3ebf9718288d..0c2d3d0d4cc6 100644
> --- a/arch/arm/include/asm/ptdump.h
> +++ b/arch/arm/include/asm/ptdump.h
> @@ -21,13 +21,10 @@ struct ptdump_info {
>   
>   void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>   #else
> -static inline int ptdump_debugfs_register(struct ptdump_info *info,
> -					const char *name)
> -{
> -	return 0;
> -}
> +static inline void ptdump_debugfs_register(struct ptdump_info *info,
> +					   const char *name) { }
>   #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
>   
>   void ptdump_check_wx(void);
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 084779c5c893..eb385a500ed0 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -450,7 +450,7 @@ void ptdump_check_wx(void)
>   static int ptdump_init(void)
>   {
>   	ptdump_initialize();
> -	return ptdump_debugfs_register(&kernel_ptdump_info,
> -					"kernel_page_tables");
> +	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +	return 0;
>   }
>   __initcall(ptdump_init);
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..598b636615a2 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
>   	.release	= single_release,
>   };
>   
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
> -	struct dentry *pe;
> -
> -	pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> -	return pe ? 0 : -ENOMEM;
> -
> +	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>   }
> 

