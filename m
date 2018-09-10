Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F57C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4952086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ehl2gXoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4952086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeIJScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:32:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3+YDtH2dDvL02PUWVWBPCC7nV4jIxIJRrr6TE1EY0PY=; b=Ehl2gXoEJrI1GJzh8xuxDvHE/
        FaakSJEl4RwE3OPLjKcMGRDelXVDSmmHx4myYkA2SkJtXKoDrftJKxwxDbg4nfniosSfRIy+6n7qA
        oGlnFJrXeXZjOp+haMsR6n8Kydga6yVs9fWDhHBmjmO34GX34SCd5UzINCkL3Df8KRYpiiiJ4DhYU
        3r5ijm2CjlSTsef2Qvm1Hh2K8wq5zbmC3AYkRZJ/C8wQUbeiwFtiiU2R/Qr7uCyUUEykQg2VG196J
        m/bsSJSKcLr4iTxBlGxxeDPqf0YSDzG3RsyzD/HdHaNZSqntHrj8Jo3EoKz3vq4iT/Ad/5O7wZRfV
        /1qftANDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMO6-0006Ee-67; Mon, 10 Sep 2018 13:37:58 +0000
Date:   Mon, 10 Sep 2018 06:37:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 14/21] riscv: use for_each_of_cpu_node iterator
Message-ID: <20180910133757.GA21593@infradead.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-15-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905193738.19325-15-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:37:31PM -0500, Rob Herring wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.

We have a few pending patches in this area that look like they might
conflict.  It might be worth to delay this one and apply it post -rc1
to avoid dependencies if that isn't a problem for you.
