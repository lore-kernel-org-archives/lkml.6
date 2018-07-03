Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289FF247D3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B++RIK3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289FF247D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeGCPGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:06:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeGCPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TurinIbeBRO+xA952J0WjUq9gfU9wwJxMRN4DxyCZ/k=; b=B++RIK3NiENbXM6t2ADVDVPNX
        ussgREQoVTM2DLROxLTTI/Rn7TIeLVOUX4D6+XPmNYXRLkFbIVj/t0BXdX6wLvJEP51/T6pY+CuB0
        L39VE00+N8yyyMjtJh3L6Kow4zTjb0JjMbpbTfdSkn/Uq04/ta8RSEO6k7lMNk3BVHGukZMvw6SDG
        epfICduzSwCsJO2oQzXo58AVNyM/+SwaRCP2/7o8H5EOXJPg0cAPkMSuOi0KXrpU3s6exL0vKPFXA
        9qEZM2Oh/oWyZMYmSuafKGvp5TQuy8r0rMXdBJR6S+bthCx1cNKn47bhO+P/DoD9Gp8O8h3Ifg31l
        JdHtzQymw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faMs3-0004SR-6p; Tue, 03 Jul 2018 15:05:35 +0000
Date:   Tue, 3 Jul 2018 08:05:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k/page_no.h: force __va argument to be unsigned
 long
Message-ID: <20180703150535.GA21590@bombadil.infradead.org>
References: <1530613795-6956-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530613795-6956-3-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703142054.GL16767@dhcp22.suse.cz>
 <20180703150315.GC4809@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703150315.GC4809@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:03:16PM +0300, Mike Rapoport wrote:
> On Tue, Jul 03, 2018 at 04:20:54PM +0200, Michal Hocko wrote:
> > On Tue 03-07-18 13:29:54, Mike Rapoport wrote:
> > > Add explicit casting to unsigned long to the __va() parameter
> > 
> > Why is this needed?
> 
> To make it consitent with other architecures and asm-generic :)
> 
> But more importantly, __memblock_free_late() passes u64 to page_to_pfn().

Why does memblock work in terms of u64 instead of phys_addr_t?

