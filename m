Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D6AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A62B208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A62B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbeHAQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:05:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389448AbeHAQFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 871BA40241C0;
        Wed,  1 Aug 2018 14:19:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5175C2026D68;
        Wed,  1 Aug 2018 14:19:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 Aug 2018 16:19:17 +0200 (CEST)
Date:   Wed, 1 Aug 2018 16:19:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
Message-ID: <20180801141914.GA21248@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
 <20180731070337.61004-1-j@bitron.ch>
 <20180731143949.GA1890@redhat.com>
 <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 14:19:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 14:19:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Jürg Billeter wrote:
>
> > Could you explain your use-case? Why a shell wants to use
> > CLONE_NEWPID?
>
> To guarantee that there won't be any runaway processes, i.e., ensure
> that no descendants (background helper daemons or misbehaving
> processes) survive when the child process is terminated.

We already have PR_SET_CHILD_SUBREAPER.

Perhaps we can finally add PR_KILL_MY_DESCENDANTS_ON_EXIT? This was already
discussed some time ago, but I can't find the previous discussion... Simple
to implement.

> And to prevent
> children from killing their ancestors.

OK, this is the only reason for CLONE_NEWPID which I can understand so far.
Not that I understand why this is that useful ;)

> > >  * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
> > >    itself, it's not possible to implement the stop action in a custom
> > >    SIGTSTP handler.
> >
> > Yes. So may be we actually want to change __isig() paths to use
> > SEND_SIG_FORCED (this is not that simple), or perhaps we can change
> > __send_signal() to not drop SIGSTOP sent to itself, or may be we can even
> > introduce SIG_DFL_EVEN_IF_INIT, I dunno.
>
> In my opinion, my patch is much simpler and also more general as it

Yes, yes, let me repeat that I am not arguing with your patch, I am just trying
to understand what

> > I can't understand this. An application should be changed anyway to do
> > PR_SET_KILLABLE?
>
> PR_SET_KILLABLE can be called (e.g., by the shell) between clone() and
> execve().

OK, this is true.

Oleg.

