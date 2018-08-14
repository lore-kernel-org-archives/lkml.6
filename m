Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6290C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABD321655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRGFObfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABD321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeHNQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:23:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbeHNQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xrP27v37wEfLTaarlipron8WUIcSnnq+qIHgp4mVPSM=; b=JRGFObfeQlY972/ReD1H+yBBh
        hJwe2F1E7Wj8YYo3DFZ1Q6bTpI5kQKM2v3JCojTQEUdn+/QtRDfWssaPbRW8bkqmAP03u2mGXL4yr
        viW7WRKvL/JN/w58ggT8Uee8RHLuGpAz47YVlEoermTzLMXUPhtozbhLuy/+BBfloBfkBdpVyqrNC
        RE97C+Bvu43wU9fm+T0497fs5LaWJSBVA0Pm/7TaFgfV8YEsaVC8h4PzldxB+0blXuE+11IZHlNyl
        q9M5f7FaKaQiJhbpC3C5/wxvHHIVF6oQ8Q50nolcrtbrCz/Rm3THBWVFGd+rU9DouIOLqYVKNdzZy
        Fv5DQ8bpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpZU1-0001vk-2T; Tue, 14 Aug 2018 13:35:38 +0000
Date:   Tue, 14 Aug 2018 06:35:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, linux@roeck-us.net,
        tklauser@distanz.ch, linux-riscv@lists.infradead.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180814133536.GB28080@infradead.org>
References: <20180810083804.GA20415@infradead.org>
 <mhng-341b5b76-2cd6-41e3-859a-6b1d926ba770@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-341b5b76-2cd6-41e3-859a-6b1d926ba770@palmer-si-x1c4>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:27:37AM -0700, Palmer Dabbelt wrote:
> I'm not sure.  We can implement the syscall fine in !SMP, it's just that the
> vDSO is expected to always eat these calls because in non-SMP mode you can
> do a global fence.i by just doing a local fence.i (there's only one hart).
> 
> The original rationale behind not having the syscall in non-SMP mode was to
> limit the user ABI, but on looking again that seems like it's just a bit of
> extra complexity that doesn't help anything.  It's already been demonstrated
> that nothing is checking the error because it's been silently slipping past
> userspace for six months, so the extra complexity seems like it'll just
> cause someone else to have to chase the bug in the future.
> 
> But I'm really OK either way.  Is there a precedent for what to do here?

I don't know of any.

