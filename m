Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59469C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1867321741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t201GZVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeL0Dlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:41:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0Dln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GjfXRjsa8UwubNB4Ft5yoX1RnN0GXGwDzWwt1eXGKQU=; b=t201GZVG6tuO6caEtWnXBRKA4
        lL0tOh7EZwnjeu2aMXsWWNLycpq8Qoe1N54w5gPds4VzKQ7BoAeNeifITYjdqibqjx8V+HOXPXB5t
        OiaoiE/n8Fd5nyWWkm3VaZQo+iOA4WtskaafGqAXiAnrSH8ZA+1uqHQG6Tg9U3vb+plsdicbR48K/
        DIDj7kJpglrKva9+KPP/ahuvvMvhYQl4bbOY0h8nAz2eChe6TM2f2234bxRPDedgfkKPheZbXLF+l
        ESoj5Bf8CGhtlSd4jfplNON5fjn+i6AixvNSjcAUtY5NMPM48zsEuMMB+2+QIpvvwK9WbhZqaDGLp
        t5wqA/uRA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcMYH-0007Hl-Eb; Thu, 27 Dec 2018 03:41:41 +0000
Date:   Wed, 26 Dec 2018 19:41:41 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
Message-ID: <20181227034141.GD20878@bombadil.infradead.org>
References: <20181226131446.330864849@intel.com>
 <20181226133351.106676005@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226133351.106676005@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 09:14:47PM +0800, Fengguang Wu wrote:
> From: Fan Du <fan.du@intel.com>
> 
> This is a hack to enumerate PMEM as NUMA nodes.
> It's necessary for current BIOS that don't yet fill ACPI HMAT table.
> 
> WARNING: take care to backup. It is mutual exclusive with libnvdimm
> subsystem and can destroy ndctl managed namespaces.

Why depend on firmware to present this "correctly"?  It seems to me like
less effort all around to have ndctl label some namespaces as being for
this kind of use.
