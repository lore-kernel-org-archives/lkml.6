Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48311C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045E021019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAUWkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:40:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfAUWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:40:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A00C58762E;
        Mon, 21 Jan 2019 22:40:15 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B464919744;
        Mon, 21 Jan 2019 22:40:14 +0000 (UTC)
Date:   Mon, 21 Jan 2019 17:40:12 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] livepatch: Handle failing allocation of shadow
 variables in the selftest
Message-ID: <20190121224012.GB8766@redhat.com>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161720.796-3-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 21 Jan 2019 22:40:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:17:18PM +0100, Petr Mladek wrote:
> Do not dereference pointers to the shadow variables when either
> klp_shadow_alloc() or klp_shadow_get() fail.
> 
> There is no need to check the other locations explicitly. The test
> would fail if any allocation fails. And the existing messages, printed
> during the test, provide enough information to debug eventual problems.
> 

I didn't run the test under those failing conditions, but at looking at
the code, I think it would simply skip the "expected <conditions> found"
and the test script would complain about not seeing that msg.

Would it be easier to just bite the bullet and verify sv[0-4] at their
allocation sites?  Then later uses (ie, the sv3 dereference that
Miroslav spotted at the bottom) or new code wouldn't fall through the
cracks.

-- Joe
