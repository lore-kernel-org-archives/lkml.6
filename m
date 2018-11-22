Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8343320685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8343320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395101AbeKVXQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:16:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVXQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:16:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A378558E27;
        Thu, 22 Nov 2018 12:36:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id E67666092D;
        Thu, 22 Nov 2018 12:36:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 13:36:58 +0100 (CET)
Date:   Thu, 22 Nov 2018 13:36:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] smp_wmb() in prepare_uprobe()
Message-ID: <20181122123655.GD28270@redhat.com>
References: <20181121224124.GB4016@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121224124.GB4016@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 22 Nov 2018 12:36:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/21, Andrea Parri wrote:
>
> The comment for the smp_wmb() in prepare_uprobe() says:
>
>   "pairs with rmb() in find_active_uprobe()"

it seems that this comment was wrong from the very beginning,


> but I see no (smp_)rmb() in find_active_uprobe(); I see the smp_rmb() in
> handle_swbp(): is this the intended pairing barrier?

Yes, and the comment near this rmb() says "pairs with wmb() in install_breakpoint()",
today this is not right too.

> Which memory accesses do you want to "order" with this pairing?

See 142b18ddc81439acda4bc4231b291e99fe67d507 ("uprobes: Fix handle_swbp()
vs unregister() + register() race") and the comment above this rmb().

Oleg.

