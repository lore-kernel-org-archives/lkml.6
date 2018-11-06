Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D392C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67192081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMQPtfXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67192081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbeKGDIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:08:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389692AbeKGDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3PK4qLrpdCJ2ZOwtWQKNE/S0hVSm46fFOopUrCT1X4E=; b=SMQPtfXdzG3kXacWDNIVIT0e5
        3J3uK9lhrS5d5+ivxx2nvgjY+3KIiACWvIJkDFcYMh5CHXq/D7FU86cZcpQxhRtWGNwBxLbCuU8TH
        fxwSbie/bCbv5bLNh0vVdOxwPQauhRYPV5PRSgKisfLAGmGf5cyWaRnJ/JNRREwFqIX6mBKRelvcv
        5931f1fqNjopj7HOYxv/0mVozKNnkVZmXsNlBJc6QFaOEuwg7eSaZD02JrBwGz+HB7TIk6TjTsElk
        SJvWIcG2hRRiYDPa65XYyHA3l3+2slh+MCnoYvvzgSZcLGRESdK73ODtyg5zHJD71ezIzFVNriyjw
        FyB40qPXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK5Lm-0007bl-LC; Tue, 06 Nov 2018 17:41:14 +0000
Date:   Tue, 6 Nov 2018 09:41:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 13/14] Documentation/x86: Rename and update
 intel_rdt_ui.txt
Message-ID: <20181106174114.GI3074@bombadil.infradead.org>
References: <20181106154034.15386-1-babu.moger@amd.com>
 <20181106154034.15386-14-babu.moger@amd.com>
 <20181106155305.GG3074@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106155305.GG3074@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:53:05AM -0800, Matthew Wilcox wrote:
> > -This feature is enabled by the CONFIG_INTEL_RDT Kconfig and the
> > -X86 /proc/cpuinfo flag bits:
> > +This feature is enabled by the CONFIG_INTEL_RDT Kconfig(for Intel) or
> > +CONFIG_AMD_QOS(for AMD) and the X86 /proc/cpuinfo flag bits:
> 
> Now I'm curious why we have two different Kconfig options for the same
> feature.  I should go and read the other patches, I suppose.

Now that I've read through them, I find nowhere that the choices:

AMQ_QOS=y INTEL_RDT=n
AMD_QOS=n INTEL_RDT=y
AMD_QOS=y INTEL_RDT=y

have any difference to the resulting code.  Thus, this looks like a
vanity config option; please don't do this.  Rename the config option
to be vendor-neutral if you must, but please no new options unless
absolutely necessary.
