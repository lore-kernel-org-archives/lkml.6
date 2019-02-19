Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C721C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfBSRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSRg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:36:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C90CC0C6C2B;
        Tue, 19 Feb 2019 17:36:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C76D19C58;
        Tue, 19 Feb 2019 17:36:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 19 Feb 2019 18:36:56 +0100 (CET)
Date:   Tue, 19 Feb 2019 18:36:54 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20190219173654.GA4314@redhat.com>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20190218193734.GA29983@roeck-us.net>
 <20190219123756.GA9210@redhat.com>
 <20190219162643.GA15202@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219162643.GA15202@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 17:36:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19, Guenter Roeck wrote:
>
> On Tue, Feb 19, 2019 at 01:37:57PM +0100, Oleg Nesterov wrote:
> >
> > looks unrelated...
> >
>
> Indeed...
>
> The underlying problem is in the error handling code of ace_setup(),
> which calls put_disk() followed by blk_cleanup_queue(). put_disk()
> calls disk_release(), which calls blk_put_queue(), which in turn
> results in a call to blk_mq_hw_sysfs_release().
>
> Added debug code, with your patch reverted, shows:
>
>  ######### blk_mq_hw_sysfs_release hctx=cee4a800
>  ...
>  ######### blk_mq_run_hw_queue hctx=cee4a800
>
> blk_mq_hw_sysfs_release() calls kfree(htcx), so accessing it later is most
> definitely not a good idea.

Thanks!

> No idea why this only causes problems with your patch applied.

Well... blk_put_queue() may trigger kobject_uevent() which does call_usermodehelper.

So if one of the used-after-free datastructures was already re-allocated as
linux_binprm, then with my patch it can look "more corrupted"...

But honestly, I too have no idea.

Thanks Guenter.

Oleg.

