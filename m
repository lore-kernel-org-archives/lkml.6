Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1842522360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1842522360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeKNCyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNCyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 448EE300156C;
        Tue, 13 Nov 2018 16:56:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id DEABA1A90C;
        Tue, 13 Nov 2018 16:55:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Nov 2018 17:55:59 +0100 (CET)
Date:   Tue, 13 Nov 2018 17:55:58 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20181113165557.GG30990@redhat.com>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 13 Nov 2018 16:56:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12, Andrew Morton wrote:

> On Mon, 12 Nov 2018 17:09:56 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
>
> >  /* sizeof(linux_binprm->buf) */
> > -#define BINPRM_BUF_SIZE 128
> > +#define BINPRM_BUF_SIZE 256
> >
> >  #endif /* _UAPI_LINUX_BINFMTS_H */
>
> It does seem a rather silly restriction, and it's tempting to suggest
> reworking the code so that linux_binprm.buf is dynamically sized to
> accommodate even ludicrously large strings.

I actually tried to do this ;)

Of course this is possible, but we need some limits anyway, we need to
read the file until we find '\n' or '\0' in kmalloc/vmalloc'ed buffer,
then split and copy the strings to bprm->vma in reverse order.

So I decided to make the trivial change for now and (hopefully) forget
about this problem.

> However it would be basically cost-free to increase
> BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
> PAGE_SIZE?

I don't think we should take sizeof(struct linux_binprm) into account, the
new members can come at any time and we can never decrease BINPRM_BUF_SIZE.

Oleg.

