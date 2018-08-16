Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0CA20936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0CA20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbeHPNpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:45:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54945 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeHPNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:45:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so4002219wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 03:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwegCybYnkdi9HYS2tjbDA27vUmWOCD2wUJPhX45qUs=;
        b=E2JtJ6m8g/8o65Dd5AldNmPEPm7LtzJqpYLuLRMP8sXgBuCvnlMOo+Fqy4nPhmZ6ct
         B4TaMrznAGAtGPg4EhVOaEusbcWV7h41ZRZD5I6WDtIcq///8ZNnksfa2Tnbs5EJcQDW
         eatoHB4BJtuulyZCugWTCMmIENsTG77rf7xl8woBCP3oOza1PpfQ7LynwJtICSXACOpY
         3rEch6D9ek+HDi9ZFFyAGUnVxyB7mIwc6pylqm8VWjOibDyuZrAbdVp6lRjvU04Wlv+k
         FTZ9p4ElxvV8V9McZyScmPw8N3IQvL+d4mAmaQ3VjHSezJ8nGKt57Gf88a2hfRu7I1br
         6l2Q==
X-Gm-Message-State: AOUpUlFrvTrLu0vWw/VN6VWgvkvppR9Nqn+zZdwVIfcPhcwyGjFyq3Ld
        GQTwFJFy74HMi0LchV1GJ+8=
X-Google-Smtp-Source: AA+uWPxUbvP5C4ssWeYOiJXV/veJdbOY4B6jHjiWMdxYvWMjwvi8nps4nyJYvOZTEk+uYTwrvdpq0A==
X-Received: by 2002:a1c:a813:: with SMTP id r19-v6mr15128646wme.100.1534416458300;
        Thu, 16 Aug 2018 03:47:38 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r18-v6sm533227wmh.28.2018.08.16.03.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 03:47:37 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6C80A1248DC; Thu, 16 Aug 2018 12:47:36 +0200 (CEST)
Date:   Thu, 16 Aug 2018 12:47:36 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: check if sections are already
 online/offline
Message-ID: <20180816104736.GA16861@techadventures.net>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816100628.26428-4-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:06:26PM +0200, David Hildenbrand wrote:

> +
> +/* check if all mem sections are offline */
> +bool mem_sections_offline(unsigned long pfn, unsigned long end_pfn)
> +{
> +	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
> +
> +		if (WARN_ON(!valid_section_nr(section_nr)))
> +			continue;
> +		if (online_section_nr(section_nr))
> +			return false;
> +	}
> +	return true;
> +}

AFAICS pages_correctly_probed will catch this first.
pages_correctly_probed checks for the section to be:

- present
- valid
- !online

Maybe it makes sense to rename it, and write another pages_correctly_probed routine
for the offline case.

So all checks would stay in memory_block_action level, and we would not need
the mem_sections_offline/online stuff.

Thanks
-- 
Oscar Salvador
SUSE L3
