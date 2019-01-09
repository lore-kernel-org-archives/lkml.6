Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E246C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13974206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m55UTsH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfAIMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:14:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfAIMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MsqdlZbisRBCTK/NvhVywIGrWksr2rkv3CdCXPuM/Fw=; b=m55UTsH9qk0hZQ+xVTu9VijX5
        MM5aQjug4xoknDeD13TH3vy4yXPZIbhCAkmxUk2tQTZlzZJiBL2J9lWdywZt+7lu9ikxsUi0G7dyV
        P1uNY3Z2wFIAgSVABFnHTg89BFN488+vmIEeaSXqkzoUFLmTpQgqrVDVx0esVCkLmPESyAdthMX74
        n6KLaE+RsQgz4O+hfBD63JainCpTagOATsBx171qclXkyYFat8H2QPFlOKt10E0duEh31BOTBNiVu
        D000dTzKIeyJLHeNlxuNsPJQWLBbVWqUxdz2DpWn3PXTUF+ykGLSEeZLophOBUJmRT5y9jUmREa6L
        E24lJ6EpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghCk4-0006Yz-Uw; Wed, 09 Jan 2019 12:13:52 +0000
Date:   Wed, 9 Jan 2019 04:13:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub.c: re-randomize random_seq if necessary
Message-ID: <20190109121352.GI6310@bombadil.infradead.org>
References: <20190109090628.1695-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109090628.1695-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:06:27PM +0800, Peng Wang wrote:
> calculate_sizes() could be called in several places
> like (red_zone/poison/order/store_user)_store() while
> random_seq remains unchanged.
> 
> If random_seq is not NULL in calculate_sizes(), re-randomize it.

Why do we want to re-randomise the slab at these points?
