Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F51EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811020841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4811020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJJP22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:28:28 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36103 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:28:28 -0400
Received: by mail-wm1-f50.google.com with SMTP id a8-v6so4631722wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60RjsazI5P2OfbzBraBQxNizSHqCqnbN/t6PHSLvfLo=;
        b=Hl8K9VHZvBbjEI0SLAxh8JlJgLA7emPfeS8phLNFR+hWNCAYqrX/Yli9yyiOFIel92
         w7EOWXbMulUtV2NuvxqMElZHdnrEg7k9GFDfvbnrpjoEsI4A2vioaVWHos2ci5UNog4q
         t8h+0yAkxUk5ylWr5n+Z39pIT63InNM2KaA+Av+XFjP6QHL1e2kGVpdmnUvjrtToCUgk
         Q062GYW5dLiNtwB8w7uoXMDmr2c29m+Vqtg6Jc394JOvtuMu5m0ijn4LbNR4cb2AyfXA
         u20Hgn+a7CwXxLAfjGBViw6qYuVftALx+Xdh1rS/JJ1lrkRaWKpN6D5XHoWInMZuyKx2
         ypFQ==
X-Gm-Message-State: ABuFfogNe2v4i0Z3fEukMocoA7yRuphhxnmzSPiUXtljsiIHMHrAsDvx
        sham7wmdCv1xe0OzUB0CtPs=
X-Google-Smtp-Source: ACcGV63Rpj4T3aKBtdCiwGHXml+ZetJImBiKOQ2zkaI3LfIPYBZFJYO269nuhgZFgPnhqKydJotBBA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15-v6mr4805370wmc.101.1539158846765;
        Wed, 10 Oct 2018 01:07:26 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a205-v6sm12772165wmh.19.2018.10.10.01.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:07:25 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id F14EB12500C; Wed, 10 Oct 2018 10:07:24 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:07:24 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Arun KS <arunks@codeaurora.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-ID: <20181010080724.GA20338@techadventures.net>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:40:05PM +0530, Arun KS wrote:
> When free pages are done with higher order, time spend on
> coalescing pages by buddy allocator can be reduced. With
> section size of 256MB, hot add latency of a single section
> shows improvement from 50-60 ms to less than 1 ms, hence
> improving the hot add latency by 60%. Modify external
> providers of online callback to align with the change.

Hi Arun, out of curiosity:

could you please explain how exactly did you mesure the speed
improvement?

Thanks
-- 
Oscar Salvador
SUSE L3
