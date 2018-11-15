Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA693C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E272146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M87ULwt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E272146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeKOSxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:53:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeKOSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8nEbJju+rUzbJ+6KzlXBDQ226HeIRdAG+2LaO/VFVr8=; b=M87ULwt8gsHNWDW2BfpxsQRrp
        jc4PA2oiw1s+gWB1+6NUtrqJsRXpZC1pu9G6khX29YRbjoY5wWLxsBScfYR9t63EWJkJThKp0UF9K
        f46aWxMLVtX/z5cqCYr6ncSemiMItWnoVkhvwsZuXCPj7KyZSUsoOHXPChPT1vK0MeVehNgqwqYfS
        M/x352O/+QyeRZDP/NsaK8817fyu8nq42cgM4ooBBpo4jnw18gMOcBReW4f2IFPpzivu6gzwxQ0DD
        Tgis8MxR2S6k7o7BTPBbSa+77PV8Uy+ctI64Kg6LyEmpuvwzS2WsI39TelR7+MCxWMlG7ZAKtcdTw
        Bx65Yw3sg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNDIQ-0000q7-B2; Thu, 15 Nov 2018 08:46:42 +0000
Date:   Thu, 15 Nov 2018 00:46:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-ID: <20181115084642.GB19286@bombadil.infradead.org>
References: <20181113151629.14826-1-urezki@gmail.com>
 <20181113151629.14826-2-urezki@gmail.com>
 <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
 <20181114151737.GA23419@dhcp22.suse.cz>
 <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
 <20181115083957.GE23831@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115083957.GE23831@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:39:57AM +0100, Michal Hocko wrote:
> On Wed 14-11-18 15:00:53, Andrew Morton wrote:
> > #define EXPORT_SYMBOL_SELFTEST EXPORT_SYMBOL_GPL
> >
> > then write a script which checks the tree for usages of the
> > thus-tagged symbols outside tools/testing and lib/ (?)
> 
> and then yell at people? We can try it out of course. The namespace
> would be quite clear and we could document the supported usage pattern.
> We also want to make EXPORT_SYMBOL_SELFTEST conditional. EXPORTs are not
> free and we do not want to add them if the whole testing infrastructure
> is disabled (assuming there is a global one for that).

How about adding

#ifdef CONFIG_VMALLOC_TEST
int run_internal_vmalloc_tests(void)
{
...
}
EXPORT_SYMBOL_GPL(run_internal_vmalloc_tests);
#endif

to vmalloc.c?  That would also allow calling functions which are marked
as static, not just functions which aren't exported to modules.
