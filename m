Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFDD2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFDD2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeI1PHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:07:18 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36298 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbeI1PHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:07:18 -0400
Received: by mail-wm1-f47.google.com with SMTP id n23-v6so1339038wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgPTyuL/K6XQ+9Dn2zgnf3qSRYQrFEhVoTHJ5knCE5c=;
        b=UWi3UeTlBxGvcbUheaDbB/SWsea0zC+bx+/5gnfuL2PG3x42vwTB36Z3T+D5/Z4PIe
         eE/Y0gou2tQK05l6jc1wHEq7pYYXI2I8AG+gYAwOrmdK4xDo/u95cxYBzngtq/+RdpvA
         WA97gKwnUaiiVklxoQ20HagLP5guTKxqukuep8OjrjX32g2iXifpjrVKqezOw6dhGLKb
         5bX0IGmIELAMZ/A+Y6bmJs3uO0+Xk4ysPbW7RxuMpLyuE6sCXYwkXtUZHqwUQfK+HIUq
         kcUHWkSGnboJufoIXuPntUl0aAoUsR8HUvMYULH8nKMzNxOlzTXv2Sk8CjK03x0NIu58
         rLqQ==
X-Gm-Message-State: ABuFfohz1lHk0+o1fXWYLPNwQfAvr2icUtOUGNS0Vv1t4ZG4uxfoABL3
        rHTJO8HEvqfjCW8c0yoMno0=
X-Google-Smtp-Source: ACcGV61XY8pAM4OmMRrb63VV0/wwRvA4w12RO5m7V3N5VC2s8tS//asXK3JMfo2rm/CgzlmDzj1ZSg==
X-Received: by 2002:a1c:8e81:: with SMTP id q123-v6mr1021796wmd.56.1538124274833;
        Fri, 28 Sep 2018 01:44:34 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h73-v6sm3988454wma.11.2018.09.28.01.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 01:44:33 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 3C735125660; Fri, 28 Sep 2018 10:44:33 +0200 (CEST)
Date:   Fri, 28 Sep 2018 10:44:33 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        dave.hansen@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20180928084433.GB25561@techadventures.net>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
 <20180927110926.GE6278@dhcp22.suse.cz>
 <20180927122537.GA20378@techadventures.net>
 <20180927131329.GI6278@dhcp22.suse.cz>
 <20180928081224.GA25561@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928081224.GA25561@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:12:24AM +0200, Oscar Salvador wrote:
> Although I am not sure about leaving memmap_init_zone unprotected.
> For the normal memory, that is not a problem since the memblock's lock
> protects us from touching the same pages at the same time in online/offline_pages,
> but for HMM/devm the story is different.
> 
> I am totally unaware of HMM/devm, so I am not sure if its protected somehow.
> e.g: what happens if devm_memremap_pages and devm_memremap_pages_release are running
> at the same time for the same memory-range (with the assumption that the hotplug-lock
> does not protect move_pfn_range_to_zone anymore).

I guess that this could not happen since the device is not linked to devm_memremap_pages_release
until the end with:

devm_add_action(dev, devm_memremap_pages_release, pgmap)
-- 
Oscar Salvador
SUSE L3
