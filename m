Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC4920663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfB0VcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:32:11 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:42112 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfB0VcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:32:11 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 90D6C43ED; Wed, 27 Feb 2019 22:32:09 +0100 (CET)
Date:   Wed, 27 Feb 2019 22:32:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, hughd@google.com, kirill@shutemov.name,
        vbabka@suse.cz, joel@joelfernandes.org, jglisse@redhat.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net
Subject: Re: [PATCH] mm,mremap: Bail out earlier in mremap_to under map
 pressure
Message-ID: <20190227213205.5wdjucqdgfqx33tr@d104.suse.de>
References: <20190226091314.18446-1-osalvador@suse.de>
 <20190226140428.3e7c8188eda6a54f9da08c43@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226140428.3e7c8188eda6a54f9da08c43@linux-foundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 02:04:28PM -0800, Andrew Morton wrote:
> How is this going to affect existing userspace which is aware of the
> current behaviour?

Well, current behavior is not really predictable.
Our customer was "surprised" that the call to mremap() failed, but the regions
got unmapped nevertheless.
They found it the hard way when they got a segfault when trying to write to those
regions when cleaning up. 

As I said in the changelog, the possibility for false positives exists, due to
the fact that we might get rid of several vma's when unmapping, but I do not
expect existing userspace applications to start failing.
Should be that the case, we can revert the patch, it is not that it adds a lot
of churn.

> And how does it affect your existing cleanup code, come to that?  Does
> it work as well or better after this change?

I guess the customer can trust more reliable that the maps were left untouched.
I still have my reserves though.

We can get as far as move_vma(), and copy_vma() can fail returning -ENOMEM.
(Or not due to the "too small to fail" ?)

-- 
Oscar Salvador
SUSE L3
