Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB00E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB00E20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeH1Pi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:38:29 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34560 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:38:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id m199-v6so1687103wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuhayUpodO8VCrMTBcg7KmMq/iMz0H3wOZSv/CeRR1I=;
        b=D6jOygXw3YuaaApfOMqBFLjRzwV8edA9K9qG1QgSiXKUQScZc85wudNf5Vu+2RfRi6
         QcS4xF/UgopzqYCKJeIiHPU2NWc0+IjUlvYaCNVdUjJA1XJYE+7xAMrQ6q1U4U23Wdfe
         p8VXQLjVszM0TsELCdC2FUGtdmpR7yYvSyCjt9Hq2BN6US5gcC9iDbpyn+b8b82TW++N
         AoBG5/07PTbHXjuoZ+3BVV+v7XYyoLcQFaB3o9wtAyxsiU1KpK9vxF89/oqPKLzOnIo8
         YtyQrhkxhh6URwKhMEJkWjuddu2rQExWbXgjKcZx0kw/5KtXgowjsCBiOLiNb6lY629Y
         qz+Q==
X-Gm-Message-State: APzg51BvDK34GRh+iQIt/dqAQnIBiluLWjowC19le77BCWYvBHQQW2ce
        MO0nftlFeedPDuA+fxPuwgE=
X-Google-Smtp-Source: ANB0VdZeGQtyFkzwOMfGErIDPR/jHnJx6XNhq50mZVF/r4MKDOeSY2zbT3iSlwPFsR4Vp8Idrqq4xA==
X-Received: by 2002:a1c:d946:: with SMTP id q67-v6mr1115073wmg.156.1535456831598;
        Tue, 28 Aug 2018 04:47:11 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u1-v6sm823876wrt.59.2018.08.28.04.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:47:10 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 02BD4124BC1; Tue, 28 Aug 2018 13:47:09 +0200 (CEST)
Date:   Tue, 28 Aug 2018 13:47:09 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        david@redhat.com, jonathan.cameron@huawei.com,
        Pavel.Tatashin@microsoft.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC v2 0/2] Do not touch pages in remove_memory path
Message-ID: <20180828114709.GA13859@techadventures.net>
References: <20180817154127.28602-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817154127.28602-1-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 05:41:25PM +0200, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
[...]
> 
> The main difficulty I faced here was in regard of HMM/devm, as it really handles
> the hot-add/remove memory particulary, and what is more important,
> also the resources.
> 
> I really scratched my head for ideas about how to handle this case, and
> after some fails I came up with the idea that we could check for the
> res->flags.
> 
> Memory resources that goes through the "official" memory-hotplug channels
> have the IORESOURCE_SYSTEM_RAM flag.
> This flag is made of (IORESOURCE_MEM|IORESOURCE_SYSRAM).
> 
> HMM/devm, on the other hand, request and release the resources
> through devm_request_mem_region/devm_release_mem_region, and 
> these resources do not contain the IORESOURCE_SYSRAM flag.
> 
> So what I ended up doing is to check for IORESOURCE_SYSRAM
> in release_mem_region_adjustable.
> If we see that a resource does not have such a flag, we know that
> we are dealing with a resource coming from HMM/devm, and so,
> we do not need to do anything as HMM/dev will take care of that part.
> 

Jerome/Dan, now that the merge window is closed, and before sending the RFCv3, could you please check
this and see if you see something that is flagrant wrong? (about devm/HMM)

If you prefer I can send v3 spliting up even more.
Maybe this will ease the review.

Thanks
-- 
Oscar Salvador
SUSE L3
