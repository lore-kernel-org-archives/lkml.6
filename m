Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3I9AEaLfGlvDCQAAmS7hNA
	; Fri, 08 Jun 2018 19:57:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D9A3607A4; Fri,  8 Jun 2018 19:57:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 902C8601C3;
	Fri,  8 Jun 2018 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 902C8601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeFHT5T (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:57:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeFHT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:57:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1DBDEC97;
        Fri,  8 Jun 2018 19:57:18 +0000 (UTC)
Date: Fri, 8 Jun 2018 12:57:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
Message-Id: <20180608125717.c34d3e7125c62fc91ac427c8@linux-foundation.org>
In-Reply-To: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Jun 2018 14:56:52 -0400 Jason Baron <jbaron@akamai.com> wrote:

> In order to free memory that is marked MLOCK_ONFAULT, the memory region
> needs to be first unlocked, before calling MADV_DONTNEED. And if the region
> is to be reused as MLOCK_ONFAULT, we require another call to mlock2() with
> the MLOCK_ONFAULT flag.
> 
> Let's simplify freeing memory that is set MLOCK_ONFAULT, by allowing
> MADV_DONTNEED to work directly for memory that is set MLOCK_ONFAULT. The
> locked memory limits, tracked by mm->locked_vm do not need to be adjusted
> in this case, since they were charged to the entire region when
> MLOCK_ONFAULT was initially set.

Seems useful.

Is a manpage update planned?

Various updates to tools/testing/selftests/vm/* seem appropriate.

> Further, I don't think allowing MADV_FREE for MLOCK_ONFAULT regions makes
> sense, since the point of MLOCK_ONFAULT is for userspace to know when pages
> are locked in memory and thus to know when page faults will occur.

This sounds non-backward-compatible?
