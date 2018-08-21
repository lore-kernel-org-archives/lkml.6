Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A99C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2F214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLZ4u9Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA2F214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeHUQeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:34:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeHUQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d98yOvqik39kYVbGz25Uc80En1BMy4Nim0RpXPxAZ9w=; b=mLZ4u9IxhcaTXXLwhMP5EeTkIa
        aBwshDvyZUMuxeB7N8uzKR+zjqyESIl5f+deQaMh6ZqPFEOIuNfrm8gqQE9eqMpFreI6Kl0w2qGlE
        14HaJFcd0SHEP61LBOG9JJnucRFtICo3YRnUQzx0uY/s5+vNAPF/W/fLDIjUBMMLEP0ak2nwu2VLo
        iedU+cdZsw2ctDRsZEh2Uqq72o34AWwLHX9oPpbyLNwl67w4wIDNfpXhwHqJhHiu+6cNRhKYJJ8L8
        y7tA6ygGbqKQqkbiPfviwFwMMHAAwl/731jrrRowbjmUswok9G6YzqfhllbIJMISAYayI++31K9ut
        jbtZfAIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs6Ub-0001ci-RX; Tue, 21 Aug 2018 13:14:41 +0000
Date:   Tue, 21 Aug 2018 06:14:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
Message-ID: <20180821131441.GA6156@infradead.org>
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180821061451.GB481@infradead.org>
 <1534851050.14722.3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534851050.14722.3.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:30:50PM +0100, David Woodhouse wrote:
> On Mon, 2018-08-20 at 23:14 -0700, Christoph Hellwig wrote:
> > On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> > > Hi Bjorn and others,
> > > 
> > > Triggered by Christoph's patches, I had another go at converting
> > > all of the remaining pci host bridge implementations to be based
> > > on pci_alloc_host_bridge and a separate registration function.
> > 
> > I really like the idea behind this series.
> 
> Hm... are you turning direct calls into retpolined indirect calls?

He does.  But not anywhere near the fast path.
