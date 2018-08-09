Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC521C69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFC521C69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeHIKPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:15:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42355 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeHIKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:15:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so4261308wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nqZ9uKhe5dKOemdoTPenoxHA0niXDfY8q89LJqfZIA=;
        b=avLe3oY5ZKwShKT3L33jQ9liSa4ExUUA9x6Q04cRl6gHmqnezHhzZW7t0RdkX+eAXE
         jZQ3d6Sn+DbrOiRyvEyYjixpkwWI5kkFB+J3o8nG42hPCv18KW616KS/PlnmWVFFWJe2
         choBBHvW+9nPjQgMktsO/DGJcj86KbyvnkNJGXSjjKujh+bjmiEQ7mXAS/1+Tvw0n5M4
         xrcfBeRunuZvIwF066RCbFg3MC5Omhr2nZE8JJLhYg6nD0UHt37Jj3oV2uoDgsmVFsxd
         RFX0MKiKD45dSr1IETDR3QQRCpvOAVYGIvqoUdD/PVV0xS0kMzbvLMmrnqRL9uN6aeuq
         tqIA==
X-Gm-Message-State: AOUpUlGh1agyYwWxTwU4V7BWfooLR+pe3s8hvblJQi9mrDDwb1QQ9X4h
        c5JZo+chw2SojRc6S7IL52Q=
X-Google-Smtp-Source: AA+uWPxYByzgDON618GnhXX2BDoyTRgrVM9zjErHMAl7lbd7frXVIz2ijXZGlBr73udtxOGXWMiUMw==
X-Received: by 2002:a5d:5385:: with SMTP id d5-v6mr643947wrv.151.1533801126542;
        Thu, 09 Aug 2018 00:52:06 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a12-v6sm6368940wru.61.2018.08.09.00.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 00:52:05 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 4B4A21247BB; Thu,  9 Aug 2018 09:52:05 +0200 (CEST)
Date:   Thu, 9 Aug 2018 09:52:05 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180809075205.GB14802@techadventures.net>
References: <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
 <20180808075614.GB9568@techadventures.net>
 <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
 <20180808134233.GA10946@techadventures.net>
 <20180808175558.GD3429@redhat.com>
 <20180808212908.GB12363@techadventures.net>
 <20180809075055.GA14802@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809075055.GA14802@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:50:55AM +0200, Oscar Salvador wrote:
> On Wed, Aug 08, 2018 at 11:29:08PM +0200, Oscar Salvador wrote:
> > On Wed, Aug 08, 2018 at 01:55:59PM -0400, Jerome Glisse wrote:
> > > Note that Dan did post patches that already go in that direction (unifying
> > > code between devm and HMM). I think they are in Andrew queue, looks for
> > > 
> > > mm: Rework hmm to use devm_memremap_pages and other fixes
> > 
> > Thanks for pointing that out.
> > I will take a look at that work.
> 
> Ok, I checked the patchset [1] and I think it is nice that those two (devm and HMM)
> get unified.
> I think it will make things easier when we have to change things for the memory-hotplug.
> Actually, I think that after [2], all hot-adding memory will be handled in 
> devm_memremap_pages.

Forgot to include the links:

[1] https://lkml.org/lkml/2018/6/19/108
[2] https://lkml.org/lkml/2018/6/19/110

-- 
Oscar Salvador
SUSE L3
