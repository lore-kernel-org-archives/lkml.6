Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3821B21AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3821B21AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeHHXum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:50:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37118 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbeHHXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:50:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so4215180wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bTngNLrRBdKeTCbueq811VrJPw7R1sVkBpJWR8WXYhQ=;
        b=N7+u4qXB+LpXkI9SKxG2OAeqkEa27UUwTASSO6+0wQQ++TlqT58wIABte1WL08T9yK
         /3tP3CA7MNkllT4hRpIOe5gm4qhzGQcMic6y1p6dozJMBzukF2IRwC1ns/UTv1rxWkJi
         Yqy+vVIXZOEhPyUX10j79ge1T9nS3UWJUB8dpHw2jTVGIyElmv6y6xFPhOYzRAPwRe7/
         eOXPn4SRaB8af9Qmw+yBXz9VpYFHIWAcUnpAVAXw1LE0NZNYnjl+kF8QVkCi5CsTMxNk
         FNZZDRKpLZGFz/NsjS2uZ84PokaOlOVkTj7EDgGPcxT4QZ139QzKrSUuF7owEiGCWDZL
         ufXg==
X-Gm-Message-State: AOUpUlFLuTFFvS8YK68yb7hI8AL/scJgnf6M5zmb8z2nX0pvjA6VJ4ZG
        vEkTWdBYjYdEOzrGQ7axzjc=
X-Google-Smtp-Source: AA+uWPw2hhEWKpKmd4p5gHJPdtC1lqlEyDhM07QdtsFef1WVtBgoDFLo7Ykrxc+8+nEpgtnuet+HKg==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr2750812wmz.95.1533763750179;
        Wed, 08 Aug 2018 14:29:10 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 66-v6sm11158629wmw.34.2018.08.08.14.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:29:09 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id F2EB31247A9; Wed,  8 Aug 2018 23:29:08 +0200 (CEST)
Date:   Wed, 8 Aug 2018 23:29:08 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808212908.GB12363@techadventures.net>
References: <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
 <20180808075614.GB9568@techadventures.net>
 <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
 <20180808134233.GA10946@techadventures.net>
 <20180808175558.GD3429@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808175558.GD3429@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:55:59PM -0400, Jerome Glisse wrote:
> Note that Dan did post patches that already go in that direction (unifying
> code between devm and HMM). I think they are in Andrew queue, looks for
> 
> mm: Rework hmm to use devm_memremap_pages and other fixes

Thanks for pointing that out.
I will take a look at that work.

-- 
Oscar Salvador
SUSE L3
