Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39686ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB88620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGWMnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:43:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53590 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbeGWMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:43:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so798773wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 04:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ia8dj8GP0dO3KcoBP71MGqZ7p7UT8Jn2L+gYB5Nml/w=;
        b=ngVfKCcDMIsxm9Y0MnUsAWrPTOnZQ3McDTO1h6Ouzabp+ZGFeif4r7yA4yGh1VExD/
         10xjlb0ygnaoUJJ1wyQqntPISuGwxUGETTuNc6K1PqcS4KK38lnZNVoecqkt1Feg/uT9
         KND829GOSX3u21SjzsJcS9RzO3y4WXyxuob34Af7ZbUTYO6Dk5uugNkc2yeBTSntS9GL
         K04ChdNAKm7f1yy2Y2hR3R78L/773w0f1hfUWssr5aPiugXAA30UWBdWZQmksSmw+t5e
         lKlYD1szjzxSf74T2G3ah3Bp0FA5F/U10jQ7U8quXBM3k2EZY1Knlx7wlZp8YCdWs/8F
         tYLg==
X-Gm-Message-State: AOUpUlGaeGmntQjz6JMjadZ3ZUK7nrl79pGv8wQuUjNo04KkgTk88wgZ
        +1r1+LUyXi3f3TosoJ2zdcw=
X-Google-Smtp-Source: AAOMgpdpy6GxXy52SxSUl20oayFguvqBpfxOLbkhqu835LXb8df+T8xJh3KMN/SCs8iLRHUERF1l8Q==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr7049146wmd.77.1532346146001;
        Mon, 23 Jul 2018 04:42:26 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j131-v6sm9239040wmb.25.2018.07.23.04.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 04:42:25 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id B1B0A124257; Mon, 23 Jul 2018 13:42:24 +0200 (CEST)
Date:   Mon, 23 Jul 2018 13:42:24 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180723114224.GA7104@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
 <20180719151555.GH7193@dhcp22.suse.cz>
 <20180719205235.GA14010@techadventures.net>
 <20180720100327.GA19478@techadventures.net>
 <20180723083519.GG17905@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723083519.GG17905@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:35:19AM +0200, Michal Hocko wrote:
> No, I do not think this is much better. Why do we need to separate those
> functions out? I think you are too focused on the current function
> without a broader context. Think about it. We have two code paths.
> Early initialization and the hotplug. The two are subtly different in
> some aspects. Maybe reusing free_area_init_core is the wrong thing and
> we should have a dedicated subset of this function. This would make the
> code more clear probably. You wouldn't have to think which part of
> free_area_init_core is special and what has to be done if this function
> was to be used in a different context. See my point?

Yes, I see your point now.
I will think about it with a wider approach.

Thanks
-- 
Oscar Salvador
SUSE L3
