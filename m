Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9FDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16856205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pw+00wzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16856205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935166AbeFRRJZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:09:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFRRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZrPnQq4umouBs46TQGYjkqkDknGgQGaqGKMu2GoGPS4=; b=Pw+00wzUl68/g9ibPj7YZxdse
        DRBQpit46IgV/CZbBSIHZZCUn7P0eUoCI2DpyX9WZaw1pbtyTP5MolR3A6DGFCgpex4CSvK7k22Dd
        +ae1gVwfkrU4d6C4VjXPbr2NiJuOkjjhly7kwToHNg3NOyxabpjnQiakKaxO8vll7xj5oX1mh/wwO
        0ioXbuhjuNgePGnTZGPazEbwzO1jtIZY4RlAqfmlJm9VW0GeYbztbzu9TZ4HYc/lqOupmLOPvanA+
        5GUMGWIWkzoJ6kH6VNdnMx8e4ypl12EY8V2OoyYZ1rOyNdVv7NceJHcnsQ4LIS22w5eHwi62uW30e
        ozFLywTKg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUxea-0003ld-LJ; Mon, 18 Jun 2018 17:09:20 +0000
Date:   Mon, 18 Jun 2018 10:09:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20180618170920.GC28748@bombadil.infradead.org>
References: <20180618132712.4b4eddc9@canb.auug.org.au>
 <CAPcyv4idNE8ErxNm5bb3rG4jUeZU9HJRmO03omMJxSN-8FYN+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4idNE8ErxNm5bb3rG4jUeZU9HJRmO03omMJxSN-8FYN+w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:50:33AM -0700, Dan Williams wrote:
> On Sun, Jun 17, 2018 at 8:27 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > After merging the xarray tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
[...]
> > from the nvdimm tree.
> >
> > Willy thanks for the heads up about this.
> >
> > I have applied the following merge fix patch (taken from the diff between
> > the -next tree at this point and the xarray-20180615 branch from the
> > xarray tree) for today.
> 
> I was hoping that dax_lock_page() and the memory_failure() handling
> could go in before the xarray rework. This helps -stable and distros
> that need to backport this error handling support. Willy, would you be
> amenable to rebasing on top of the next rev of the
> dax+memory_failure() work?
> 
> Apologies for the thrash.

I am absolutely amenable to rebasing.  The only problem is that I'm
in Tokyo for the next two weeks.  I can put some work in on this, but
coordination may be a little off.  If somebody else wants to do the work,
the only (serious) difference between the xarray-20180615 and xarray
branches in my repo is that the former is based on the dax_lock_page()
changes having gone in.

The differences sum up to:

+@@ -414,8 +413,7 @@ struct page *dax_lock_page(unsigned long pfn)
+ 
+               entry = __radix_tree_lookup(&mapping->i_pages, index, NULL,
+                               &slot);
+-              if (!entry ||
+-                  WARN_ON_ONCE(!radix_tree_exceptional_entry(entry))) {
++              if (!entry || WARN_ON_ONCE(!xa_is_value(entry))) {
+                       xa_unlock_irq(&mapping->i_pages);
+                       break;
+               } else if (!slot_locked(mapping, slot)) {

(in "xarray: Replace exceptional entries")

then dax_entry_waitqueue() changing its argument in "dax: Hash on XArray instead of mapping".

and finally the patch converting dax_lock_page() and dax_unlock_page().

I really wanted to keep the thrash here to a minimum, but this is the
best I could come up with in terms of minimising conflicts :-(
