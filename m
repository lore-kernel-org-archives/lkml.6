Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09442146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jSlsVUtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09442146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeLADe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:34:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLADe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P0ZOugyMlnKj+NkZlXijcTkkjHK+ttJiBPhe82ZjmJ0=; b=jSlsVUtY+m3I6zPUn9Hyhosa7
        pv+f51J+wDEnbvu1qSm79x2+I5a0sULnE92GHedKnkqfTeczxXfxVSecBMOwF59iSzudoWzS/IZcV
        82co6yRQjjSnCaHwHhHabJIDQZrvTfhfz9dQdnemqEjEuYq89i0BCipw0HO7U73NFv/iR5hAsbWXS
        vn5AUoVKNgohkBNzycw8yVWLjNZ6EC9IYSE40Afdq/+3UpL1JaIN1ZUjCP9ZyhZxp0UKOPzfPS9bC
        PBruKpA0WqZd4lwtt2ophMR6S0tlH/iAUF7Uir3mPa+iC63twiq2pBjGARnk9Ibh7Cy3tAkwSvCFm
        0W7Y/tRzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSlal-000394-EH; Fri, 30 Nov 2018 16:24:35 +0000
Date:   Fri, 30 Nov 2018 08:24:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
Message-ID: <20181130162435.GM10377@bombadil.infradead.org>
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org>
 <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 07:54:49AM -0800, Dan Williams wrote:
> Looks good to me, although can we make that cookie an actual type? I
> think it's mostly ok to pass around (void *) for 'entry' inside of
> fs/dax.c, but once an entry leaves that file I'd like it to have an
> explicit type to catch people that might accidentally pass a (struct
> page *) to the unlock routine.

That's a really good idea.  Something like this?

typedef struct {
	void *v;
} dax_entry_t;

I could see us making good use of that within dax.c.
