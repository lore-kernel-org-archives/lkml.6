Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9206BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C8F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ce/ILpdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C8F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeGaCWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:22:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGaCWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2QT5qkxa4hIxAcKtQM3f0aUFrGje52f7KuS4xVzw8FM=; b=ce/ILpdjOH2YMzTmY1+y6rOxW
        4OR0h5h02/sXOnBgH5BCSMu61QKvi0lZIZ9mVvJOZ75LEinyUJUs26HuIzCvu+TXuQrHdaltENWwN
        kftt0nD2gPiveZldzvgz08XAfAzIjBii19gugkFb//ekeg1vzW7Wg0Zi2c1AeSRp4keaUHzk6YFWo
        3pAdsQjaUFY6KTnFz6Y18vbtPfNu8eH0un2xt5fS7vDjUZ1BE5pXFGKDPcWGpSlPzVB0hrA/tkwpm
        M80P6kZWbTPRo4clvzonQNYqkFd+v3PCbAyDjiLLK8+dPvpMlPbnJVZ1shoYgDSC0I4Scn7aXQE1R
        SCtVsorKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkIme-0000q2-86; Tue, 31 Jul 2018 00:45:04 +0000
Date:   Mon, 30 Jul 2018 17:45:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Message-ID: <20180731004504.GB19692@bombadil.infradead.org>
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com>
 <20180730162926.GD11890@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730162926.GD11890@nazgul.tnic>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:29:27PM +0200, Borislav Petkov wrote:
> > +EXPORT_SYMBOL(__clear_page_nt)
> 
> EXPORT_SYMBOL_GPL like the other functions in that file.

Actually, __clear_page_nt doesn't need to be exported at all for this
patch set; it's not invoked from a module.
