Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8639C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A95421759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A95421759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeHCOKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:10:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbeHCOKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:10:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C4AA7DAC3;
        Fri,  3 Aug 2018 12:14:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 27DFB21565E1;
        Fri,  3 Aug 2018 12:14:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Aug 2018 14:14:09 +0200 (CEST)
Date:   Fri, 3 Aug 2018 14:14:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
Message-ID: <20180803121406.GB13794@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
 <20180731070337.61004-1-j@bitron.ch>
 <20180731143949.GA1890@redhat.com>
 <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
 <20180801141914.GA21248@redhat.com>
 <7f7c57230e0279f4599bf13ae1d1d449d76ac232.camel@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f7c57230e0279f4599bf13ae1d1d449d76ac232.camel@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 12:14:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 12:14:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03, Jürg Billeter wrote:
>
> On Wed, 2018-08-01 at 16:19 +0200, Oleg Nesterov wrote:
> > On 07/31, Jürg Billeter wrote:
> > >
> > > > Could you explain your use-case? Why a shell wants to use
> > > > CLONE_NEWPID?
> > >
> > > To guarantee that there won't be any runaway processes, i.e., ensure
> > > that no descendants (background helper daemons or misbehaving
> > > processes) survive when the child process is terminated.
> >
> > We already have PR_SET_CHILD_SUBREAPER.
> >
> > Perhaps we can finally add PR_KILL_MY_DESCENDANTS_ON_EXIT? This was already
> > discussed some time ago, but I can't find the previous discussion... Simple
> > to implement.
>
> This would definitely be an option. You mentioned it last October in
> the PR_SET_PDEATHSIG_PROC discussion¹. However, as PID namespaces
> already exist and appear to be a good fit for the most part,

Sure, if CLONE_NEWPID fits your needs you can use it,

> I think it
> makes sense to just add the missing pieces to PID namespaces instead of
> duplicating part of the PID namespace functionality.

Again, I am not arguing with your change.

PR_KILL_MY_DESCENDANTS_ON_EXIT can make sense just like PR_SET_CHILD_SUBREAPER
even if PID namespace functionality implies both. Simply because CLONE_NEWPID
is not necessarily the best tool, if nothing else you do not necessarily want
the pid isolation.

> Also, based on Eric's comment in that other discussion about
> no_new_privs not being allowed to increase the attack surface,
> PR_KILL_MY_DESCENDANTS_ON_EXIT might require CAP_SYS_ADMIN as well (due
> to setuid children).

No, no, the exiting parent should simply do group_send_sig_info(SIGKILL)
for every descendant and rely on check_kill_permission().

OK, lets forget it for now.

Oleg.

