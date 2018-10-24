Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A9C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F02064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWwoICoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F02064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJXVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:40:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eQE7C7t/tLLe1zAX3ULvBhqWlIov+gYLgRl4Ix3x1uk=; b=MWwoICoO6sutQNtr5Y6ibMgew
        tEUikUkQDSMtJTNbEHJ168Yg9kJ1OcD3ruQOQ0WWqN7QPw/8SOIeXUkk0pFPMiBxLC5UIJV315JAR
        S8uacoN1mZtWg0r+RiKz5Ef4i5nyg5WKXuq3uP41Dby9oH7p9eVQcMdYS1nea0rwPwoqG2YLfovQj
        gOGqFh3FUoOdn9ebBTiUpeFFjAmmAZLtBTkJ92NTt39RJGrQxAASIud9Fynysd6wHxycWdOk00IkI
        Ikh5sK//M51PbMB4RX6M+6mcNmd+/0mowBwUwnaYARZTVLgeJvAvr1Xnte+UV7OmKSUPU0ATRpMJR
        OxT4IYzLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFIxa-00038W-KY; Wed, 24 Oct 2018 13:12:30 +0000
Date:   Wed, 24 Oct 2018 06:12:30 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181024131230.GF25444@bombadil.infradead.org>
References: <20181024125112.55999-1-kirill.shutemov@linux.intel.com>
 <20181024125112.55999-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024125112.55999-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:51:11PM +0300, Kirill A. Shutemov wrote:
> +++ b/Documentation/x86/x86_64/mm.txt
> @@ -34,23 +34,24 @@ __________________|____________|__________________|_________|___________________
>  ____________________________________________________________|___________________________________________________________
>                    |            |                  |         |
>   ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor

Oh good, it's been rewritten for people with 200-column screens.  It's
too painful to review now.

This is how it looks for me, Ingo:

> @@ -34,23 +34,24 @@ __________________|____________|__________________|_______
__|___________________
>  ____________________________________________________________|________________
___________________________________________
>                    |            |                  |         |
>   ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole,
 also reserved for hypervisor

If it were being formatted in rst so we could get a nice html view out
of the conversion, I'd understand.  But I don't see what we get from
this hilariously verbose reformatting.
