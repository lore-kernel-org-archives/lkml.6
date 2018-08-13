Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E406321761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E406321761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbeHMReC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeHMReC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 618AB40241C0;
        Mon, 13 Aug 2018 14:51:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F321D178BE;
        Mon, 13 Aug 2018 14:51:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 13 Aug 2018 16:51:26 +0200 (CEST)
Date:   Mon, 13 Aug 2018 16:51:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Song Liu <liu.song.a23@gmail.com>, srikar@linux.vnet.ibm.com,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180813145121.GD28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
 <20180813131723.GC28360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813131723.GC28360@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 14:51:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 14:51:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13, Oleg Nesterov wrote:
>
> On 08/13, Ravi Bangoria wrote:
> >
> > > But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
> > > hook and avoid delayed_uprobe_install() in uprobe_mmap().
> >
> > I'm sorry. I didn't get this.
>
> Sorry for confusion...
>
> I meant, if only exec*( could race with _register(), we could add another uprobe
> hook which updates all (delayed) counters before return to user-mode.
>
> > > Afaics, the really problematic case is dlopen() which can race with _register()
> > > too, right?
> >
> > dlopen() should internally use mmap() right? So what is the problem here? Can
> > you please elaborate.
>
> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
> because dlopen() can race with _register() too, just like exec.

I'm afraid I added even more confusion... so let me clarify although I am sure you
understand this better than me ;)

of course, the main reason why we can't avoid uprobe_mmap()->delayed_uprobe_install()
is not the race with _register(), the main reason is that dlopen() can mmap the code
first, then mmap the counter we need to increment.

Again, just like exec, but exec is "atomic" in that it can't return to user-mode until
evrything is done, so we could add another uprobe hook and avoid delayed_uprobe_install
in uprobe_mmap().

Just in case my previous email was not clear.

Oleg.

