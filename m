Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA47C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F84724E87
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F84724E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGBS4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:56:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:35476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753162AbeGBS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:56:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3EC9AD2E;
        Mon,  2 Jul 2018 18:56:15 +0000 (UTC)
Date:   Mon, 2 Jul 2018 20:56:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] mm: teach dump_page() to correctly output poisoned
 struct pages
Message-ID: <20180702185612.GJ19043@dhcp22.suse.cz>
References: <20180702180536.2552-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702180536.2552-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 14:05:36, Pavel Tatashin wrote:
[...]
>  void __dump_page(struct page *page, const char *reason)
>  {
> +	bool page_poisoned = PagePoisoned(page);
> +	int mapcount;
> +
> +	/*
> +	 * If struct page is poisoned don't access Page*() functions as that
> +	 * leads to recursive loop. Page*() check for poisoned pages, and calls
> +	 * dump_page() when detected.
> +	 */
> +	if (page_poisoned) {
> +		pr_emerg("page:%px is uninitialized and poisoned", page);
> +		goto hex_only;
> +	}

Thanks for the updated comment. Exactly what I was looking for!
-- 
Michal Hocko
SUSE Labs
