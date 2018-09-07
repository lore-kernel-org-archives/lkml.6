Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09368C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A1D2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A1D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeIGRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:49:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbeIGRtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB29B400E9A8;
        Fri,  7 Sep 2018 13:08:38 +0000 (UTC)
Received: from treble (ovpn-125-2.rdu2.redhat.com [10.10.125.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A42AB2026D76;
        Fri,  7 Sep 2018 13:08:38 +0000 (UTC)
Date:   Fri, 7 Sep 2018 08:08:37 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] objtool: Support multiple rodata sections.
Message-ID: <20180907130837.mjbfmqffhoevjuep@treble>
References: <20180829170412.8248-1-allan.x.xavier@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829170412.8248-1-allan.x.xavier@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 13:08:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 13:08:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:04:12PM +0100, Allan Xavier wrote:
> This commit adds support for processing switch jump tables in objects
> with multiple .rodata sections, such as those created when using
> -ffunction-sections and -fdata-sections.  Currently, objtool always
> looks in .rodata for jump table information which results in many
> "sibling call from callable instruction with modified stack frame"
> warnings with objects compiled using those flags.
> 
> The fix is comprised of three parts:
> 
> 1. Flagging all .rodata sections when importing elf information for
> easier checking later.
> 
> 2. Keeping a reference to the section each relocation is from in order
> to get the list_head for the other relocations in that section.
> 
> 3. Finding jump tables by following relocations to .rodata sections,
> rather than always referencing a single global .rodata section.
> 
> The patch has been tested without data sections enabled and no
> differences in the resulting orc unwind information were seen.
> 
> Note that as objtool adds terminators to end of each .text section the
> unwind information generated between a function+data sections build and
> a normal build aren't directly comparable. Manual inspection suggests
> that objtool is now generating the correct information, or at least
> making more of an effort to do so than it did previously.
> 
> Signed-off-by: Allan Xavier <allan.x.xavier@oracle.com>
> ---
> 
> Changes since v2:
> - Reworked and commented mark_rodata as suggested.
> 
> Changes since v1:
>  - Cleaned up section symbol check.
>  - Fixed brackets.
>  - Moved mark_rodata to decode_sections().
>  - Excluded *.str1.[18] sections from rodata sections.

Thanks, looks good.  I'll submit it to the -tip tree.

-- 
Josh
