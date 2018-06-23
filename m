Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585B7C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F123B24D5F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KugOrsKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F123B24D5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeFWXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 19:20:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFWXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4OQb4Qkf0Pke+KgKcNwayUp8WaIgb1wmHS28wfE+T7o=; b=KugOrsKqiQYaZ4VzqanXIWJbo
        krz8VWzuqehl9Px3yxXLVMcglF8i2l8McpAtltdqiLN6E/Iz/RvTCzKET4Trx9ynzbr6udZVbXU9l
        bQgLusmYIyvt/lgH2T4x8kHUYx/wTeXoSyjMFfTpIKJ/iQSgC/3JJVuSipf4XxwqJUXH7qGrcj1ig
        eEx87qlaFVuXQsCyaxgaAb/DLPnuSNfR+IbK2KDdx+Xp9lQmhXBYMJpdjuzYLosdQ7mpNTVGgNOAV
        bl+Ole9F7z1BOLtFgW8rANo+fnFZKmvzIZ9uYnv8LXEVuVaSh+rmJUxlp1wdxeX6MZQNKum/uEgF/
        oygIHI8aA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWrpZ-0006xg-UZ; Sat, 23 Jun 2018 23:20:33 +0000
Date:   Sat, 23 Jun 2018 16:20:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
Message-ID: <20180623232033.GF18630@bombadil.infradead.org>
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180623074650.GC18630@bombadil.infradead.org>
 <554b70ff-5a94-8338-6831-ce2efa1be287@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554b70ff-5a94-8338-6831-ce2efa1be287@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 09:43:41AM -0700, Guenter Roeck wrote:
> On 06/23/2018 12:46 AM, Matthew Wilcox wrote:
> > There actually is a rule that pointers passed to the IDR be aligned.
> > It might not be written down anywhere ;-)  And I'm quite happy to lift
> > that restriction; after all I don't want to force everybody to decorate
> > definitions with __aligned(4).
> 
> I am not sure if that is really correct, or at least I was unable to
> find such a restriction documented or even mentioned anywhere. It is
> true for radix trees, but even there the restriction used to be "even".
> This was changed to "word aligned" with commit 3bcadd6fa6c4f, and the
> offending commit here moves the "INTERNAL" bit from position 0 to 1.
> This is quite a subtle change that was introduced over time. I'd be
> not surprised if there are other more severe problems lurking in
> the radix tree code and/or its users because of that.
> 
> Either case, I think the check for radix_tree_is_internal_node() in
> idr_alloc_u32() is wrong. If anything, it should be radix_tree_exception().
> If that was the case, the problem (and maybe other similar problems)
> would have been found with commit 3bcadd6fa6c4f, not only now.

Oh, but we want people to be able to store exceptional entries as well
as pointers.  So this was the right solution at the time.  Now that I'm
trying to expand the range of exceptional entries, it's time to make all
(*) values storable in the IDR.

(*) Still not all.  The radix tree/IDR/XArray reserve some values for
its own use.  Various values below 4096 and above -4095, for example.

Here's the test-case I'm currently working on:

+static void idr_align_test(struct idr *idr)
+{
+       char name[] = "Motorola 68000";
+       int i;
+
+       for (i = 0; i < 9; i++)
+               BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i);
+       idr_destroy(idr);
+
+       for (i = 1; i < 10; i++)
+               BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 1);
+       idr_destroy(idr);
+
+       for (i = 2; i < 11; i++)
+               BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 2);
+       idr_destroy(idr);
+
+       for (i = 3; i < 12; i++)
+               BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 3);
+       idr_destroy(idr);
+
+       for (i = 0; i < 8; i++) {
+               BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
+               BUG_ON(idr_alloc(idr, &name[i + 1], 0, 0, GFP_KERNEL) != 1);
+               idr_remove(idr, 1);
+               idr_remove(idr, 0);
+               BUG_ON(!idr_is_empty(idr));
+       }
+}

