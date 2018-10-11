Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3BCC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19B62087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19B62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJKWeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbeJKWeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:34:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB98940F0B;
        Thu, 11 Oct 2018 15:06:40 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-31.brq.redhat.com [10.40.200.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7615866A1B;
        Thu, 11 Oct 2018 15:06:37 +0000 (UTC)
Date:   Thu, 11 Oct 2018 17:06:58 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v3 7/7] ia64: wire up system calls
Message-ID: <20181011150654.GB22118@asgard.redhat.com>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <1539231895-4118-8-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 11 Oct 2018 15:06:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:24:43AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 11, 2018 at 6:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > +# perf_event_open requires an architecture specific implementation
> > +326    common  perf_event_open                 sys_perf_event_open
[...]
> 
> I don't think that's correct for these two. perf_event_open() of
> course requires 'perf' support that ia64 does not have

That's actuallt quite funny, given the fact that IA-64 has perfmonctl()
which likely was the precursor of current perf infractructure.

> > +# pkey_mprotect requires an architecture specific implementation
> > +328    common  pkey_mprotect                   sys_pkey_mprotect
> > +# pkey_alloc requires an architecture specific implementation
> > +329    common  pkey_alloc                      sys_pkey_alloc
> > +# pkey_free requires an architecture specific implementation
> > +330    common  pkey_free                       sys_pkey_free
> 
> One comment for all pkey calls would be sufficient. More importantly
> it requires hardware support that ia64 does not have AFAICT.

Except it has[1].

[1] https://www.thailand.intel.com/content/dam/www/public/us/en/documents/manuals/itanium-architecture-software-developer-rev-2-3-vol-2-manual.pdf#page=78
