Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43774ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BAB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ybPP8S6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BAB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeGTNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:44:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38067 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbeGTNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so6793305pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQXg/mOAWgzBI79R1/R01wFsgaLIKE5WEYU0MTVhbq8=;
        b=ybPP8S6eAXd1bjivxkWDKAPF2MsESCokwyr1w6m2HPLxWjMHVF1H9KTjVuJDU+MGih
         xlf79/4fABrRYHiyz2WchTj4U5dnqttk9oSfH8LUW7PYSFkd6u48hHSRzkAoeqKZKuwE
         /E/2YSQSQ6qDFCI09LHLSsGJqW7Y2FrtykGEHt4GvVAQRzle+PKblWr4vtNS3w9G7/0/
         UfBeTh95LeBx+CFN32bn2kmu93VamXfIMcORM/X/PJZySAU8gbOXROVTYj9CK34rlEub
         k1idzGACdQMn199ivGhWeIqA3SyPi4eh1UFhGOY3fe44fDr/GGJZvE8b4UFfHluPmtnr
         LqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQXg/mOAWgzBI79R1/R01wFsgaLIKE5WEYU0MTVhbq8=;
        b=lEF/kdxVJrOAILuEfwzW02kwyFxMyIRKSLghhfprX6Hg9U/kswOgugEXHTWlvcyx90
         zNiNWVxbkcQatUHiHWwHNAbvqUjQwpMRS1uYtUlz9Fk8FpgXLpg0hafAd9mr2sVDx6mU
         LvRmTjiBuuBFsV0uCHi/GKU0nnG2NuycqCT/3CZQTV0IKf7tEa07xmtFLrOXM8i420AO
         C0eRTL88D8pCNbg5ZRnEiTXdEqW/P2fa8JQNyJwYBbQGBmU3YunCe0eJ6lSJjIWM0UF8
         MPv8p1t/lBw/r3eyJpl37j+gdByRduo4mkeqa9LNx4E/mDU2vgkIa6nnGD47EheCRGVL
         HpMg==
X-Gm-Message-State: AOUpUlGuNiY8N7u7bDOri0AG85hCUf0J5867PzfrtJYEQSffrFIQxJn1
        RQVyBrxLd4fD45qSGNbMCUStXw==
X-Google-Smtp-Source: AAOMgpf3E6wW1rK7oVV192d5VeZChqyCJxEx7drCvc+feSQTB65dfSsx94KUUrke3NQNiaSttJpnuA==
X-Received: by 2002:a63:4c56:: with SMTP id m22-v6mr1878239pgl.299.1532090060167;
        Fri, 20 Jul 2018 05:34:20 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id u1-v6sm3838600pgk.25.2018.07.20.05.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:34:19 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1C1E6300254; Fri, 20 Jul 2018 15:34:16 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:34:16 +0300
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
Message-ID: <20180720123415.57m2fqbdjtvnietu@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-9-kirill.shutemov@linux.intel.com>
 <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com>
 <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
 <20180719131245.sxnqsgzvkqriy3o2@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191515150.1602@nanos.tec.linutronix.de>
 <20180719132312.75lduymla2uretax@kshutemo-mobl1>
 <alpine.DEB.2.21.1807191539370.1602@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807191539370.1602@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:40:41PM +0200, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > On Thu, Jul 19, 2018 at 03:18:03PM +0200, Thomas Gleixner wrote:
> > > On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > > > On Thu, Jul 19, 2018 at 02:37:35PM +0200, Thomas Gleixner wrote:
> > > > > On Thu, 19 Jul 2018, Kirill A. Shutemov wrote:
> > > > > > On Wed, Jul 18, 2018 at 04:19:10PM -0700, Dave Hansen wrote:
> > > > > > > >  	} else {
> > > > > > > >  		/*
> > > > > > > >  		 * Reset __PHYSICAL_MASK.
> > > > > > > > @@ -591,6 +592,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
> > > > > > > >  		 * between CPUs.
> > > > > > > >  		 */
> > > > > > > >  		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> > > > > > > > +		mktme_keyid_mask = 0;
> > > > > > > > +		mktme_keyid_shift = 0;
> > > > > > > > +		mktme_nr_keyids = 0;
> > > > > > > >  	}
> > > > > > > 
> > > > > > > Should be unnecessary.  These are zeroed by the compiler.
> > > > > > 
> > > > > > No. detect_tme() called for each CPU in the system.
> > > > > 
> > > > > And then the variables are cleared out while other CPUs can access them?
> > > > > How is that supposed to work?
> > > > 
> > > > This code path only matter in patalogical case: when MKTME configuation is
> > > > inconsitent between CPUs. Basically if BIOS screwed things up we disable
> > > > MKTME.
> > > 
> > > I still don't see how that's supposed to work.
> > > 
> > > When the inconsistent CPU is brought up _AFTER_ MKTME is enabled, then how
> > > does clearing the variables help? It does not magically make all the other
> > > stuff go away.
> > 
> > We don't actually enable MKTME in kernel. BIOS does. Kernel makes choose
> > to use it or not. Current design targeted to be used by userspace.
> > So until init we don't have any other stuff to go away. We can just
> > pretend that MKTME was never there.
> 
> Hotplug is not guaranteed to happen _BEFORE_ init. Think about physical
> hotplug.

Ouch. I didn't think about this. :/

In this case I don't see how to handle the situation properly.
Is it okay to WARN() && pray()?

-- 
 Kirill A. Shutemov
