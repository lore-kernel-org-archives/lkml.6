Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23128C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4012077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="IyB7O7bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4012077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeICOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:46:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40050 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeICOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:46:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so32796pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSZqueompcOQmme62pm3nN7LsB9nZ0fRRDlYkCiKIfo=;
        b=IyB7O7bTc8vKS+Xke1FHCKmiaC8XhwL5QyN95NnNWv/w7qxnELMNTwQ/5v+tWrAoi0
         yVWCyK962WPK0I2FEkFIoEInj/Wz2JQBeYWkLt9+CgK3DoeQzePQVZoz2fjmDiX8p02Q
         S5SwgsetubYmZ6RVv96CKHd73cLPwrIZwnVhAXSJUgp1rDj9f2EegCgu5fNrbPCyc2EZ
         bhs0m8748/ajIjHpFJNQDsAVY/vE/xCJ7zS/EaKEFd4cp57Fo/fbH+s925Ygsmvgo2oU
         alHQ49SshYrnqcJOmimobIYMqLgxM5DN9qRTe2QvnQTZHR9TYL8otVlhpSJ7i7FweSWB
         tCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSZqueompcOQmme62pm3nN7LsB9nZ0fRRDlYkCiKIfo=;
        b=S22PfeFKYGvNLs/YipQo+0aNFEB/xn6tz19nPyc5+vbfRkFmNbp4VJ6CFgryPo2iXp
         f9phh7G+Fyc9pzwsUtd4OFYbTZmF8wM97RDt7ug9/kmHDG5oDHTn62A0dbHNbn16NBTJ
         /GyElIJUC3+0JU5TB+rkvHNkrmdqQzddmFE4nvThqs6z0SzO41af/cYG3sdRsF6sY5Jg
         JFtlR8ANqcLS7MhsvsUPTAeazSfrnzuWNCNVrrY5LuAJBfMYV1ipSeLaN7atVowUbOvN
         VOvVqPM75jyFaPGG+mF2rUFruj/nZ6VfMYrUXDSR0UQDqtY9QngeXGE5lMs70szf814y
         QGRg==
X-Gm-Message-State: APzg51DoqFjdqoVKTxdiolOscK6SNljGdKfEpMEvnhgIzpcczmlR5KYx
        nJS9ddLz7fcygvOTgweclnjUzBKDZubeEA==
X-Google-Smtp-Source: ANB0VdZkrUGms1gp56U7nb/gNvpmQcPv9dG7reE5hItonWUmaMlgQwKWTAvE52uPKRORcklncvLLRw==
X-Received: by 2002:a63:1b4e:: with SMTP id b14-v6mr25520197pgm.303.1535970408327;
        Mon, 03 Sep 2018 03:26:48 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id g6-v6sm34252256pfb.11.2018.09.03.03.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:26:47 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5C0F9300D89; Mon,  3 Sep 2018 13:26:42 +0300 (+03)
Date:   Mon, 3 Sep 2018 13:26:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180903102642.rmzawwqsqjvh2mkb@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
 <20180830152512.GE14702@192.168.1.2>
 <20180902205242.kcpt6wsatacahswp@kshutemo-mobl1>
 <20180903074718.GD1740@192.168.1.3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903074718.GD1740@192.168.1.3>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 03:47:18PM +0800, Baoquan He wrote:
> On 09/02/18 at 11:52pm, Kirill A. Shutemov wrote:
> > On Thu, Aug 30, 2018 at 11:25:12PM +0800, Baoquan He wrote:
> > > Hi Kirill,
> > > 
> > > I made a new version according to your suggestion, just a little
> > > different, I didn't make 1TB as default, just calculate with the actual
> > > size, then align up to 1TB boundary.  Just found kcore is printing more
> > > entries than before, I thought it's caused by my code, later got it was
> > > touchde by other people.
> > > 
> > > Any comment about this? I can change accordingly.
> > 
> > Looks good to me.
> > 
> > But there's corner case when struct page is unreasonably large and
> > vmemmap_size will be way to large. We probably have to report an error if
> > we cannot fit vmemmap properly into virtual memory layout.
> 
> Hmm, sizeof(struct page) can't exceed one whole page surely, otherwise
> system bootup can't go over vmemmap initlization. Except of this, we may
> need think about the virtual memory layout which vmemmap can be allowed
> to occupy.
> 
> If KASAN enabled, KASLR disabled,
> 4-level 1TB + 1TB hole (2TB)
> 5-level 512TB + 2034TB hole (2.5PB)
> 
> If KASAN disabled, KASLR enabled,
> 4-level 1TB + 1TB hole + 16TB  (18TB)
> 5-level 512TB + 2034TB hole + 8PB (10.5PB)
> 
> So, as you can see, if add check in memory KASLR code, we should only
> consider KASLR enabled case. We possibly don't need to worry about
> 5-level case since the size 10.5PB is even bigger than the maximum
> physical RAM mapping size. For 4-level, 18TB align to multiples of 2, it
> will be 32 times of the current 1TB, then we usually assume 64 as the
> default value of sizeof(struct page), then 64*32 == 1024. So we can add
> check like this, what do you think? Or any other idea?

Looks reasonable to me.

But I would have the BUILD_BUG_ON() in generic code. If you struct page is
more than 1/4 of PAGE_SIZE something is horribly broken.

> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 1db8e166455e..776ec759a87c 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -90,6 +90,7 @@ void __init kernel_randomize_memory(void)
>         BUILD_BUG_ON(vaddr_start >= vaddr_end);
>         BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
>         BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
> +       BUILD_BUG_ON(sizeof(struct page ) > PAGE_SIZE/4);

Nitpick: redundant space before ')'.

>  
>         if (!kaslr_memory_enabled())
>                 return;
> 
> 
> For 5-level paging mode, we
> may not need to worry about that. Since KASAN 
> 
> ***4-level***
> ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
> ... unused hole ...
> ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> ... unused hole ...
> 
> 
> 
> ***5-level***
> ffd4000000000000 - ffd5ffffffffffff (=49 bits) virtual memory map (512TB)
> ... unused hole ...
> ffdf000000000000 - fffffc0000000000 (=53 bits) kasan shadow memory (8PB) 
> 
> > 
> > -- 
> >  Kirill A. Shutemov

-- 
 Kirill A. Shutemov
