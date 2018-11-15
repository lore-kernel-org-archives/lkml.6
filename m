Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605FCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2683420825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwKSwPMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2683420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbeKOTsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:48:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKOTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0YIP6kms/+57IvcKRu5puAui3qvcW2fPwyVGn1GwsXU=; b=hwKSwPMNMFe+Q9FfrbofwviLz2
        P09ZoDsAXq83UP5IYoo27fVrMHcUdsXOCxDKwMyc6s3albWw2eGrKhglseX2lI80CGsI5EjKZH8ba
        QkV+Pj1ViCGt/V07VkhHnTsyTTBuv2o9p1NrkpzogR5hLuCErWZRiCpToaN8t8IDsBGugphSq6Ufu
        f9oWHLWOhR671KmZ4wJQZzXhxVC3wBJU0VmF3dYeqLxfMOXcHGngYxeXDd4vQi4WhmH9FYcyXxnbt
        QoY6ihAZHDOi9xPV6+NWq7FafDFaqsJQCteaV9z5lZQkwYSp2guq0J8K/Z5JoDtFwo96C58DLsMib
        J0UdPNjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNE9E-00070e-Ld; Thu, 15 Nov 2018 09:41:16 +0000
Date:   Thu, 15 Nov 2018 01:41:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Graf <agraf@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Brown <rbrown@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] arm64: Make kpti command line options x86 compatible
Message-ID: <20181115094116.GA18154@infradead.org>
References: <20181113152046.22389-1-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113152046.22389-1-agraf@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 04:20:46PM +0100, Alexander Graf wrote:
> I've already stumbled over 2 cases where people got confused about how to
> disable kpti on AArch64. In both cases, they used existing x86_64 options
> and just applied that to an AArch64 system, expecting it to work.
> 
> I think it makes a lot of sense to have compatible kernel command line
> parameters whenever we can have them be compatible.
> 
> So this patch adds the pti= and no_pti kernel command line options, mapping
> them into the existing kpti= command line framework. It preserves the old
> syntax to maintain compatibility with older command lines.
> 
> While at it, the patch also marks the respective options as dual-arch.

Thanks.  Which also brings up my old complainﬆ that arm64 and x86 should
use the same config option.  Bonus points for moving the parsing code
to a common file..
