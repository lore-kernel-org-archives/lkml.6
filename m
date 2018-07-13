Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6299AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2016208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2016208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeGMNca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:32:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39612 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeGMNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:32:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so9315614wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MNRDAwDRxgSfPkEgH4AWAf1c3IjsGhwaG/XrdayoDw=;
        b=ar/Vnz+8YlUUGZjbdQcdWFDo7BcroQf2DfCf5UdOGm10OwovZeS0BUvHHmem0xPTzt
         /hrnIxZIEq5P2lq1XMfQBxloMiaKsjLpWfnThijeqrwhfQSqPrTFqQkXJGMf3nHymvPY
         SyiJ8mdlLCrfP2cygrDvld1Uo46yGKcgWyrOiqRAaJfLUdMM2PmiCCzenETq4ysjhKz6
         eBM2+f84KMIC0IbZQraKS8VYDEXCiOjULGKPgtaLShAG7ohPlcf/Py57O1MMRG8iix7t
         k43fGXsETInM4T3Wnk+0YKmzM8uG2jkV204hFEJuvJy3KjrTWO0QShUHnpQwndD9bph6
         vYiw==
X-Gm-Message-State: AOUpUlFkAIHR2mFw7GaMTa87SrBcaXMoYm8ZOsGF2pFHbkn2w/fAN9lq
        26k8mub2M6HOCi7yTxUpUYk=
X-Google-Smtp-Source: AAOMgpdT9bLMdfIhLT6DH8EEqwhmV1Y/RjCvZ84b20yQmX2mo9CCJ0/j3nLs+yA/WburMfR0l2oNJA==
X-Received: by 2002:a1c:9754:: with SMTP id z81-v6mr4107337wmd.35.1531487870477;
        Fri, 13 Jul 2018 06:17:50 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 35-v6sm19996147wri.78.2018.07.13.06.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 06:17:49 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2DCCF123ECC; Fri, 13 Jul 2018 15:17:49 +0200 (CEST)
Date:   Fri, 13 Jul 2018 15:17:49 +0200
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
Subject: Re: [PATCH v5 1/5] mm/sparse: abstract sparse buffer allocations
Message-ID: <20180713131749.GA16765@techadventures.net>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712203730.8703-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:37:26PM -0400, Pavel Tatashin wrote:
> +static void *sparsemap_buf __meminitdata;
> +static void *sparsemap_buf_end __meminitdata;
> +
> +void __init sparse_buffer_init(unsigned long size, int nid)
> +{
> +	BUG_ON(sparsemap_buf);

Why do we need a BUG_ON() here?
Looking at the code I cannot really see how we can end up with sparsemap_buf being NULL.
Is it just for over-protection?

> +	sparsemap_buf =
> +		memblock_virt_alloc_try_nid_raw(size, PAGE_SIZE,
> +						__pa(MAX_DMA_ADDRESS),
> +						BOOTMEM_ALLOC_ACCESSIBLE, nid);

In your previous version, you didn't pass a required alignment when setting up sparsemap_buf.
size is already PMD_SIZE aligned, do we need to align it also to PAGE_SIZE?

Thanks
-- 
Oscar Salvador
SUSE L3
