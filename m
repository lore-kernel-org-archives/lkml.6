Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7343BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE0205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE0205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeIAA7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:59:55 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37538 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIAA7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:59:55 -0400
Received: by mail-wr1-f50.google.com with SMTP id u12-v6so12311007wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SVi80wrbbngLcx6Bsj63I2xnjD8Ms9n+e/3Og5oNRk=;
        b=iSyiGWf+3PZWEBqodfvpyGlA+lWHT2j/r9Og3iUdRcT6sTYwAe+V7b77iKJ7mnvha+
         ahUKbPrQ6ge+4rrrAQJMideKxSAUqK0QWMgOQYhvYrdRH/ElzhlQLfSiNvrBUWJKYhTY
         DvL6ZZ7q2Zf/scXYhCA3EXUOdF3CYN+ryGHNAwNsgN23Z/RhTxrxSleCDmA9YcnRQz2G
         Ela6fywbXTC4zw9/ebzwJ2ArpdT/6lxxl1CtPzUTXPFH7PfObDYtUoesLd5pL1kHb21F
         uMboEGW90geu2KA0WgSmH1MVrQV7ucE22CHvBc/6lf4wwuKdJifQonIRMV4nSubaZMAt
         gHYA==
X-Gm-Message-State: APzg51B5jSZ1nrkoxWmgGQUGqWUe2NOViO3VbSkP5Xeh5XQG/9PrvmVY
        3bd/PCpY5m6t0GF5zpfBUstG/SP5KYyo6Q==
X-Google-Smtp-Source: ANB0VdaesVc9g/j44+IV0W5p0Dh33abxwEU33j9D0lZEcgpSAWtE0CyM9rTCr8Kb20C1iK/lf18ZjQ==
X-Received: by 2002:adf:e14f:: with SMTP id f15-v6mr11875988wri.42.1535748641700;
        Fri, 31 Aug 2018 13:50:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id z16-v6sm9053337wrq.78.2018.08.31.13.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:50:40 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 5EE4D124D4B; Fri, 31 Aug 2018 22:50:40 +0200 (CEST)
Date:   Fri, 31 Aug 2018 22:50:40 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC v2 2/2] mm/memory_hotplug: Shrink spanned pages when
 offlining memory
Message-ID: <20180831205040.GA3945@techadventures.net>
References: <20180817154127.28602-1-osalvador@techadventures.net>
 <20180817154127.28602-3-osalvador@techadventures.net>
 <348c662b-455a-1ea4-1db5-3bddcbdb4f14@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348c662b-455a-1ea4-1db5-3bddcbdb4f14@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:09:01PM +0000, Pasha Tatashin wrote:
> Hi Oscar,
> 
> I have been studying this patch, and do not see anything bad about it
> except that it begs to be split into smaller patches. I think you can
> send this work as a series without RFC if this patch is split into 3 or
> so patches. I will review that series.

Thanks Pavel for having taken a look at this.
I will split up the patch and re-send it without RFC.

Thanks!
-- 
Oscar Salvador
SUSE L3
