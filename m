Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E9520862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlmdNo7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbeKGBTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:19:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGBTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JBm0TxjK+YT/9uJcVZaN6FTpyAJoZyO2CN2vfmc48Z8=; b=IlmdNo7qk0roDwuGXixzv7tpv
        XCYkYhyao0iTNr08dE25kpYtiymMJTRp2UoAQgQcu5XbqCqBCanePTZ+48dBAPTy7j7XiiLlR0yth
        IkkOjp4LSbubE7yFjjdfPlmCIwx4iSEiGK9xNoGW5fW/+Xl4cdSxqvfy7Vb3fk9RFG/26ZU2MMIfq
        NoFSvxh3yKitTFh1nKLHjaLob91XozGXlU7r42yxBZxXZe9GVNs9YYu7P8uOkAPBmmJ93Hrpz2Ky8
        Bh6RyrpaeytpbDb6phId7a3pBpGngL8NAqHyg/vcWH847zGw5m4koOhlGtYhyl9pOJG/vVAje9VN7
        bkXoUIftA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK3f7-0008EY-Vj; Tue, 06 Nov 2018 15:53:05 +0000
Date:   Tue, 6 Nov 2018 07:53:05 -0800
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
Message-ID: <20181106155305.GG3074@bombadil.infradead.org>
References: <20181106154034.15386-1-babu.moger@amd.com>
 <20181106154034.15386-14-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106154034.15386-14-babu.moger@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:41:26PM +0000, Moger, Babu wrote:
> @@ -1,4 +1,7 @@
> -User Interface for Resource Allocation in Intel Resource Director Technology
> +User Interface for RESCTRL feature

"for Resource Control".

> +Intel refers to this feature as Intel Resource Director Technology(Intel(R) RDT).
> +AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>  
>  Copyright (C) 2016 Intel Corporation
>  
> @@ -6,8 +9,8 @@ Fenghua Yu <fenghua.yu@intel.com>
>  Tony Luck <tony.luck@intel.com>
>  Vikas Shivappa <vikas.shivappa@intel.com>
>  
> -This feature is enabled by the CONFIG_INTEL_RDT Kconfig and the
> -X86 /proc/cpuinfo flag bits:
> +This feature is enabled by the CONFIG_INTEL_RDT Kconfig(for Intel) or
> +CONFIG_AMD_QOS(for AMD) and the X86 /proc/cpuinfo flag bits:

Now I'm curious why we have two different Kconfig options for the same
feature.  I should go and read the other patches, I suppose.
