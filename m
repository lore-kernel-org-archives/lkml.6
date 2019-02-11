Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537A21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfBKOIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:08:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfBKOIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:08:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71187811D6;
        Mon, 11 Feb 2019 14:08:16 +0000 (UTC)
Received: from treble (ovpn-121-194.rdu2.redhat.com [10.10.121.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F60163BAF;
        Mon, 11 Feb 2019 14:08:15 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:08:13 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
Message-ID: <20190211140813.z7kap634gz3gp6a4@treble>
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 14:08:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 02:47:28PM +0530, Kamalesh Babulal wrote:
> While the consistency model was introduced, architectures without the
> reliable stack trace implementation could use the immediate flag for
> livepatching but with its own limitations.
> 
> After removal of the immediate flag by commit d0807da78e11
> ("livepatch: Remove immediate feature"), reliable stack trace became
> enforcing dependency for livepatch support on any architecture. In
> the current code, we ensure that the dependency is met when
> enabling the patch during the module load.
> 
> This dependency check can be improved by moving it to the Kconfig,
> which disables the support for livepatching in the kernel for unmet
> dependencies. This patch moves both HAVE_RELIABLE_STACKTRACE and
> STACKTRACE under config LIVEPATCH, it also removes the
> klp_have_reliable_stack() function.
> 
> Loading a livepatching module on an architecture where reliable
> stack trace is yet to be implemented, the user should see:
> 
> insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format
> 
> ...
> [  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled

Wouldn't the module fail to build in the first place, since
CONFIG_LIVEPATCH is disabled?

Anyway, I'm not sure about this approach.  This patch makes the s390
livepatch code no longer compilable, turning it into completely dead
code.  So if something changes in the s390 code which causes it to stop
compiling, nobody will notice.

I think I'd rather go in the opposite direction: allow the patches to be
loaded.  Then they can be forced, if needed.  That enables both compile
and runtime testing.  That way we don't make any backward progress,
until such arches get reliable stacktraces.

-- 
Josh
