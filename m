Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5564F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5564F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeH2QNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:13:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeH2QNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DE49B5CA;
        Wed, 29 Aug 2018 12:16:28 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BF83A9EF1;
        Wed, 29 Aug 2018 12:16:27 +0000 (UTC)
Date:   Wed, 29 Aug 2018 20:16:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180829121624.GA1885@192.168.1.4>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 12:16:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 12:16:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/18 at 03:05pm, Kirill A. Shutemov wrote:
> On Wed, Aug 29, 2018 at 10:17:54AM +0800, Baoquan He wrote:
> > Vmemmap area has different base and size depending on paging mode.
> > Now we just hardcode its size as 1TB in memory KASLR, it's not
> > right for 5-level paging mode.
> > 
> > Adjust it according to paging mode and use it during memory KASLR.
> > 
> 
> I think 512TiB is wasteful for 5-level paging. We don't need that much.
> 
> 1TiB limit with 4-level paging is required to fit struct pages for all
> 64TiB of physical memory, assuming each struct page is 64 bytes.
> 
> With 5-level paging the limit on physical memory is not 512-times bigger:
> we cap at 52-bit physical address space. So it's just 64 times bigger and
> we need only 64TiB in worst case.

Thanks, Kirill.

Exactly, the current 5-level only costs 64TB for vmemmap at most. I just
copy 512TB from Documentation/x86/x86_64/mm.txt. It might develop very
quickly to need enlarge RAM space to exceed 52bit in the future. And
KASLR and KASAN are mutually exclusive. With KASLR enabled, we can take
another 8PB space reserved for KASAN. So taking 512TB here might not
mitigate KASLR. This is my thought for this fix. But I am also fine to
change it to be 64TB for 5-level paging mode. I can change it with your
idea and repost.

Thanks
Baoquan

