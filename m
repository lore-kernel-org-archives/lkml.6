Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27463C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E617421773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfS72XQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeLTIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbeLTIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PUxKvZ3nRgpmAu1KIWw+9VlfqH/pgkRRGLhzZ72s44c=; b=VfS72XQzNGnbcX9kKklRID8m0
        TXLbYVpMT6viemKcEHkxIJphTLCgxdIfp1zU2hPAGi65580Z+yNaX9DtbTVGmW9//y7lDCjfvzIdu
        uuhnqnTbKiAjmYicfOjPqWndFcdl9LYyMtShr5jQYQTBdKWsN51dR3eIt3JKYZ9l7DSn6K6rbSc2d
        DDDRxrm1Sq28nhcP+AEiXh/ET/iaGV0hYJc5CgI6DCXhcWNfFXbC7rxDRmZVK37lvSCbUUqtMHEki
        5OKSfkY8rzJyaVQxT/Q+SyZJgRFV8twYDl3RY9jmWPVyzWPEjraIBLLx1SXhmecb1POHqLvHf69mg
        UsR4J7BNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZtch-0006zW-DQ; Thu, 20 Dec 2018 08:24:03 +0000
Date:   Thu, 20 Dec 2018 00:24:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Map a second 8M text page at startup when
 needed.
Message-ID: <20181220082403.GA25436@infradead.org>
References: <27edd227d3b9dcda4e2ce7d00d9fddeb7a5520a1.1545241146.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27edd227d3b9dcda4e2ce7d00d9fddeb7a5520a1.1545241146.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:48:25AM +0000, Christophe Leroy wrote:
> Some debug setup like CONFIG_KASAN generate huge
> kernels with text size over the 8M limit.
> 
> This patch maps a second 8M page when _einittext is over 8M.

Do we also need a check to generate a useful warning if we ever overflow
the 16MB?
