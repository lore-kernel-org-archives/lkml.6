Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B1DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041921762
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="y3gnxh+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F041921762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeHMNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:40:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39728 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbeHMNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:40:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so7344494pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZuxAIN/3RwIR+KPVodlSMQ+5/sOizY5WeQimLTvJSc=;
        b=y3gnxh+nTElj6u8tizhWztHxMXfXlMytSm1Kc2LrMacJDeqlZW4T1Z20yhKGkyTQqW
         ulTy5rDRO5XVnO/L8H8FpB0QmX2Y9A19+/T3XxNr4bc0MYx1EHT4q1BvIAjdlJsnPCDc
         fLaG0jQDLUZx+vIpCYaoFheYoJ6UW9iFV6toPGJz+htwyoDoCWvEJQIK2rZRfwY8uHuo
         1PlAkadZHdUYXOYHtRxw9T2PsOc2QTPmbdv4p/7McTIa8Mt5jiF6oBppv4GF0Yso38IC
         vt0AHSjWpmrvxM1+WhTBPnztVwusEWMbI34ODvqQtwHFvyA123oUeo1zrONYdyKct7SI
         DeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZuxAIN/3RwIR+KPVodlSMQ+5/sOizY5WeQimLTvJSc=;
        b=ZBkh5nirMG0D/h2TbgNyU4Vk85pl8XCZUSRGDg2pzZpbvwdnY4+bTAIFI5GOB4Dhy+
         Mngd1ZAkFz+uC91O4hTbIYoqS13z301q0Pa4w1a11rPQuce+Ehu/JvVFVTTVOB4v0t5U
         zklLoEIlBmw8egSOl/flewnJD8oVAdps0c9UtwIDsSFNupSdWXu6RexZUxC9Z097e59O
         Hc/eKlggL/rrFB7vvCM2u2JScEHbCDpGl6Y71IYiZ7ermfZq7QQJuU8+o2oSRihvi5Z1
         Ny+BxoIgNYlzT38NrXRenulr1KxOikixWPvGwshpTqL7Z1+UuyDVT9l29lZQwvAvJ76f
         JA1A==
X-Gm-Message-State: AOUpUlFVo/dHb1kej4J+Q0tZfZZIUAM+cWLdihDcgMzGIZKdZEc6oxYw
        mIZ2IwIcxhgIeSsVofT6CFYxvw==
X-Google-Smtp-Source: AA+uWPzWbfK35togUaoB3tKcMrstBDDRXp5lFuAjRIqB3l4yyFy7UA2qS17n90y/f2gJXSTSCqPIJQ==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr16188568pgb.95.1534157906361;
        Mon, 13 Aug 2018 03:58:26 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id p73-v6sm34511626pfk.186.2018.08.13.03.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 03:58:25 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5417E3000A7; Mon, 13 Aug 2018 13:58:21 +0300 (+03)
Date:   Mon, 13 Aug 2018 13:58:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: migration: fix migration of huge PMD shared pages
Message-ID: <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
References: <20180813034108.27269-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813034108.27269-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 08:41:08PM -0700, Mike Kravetz wrote:
> The page migration code employs try_to_unmap() to try and unmap the
> source page.  This is accomplished by using rmap_walk to find all
> vmas where the page is mapped.  This search stops when page mapcount
> is zero.  For shared PMD huge pages, the page map count is always 1
> not matter the number of mappings.  Shared mappings are tracked via
> the reference count of the PMD page.  Therefore, try_to_unmap stops
> prematurely and does not completely unmap all mappings of the source
> page.
> 
> This problem can result is data corruption as writes to the original
> source page can happen after contents of the page are copied to the
> target page.  Hence, data is lost.
> 
> This problem was originally seen as DB corruption of shared global
> areas after a huge page was soft offlined.  DB developers noticed
> they could reproduce the issue by (hotplug) offlining memory used
> to back huge pages.  A simple testcase can reproduce the problem by
> creating a shared PMD mapping (note that this must be at least
> PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
> migrate_pages() to migrate process pages between nodes.
> 
> To fix, have the try_to_unmap_one routine check for huge PMD sharing
> by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
> shared mapping it will be 'unshared' which removes the page table
> entry and drops reference on PMD page.  After this, flush caches and
> TLB.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> I am not %100 sure on the required flushing, so suggestions would be
> appreciated.  This also should go to stable.  It has been around for
> a long time so still looking for an appropriate 'fixes:'.

I believe we need flushing. And huge_pmd_unshare() usage in
__unmap_hugepage_range() looks suspicious: I don't see how we flush TLB in
that case.

-- 
 Kirill A. Shutemov
