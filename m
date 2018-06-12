Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A1AA0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E486208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhhExfVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E486208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFLFSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:18:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeFLFSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T4rC2sJuSL2jhBpi3Qctx/1Tm76SWDUvhlkqU7f5FZY=; b=jhhExfVn5wtXGHCPGr7+0cCQU
        WAUI9/uUdydrfccUHyUM4tWL9PTBqBypGl0zFOxo4d9iJA0x4S8H8BZoonA63oCHg5kG2EWQZM3Nq
        I/G2bvMf1fPvgpv/rXZNnwl8NxY+yffdCitoSOXlLJmjxMokFq6wi+TVs4zZvgUbe5PUQH0dlMWOr
        MThSkyoANiHs+4Kiy0ihfYYrw75rmBAweXLiHdjRD21Llxp/YtUbFEVtXgrXoZUFKw/VmLaCOYJqA
        uUHxk0ssX2gZpbqUGv/HKTfrg2A68Oew7CuFzsJXXBeb1CjjNe6jWrGlQ48q5nIoul/PP5EoRMNH5
        K+bkCNk3g==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSbhG-0000RQ-8B; Tue, 12 Jun 2018 05:18:22 +0000
Date:   Mon, 11 Jun 2018 22:18:19 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: build failure after merge of the drivers-x86 tree
Message-ID: <20180612051819.GB112645@localhost.localdomain>
References: <20180612112310.2d77e1c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612112310.2d77e1c3@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:23:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/platform/x86/silead_dmi.c:84:21: error: variable 'chuwi_vi10_data' has initializer but incomplete type
>  static const struct ts_dmi_data chuwi_vi10_data = {
>                      ^~~~~~~~~~~
> drivers/platform/x86/silead_dmi.c:85:3: error: 'const struct ts_dmi_data' has no member named 'acpi_name'
>   .acpi_name      = "MSSL0002:00",
>    ^~~~~~~~~
> drivers/platform/x86/silead_dmi.c:85:20: warning: excess elements in struct initializer
>   .acpi_name      = "MSSL0002:00",
>                     ^~~~~~~~~~~~~
> drivers/platform/x86/silead_dmi.c:85:20: note: (near initialization for 'chuwi_vi10_data')
> drivers/platform/x86/silead_dmi.c:86:3: error: 'const struct ts_dmi_data' has no member named 'properties'
>   .properties     = chuwi_vi10_props,
>    ^~~~~~~~~~
> drivers/platform/x86/silead_dmi.c:86:20: warning: excess elements in struct initializer
>   .properties     = chuwi_vi10_props,
>                     ^~~~~~~~~~~~~~~~
> drivers/platform/x86/silead_dmi.c:86:20: note: (near initialization for 'chuwi_vi10_data')
> drivers/platform/x86/silead_dmi.c:84:33: error: storage size of 'chuwi_vi10_data' isn't known
>  static const struct ts_dmi_data chuwi_vi10_data = {
>                                  ^~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   2da502a0aea7 ("platform/x86: silead_dmi: Add touchscreen info for the Chuwi Vi10 tablet")
> 
> I have reverted that commit for today.  More care please.

Thank you Stephen. We caught this earlier, but failed to remove it from for-next
while repairing the series. Our apologies. I have removed this series back to
the known good patch in for-next:

26ed9d1 platform/x86: silead_dmi: Add entry for Chuwi Hi8 tablet touchscreen

Andy has this reworked already and is working on completing
testing before pushing the update to for-next.

-- 
Darren Hart
VMware Open Source Technology Center
