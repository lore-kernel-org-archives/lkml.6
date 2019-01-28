Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159DB2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfA1QTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388125AbfA1QTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B48D4A7E1;
        Mon, 28 Jan 2019 16:19:16 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EDEA10D7062;
        Mon, 28 Jan 2019 16:19:16 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:19:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     valdis.kletnieks@vt.edu
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190125 - objtool complains about dumpstack
Message-ID: <20190128161914.hc53qk6yplah6tl2@treble>
References: <27806.1548647103@turing-police.cc.vt.edu>
 <20190128041825.db2fsdktmisvzq72@treble>
 <1255.1548650410@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1255.1548650410@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 28 Jan 2019 16:19:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 11:40:10PM -0500, valdis.kletnieks@vt.edu wrote:
> On Sun, 27 Jan 2019 22:18:25 -0600, Josh Poimboeuf said:
> > On Sun, Jan 27, 2019 at 10:45:03PM -0500, valdis.kletnieks@vt.edu wrote:
> > > Seen in a build:
> > > 
> > >   CC      arch/x86/kernel/dumpstack.o
> > > arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x9: undefined stack state
> > > arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x0: stack state mismatch: cfa1=6+16 cfa2=7+8
> > > 
> > > Probably a gcc9 code generation that objtool doesn't know about?
> >
> > Can you share the .o file?
> 
> Sure.  Attached.

Thanks for reporting it.  Here's the fix below.  I'll submit an official
patch soon.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..df9bd60153c9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -165,6 +165,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
