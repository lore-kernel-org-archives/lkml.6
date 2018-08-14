Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C154FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756802175C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756802175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeHNMl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:41:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36937 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:41:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so11557809wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1926iGuqOKQq+bnw3sAvdtW2YsBi0Y8zwXs27qU4nE=;
        b=bGT+hU83kia4wU9wUV0Qca7fq2Yyk7RgKjyL2XBnAzk6ukKg+ABnTDncBKCqZWicPx
         in1iDUF6CChzO8yn28vUpYqlUVKZK7mDzcS4sQZDk5zAqLQxUhkzPPBgP5S5dtKax5Mo
         5TQvFpTsiSNnBGldlFEDE8/Iwmwfsk8PQOYeG3MMW4mPViaizG9yTFVYlPsWoppJZtd+
         kVBl7EGUYWm6ijSRjisOkWpyQblY6HlXrE21TuGQK/Wn30GuOr/lyxm9dw47WmvL4OJj
         X8gObYxHiJ++WE5+fXXzwW7T+ZQ/+su6epquQ4rpjCzS7KkKqRm5ARcds7pi5iE7kHFX
         pjjQ==
X-Gm-Message-State: AOUpUlFh1nqwPZwUPM9nxvwfjDVXb8BIeMt/o6sk5iPqlNbCMo9Cf1tA
        u3DctzYv+cW4YOfGVKbz+4o=
X-Google-Smtp-Source: AA+uWPzRCmkSHF6vWNqjSvsHBcEsLahCd9fyRUAGal4M01ZbcKdsbn4QXZk+4obWS8DzhsG7UfCbXg==
X-Received: by 2002:a1c:e304:: with SMTP id a4-v6mr10605900wmh.0.1534240501708;
        Tue, 14 Aug 2018 02:55:01 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id w8-v6sm17219747wrp.72.2018.08.14.02.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:55:01 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 71B7D124876; Tue, 14 Aug 2018 11:55:00 +0200 (CEST)
Date:   Tue, 14 Aug 2018 11:55:00 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, jglisse@redhat.com, rafael@kernel.org,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/3] mm/memory_hotplug: Refactor
 unregister_mem_sect_under_nodes
Message-ID: <20180814095500.GA6979@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
 <20180813154639.19454-4-osalvador@techadventures.net>
 <24b69c72-0ebd-476d-1c47-9c64c24b831f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b69c72-0ebd-476d-1c47-9c64c24b831f@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:39:34AM +0200, David Hildenbrand wrote:
> On 13.08.2018 17:46, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > While at it, we can also drop the node_online() check, as a node can only be
> > offline if all the memory/cpus associated with it have been removed.
> 
> I would prefer splitting this change out into a separate patch.

Yes, I guess it is better as it is not really related to the changes in this patch.
I will wait for more feedback and I will split it up in v3.

> > +
> > +	if (unlinked_nodes)
> > +		NODEMASK_FREE(unlinked_nodes);
> 
> NODEMASK_FEEE/kfree can deal with NULL pointers.

Good point, I missed that.
I will fix it up in v3.

Thanks for reviewing.
-- 
Oscar Salvador
SUSE L3
