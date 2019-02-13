Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845AC4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE1120700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yr18yT/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393405AbfBMRyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:54:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393391AbfBMRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=31As72HmY/5vPL/vNBqSMGT7dQJ5eUWsX/RIGnW7RpU=; b=Yr18yT/o/W3aw3SnLVQKGOLf+
        4bnjvAOls61Dc5jJ40BPSdySq+7B7lSmGPVIFeK0Wmx5D/R+EBf4nBNJFviYvXHZZ/rMNPJWpYGy/
        5lmgt2NUbuzExUvo0j5R+igJTYDy8oh/oAva7B7gFiEnwxCWA9pJntOrVxdmvQoCTGFfrS1dp5XJp
        PC+AprN3ZLRszzBvIxFi84g3smIeloQsWvtTi4kEn+F+thCnZCfH33yoAQ19ZSoQzIdCw0QFzincU
        G15lmveYvK9gxUO5rtPsZS+0fZoQHx5kxP/rM9Trm1bVJ3xZo9MmE+uQEUpxoIn9kg5inXJTvOQn2
        VqUJYmCdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyjf-0004CM-Bs; Wed, 13 Feb 2019 17:54:15 +0000
Date:   Wed, 13 Feb 2019 09:54:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Message-ID: <20190213175415.GA11635@infradead.org>
References: <20190213063127.28703-1-anup.patel@wdc.com>
 <20190213063127.28703-7-anup.patel@wdc.com>
 <20190213064419.GA27012@infradead.org>
 <20190213073835.GA18267@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213073835.GA18267@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:38:36AM +0200, Mike Rapoport wrote:
> memblock_free() is has no real effect at this point, no idea why arm64
> calls it.

Looks like the call was added fairly recently by:

commit 05c58752f9dce11e396676eb731a620541590ed0
Author: CHANDAN VN <chandan.vn@samsung.com>
Date:   Mon Apr 30 09:50:18 2018 +0530

    arm64: To remove initrd reserved area entry from memblock

which claims it is to work around the initrd being displayed in
/sys/kernel/debug/memblock/reserved.

I really think we need to have common behavior there - either do this
for all architectures or none.  I've just sent a series that
consolidates all but a handful of the free_initrd_mem, so implementing
any common behavior on top of that would be good.
