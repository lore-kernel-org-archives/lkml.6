Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC764214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8Erarbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfAIT7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:59:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfAIT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=en7Ss+BCNM5Jzlzw5YDF53rYHwwJu5fXjdv9zfRg/1E=; b=B8ErarbtXzYTcMIScThY8xjPm
        p2wwTC3Dx9YVZM5Xv/O+nPfDtzyQVlXc3+F11yIFpBHcvJgnHm1dQMOKGPjm8NHdaLAX27ffWsOaU
        /LmXTjA32Vn1JV87jj6jIqNJRXEnuhgRB1mOJie2+s2NRkzuGKEkE2ori6wLhUbtd9u5d8n1a2lwW
        ukaOIrrgnjqmZ2m1vqZny4z0Lqb2enHvZ7BbVhGMLl25/HeCpbmhuHK5FNbigHlf2Gw53/OX9E2rJ
        4ifhXfDufYEuk1evtE7NO/ltTxZCgOIqG1hB8Wa6a8yai2pPEO//96lMBksZP6CsIFLfa2gEkNja8
        MELZC2OYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghK0u-0003Tu-IF; Wed, 09 Jan 2019 19:59:44 +0000
Date:   Wed, 9 Jan 2019 11:59:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/4] /proc/stat: Reduce irqs counting performance
 overhead
Message-ID: <20190109195944.GQ6310@bombadil.infradead.org>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
 <20190109174403.GN6310@bombadil.infradead.org>
 <f6302369-9eda-ef58-4f18-3dc9ffbc31f1@redhat.com>
 <20190109182417.GO6310@bombadil.infradead.org>
 <f0ae7bd8-5c5b-aefd-aff8-2719fc0edbaa@redhat.com>
 <3f44cc18-4dd8-e313-26b9-1502b0b40507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f44cc18-4dd8-e313-26b9-1502b0b40507@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:54:36PM -0500, Waiman Long wrote:
> If you read patch 4, you can see that quite a bit of CPU cycles was
> spent looking up the radix tree to locate the IRQ descriptor for each of
> the interrupts. Those overhead will still be there even if I use percpu
> counters. So using percpu counter alone won't be as performant as this
> patch or my previous v1 patch.

Hm, if that's the overhead, then the radix tree (and the XArray) have
APIs that can reduce that overhead.  Right now, there's only one caller
of kstat_irqs_usr() (the proc code).  If we change that to fill an array
instead of returning a single value, it can look something like this:

void kstat_irqs_usr(unsigned int *sums)
{
	XA_STATE(xas, &irq_descs, 0);
	struct irq_desc *desc;

	xas_for_each(&xas, desc, ULONG_MAX) {
		unsigned int sum = 0;

		if (!desc->kstat_irqs)
			continue;
		for_each_possible_cpu(cpu)
			sum += *per_cpu_ptr(desc->kstat_irqs, cpu);

		sums[xas->xa_index] = sum;
	}
}
