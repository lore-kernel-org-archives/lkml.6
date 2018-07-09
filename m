Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2271C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBA20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DBA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeGIPU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:20:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932844AbeGIPU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:20:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C76C540201A2;
        Mon,  9 Jul 2018 15:20:56 +0000 (UTC)
Received: from krava (ovpn-204-174.brq.redhat.com [10.40.204.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14ED1111DCF7;
        Mon,  9 Jul 2018 15:20:54 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:20:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, sunil.k.pandey@intel.com
Subject: Re: [PATCH] perf evlist: Fix error out while applying initial delay
 and LBR
Message-ID: <20180709152054.GA11886@krava>
References: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 15:20:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 15:20:56 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:15:22AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf record will error out if both --delay and LBR are applied.
> For example:
>   perf record -D 1000 -a -e cycles -j any -- sleep 2
>   Error:
>   dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts.
>   Try 'perf stat'
> 
> A dummy event is added implicitly for initial delay, which has the same
> configurations as real sampling events. The dummy event is a software
> event. If LBR is configured, perf must error out.
> 
> The dummy event only be used to track PERF_RECORD_MMAP while perf waits
> for the initial delay to enable the real events. The BRANCH_STACK bit
> can be safely cleared for the dummy event.
> 
> After applying the patch:
>   perf record -D 1000 -a -e cycles -j any -- sleep 2
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]
> 
> Reported-by: Pandey, Sunil K <sunil.k.pandey@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
