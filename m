Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79001C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F72151B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358F72151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeHHXtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:49:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39126 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeHHXtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:49:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so4234668wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXCISUP6PKXV1EZJmjf20iUtnzXRqExB9ggD2nevNhA=;
        b=ufN+BnuHg5C0r6udTtb8MJJ0RfWD76la7TflG4cHgJ31ORmUusQHPG32aEFPWrplgf
         kzKCqj757UeG6CEVl540uiKAF3IiA2YbR+lK0S7F/NEbqmf17K4w9Bfp+tEhpBC9TrsI
         ecyXpoWtfdIVb45OT2hbGVdaCETXqpGg4wa2PUWIi+i5D8x2LIQzYicPnlJw7ZL5j13D
         Bj5dXZ88FKUZD21FjTxyuxuQNGSu96lkSUWv+yZs7QDUiSvPd3+H+KHk3dF30tzaV+Fp
         KSMP0QJRcQdVQuwGAJIBVSVzc2t+BRty03m6qSOKiZMJgDg53HMMb9VYSWmwXv2jVZsq
         Susw==
X-Gm-Message-State: AOUpUlH6FYeToEk8CemZoNA1x6TmV8U6nHPJVvI3fCPsfuzemQqOUSPL
        hYoWl44zJPpSY+9GJxwPgI0=
X-Google-Smtp-Source: AA+uWPwWQSpl1npXFf9kqR9Ry9QHFS8EK9JMAM2D1QBvJBx9kfTy2105QeWLNbllQIv/XEc1aeXUMA==
X-Received: by 2002:a1c:7ed8:: with SMTP id z207-v6mr2920954wmc.139.1533763697212;
        Wed, 08 Aug 2018 14:28:17 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o16-v6sm3420684wmf.10.2018.08.08.14.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:28:16 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C9A5D1247A7; Wed,  8 Aug 2018 23:28:15 +0200 (CEST)
Date:   Wed, 8 Aug 2018 23:28:15 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808212815.GA12363@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
 <20180808165814.GB3429@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808165814.GB3429@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:58:15PM -0400, Jerome Glisse wrote:
> > If the former then I do not see any reason why we couldn't simply
> > refactor the code to expect a failure and drop the warning in that path.
> 
> Referring to newer case ie calling release_mem_region_adjustable() for
> ZONE_DEVICE too. It seems i got my recollection wrong in the sense that
> the resource is properly register as MEM but still we do not want to
> release it because the device driver might still be using the resource
> without struct page. The lifetime of the resource as memory with struct
> page and the lifetime of the resource as something use by the device
> driver are not tie together. The latter can outlive the former.
> 
> So when we hotremove ZONE_DEVICE we do not want to release the resource
> yet just to be on safe side and avoid some other driver/kernel component
> to decide to use that resource.

I checked the function that hot-removes the memory in HMM code.
hmm_devmem_pages_remove(), which gets called via hmm_devmem_remove(), is in charge
of hot-removing the memory.

Then, hmm_devmem_remove() will release the resource only if the resource is not of
type IORES_DESC_DEVICE_PUBLIC_MEMORY.

So I guess that there are cases(at least in HMM) where we release the resource when
hot-removing memory, but not always.

Looking at devm code, I could not see any place where we release the resource
when hot-removing memory.

So, if we are really left with such scenario, maybe the easiest way is to pass a parameter
from those paths to arch_remove_memory()->__remove_pages() to know
if we get called from device_functions, and so skip the call to release_mem_region_adjustable.

Thanks
-- 
Oscar Salvador
SUSE L3
