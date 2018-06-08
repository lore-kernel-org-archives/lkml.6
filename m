Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id thZ3E4uqGlvCTgAAmS7hNA
	; Fri, 08 Jun 2018 16:12:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 993A2607DC; Fri,  8 Jun 2018 16:12:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E210C601B4;
	Fri,  8 Jun 2018 16:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E210C601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeFHQMX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752075AbeFHQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:12:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8015740252EB;
        Fri,  8 Jun 2018 16:12:21 +0000 (UTC)
Received: from treble (ovpn-120-53.rdu2.redhat.com [10.10.120.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A5C42026DFD;
        Fri,  8 Jun 2018 16:12:21 +0000 (UTC)
Date: Fri, 8 Jun 2018 11:12:19 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180608161219.q3lwvlydvs4l2gxa@treble>
References: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419051510.GA21898@mwanda>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 16:12:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 16:12:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:15:10AM +0300, Dan Carpenter wrote:
> Several people have asked me to write this and I think one person was
> maybe working on writing it themselves...
> 
> The point of this check is to find place which might be vulnerable to
> the Spectre vulnerability.  In the kernel we have the array_index_nospec()
> macro which turns off speculation.  There are fewer than 10 places where
> it's used.  Meanwhile this check complains about 800 places where maybe
> it could be used.  Probably the 100x difference means there is something
> that I haven't understood...
> 
> What the test does is it looks at array accesses where the user controls
> the offset.  It asks "is this a read?" and have we used the
> array_index_nospec() macro?  If the answers are yes, and no respectively
> then print a warning.
> 
> http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c
> 
> The other thing is that speculation probably goes to 200 instructions
> ahead at most.  But the Smatch doesn't have any concept of CPU
> instructions.  I've marked the offsets which were recently compared to
> something as "local cap" because they were probably compared to the
> array limit.  Those are maybe more likely to be under the 200 CPU
> instruction count.
> 
> This obviously a first draft.
> 
> What would help me, is maybe people could tell me why there are so many
> false positives.  Saying "the lower level checks for that" is not
> helpful but if you could tell me the exact function name where the check
> is that helps a lot...
> 
> I have included the warnings from yesterday's linux-next.

Hi Dan,

Smatch is amazing.  I've been going through a lot of the results.  The
false positive rate is much lower than I expected.

I have a few questions/comments.

1) I've noticed a common pattern for many of the false positives.
   Smatch doesn't seem to detect when the code masks off the array index
   to ensure that it's safe.

   For example:

   > ./include/linux/mmzone.h:1161 __nr_to_section() warn: potential spectre issue 'mem_section[(nr / (((1) << 12) / 32))]'

   1153 static inline struct mem_section *__nr_to_section(unsigned long nr)
   1154 {
   1155 #ifdef CONFIG_SPARSEMEM_EXTREME
   1156         if (!mem_section)
   1157                 return NULL;
   1158 #endif
   1159         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
   1160                 return NULL;
   1161         return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
   1162 }

   In the 2-D array access, it seems to be complaining about the '[nr &
   SECTION_ROOT_MASK]' reference.  But that appears to be safe because
   all the unsafe bits are masked off.
 
   It would be great if Smatch could detect that situation if possible.

2) Looking at the above example, it seems that the value of 'nr' is
   untrusted.  If so, then I wonder why didn't it warn about the other
   array accesses in the function: line 1559 and the first dimension
   access in 1161?

3) One thing that I think would help with analyzing the results would be
   if there was a way to see the call chain for each warning, so that
   it's clear which value isn't trusted and why.

4) Is there a way to put some results in a whitelist to mark them as
   false positives so they won't show up in future scans?  Something
   like that would help with automatic detection and reporting of new
   issues by the 0-day kbuild test robot, for example.

-- 
Josh
