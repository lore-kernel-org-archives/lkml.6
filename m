Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3376EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C320846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53C320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbeGWIBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:01:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728188AbeGWIBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BF5077888;
        Mon, 23 Jul 2018 07:01:48 +0000 (UTC)
Received: from krava (ovpn-204-187.brq.redhat.com [10.40.204.187])
        by smtp.corp.redhat.com (Postfix) with SMTP id 55C96111CB8C;
        Mon, 23 Jul 2018 07:01:46 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:01:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl
Subject: Re: [PATCH 3/4] perf tools: Fix check-headers.sh output file
 variables
Message-ID: <20180723070145.GB7523@krava>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-3-jolsa@kernel.org>
 <20180720145745.GB4329@kernel.org>
 <20180720151518.GC27176@krava>
 <CAJ1xhMUeXAwZADxxJAALzwhnMFDQk0hMPeepRML+OLV92fmnJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1xhMUeXAwZADxxJAALzwhnMFDQk0hMPeepRML+OLV92fmnJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 07:01:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 07:01:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:22:49PM +0300, Alexander Kapshuk wrote:
> On Fri, Jul 20, 2018 at 6:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Jul 20, 2018 at 11:57:45AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jul 20, 2018 at 01:00:35PM +0200, Jiri Olsa escreveu:
> > > > The warning message in check_w function uses wrongly
> > > > the $file variable instead of $file1 and $file2.
> > >
> > > Humm,
> > >
> > > Before:
> > >
> > > Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
> > >
> > > After:
> > >
> > > Warning: Kernel ABI header at '../arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at '../../arch/powerpc/include/uapi/asm/unistd.h'
> > >
> > >
> > > The previous version is better, I can then just use:
> > >
> > > diff -u tools/arch/powerpc/include/uapi/asm/unistd.h arch/powerpc/include/uapi/asm/unistd.h
> > >
> > > and get what changed, with your change I have to go to tools/perf before
> > > doing that diff, which is an unnecessary extra step in at least my
> > > workflow.
> >
> > so all paths output based in kernel tree root then, will change
> >
> > jirka
> 
> I was going to ask about this in a separate email initially, but then
> thought I'd use this email exchange instead, as my question is about
> the code in question. Hope you don't mind.
> 
> If I'm reading this right, the intended behavoir of the block of code
> below is to test file2 for existance, and if it exists, to evaluate $cmd.
> If file1 and file2 are found to differ, print the warning.
> 
> test -f $file2 &&
>   eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file'
> differs from latest version at '$file'" >&2
> 
> The '||' path of execution is however also taken if file2 doesn't exist,
> which is probably very unlikely to happen. See below.
> 
> % file1=file1; file2=file2
> % cmd="echo diff $file1 $file2"
> % test -f $file2 &&
> eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
> differs from latest version at '$file2'" >&2
> Warning: Kernel ABI header at 'tools/file1' differs from latest
> version at 'file2'
> 
> Is this something you would rather leave as is, or perhaps use something
> along the lines of the code below instead:
> 
> test -f $file2 && {
> eval $cmd ||
> echo "Warning: Kernel ABI header at 'tools/$file' differs from latest
> version at '$file'" >&2
> }

hi,
yea, probably..  please feel free to post a patch.. just make sure all
the displayed files paths are based on the kernel root

thanks,
jirka
