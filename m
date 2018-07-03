Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53983C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0846924897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0846924897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeGCUYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:24:13 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:47325 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752145AbeGCUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:24:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0A3591822408B;
        Tue,  3 Jul 2018 20:24:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg54_416689f6a434c
X-Filterd-Recvd-Size: 1828
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Jul 2018 20:24:09 +0000 (UTC)
Message-ID: <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 03 Jul 2018 13:24:07 -0700
In-Reply-To: <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
         <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 12:57 -0700, Andrew Morton wrote:
> Did you see all this checkpatch noise?
> 
> : WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
> : #54: FILE: mm/memblock.c:1348:
> : +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
> : +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> : +		     &max_addr, (void *)_RET_IP_);
> : ...

%p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67

I think it'd be simplest to just convert
all the %pF and %pf uses all at once.

$ git grep --name-only "%p[Ff]" | \
  xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'

and remove the appropriate Documentation bit.

