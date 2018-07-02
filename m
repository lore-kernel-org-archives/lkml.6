Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B056DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6433B2504E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fszUa4yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433B2504E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeGBUdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:33:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeGBUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+l+loOYFVRC/LmvQ+sJhqUFloWFSZOBmg40ommuB4BY=; b=fszUa4yOzJyVKK+p/mF9M2TPm
        8e0XjT8yjy2uXIXG0U502Y7dvO6HmUe086xgIDg63/MGo054ZPec2iSzz0N5TCkIwLtnpC0fOMzah
        Z4KxaN0fd8Stw3BOIw9Q0LVcjKZc+Llbp62ThZ8nAwJqgTqUJV0oyXT86e7Chm+V7QMJHsY5J636S
        adzq3NvADLOL8ZvpKJ+ZTd+n0vrHtV4D0/Bc6fEuiPxrm8do004dJ5Kkdr/OaIzcV7CQKqmiilkt6
        hPLnt/get0qx8xcrdjYw/haCMUbJZae8AQwReONDgSp9apfvVGP/xr4laAYZ7aKjuFOAJjw2sTl6G
        Rc/kTg5eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5Vh-0003A5-6R; Mon, 02 Jul 2018 20:33:21 +0000
Date:   Mon, 2 Jul 2018 13:33:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kostya Serebryany <kcc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        cl@linux.com, mark.rutland@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        marc.zyngier@arm.com, dave.martin@arm.com,
        ard.biesheuvel@linaro.org, ebiederm@xmission.com, mingo@kernel.org,
        Paul Lawrence <paullawrence@google.com>, geert@linux-m68k.org,
        arnd@arndb.de, kirill.shutemov@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        rppt@linux.vnet.ibm.com, kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>, cpandya@codeaurora.org,
        Vishwath Mohan <vishwath@google.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-ID: <20180702203321.GA8371@bombadil.infradead.org>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:04:28PM -0700, Kostya Serebryany wrote:
> The problem is more significant on mobile devices than on desktop/server.
> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
> doesn't have an analog of aarch64's top-byte-ignore hardware feature.

Well, can we emulate it in software?

We've got 48 bits of virtual address space on x86.  If we need all 8
bits, then that takes us down to 40 bits (39 bits for user and 39 bits
for kernel).  My laptop only has 34 bits of physical memory, so could
we come up with a memory layout which works for me?
