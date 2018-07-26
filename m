Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FC12064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FC12064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeGZRNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:13:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730298AbeGZRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4926B87927;
        Thu, 26 Jul 2018 15:55:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6A9521568A1;
        Thu, 26 Jul 2018 15:55:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jul 2018 17:55:49 +0200 (CEST)
Date:   Thu, 26 Jul 2018 17:55:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Subject: Re: [PATCH v3 20/20] signal: Don't restart fork when signals come in.
Message-ID: <20180726155546.GA467@redhat.com>
References: <874lgo5xdg.fsf@xmission.com>
 <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
 <87fu084cxj.fsf@xmission.com>
 <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
 <87a7qg4bb3.fsf_-_@xmission.com>
 <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
 <87pnzc2upf.fsf@xmission.com>
 <87k1pk2cj9.fsf_-_@xmission.com>
 <20180726134143.GB32718@redhat.com>
 <87pnza6ou2.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnza6ou2.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 15:55:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 15:55:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26, Eric W. Biederman wrote:
>
> Are the earlier patches looking ok to you?

I obviously like 1-15.

"[PATCH 16/20] fork: Move and describe why the code examines PIDNS_ADDING"
is "interesting". I mean it is fine, but at the end of this series it doesn't
matter what we check first, PIDNS_ADDING or fatal_signal_pending() - restart
is not possible in both cases.


As for 17-20... Yes I am biased. But I still think the simple approach I tried
to propose from the very beginning is better. At least simpler, in that you do
not need to worry about all these special cases/reasons for signal_pending().




And you can not imagine how much I hate "[PATCH 19/20] fork: Have new threads
join on-going signal group stops" ;) Because I spent HOURS looking at this trivial
patch and I am still not sure...

To clarify, the CLONE_THREAD with JOBCTL_STOP_PENDING case is simple, I am mostly
worried about JOBCTL_TRAP_STOP/etc with or without CLONE_THREAD, this adds some
subtle changes but unfortunately I failed to find something wrong so I can't argue.

Oleg.

