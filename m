Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31DB2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31DB2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeI0SvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:51:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeI0SvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:51:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so5726616wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4lOJ+jQdw/aWG0FNaahs6A9lQWldhauNd3wgwiV1ug=;
        b=YIi3F/XfTEK2maDHVW6EbZlYKIoeET6wjzP1ICqtkviQh7H3hcMUOQICh5g0dfKVA8
         Y0jwBJpW/AevHyNN8X0aorrNrrMXYlWfh8kRbiozmvcZD7eR5fB0Ra/X5PGMZ8sw4Cg2
         ZPSTJ5eOZ0fnTGYru9uRn01Vqy4Hf3zLk/TLWM82RGvkyA2vVQPMcoho2mX/9HYeivHh
         l9+7tN2RjLQ1DpfZJMWz70zfFo14YCxj+0o9cegLkMLxZkB3TDC1TKhJDcCda93NyeSz
         RCB1a9YsfqxbX2sNSIFnoLwcwADb0uYIjWBZQjoV8XvDPbtq3FIlxWWfcitjpZj3tQzn
         GXCg==
X-Gm-Message-State: ABuFfoidSQ7JK4vpxNlK9Fr1s6tdXwZFVB4M0bTRRFMBpz/0/a4QMLY2
        /qTLT34L8d6hUVL58lLh7CE=
X-Google-Smtp-Source: ACcGV600bcs5X1VmEMzHZkh8Z847Zc+wIHZtUZ/fhWRA1YvpJSH2C35SAC0WXOXPOL6/XWlkbwg2qA==
X-Received: by 2002:a1c:9295:: with SMTP id u143-v6mr1967680wmd.126.1538051575507;
        Thu, 27 Sep 2018 05:32:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a1-v6sm2082587wrt.9.2018.09.27.05.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 05:32:54 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2B78312561B; Thu, 27 Sep 2018 14:32:54 +0200 (CEST)
Date:   Thu, 27 Sep 2018 14:32:54 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        rppt@linux.vnet.ibm.com, dan.j.williams@intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20180927123254.GB20378@techadventures.net>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:25:37AM -0700, Alexander Duyck wrote:
> With that said I am open to suggestions if you still feel like I need to
> follow this up with some additional work. I just want to avoid introducing
> any regressions in regards to functionality or performance.

Hi Alexander,

the problem I see is that devm/hmm is using some of the memory-hotplug 
features, but their paths are becoming more and more diverged with changes
like this, and that is sometimes a problem when we need to change
something in the generic memory-hotplug code.

E.g: I am trying to fix two issues in the memory-hotplug where we can
access steal pages if we hot-remove memory before online it.
That was not so difficult to fix, but I really struggled with the exceptions
that HMM/devm represent in this regard, for instance, regarding the resources.

The RFCv2 can be found here [1] https://patchwork.kernel.org/patch/10569083/
And the initial discussion with Jerome Glisse can be found here [2].

So it would be great to stick to the memory-hotplug path as much as possible,
otherwise when a problem arises, we need to think how we can workaround
HMM/devm.

[1] https://patchwork.kernel.org/patch/10569083/
[2] https://patchwork.kernel.org/patch/10558725/

-- 
Oscar Salvador
SUSE L3
