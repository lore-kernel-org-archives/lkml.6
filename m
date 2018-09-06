Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF1C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8DE20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xqsLWUvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8DE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeIGBDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:03:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIGBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vtHKh/JT9sqbD4tvoq794Idr7uFMT0fTiuI3wwMSzlQ=; b=xqsLWUvcWFB25SC5eOHRLvsaOS
        a0h40SihAoGaWIDS/s5D2bUZqDD74aq7kPvVPljn47SRh9nXhKfvdb4N2qEHGiJLgoUuoGLgnlay9
        25KNpoNMD7Kd39XkYhC5eC03hp/37JpMA0h40InccSjFCwsjjiq0lNszP5NtHvz3yUs+qaQUwvm6a
        b5iQIpuvjsf8y4RuTQN3ri6CxqzAMw+dmXs6/8kDp4dKayQ07152zWFQpsFMJCoUIIDVytB02J9UA
        37CLHgI3ZMQ0JjY7dPERbHYKLeCOep39FUiu81ZAPHM9BJcMWEO6HPr9npZcOsOQWVtZfWSws6xDy
        TBFxm3fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy0qb-0004k5-Hd; Thu, 06 Sep 2018 20:25:49 +0000
Received: by worktop (Postfix, from userid 1000)
        id 47D076E0AA9; Thu,  6 Sep 2018 22:25:47 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:25:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Message-ID: <20180906202547.GC9358@worktop.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
 <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:58:40PM +0000, Nadav Amit wrote:
> > With that CR3 trickery, we can rid ourselves of the text_mutex
> > requirement, since concurrent text_poke is 'safe'. That would clean up
> > the kgdb code quite a bit.
> 
> I don’t know. I’m somewhat worried with multiple mechanisms potentially
> changing the same code at the same time - and maybe ending up with some
> mess.

kgdb only pokes INT3, that should be pretty safe.
