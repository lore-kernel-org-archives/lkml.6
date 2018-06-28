Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35CAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7137F27158
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/8hBlKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7137F27158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934545AbeF1JXP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:23:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeF1JXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kc9rX/247PNlOJuxqwlE0JiHyV+A2GrD88slWMc1v90=; b=U/8hBlKqFKpDWszP30vQaTiIQ
        DsUKdWrWGxbLwTvwicCppgSq8zoIHaKQKBEq3Z17jhzQSCWh7UfQMnvdEL5kr7HwWPuJ8FueeRzQU
        5JtMQNuz8XWy1jbRqFTURp6ndL/KnVGYyVZJ70MqcEf0RTx6RFqiBnVsovb19qoEzLJoJ06kOM0jU
        NNqgTBNAoIZgUFEhOycVT5QV8H3FRH6Tf7iUm/Y9/xRWLa2aVT67B2LonIfbwXK22Q6IAFEvQGWNG
        AXnLgoHIxR5EF78YnmsIRSBIXrKPcdd1FYrMJL/Jjfcn7vYeCKoRGcBgP5rIF4ah2WUD418cCvq1R
        LslUK9PJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYT8p-0004bY-Me; Thu, 28 Jun 2018 09:23:03 +0000
Date:   Thu, 28 Jun 2018 02:23:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] <linux/taggedptr.h>: Introduce tagged pointer
Message-ID: <20180628092303.GD7646@bombadil.infradead.org>
References: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:06:29PM +0800, Gao Xiang wrote:
> Therefore, this patch introduces simple generic methods to fold
> tags into a pointer integer. It currently reuses the last 2 bits
> of the pointer for tags, which are safely for all modern platforms.

The m68k people will have your head.  alignof(unsigned long) == 2 on
m68k.  Now, kmalloc always returns 8-byte aligned quantities, but
if you have:

static unsigned long foo;

then ((unsigned long)&foo & 2) may be non-zero.

> +/*
> + * mark these special integers as another type
> + * in order to highlight the tagged pointer usage.
> + */
> +typedef uintptr_t	taggedptr_t;

I find this a bit verbose.  How about tagptr_t ?

