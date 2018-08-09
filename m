Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539221C69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A539221C69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeHIKOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:14:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35982 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:14:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so5401600wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzxT2uBGl044gO/2OlMmNiPotKOKBWgF7s3uztFhMzk=;
        b=tCroOfyYOYcDRUeBC0WPhkJELhaYtJKuDaZ8j6NZvjkfBX9nyZabDBwVBMe+PgSMNu
         vNV1M0/GnrjWD1x/+Ouo/IXFoZuNnTJbDsGrIuuwOAnGpt8neyKVb41ixM0J0eqO4t5o
         0m/I6suo8YTytWShYs2Kv5YiBhNSlvcf107Wc/bgUTl8V3SjH7Ul0dsvraYLorBah76B
         VkKDnpBQjMnov2DuFoWGNV4cBsJi2NDwiqGlidcL+FYoCbwZQH1UQdMtmS8NHSHT9Ekf
         BUGEL+ooCRUOuEdoD5XrTZ5TcWYzmQ1Kr7mhr/3zy/i+krU1FehG79RjyKOwoyWBgXRC
         /AGA==
X-Gm-Message-State: AOUpUlG6GPIwgDJGe2zCr5EDgt/4UW2dMBy/CoHLLExIIMYXFX8DEBWi
        5VoHH7SBe4aancyX80bxPfc=
X-Google-Smtp-Source: AA+uWPwJqAL5WcXeSda0a/O7LbS4p1dtul5jZGYaz8yXwpj9Nh4bLqNGYJtFk5Kvnlv6jZqDFtPSlw==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr902741wmf.104.1533801056920;
        Thu, 09 Aug 2018 00:50:56 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b2-v6sm6481226wmh.3.2018.08.09.00.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 00:50:56 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 8CBA61247B9; Thu,  9 Aug 2018 09:50:55 +0200 (CEST)
Date:   Thu, 9 Aug 2018 09:50:55 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180809075055.GA14802@techadventures.net>
References: <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
 <20180808075614.GB9568@techadventures.net>
 <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
 <20180808134233.GA10946@techadventures.net>
 <20180808175558.GD3429@redhat.com>
 <20180808212908.GB12363@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808212908.GB12363@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:29:08PM +0200, Oscar Salvador wrote:
> On Wed, Aug 08, 2018 at 01:55:59PM -0400, Jerome Glisse wrote:
> > Note that Dan did post patches that already go in that direction (unifying
> > code between devm and HMM). I think they are in Andrew queue, looks for
> > 
> > mm: Rework hmm to use devm_memremap_pages and other fixes
> 
> Thanks for pointing that out.
> I will take a look at that work.

Ok, I checked the patchset [1] and I think it is nice that those two (devm and HMM)
get unified.
I think it will make things easier when we have to change things for the memory-hotplug.
Actually, I think that after [2], all hot-adding memory will be handled in 
devm_memremap_pages.

What I do not see is why the patch did not make it to further RCs.

Thanks
-- 
Oscar Salvador
SUSE L3
