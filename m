Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67425208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67425208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeG0Q3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:29:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53979 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0Q3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:29:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so5580365wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MrfnR3HHj0+/mRLp8JDGO54M+fVN0tbddLyG5kskus=;
        b=qwnr1dhTQBEN9iflUsx6zQM3otoUSxsEEyV9r0YFM1WOUR/zv11l5/N1NWguN1ZYZ+
         evC28+nLegERdQXmx4G9AK24s+8ejnKsPfB7wQS892rxFLdOLuxBd7CJgBCxPiBkGQ+r
         sOc1n4qmaiTH/rBJyUv8M3DTMPlVn3XB/v5gAn2OakH0m+V6m5tyC4vbi3NebTKCsY3o
         bIxeGAFk0mYuhbp9vYnyj8Lxwdh0GhULgj0opRbRsvNAQLWzdxCAJ0jOPd2xdzGojV2y
         R5s2zM7b57+v3WNGnweigVzpjQaSnf135byXXufZLG5dDkszNDOCqZvemt0+zVxENLcA
         2r6A==
X-Gm-Message-State: AOUpUlGDRy/uLBgPtkLVhml0bgLH4DSy3pZAIlqVK/4DECLOMS0EYSyA
        BAdOX9pIsfx3pxx7C96jJDE=
X-Google-Smtp-Source: AAOMgpdRNUYBsvzcopuVu3x0YLB52Vt8l2MkbbqRmSfwlriFtEoTMw9GfV6gL+hj5ZYmUiqrivc3TQ==
X-Received: by 2002:a1c:a691:: with SMTP id p139-v6mr4512006wme.42.1532704052253;
        Fri, 27 Jul 2018 08:07:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id w8-v6sm6555877wrp.72.2018.07.27.08.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:07:31 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id DF7BE12440F; Fri, 27 Jul 2018 17:07:30 +0200 (CEST)
Date:   Fri, 27 Jul 2018 17:07:30 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/3] mm: calculate deferred pages after skipping
 mirrored memory
Message-ID: <20180727150730.GA14428@techadventures.net>
References: <20180726193509.3326-1-pasha.tatashin@oracle.com>
 <20180726193509.3326-3-pasha.tatashin@oracle.com>
 <20180727115645.GA13637@techadventures.net>
 <CAGM2reZnrwy1Y8MFRgyDLG8VZ6Hf+v-PAmZvUG4H65zunmjWZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZnrwy1Y8MFRgyDLG8VZ6Hf+v-PAmZvUG4H65zunmjWZw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:53:24AM -0400, Pavel Tatashin wrote:
>                          unsigned long *nr_initialised)
> > > +static bool __meminit
> > > +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> >
> > Hi Pavel,
> >
> > maybe I do not understand properly the __init/__meminit macros, but should not
> > "defer_init" be __init instead of __meminit?
> > I think that functions marked as __meminit are not freed up, right?
> 
> Not exactly. As I understand: __meminit is the same as __init when
> CONFIG_MEMORY_HOTPLUG=n. But, when memory hotplug is configured,
> __meminit is not freed, because code that adds memory is shared
> between boot and hotplug. In this case defer_init() is called only
> during boot, and could be __init, but it is called from
> memmap_init_zone() which is __meminit and thus section mismatch would
> happen.

Oh yes, I did not think about memmap_init_zone(), you are right.
Then, nothing to argue about ;-).

Thanks
-- 
Oscar Salvador
SUSE L3
