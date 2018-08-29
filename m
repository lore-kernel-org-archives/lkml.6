Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7DC20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7DC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeH2QPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:15:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbeH2QPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BC12402315B;
        Wed, 29 Aug 2018 12:18:59 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D263D2166B41;
        Wed, 29 Aug 2018 12:18:58 +0000 (UTC)
Date:   Wed, 29 Aug 2018 20:18:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to
 paging mode
Message-ID: <20180829121856.GB1885@192.168.1.4>
References: <20180829021754.21850-1-bhe@redhat.com>
 <20180829021754.21850-2-bhe@redhat.com>
 <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829120530.6dhgsautjjrj4ztt@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 12:18:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 12:18:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
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
> 
> I think we can limit it further by taking into account memory_tb. Most of
> machines will be fine with 1TiB there and we save few more bits from
> KASLR.

Oh, do you mean to make a calculation according to the actual size of
system RAM? And still taking 1TB as default, then adapt later by RAM? 

Then, no need to introduce VMEMMAP_SIZE_TB, this also looks good to me.

Thanks
Baoquan
