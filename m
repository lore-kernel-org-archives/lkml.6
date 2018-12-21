Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820FDC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3669021927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOJCF+U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbeLUVHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:07:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeLUVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OEXYdZpJ5heyKiGxKBrWzRjppUh95Jb5QndoCrwt2F8=; b=bOJCF+U1k/EoJ9awRM6H5P3LM
        Yp7qS32fCkyR6Xo0DyVeND+KyLmIi7nZTIa9R7bgtuBokRoJ+hYdGAqEJcMUiho5AQheuOF9B8QtM
        /J/9BHGQKrd+UWVKpWLzD/kXXYUVt8YSLvf82QBr+yN0bUgjx98IrqyKzaQ064/eoEVOkz4B0aoVI
        YUrvASvjGW+zfeadf9VpUhfv/HhHgW0VgQUbfgHnwIrAW5SRMUlF8Z1N4rjYNK67ZvUl74A7kHjbA
        YdR7P0HKNICTkQzLO1OdpInYonm/rwDmJtLx23fRBat4+IPguyksMzJ8X8ttJkPu0E1fK/wc1ccO+
        j+cw3XA+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaS0v-0000b0-Ui; Fri, 21 Dec 2018 21:07:21 +0000
Date:   Fri, 21 Dec 2018 13:07:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221210721.GK10600@bombadil.infradead.org>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
 <20181221200546.GA8441@uranus>
 <20181221202946.GJ10600@bombadil.infradead.org>
 <20181221204616.GC8441@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221204616.GC8441@uranus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:46:16PM +0300, Cyrill Gorcunov wrote:
> Cast to unsigned char is needed in any case. And as far as I remember
> we've been using this multiplication trick for a really long time
> in x86 land. I'm out of sources right now but it should be somewhere
> in assembly libs.

x86 isn't the only CPU.  Some CPUs have slow multiplies but fast shifts.
Also loading 0x0101010101010101 into a register may be inefficient on
some CPUs.
