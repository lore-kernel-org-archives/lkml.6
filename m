Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16F620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16F620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeGZUdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:33:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbeGZUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:33:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so2762467wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4IzRg2SDKNUgMBR6sRLOclGJ2iNz17T8fUb4ChwV6A=;
        b=nlQ+vUMF+QGg957XKme4AizlZNg8hN2vugb4KH8LhimRSVzOjWD6tYx0UGqouyzMr8
         K548bPAw7dlrNNzgbxvMHuJqCLQo0F7/DBooCsjMFGzbpfkU31LHK2O94JmEogdhfua6
         CWXb0DhuXJdt9uT1CjZOL4qYoI8ce2o5AT5o2CXvNSGyR6IgS43iFF4ybaSOBanPZP04
         C/c1OzQNctukvqs+WNYnhl+FzDmcMZOrUF+PdmsTw7aXKAZ53X71us0fYkv1WCxO8Oam
         qu3imeKdF21W4PA+gUA/CqcuRhjlaKdC5hj5wlhadoTGHsUBXhSDRzV+O3ebOd70Ru2j
         hTUw==
X-Gm-Message-State: AOUpUlFH9G65n4htDck8cau99mRwL0hO+in1hR63X4Gj0FuP54IuNtax
        3f3IoA3/7B5NHZyP86dlu6E=
X-Google-Smtp-Source: AAOMgpdlP4qG0TFSmcCJNO+k4HdO6Q9dY+NeGVz4FZ2Euf1p5KVX/VhLLo2ZBeP1mcQ0YxRiDkNW8g==
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr2591846wrq.272.1532632518133;
        Thu, 26 Jul 2018 12:15:18 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1505666wmh.9.2018.07.26.12.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:15:17 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C4DC41243DA; Thu, 26 Jul 2018 21:15:16 +0200 (CEST)
Date:   Thu, 26 Jul 2018 21:15:16 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Subject: Re: [PATCH v3 4/5] mm/page_alloc: Move initialization of node and
 zones to an own function
Message-ID: <20180726191516.GA10288@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-5-osalvador@techadventures.net>
 <20180726081200.GY28386@dhcp22.suse.cz>
 <CAGM2rebcp=S+WN3owDWVSa3_6QqLzs=qbOFs76rhsxuepQ1ALw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebcp=S+WN3owDWVSa3_6QqLzs=qbOFs76rhsxuepQ1ALw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:35:35AM -0400, Pavel Tatashin wrote:
> > OK, this looks definitely better. I will have to check that all the
> > required state is initialized properly. Considering the above
> > explanation I would simply fold the follow up patch into this one. It is
> > not so large it would get hard to review and you would make it clear why
> > the work is done.
> 
> I will review this work, once Oscar combines patches 4 & 5 as Michal suggested.

I will send a new version tomorrow with some fixups and patch4 and patch5 joined.

Thanks
-- 
Oscar Salvador
SUSE L3
