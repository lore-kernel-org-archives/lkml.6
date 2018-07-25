Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11479C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91F20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA91F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeGYNAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:00:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38552 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeGYNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:00:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5678728wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 04:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5L93+pQgfYZ+C/LkhZnPcSvpUl/eQ9wn+UtyslWdvY8=;
        b=REITq3P7oblKiWkLAHhuTiR0eh+HN2vAcdmZs2sEKBvOtmWLFuWaXyRF4//N+rwg2P
         7IIcsC6ssFEEPwAgOel1A6bsHbXfWTIPs0WXRXSRT5Xd8uapD+84Mk2H+A41fpsGeYJn
         lLMBDlgV5pFVFKU9us8HiF8Xf7WkuhcXVzyhBuZnIyBFW64AcOi0R9ECfb24JYkJVtme
         GZJkC7ysIjBPIKPTgbkrDBoYVYcshP2qr6B7SLJuDhMrJ+IOUfA+QevcK2WYBYH8Yhal
         ApTrTxHnKKjUmnEZd9hr4dMSE44L99k/oRdLtljih++6jpoNMu1Srt/EGMXV0AkucAKx
         QVHA==
X-Gm-Message-State: AOUpUlEP8doDmAQzciL2HIJ/h1vLh1dapyw0vRA+ENJLxArdmR+vD8WT
        EwUA7w0230YrN4beJMzJCuA=
X-Google-Smtp-Source: AAOMgpcwb/NPoMhpP1fUNnLHwqL3q8I6b4lxWKjhvuBguXzIh9nI71tx4cCCZHMo3CiaSLShdPR8DA==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr4292752wmx.38.1532519328759;
        Wed, 25 Jul 2018 04:48:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 185-v6sm5214089wmh.22.2018.07.25.04.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 04:48:48 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6F0AA124329; Wed, 25 Jul 2018 13:48:47 +0200 (CEST)
Date:   Wed, 25 Jul 2018 13:48:47 +0200
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
Subject: Re: [PATCH 3/3] mm: move mirrored memory specific code outside of
 memmap_init_zone
Message-ID: <20180725114847.GA16691@techadventures.net>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-4-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724235520.10200-4-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:55:20PM -0400, Pavel Tatashin wrote:
> memmap_init_zone, is getting complex, because it is called from different
> contexts: hotplug, and during boot, and also because it must handle some
> architecture quirks. One of them is mirroed memory.
> 
> Move the code that decides whether to skip mirrored memory outside of
> memmap_init_zone, into a separate function.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Hi Pavel,

this looks good to me.
Over the past days I thought if it would make sense to have two
memmap_init_zone functions, one for hotplug and another one for early init,
so we could get rid of the altmap stuff in the early init, and also the 
MEMMAP_EARLY/HOTPLUG context thing could be gone.

But I think that they would just share too much of the code, so I do not think
it is worth.

I am working to do that for free_area_init_core, let us see what I come up with.

Anyway, this looks nicer, so thanks for that.
I also gave it a try, and early init and memhotplug code seems to work fine.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
