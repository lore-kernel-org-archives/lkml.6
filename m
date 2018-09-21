Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1224ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D09D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D09D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbeIUQSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:18:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36091 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389215AbeIUQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:18:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so12358080wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 03:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Okn+4k5hRHBx3TD6ErfmaJ0Y9e9n7x98Pj1Dvrx5AqU=;
        b=Io1oCFM6Eol8Hpa6Mj3m63JZyZSr2nYXbWW1jc2WwvL3cmssyT5T5DCAKQv6B/Zi8A
         eNKjfyN2kHSjOqdxtucYKroTyvpY4BVi3ce4YmGzeyYFXdH0siPi5VEk44m/8zXiyces
         6soJ5Na61iKF4SZBxFros9NclBYGuN0QV4wW06t1COcHNZSZe6xXEo01qPU89Iwpj9YZ
         g6798uYlZIJZDbOptBm2equZALq6eMCpES97121i/eRSXiM0vYwNKaGUfKAJ3GZ6BnPm
         2wYFXGOSqX9RzzduX6UF4c3hROw4pYs7uL7EEobkk2w3iSo2iQh40n5Vh9XGaSzCqwta
         /KLg==
X-Gm-Message-State: APzg51ARth+VjOYA//Gp4id31hHIzswPCcETHNWRVI8GY4PQSlo9BDHb
        I9hQ0G61RqtrhSCjA97klka/fNxl45g=
X-Google-Smtp-Source: ANB0VdbKFvhH3TDNw2TgmqGA+FSbJOaE+bqyPXQgH4futEGOzfzZQU5MRk+vxYiA3PfY7xAD+QFvig==
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr38834309wrr.155.1537525830833;
        Fri, 21 Sep 2018 03:30:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e141-v6sm9356369wmd.32.2018.09.21.03.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:30:30 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7BF50125424; Fri, 21 Sep 2018 12:30:29 +0200 (CEST)
Date:   Fri, 21 Sep 2018 12:30:29 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 4/5] mm/memory_hotplug: Simplify
 node_states_check_changes_online
Message-ID: <20180921103029.GA15555@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-5-osalvador@techadventures.net>
 <71676241-8aa5-2b58-b2fa-706bf21b9cfb@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71676241-8aa5-2b58-b2fa-706bf21b9cfb@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:15:53AM +0000, Pasha Tatashin wrote:

Hi Pavel,

> But what if that changes, will this function need to change as well?

That's true.

> Should not we have:
> 			else
> 				arg->status_change_nid_high = -1; ?
> 
> > +		} else
> > +			arg->status_change_nid_high = -1;

Yes, I forgot about that else.

> I think it is simpler to have something like this:
> 
>         int nid = zone_to_nid(zone);
> 
>         arg->status_change_nid_high = -1;
>         arg->status_change_nid = -1;
>         arg->status_change_nid = -1;
> 
>         if (!node_state(nid, N_MEMORY))
>                 arg->status_change_nid = nid; 
>         if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
>                 arg->status_change_nid_normal = nid; 
> #ifdef CONFIG_HIGHMEM
>         if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
>                 arg->status_change_nid_high = nid; 
> #endif

I can write it that way, I also like it more.

I will send it in V2.

Thanks for reviewing it!
-- 
Oscar Salvador
SUSE L3
