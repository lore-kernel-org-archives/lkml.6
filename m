Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7673120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHvWB1XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7673120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeILVLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:11:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nfel58R0LVQQtor4RtAdO+tsnNWO+chqGcamaqu5NWk=; b=mHvWB1XY+HPWgo1PGFXS93DjA
        gHzQEn+L4Jo3YulvPqSp9SaPnc7u0LlHx7EV6kP2kCFrRVNpKLstAe/+YrRVkT++opbEOWALgO+In
        aiPZ5ZKnUbvGlsO1BlKnjFn7QKNAqX5tFjhTC/9JCRxcnzfNTdKKOTst4aARZA3M3UqAjZgUGPMHg
        8zXQe/v3zzn4vjmhgrMMge8HU3oFqDIa8uuDDARr+yOJsrI6aVWQf0CcOyuJCmezQHXoP5chgVsAX
        Fdj8XLnCT1GrqaOyI/pmgwHqlE+oiZp9QnCwR7C9gB41EGkMKC5jN+pjBaGDtyw7mAvRvacRWpmTZ
        EIAdEtGYQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07ev-0006xN-1B; Wed, 12 Sep 2018 16:06:29 +0000
Date:   Wed, 12 Sep 2018 09:06:26 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario.Limonciello@dell.com
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
Message-ID: <20180912160626.GA24957@wrath>
References: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
 <20180910205139.GC5659@wrath>
 <d140b6171dfe4e748b7491f4955c07be@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d140b6171dfe4e748b7491f4955c07be@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:14:34PM +0000, Mario.Limonciello@dell.com wrote:
> Darren,
> 
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Monday, September 10, 2018 3:52 PM
> > To: Limonciello, Mario
> > Cc: Andy Shevchenko; LKML; platform-driver-x86@vger.kernel.org;
> > stable@vger.kernel.org
> > Subject: Re: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
> > 
> > On Mon, Sep 10, 2018 at 01:01:52PM -0500, Mario Limonciello wrote:
> > > ACPI buffers were being allocated but never freed.
> > >
> > > Reported-by: Pinzhen Xu <pinzhen.xu@intel.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > Cc: stable@vger.kernel.org
> > 
> > Thanks Mario and Pinzhen, both queued. That's an easy one to miss, the usage not
> > being particularly obvious.
> > 
> 
> This cropped up and is fixed by that patch:
> https://github.com/dell/libsmbios/issues/63
> 
> Given the impact and how small the patch is, I think it might be good if this can come to 4.19-rcX if possible.
> Thoughts?
> 
> I suspect this one might be the same issue too:
> https://bugzilla.redhat.com/show_bug.cgi?id=1627609


Happy to pull these into fixes for 4.19-rcX. Queued to Fixes.

-- 
Darren Hart
VMware Open Source Technology Center
