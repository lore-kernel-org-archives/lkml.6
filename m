Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59117C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A83520837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy6lNPcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A83520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeH3WmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeH3WmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:42:16 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16DC20658;
        Thu, 30 Aug 2018 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535654326;
        bh=4jbi0hsP71QIm5CLViuOGptUy+UyZH1xmsrEktUb0Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zy6lNPczRsAX2gudm/xTNIn1pVkOfQRIqSi6xQxseQVRYWRtfXhOnZd6lcjLdYkZ2
         ZLFtYRFU77TlzaqAEDWgDIgdgdyYeY51U7kmtq88ZFyy15Vbymdjxq1uZW1f4RCAb3
         RtcARoISpUUA3z2dejV2ZGtL0Muxjz/a+Azhxcxw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 21B96141C3F; Thu, 30 Aug 2018 15:38:36 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:38:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kim Phillips <kim.phillips@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        perf group <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf annotate: Handle arm64 move instructions
Message-ID: <20180830183836.GF6097@kernel.org>
References: <20180827150807.304110d2e9919a17c832ca48@arm.com>
 <7b5ea377-91a6-d3f3-56a1-a836d5aaa7c5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5ea377-91a6-d3f3-56a1-a836d5aaa7c5@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 28, 2018 at 08:22:40AM +0200, Thomas-Mich Richter escreveu:
> On 08/27/2018 10:08 PM, Kim Phillips wrote:
> > Add default handler for non-jump instructions.  This really only has an
> > effect on instructions that compute a PC-relative address, such as 'adrp,'
> > as seen in these couple of examples:
> > 
> > BEFORE: adrp   x0, ffff20000aa11000 <kallsyms_token_index+0xce000>
> > AFTER:  adrp   x0, kallsyms_token_index+0xce000
> > 
> > BEFORE: adrp   x23, ffff20000ae94000 <__per_cpu_load>
> > AFTER:  adrp   x23, __per_cpu_load
> > 
> > The implementation is identical to that of s390, but with a slight
> > adjustment for objdump whitespace propagation (arm64 objdump puts
> > spaces after commas, whereas s390's presumably doesn't).
> > 
> > The mov__scnprintf() declaration is moved from s390's to arm64's
> > instructions.c because arm64's gets included before s390's.
> > 
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks, applied.

- Arnaldo
