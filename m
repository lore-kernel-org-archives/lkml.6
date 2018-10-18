Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D80ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1121476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJRMbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:31:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41882 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJRMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:31:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCzya-0007M8-QA; Thu, 18 Oct 2018 04:32:00 +0000
Date:   Thu, 18 Oct 2018 05:32:00 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Hongzhi, Song" <hongzhi.song@windriver.com>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Question about mmap syscall and POSIX standard on mips arch
Message-ID: <20181018043200.GE32577@ZenIV.linux.org.uk>
References: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[mips folks Cc'd]

On Thu, Oct 18, 2018 at 11:26:02AM +0800, Hongzhi, Song wrote:
> Hi all,
> 
> Ltp has a POSIX teatcase about mmap, 24-2.c.
> 
> https://github.com/linux-test-project/ltp/blob/e816127e5d8efbff5ae53e9c2292fae22f36838b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c#L94

[basically, MAP_FIXED mmap with addr + len > TASK_SIZE fails with
-EINVAL on mips and -ENOMEM elsewhere]
 
> Under POSIX standard, the expected errno should be ENOMEM
> 
> when the specific [addr+len] exceeds the bound of memory.

The mmap() function may fail if:

[EINVAL]
The addr argument (if MAP_FIXED was specified) or off is not a multiple
of the page size as returned by sysconf(), or is considered invalid by
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
the implementation.
^^^^^^^^^^^^^^^^^^^

So that behaviour gets past POSIX.  That part is mostly about the
things like cache aliasing constraints, etc., but it leaves enough
space to weasel out.  Said that, this

[ENOMEM]
MAP_FIXED was specified, and the range [addr,addr+len) exceeds that allowed
for the address space of a process; or, if MAP_FIXED was not specified and
there is insufficient room in the address space to effect the mapping.

is a lot more specific, so switching to -ENOMEM there might be a good idea,
especially since on other architectures we do get -ENOMEM in that case,
AFAICS.
