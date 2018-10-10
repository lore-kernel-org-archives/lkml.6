Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA82075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFA82075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:22:59 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54261 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:22:59 -0400
Received: by mail-wm1-f52.google.com with SMTP id y11-v6so4973672wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGOvIDiXi8rZpK4pQ1UHgy5Nu+v3SkUkMwVE8LJ4460=;
        b=f84s0NLqn7YBqrcX2fQlhKrxrKy87et0kRPwGGFNFOaRJ1a9IAyE5Z9xt1ZUgFi28J
         0DTRP8ysLy/7t8JVCaPma9H/2XghTAckoOVFoAqx2SpdCCo7r5drFXOFp38yTLmd2vTD
         V4Z41vg/pfOUBPcdE7C4YN9Y1JSaEUF5AnGj9lde/BgnXZAcrN/Y2cohdEnyQ1v3ftcz
         FnHjQ7j0zcdi7nMU48GJZo9fBodZRg0pa6J2MzBzT9rXdxLqorakkux8ISvUoLnQfCcl
         dpTo7PDqCbOZb5rrj/JuaMjlaTcqAGcNs+xX+BYOtXXIPGrnqSdKxH+eoPOxxJjEmyuu
         Suyg==
X-Gm-Message-State: ABuFfogi/XSP+vphvz7LKBKMzJ17kuke99jkx6qKjENb0CB8ngkBr0Uo
        ShY+xX5S0+PqE8dmJEQkQk8=
X-Google-Smtp-Source: ACcGV60GSsvJTzGmY5aYH48vPCfYL7vQRN6YIA0LfR7Ufo9bJOOzEkW8Sy00JprVe8mX4l9WxSkzKg==
X-Received: by 2002:a1c:6783:: with SMTP id b125-v6mr494487wmc.142.1539169281121;
        Wed, 10 Oct 2018 04:01:21 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o126-v6sm15784539wmo.3.2018.10.10.04.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 04:01:20 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id BC7C8125026; Wed, 10 Oct 2018 13:01:19 +0200 (CEST)
Date:   Wed, 10 Oct 2018 13:01:19 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Arun KS <arunks@codeaurora.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-ID: <20181010110119.GA20952@techadventures.net>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <20181010080724.GA20338@techadventures.net>
 <f18b87a0762c4379b78e9b5e09ff4840@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18b87a0762c4379b78e9b5e09ff4840@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:21:16PM +0530, Arun KS wrote:
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e379e85..2416136 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -690,9 +690,13 @@ static int online_pages_range(unsigned long start_pfn,
> unsigned long nr_pages,
>                         void *arg)
>  {
>         unsigned long onlined_pages = *(unsigned long *)arg;
> +       u64 t1, t2;
> 
> +       t1 = local_clock();
>         if (PageReserved(pfn_to_page(start_pfn)))
>                 onlined_pages = online_pages_blocks(start_pfn, nr_pages);
> +       t2 = local_clock();
> +       trace_printk("time spend = %llu us\n", (t2-t1)/(1000));
> 
>         online_mem_sections(start_pfn, start_pfn + nr_pages);

Thanks ;-)
 

-- 
Oscar Salvador
SUSE L3
