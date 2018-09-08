Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CB9C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F10206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F10206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIHSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:19:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbeIHSTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61490804B4BA;
        Sat,  8 Sep 2018 13:33:42 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 642BB2166BA3;
        Sat,  8 Sep 2018 13:33:40 +0000 (UTC)
Date:   Sat, 8 Sep 2018 21:33:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of kalsr
 region initial size
Message-ID: <20180908133337.GT1740@192.168.1.3>
References: <20180829021754.21850-1-bhe@redhat.com>
 <alpine.DEB.2.21.1809081410230.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809081410230.1402@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 08 Sep 2018 13:33:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 08 Sep 2018 13:33:42 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 at 02:10pm, Thomas Gleixner wrote:
> On Wed, 29 Aug 2018, Baoquan He wrote:
> 
> > In memory KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate the
> > initial size of the direct mapping region. This is right in the
> > old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > 46bit, and only 4-level mode was supported.
> > 
> > Later, in commit:
> > b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> > __PHYSICAL_MASK_SHIFT was changed to be 52 always, no matter it's
> > 5-level or 4-level. This is wrong for 4-level paging. Then when
> > adapt phyiscal memory region size based on available memory, it
> > will overflow if the amount of system RAM and the padding is bigger
> > than 64TB.
> > 
> > In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> > by replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> This lacks a fixes tag .....

Sure, I will add fix tag in this patch, and arrange a new patchset
according to discussion with Kirill after test.

Thanks
Baoquan
