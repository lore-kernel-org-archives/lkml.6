Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B113CC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8612080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LzzXd638"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfBDTLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:11:51 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17236 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBDTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:11:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c588e560000>; Mon, 04 Feb 2019 11:11:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 11:11:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Feb 2019 11:11:48 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 4 Feb
 2019 19:11:48 +0000
Subject: Re: [PATCH 4/6] mm/gup: track gup-pinned pages
To:     Matthew Wilcox <willy@infradead.org>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <20190204052135.25784-5-jhubbard@nvidia.com>
 <20190204181944.GD21860@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f99faa07-5139-602f-dac5-3f72f16632e4@nvidia.com>
Date:   Mon, 4 Feb 2019 11:11:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204181944.GD21860@bombadil.infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549307478; bh=WJmOpp9hjc5i9FcdMolKyZT9L4tb15BeDAuReza4xvo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LzzXd638u1XMmc+ElbDj1YOanoDeGKHAdwbB4+O7StuXZJE3+DtthQyzUge3Cy/1i
         NTwlka1kfeKHNp722TaLkL/+Zgw+xv4LTc1MEZy90zZwbUHCQQRCWTRQdd47B+kRRO
         lixXxP5Wo4PIIgxfTIb7aDkNOrSAIUCmugEwjvnIpbGj9tNOgA1v+SBBLIS16L7cQB
         hI+V0E/XispNBrQ5DPaccPToIUpaekPPsStWy0a1WH63K6wSNw9v3wyeuxgPNOcRGH
         6BNWkB3sZlziejAvgJoColb5Lg2au/n3e6AGqaormGN0LtHtVP+sSlp5YstQoL51+q
         HqSFul0QqR9mg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 10:19 AM, Matthew Wilcox wrote:
> On Sun, Feb 03, 2019 at 09:21:33PM -0800, john.hubbard@gmail.com wrote:
>> +/*
>> + * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
>> + * the page's refcount so that two separate items are tracked: the original page
>> + * reference count, and also a new count of how many get_user_pages() calls were
>> + * made against the page. ("gup-pinned" is another term for the latter).
>> + *
>> + * With this scheme, get_user_pages() becomes special: such pages are marked
>> + * as distinct from normal pages. As such, the new put_user_page() call (and
>> + * its variants) must be used in order to release gup-pinned pages.
>> + *
>> + * Choice of value:
>> + *
>> + * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
>> + * counts with respect to get_user_pages() and put_user_page() becomes simpler,
>> + * due to the fact that adding an even power of two to the page refcount has
>> + * the effect of using only the upper N bits, for the code that counts up using
>> + * the bias value. This means that the lower bits are left for the exclusive
>> + * use of the original code that increments and decrements by one (or at least,
>> + * by much smaller values than the bias value).
>> + *
>> + * Of course, once the lower bits overflow into the upper bits (and this is
>> + * OK, because subtraction recovers the original values), then visual inspection
>> + * no longer suffices to directly view the separate counts. However, for normal
>> + * applications that don't have huge page reference counts, this won't be an
>> + * issue.
>> + *
>> + * This has to work on 32-bit as well as 64-bit systems. In the more constrained
>> + * 32-bit systems, the 10 bit value of the bias value leaves 22 bits for the
>> + * upper bits. Therefore, only about 4M calls to get_user_page() may occur for
>> + * a page.
> 
> The refcount is 32-bit on both 64 and 32 bit systems.  This limit
> exists on both sizes of system.
> 

Oh right, I'll just delete that last paragraph, then. Thanks for catching that.


thanks,
-- 
John Hubbard
NVIDIA
