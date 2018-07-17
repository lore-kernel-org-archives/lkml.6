Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999BB20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999BB20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGQMR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:17:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbeGQMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:17:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so925083wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtdSOb4GZ4U9el9BOSRyCzTTYhimPCCIaDmsHYe5Fek=;
        b=LnHxgBOiA4qnjOOllAkQP9lH+SLlzey441mOvZBuVAY22vUgII3KapMF1Ts7r8tKKm
         MUYOW5MC3kIy1kCCzIjwMZB+7ZslntEjz9lZdO+gkgHSFRA24eEWvHRGO/B0zyXRlNO5
         PYsS7fiywpSYhJ0HNplX/ZE8S2//EQQ+MuJ8yOVEf1jjZ/FMPUYoot1R/lIU35i2na2h
         a5NIVTnpgK31tFH/vka9s83Voc/yXr0h1396jw3S8aMAGzjnSGtY/8LRm6itrbyCe4q6
         Vm4RSPxYEIgYB2dFqVjBSA4pc6JO2sCc+MucMb3ZBoPscwCx+tDnI8ykVB/xNCrCt6mM
         FQew==
X-Gm-Message-State: AOUpUlEb8/qxS/RLxXs99IEZ0lEm028+RLhx82x3OCNfPA7ibxlH+mHz
        BbjLMMoO1ymmISrd2KAa1Kk=
X-Google-Smtp-Source: AAOMgpcnt19ww76GHsitKvBwv6wIJwCA14uJsEUUj4XjHnWz/igBbK3MSOA8iCnbbuWiDmv00/Wtkg==
X-Received: by 2002:adf:b786:: with SMTP id s6-v6mr1094306wre.247.1531827912306;
        Tue, 17 Jul 2018 04:45:12 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h2-v6sm993161wmf.28.2018.07.17.04.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:45:11 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2D26712401A; Tue, 17 Jul 2018 13:45:11 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:45:11 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v6 1/5] mm/sparse: abstract sparse buffer allocations
Message-ID: <20180717114511.GB24361@techadventures.net>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
 <20180716174447.14529-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716174447.14529-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:44:43PM -0400, Pavel Tatashin wrote:
> When struct pages are allocated for sparse-vmemmap VA layout, we first try
> to allocate one large buffer, and than if that fails allocate struct pages
> for each section as we go.
> 
> The code that allocates buffer is uses global variables and is spread
> across several call sites.
> 
> Cleanup the code by introducing three functions to handle the global
> buffer:
> 
> sparse_buffer_init()	initialize the buffer
> sparse_buffer_fini()	free the remaining part of the buffer
> sparse_buffer_alloc()	alloc from the buffer, and if buffer is empty
> return NULL
> 
> Define these functions in sparse.c instead of sparse-vmemmap.c because
> later we will use them for non-vmemmap sparse allocations as well.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

I did not see anything wrong, so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
