Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23A720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeIKU3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:29:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbeIKU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:29:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB47CC12AF;
        Tue, 11 Sep 2018 15:29:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAC1AD1CE7;
        Tue, 11 Sep 2018 15:29:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Sep 2018 17:29:56 +0200 (CEST)
Date:   Tue, 11 Sep 2018 17:29:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180911152953.GB9450@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
 <20180910172109.GB27005@redhat.com>
 <20180910174355.GA27312@redhat.com>
 <CAGXu5jKwJx6mLV8=Z313kkZzqhikyoKwnRTQsd5X+U_gMkuS_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKwJx6mLV8=Z313kkZzqhikyoKwnRTQsd5X+U_gMkuS_w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 15:29:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 15:29:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Kees Cook wrote:
>
> On Mon, Sep 10, 2018 at 10:43 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > with this patch
> >
> >         #define MAX_ARG_STRINGS 0x7FFFFFFF
> >
> > doesn't match the reality. perhaps something like below makes sense just
> > to make it clear, but this is cosmetic.
>
> Part of the discussion from back then was basically "we don't have
> hard-coded limits so programs need to check dynamically themselves".
>
> I'd prefer to leave it all well enough alone since I don't want to
> introduce regressions here in the face of the many many Stack Clash
> style weaknesses.

I simply can't understand... Perhaps you too misunderstood me, I only
tried to say that count() can stop earlier, it is pointless to continue
to count the arg/env strings after argc + envc > _STK_LIM / 4 * 3 / 2,
copy_strings() will fail anyway.

Oleg.

