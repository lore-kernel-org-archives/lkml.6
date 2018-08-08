Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C92172D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7C92172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeHHKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:19:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54238 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeHHKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:19:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so1706500wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGEeHhdKYPtULeKuyC8w6Zzmhz8Vu5OQoELCkXhfE18=;
        b=A1cEWz50YHv6RaoeGCjefK6ycnwPRRVx29CoRezdPVVuxCH672MC7Bsy0Re7CJJc5a
         ZrxtYlKfxsZuvaQOq19EQDfgMBaMJmH/UGcGdfvEbt4cHT42xRoQVTFKMS4csIAYkmkj
         TfwcToRddwKNmigdNZ3LgIHi5J7feT2RnZdeCIAT4oS8c0cnixdHrSw2F5qFHUDqZdVZ
         db4+apS8rlbHdUstbNiYhVqwrYbdIxTFfNm1tkeaYB0RJBkpYeScZSBuxJsPfo2tgJjs
         q5Yvz5EOFZqMTJlYHULFg9ynXTjhHQT6CUfNQy3a/gau+HqLL/38tow7fp55hzSXFdKz
         lAVg==
X-Gm-Message-State: AOUpUlGU8D9APC4FuwuXHRYUccwq7TnhGAcyY2PDF+7QuI7I9F7TyTc+
        c0YH1QBuzelmyprnn7TazSAvlaMzR8w=
X-Google-Smtp-Source: AA+uWPzNMRitGpRHDze7UHeHZiolZZO8sL2llfAradKQBdlKWUop8zhzQn1ddZsr2roJv2xpj/qLXQ==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr1050027wme.13.1533715251225;
        Wed, 08 Aug 2018 01:00:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t6-v6sm5354203wmf.8.2018.08.08.01.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:00:50 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id F2DF112476F; Wed,  8 Aug 2018 10:00:49 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:00:49 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808080049.GC9568@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <24da07b9-5e06-af1d-42d3-c663eade16ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24da07b9-5e06-af1d-42d3-c663eade16ea@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:51:50AM +0200, David Hildenbrand wrote:
> > I am pretty sure this is a dumb question, but why HMM/devm path
> > do not call online_pages/offline_pages?
> 
> I think mainly because onlining/offlining (wild guesses)
> 
> - calls memory notifiers
> - works with memory blocks
> 
> (and does some more things not applicable to ZONE_DEVICE memory)

Yes, you are right.
They call arch_add_memory while want_memblock being false and so they do not
get to call hotplug_memory_register which handles all the memory block stuff.

Thanks
-- 
Oscar Salvador
SUSE L3
