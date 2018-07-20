Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF07ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6C204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BPSg9uzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE6C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeGTO2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:28:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33923 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeGTO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:28:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so6953227pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqwRwz5WvUraR6XNVxZxSxVFZBSQrVW8UAkH2+gtLLU=;
        b=BPSg9uztMUShV+u3tduglSDkOpLpiHSV8t1IAra6IsmkWZUw9uUZv05v2oL9DdamX/
         jDkHjUcT89X+0xtnBuut2EYRUeHx2YlrjxWuhvKipN4kVACc4BMG5HU6zNsq3gqKxdo/
         ILY858gT0EH5X7gMH6ToHo1KAms5n+z0e6ybN58OdWGL+Wyp3L7vbg8vFmeW8cSRFPnV
         sNzzvwFSPAnXErW4wxVnii9Rcs9Mu1TBqytujSv1+84Tf64pCCPAwJiyOeClTR3xf3PC
         BAGxEAxjHUZy9cDILBSWonEH4SyMxJ2mWqt32GdkE95IlKIabSjG3O+E87u9KNBW0iMw
         jC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqwRwz5WvUraR6XNVxZxSxVFZBSQrVW8UAkH2+gtLLU=;
        b=KhTExbQa87aK+YCpVF4at8Fsnn6jQuxuce1Ej8Z0xVRO1gg0Oy3ccRMBwPcmXequh1
         L6hTSQkFI3awwDAOkjOthZNOubNweHb7oSghWRE26FWXCutdkBWh2A18QUAwivpXYBUh
         xxI8ejKzybRY6RnJk40iiPCUj1bEnxM41qFagCyHt0HDaQ1ghm5DBUj53wz8FmY5YfF8
         8cYbU/sGtiBztiK2bza56KsyIxdOXphfMV4vRsKlnc/2i92mnLygWZ+Ydh0IN4AfJNJQ
         xUD4zTEViYGGL61XK88uRenoEC5jeKv/SFz6vV5PMVDgW/0JTAcaBUi5SjLGPAGtUw8y
         gauQ==
X-Gm-Message-State: AOUpUlGoK/PZPFAENwK6yZ16XccQpluvh7t5lDwdzuA6dxmxnO/i/J43
        Z5JBphyLwwkA6We7zeZbc6vPlQ==
X-Google-Smtp-Source: AAOMgpeSPralCniuMnjJk04mb8tJ8POOct8XikMSnOQwHlrlNXDOvv6WgUIuv1UzKaybHbVfDZPj/g==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr2216371pff.211.1532094030608;
        Fri, 20 Jul 2018 06:40:30 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id z184-v6sm3749258pgd.83.2018.07.20.06.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:40:29 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 7F7BE300254; Fri, 20 Jul 2018 16:40:26 +0300 (+03)
Date:   Fri, 20 Jul 2018 16:40:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
Message-ID: <20180720134026.6saxekgxxgltv3hg@kshutemo-mobl1>
References: <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
 <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
 <20180719131245.sxnqsgzvkqriy3o2@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191515150.1602@nanos.tec.linutronix.de>
 <20180719132312.75lduymla2uretax@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191539370.1602@nanos.tec.linutronix.de>
 <20180720123415.57m2fqbdjtvnietu@kshutemo-mobl1>
 <alpine.DEB.2.21.1807201511560.1580@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807201511560.1580@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:17:54PM +0200, Thomas Gleixner wrote:
> On Fri, 20 Jul 2018, Kirill A. Shutemov wrote:
> > On Thu, Jul 19, 2018 at 03:40:41PM +0200, Thomas Gleixner wrote:
> > > > > I still don't see how that's supposed to work.
> > > > > 
> > > > > When the inconsistent CPU is brought up _AFTER_ MKTME is enabled, then how
> > > > > does clearing the variables help? It does not magically make all the other
> > > > > stuff go away.
> > > > 
> > > > We don't actually enable MKTME in kernel. BIOS does. Kernel makes choose
> > > > to use it or not. Current design targeted to be used by userspace.
> > > > So until init we don't have any other stuff to go away. We can just
> > > > pretend that MKTME was never there.
> > > 
> > > Hotplug is not guaranteed to happen _BEFORE_ init. Think about physical
> > > hotplug.
> > 
> > Ouch. I didn't think about this. :/
> > 
> > In this case I don't see how to handle the situation properly.
> > Is it okay to WARN() && pray()?
> 
> Not really. First of all, you want to do the initial checking on the boot
> CPU and then when secondary CPUs are brought up, verify that they have
> matching parameters. If they do not, then we should just shut them down
> right away before they can touch anything which is TME related and mark
> them as 'don't online again'. That needs some extra logic in the hotplug
> code, but I already have played with that for different reasons. Stick a
> fat comment into that 'not matching' code path for now and I'll give you
> the magic for preventing full bringup after polishing it a bit.

Got it. Thanks!

-- 
 Kirill A. Shutemov
