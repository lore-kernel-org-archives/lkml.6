Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E20C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13C625475
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ4UcaBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13C625475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeGBHEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:04:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34876 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeGBHER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:04:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id i125-v6so11691549lji.2;
        Mon, 02 Jul 2018 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0r3B2TrzDpZ9ziRkX5skhp/Llmo6Bo0BJKaeWhPKbNY=;
        b=LJ4UcaBx+rTF9qZB6GEOwQ6Js68f31sSdPIafvahzu7J6lyPZMOkez6ZYf2Khg8Te1
         CLElRCeVdXN+IX+iJKYIy1iwYTkOUtPNzhuvyroAsj3d069Jfp73DmO3+EtW5ESjaEX1
         JSVcfoElFKBD3TDRb+YMnwH7+dBP0swC9QBFGRBMl1jeAIbIL66wPQVxv8JEeLjE4y+a
         FTuUw/+eUtbrpFyr0Nyyc7bKwRDxs/phmfzlUh7TAn+kqeRcC4n5DDxk00+kVo86QT+E
         ODx0Fq3K1Bg2rZfZkxw9KUgbQKZX5XSThMs4wKtVdkvmBYJNvSq0aAHcS7IFOOgv5dQ8
         endQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0r3B2TrzDpZ9ziRkX5skhp/Llmo6Bo0BJKaeWhPKbNY=;
        b=J2i164r1E2qGWciMPmHbgwdbpvVk7x7kt/S8aSgq1Esi0XjUO19tQoCbq7uAQwW9l2
         06ZTgUJ04PIPQZia46NY8/O/snQUeMSKeCNB6lKG0vUOyC4UvEyH2balOCxl80VGAkQs
         QsvrHjHWBlG40NIDry90E9j/SEar/Pi9PrYBFn1Ioqb5dMrhv0DZtsTzmf5u3pvVywF/
         Wwqk2ph/BjA0LGmckBwAD8mEKqTFpkgdXzUbuWPhHnm0HF09k6Oi4zpE9epkmHJpCcHz
         XpezN4VdoUsxG0q9plEdK2cTNfThTeZYKeySsb1xDsZblPnlQHQbmixhey/1KVRalwhX
         Tf4Q==
X-Gm-Message-State: APt69E1gBtg5yoHS9qVDLk0sXk42+upQXMsV9qr2Th4C26OOWL8Ra2cF
        NndRyqBjjQbqOH6Cyyq5ie4=
X-Google-Smtp-Source: AAOMgpei9boRUSIVqmxHLwnP3uLi8JaFPg/ZnGDMR5M0TcSm1dx5RmmeBt7pfM4/yDfsdng+IRh0Yg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr15620811ljj.49.1530515055456;
        Mon, 02 Jul 2018 00:04:15 -0700 (PDT)
Received: from [10.17.182.9] (ll-53.209.223.85.sovam.net.ua. [85.223.209.53])
        by smtp.gmail.com with ESMTPSA id o34-v6sm1592386lfg.12.2018.07.02.00.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 00:04:14 -0700 (PDT)
Subject: Re: [PATCH v4 8/9] xen/gntdev: Implement dma-buf export functionality
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
 <20180615062753.9229-9-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <31fdf7cc-6c57-6216-06b6-54471d873178@gmail.com>
Date:   Mon, 2 Jul 2018 10:04:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615062753.9229-9-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+
> +static const struct dma_buf_ops dmabuf_exp_ops =  {
> +	.attach = dmabuf_exp_ops_attach,
> +	.detach = dmabuf_exp_ops_detach,
> +	.map_dma_buf = dmabuf_exp_ops_map_dma_buf,
> +	.unmap_dma_buf = dmabuf_exp_ops_unmap_dma_buf,
> +	.release = dmabuf_exp_ops_release,
> +	.map = dmabuf_exp_ops_kmap,
> +	.map_atomic = dmabuf_exp_ops_kmap_atomic,
> +	.unmap = dmabuf_exp_ops_kunmap,
> +	.unmap_atomic = dmabuf_exp_ops_kunmap_atomic,
> +	.mmap = dmabuf_exp_ops_mmap,
> +};
> +
>
Due to upcoming API change [1] the atomic ops need to be removed before
merging into the mainline

[1] 
https://cgit.freedesktop.org/drm/drm-misc/commit/include/linux/dma-buf.h?id=f664a52695429b68afb4e130a0f69cd5fd1fec86
