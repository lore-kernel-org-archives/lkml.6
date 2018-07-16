Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589142084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589142084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeGPNHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:07:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbeGPNHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:07:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AC5977885;
        Mon, 16 Jul 2018 12:40:16 +0000 (UTC)
Received: from treble (ovpn-122-49.rdu2.redhat.com [10.10.122.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39B83111DD03;
        Mon, 16 Jul 2018 12:40:15 +0000 (UTC)
Date:   Mon, 16 Jul 2018 07:40:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
Message-ID: <20180716124013.uiyyzr3wabgdshea@treble>
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20180713183756.gfddtn3gbwkwpqbj@treble>
 <dbd9bdf6-7cb1-cde1-5f7d-d3a5449c560d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbd9bdf6-7cb1-cde1-5f7d-d3a5449c560d@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:40:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:40:16 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 01:05:56PM +0530, Kamalesh Babulal wrote:
> On Saturday 14 July 2018 12:07 AM, Josh Poimboeuf wrote:
> > > We bail out during patch registration for architectures, those don't
> > > support reliable stack trace.
> > 
> > Does anybody know if that change was intentional?  I thought the plan
> > was to allow non-consistency-model arches to still use livepatch, and
> > that they'd just have to 'force' patches to completion instead.  That
> > seems a little more forgiving.
> > 
> 
> The initial proposal was to allow 'force' feature on architectures
> without HAVE_RELIABLE_STACKTRACE support and use pr_notice() to warn
> user about the non-availability of consistency model. It was argued
> against, as it will encourage people to use it as an alternative instead
> of adding HAVE_RELIABLE_STACKTRACE support to the kernel.

Ok, looking through the archives, I found it:

  https://lkml.kernel.org/r/20171221151428.rt4dlizxb5nqhb3h@pathway.suse.cz

I'm not sure I agree with that conclusion, but nobody has complained
about it, so it's probably fine...

-- 
Josh
