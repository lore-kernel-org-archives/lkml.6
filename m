Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3C3206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="l/Qy7bnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3C3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632756AbeKXCnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:43:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436676AbeKXCnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:43:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so4530170pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i2gvPd8u3BbT9/uNDz+jNE/GrFVm3gpOMSQ/FV8d6jE=;
        b=l/Qy7bnUNaAiCIKiEPV9DoTw3qBRK96a0RmgrDnXN+s8KxPPOr0JLkeWvlFXmTwxKN
         YLIz8g/TJy2/nlIN5buLSm7s9Xknp+2u4Dc7JFM74uPN6fm/4OwfRgh7wSbC1nAgteac
         kUAQg0a6XZmb3XQEiXW8fDOgA9bnfp2dRbDfa1AIg9GyFoyNsYb8xHIKrGSDBTatc5qu
         cbIkQ/ZDNq+2ykPaw+n7tkNMwAFzIwiLVh8zxAmwAcuTtQVKH6qU6eTj6/lnToaX8S4D
         PPbRUQhRpDTKKf4prQQf+e4sGDNgXUlOVrDU46Yi3If052P6Dd9iNNppASltWqZbtTKm
         ZwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2gvPd8u3BbT9/uNDz+jNE/GrFVm3gpOMSQ/FV8d6jE=;
        b=mGpgbByG40uKMZ0NHK6noOdjdFYxPu4/zWHVVomjuz8SDBjiJoewey1OlNQjjqSI+y
         INY4M2+mwlnIrJ93945JcLzYcv/k8yEr5lw67uy6yJcIcNLPrYe9CsB46EUpA6swbW78
         7IMKgfOesUviwDdOI2GjlA7cVpbjCVrZkJWqwniYkanWnEKZ1JF+wvp18sOo2tg16ffj
         0Go+7pg3seIsoUWLFBB/2ZfVf04pkvXBPQz8/FuSN5CVVqgZOMT5CcGcPY6hOvIujD/n
         l7jiPTNatj+LncyjF/Qla3Dn2AA7C1icrYTcnsWBp/e7noW1oMHR9SrSAGTiKIdqTxzs
         uwzg==
X-Gm-Message-State: AA+aEWYDDLOj7vgEkzyjL1OIKaP771Xb0kVVmHZwGF171F28uyeCE/I/
        6vZATBGNd38O2WoOFKGtvENTSw==
X-Google-Smtp-Source: AFSGD/VZP//lIWNvC9q7s7UlH2iz0Vn8rqCfnPWUwdyrypZmgxINSoZv2t5dK8HRmbM6jB0jt1tL/A==
X-Received: by 2002:a17:902:4623:: with SMTP id o32-v6mr16125373pld.187.1542988716123;
        Fri, 23 Nov 2018 07:58:36 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id x123-v6sm73221175pfb.124.2018.11.23.07.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 07:58:35 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4BC9430033D; Fri, 23 Nov 2018 18:58:31 +0300 (+03)
Date:   Fri, 23 Nov 2018 18:58:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181123155831.ewkrq4r27rne75mz@kshutemo-mobl1>
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com>
 <20181026122856.66224-2-kirill.shutemov@linux.intel.com>
 <20181110122905.GA2653@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110122905.GA2653@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 08:29:05PM +0800, Baoquan He wrote:
> > diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
> > index 702898633b00..75bff98928a8 100644
> > --- a/Documentation/x86/x86_64/mm.txt
> > +++ b/Documentation/x86/x86_64/mm.txt
> > @@ -34,23 +34,24 @@ __________________|____________|__________________|_________|___________________
> >  ____________________________________________________________|___________________________________________________________
> >                    |            |                  |         |
> >   ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> > - ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> > - ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> > + ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI
> > + ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> > + ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole
> 
> Hi Kirill,
> 
> Thanks for this fix. One small concern is whether we can put LDT
> remap in other place, e.g shrink KASAN area and save one pgd size for
> it, Just from Redhat's enterprise relase point of view, we don't
> enable CONFIG_KASAN, and LDT is rarely used for server, now cutting one
> block from the direct mapping area and moving it up one pgd slot seems a
> little too abrupt. Does KASAN really cost 16 TB in 4-level and 8 PB in
> 5-level? After all the direct mapping is the core mapping and has been
> there always, LDT remap is kind of not so core and important mapping.
> Just a very perceptual feeling.

Sorry for late reply.

KASAN requires one byte of shadow memory per 8 bytes of target memory, so,
yeah, we need 16 TiB of virtual address space with 4-level paging.

With 5-level, we might save some address space as the limit for physical
address space if 52-bit, not 55. I dedicated 55-bit address space because
it was easier: just scale 4-level layout by factor of 9 and you'll get all
nicely aligned without much thought (PGD translates to PGD, etc).

There is also complication with KASAN layout. We have to have the same
KASAN_SHADOW_OFFSET between 4- and 5-level paging to make boot time
switching between paging modes work. The offset cannot be changed at
runtime: it used as parameter to compiler. That's the reason KASAN area
alignment looks strange.

A possibly better solution would be to actually include LDT in KASLR:
randomize the area along with direct mapping, vmalloc and vmemmap.
But it's more complexity than I found reasonable for a fix.

Do you want to try this? :)

-- 
 Kirill A. Shutemov
