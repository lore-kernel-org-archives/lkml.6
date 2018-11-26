Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BC820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Az1GQNRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BC820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKZTPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:15:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=di4PsUpdDbM5/ej/7pGZcof0hVhDgguMhpBso9HbpKw=; b=Az1GQNRJMI+bk817CrVCZBaC6
        tyQxACbydtO8DCDYLO6Co1kelxN14HPEmgHLA+6ZSLA29owYf/0ptQUzCFfsVeehDkRxo8kvS+wnb
        eQrNsqrxXOpMLhYgqZ537EnxC/rXyxy/m55LzYv78+rDNvbqL+c6xr6X237+KBqKuXVBZbi24h77Q
        0txuzkeZ/7ympi7IqOGAm7KiSUdZFpbCxkERrnLWgK1lZTJBsnqDqb9QyfZFvfKb/F/r4Zhha9act
        jihYY0z4IwITwqpVtNbQL2+n4DLvU+Vst1ZWRh2sbibY7gNlo7WN0wYJ4FZkT6uOasLiQH8bqriUs
        fUoeRJusQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRC98-00044W-8d; Mon, 26 Nov 2018 08:21:34 +0000
Date:   Mon, 26 Nov 2018 00:21:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 5/5] arch: simplify several early memory allocations
Message-ID: <20181126082134.GA10530@infradead.org>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
>  {
> -	void *ptr = __va(memblock_phys_alloc(sz, align));
> -	memset(ptr, 0, sz);
> -	return ptr;
> +	return memblock_alloc(sz, align);
>  }

What is the point of keeping this wrapper?

>  static void __init *early_alloc(unsigned long sz)
>  {
> -	void *ptr = __va(memblock_phys_alloc(sz, sz));
> -	memset(ptr, 0, sz);
> -	return ptr;
> +	return memblock_alloc(sz, sz);
>  }

Same here.
