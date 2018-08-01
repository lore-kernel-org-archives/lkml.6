Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF41C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E10D208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbeHARqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389643AbeHARqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:46:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 979D381663F5;
        Wed,  1 Aug 2018 15:59:38 +0000 (UTC)
Received: from redhat.com (ovpn-124-83.rdu2.redhat.com [10.10.124.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D0651C640;
        Wed,  1 Aug 2018 15:59:38 +0000 (UTC)
Date:   Wed, 1 Aug 2018 11:59:37 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] watchdog: Reduce message verbosity
Message-ID: <20180801155937.hwsgqpa5n4q2dkfe@redhat.com>
References: <20180730190949.141996-1-okaya@kernel.org>
 <20180730192800.nqdhugzbxmin6e25@redhat.com>
 <4e5def8b-df29-0efb-7e35-e71070e94d91@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5def8b-df29-0efb-7e35-e71070e94d91@kernel.org>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 15:59:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 15:59:38 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:43:34PM -0700, Sinan Kaya wrote:
> Hi Don,
> 
> On 7/30/2018 12:28 PM, Don Zickus wrote:
> > > [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
> > > [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled
> > Hi Sinan,
> > 
> > Any reason why?  Usually when the 'perf event' fails, that indicates a
> > system problem.  And most folks don't boot with the 'debug' option.  This
> > means these unusual failures are hidden and become difficult to debug later
> > when it propagates.
> 
> Sorry, I should have been more clear. I'm only suppressing the first
> error message.
> 
> [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
> 
> Second message is still visible during boot. User knows that NMI watchdog is
> disabled.
> 
> [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> Code is trying to probe the platform capabilities and is failing
> because of missing PMU in the system. If someone is interested in
> finding out why watchdog was disabled, they can turn on the debug
> message level.
> 
> > 
> > Or are you running the watchdog in a different configuration such that this
> > is a common nuisance that you are trying to suppress?
> 
> Yup, system doesn't support PMU.

Hi Sinan,

Oh, I see.  You are just trying to hide the always failing probe.  It seems
to make sense.

Acked-by: Don Zickus <dzickus@redhat.com>

