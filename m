Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC42C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503972054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BuFBCVuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503972054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeJaXQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:16:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbeJaXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5pjh20Ro0or4wwBRda2IEnIozZqarrHiENSFS1VMJhE=; b=BuFBCVuXYQYdDo+hYUOMcSVgU
        JCwk9yZCD1fCrfH3dhU8/2G+dO+R1XelLjWfsmK885k/Nodc5W4Q+GXoYGGzW/KhOkfJjr+wh49IT
        um7KqIN0CyibrAz1ugCNvzg3jyfLjUkiekeyzc5/iVwRwosgieJ9wwpZqN5IJ7UvskkvC3sV8Jkbg
        3QLqr41rg9dQt/bpeZaIO7djRQuYZE8fTisHBYBaYpC+O5HSkAIytrB6peYUEn3HsEwxYNTrMZCxo
        5jXUdg/LgsomaJgQXEW1ecY0S3VznTgzKOwnu4UzWNBQqxh1UY5mT2J3lxa1g8PsDS7i7rMXPJs5S
        gyOKGVq+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHrJZ-0002mM-Ko; Wed, 31 Oct 2018 14:17:45 +0000
Date:   Wed, 31 Oct 2018 07:17:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     vincentc@andestech.com, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, alankao@andestech.com,
        greentime@andestech.com, Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181031141745.GA5183@infradead.org>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
 <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 04:46:10PM +0530, Anup Patel wrote:
> I agree that we need a place for vendor-specific ISA extensions and
> having vendor-specific directories is also good.

The only sensible answer is that we should not allow vendor specific
extensions in the kernel at all.  We need to standardize cache flushing
and we need to do it soon and not introduce horrible bandaids because
the foundation did not do its work.
