Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02BB20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIACMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:12:16 -0400
Received: from twin.jikos.cz ([91.219.245.39]:59280 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbeIACMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:12:15 -0400
X-Greylist: delayed 2675 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2018 22:12:14 EDT
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w7VLIAk9007202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 31 Aug 2018 23:18:11 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id w7VLI9Bg006565;
        Fri, 31 Aug 2018 23:18:09 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Fri, 31 Aug 2018 23:18:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Juergen Gross <jgross@suse.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: Access to non-RAM pages
In-Reply-To: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
Message-ID: <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Juergen Gross wrote:

> While being very unlikely I still believe this is possible. Any
> thoughts?

So in theory we should somehow test whether the next page is some form of 
mmio/gart/... mapping, but I guess that by itself would kill the 
performance advantage of the whole load_unaligned_zeropad() trick.

And yes, the sideffects of reading from mmio mapping is a real thing -- 
see for example the issue fixed by 2a3e83c6f9.

If noone has any clever idea how to work this around (I don't), I am 
afraid we'd have to ditch the whole DCACHE_WORD_ACCESS optimization, as 
it's silently dangerous.

Thanks,

-- 
Jiri Kosina
SUSE Labs
