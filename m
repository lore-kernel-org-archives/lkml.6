Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C01208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C01208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbeKOB6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbeKOB6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:58:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E573168F;
        Wed, 14 Nov 2018 15:54:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id C393B60BF6;
        Wed, 14 Nov 2018 15:54:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Nov 2018 16:54:16 +0100 (CET)
Date:   Wed, 14 Nov 2018 16:54:14 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20181114155413.GC13885@redhat.com>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
 <20181113165557.GG30990@redhat.com>
 <20181113124305.73b8ac9e5a2ef9b18d3444b2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113124305.73b8ac9e5a2ef9b18d3444b2@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 14 Nov 2018 15:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Andrew Morton wrote:
>
> On Tue, 13 Nov 2018 17:55:58 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > However it would be basically cost-free to increase
> > > BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
> > > PAGE_SIZE?
> >
> > I don't think we should take sizeof(struct linux_binprm) into account, the
> > new members can come at any time and we can never decrease BINPRM_BUF_SIZE.
>
> My main point is..  why not make BINPRM_BUF_SIZE a lot larger than 256?

Of course we can make it larger. And of course 256 is just another silly/random
value. Currently it seems to work, but if we have another bug report we should
probably rework load_script() to use vmalloc()'ed buffer. Perhaps we should do
this right now and I am just too lazy.

Oleg.

