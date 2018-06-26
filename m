Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86073C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4828C2691C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4828C2691C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755001AbeFZSoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752086AbeFZSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B75F0402178A;
        Tue, 26 Jun 2018 18:44:06 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80972213ED6A;
        Tue, 26 Jun 2018 18:44:06 +0000 (UTC)
Date:   Tue, 26 Jun 2018 13:44:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
Message-ID: <20180626184405.hsbuuq5eo7qzicoi@treble>
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
 <20180626164338.GH2458@hirez.programming.kicks-ass.net>
 <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 18:44:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 18:44:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:31:18PM +0100, Allan Xavier wrote:
> Hi Peter,
> 
> On 26/06/18 17:43, Peter Zijlstra wrote:
> > On Tue, Jun 26, 2018 at 05:20:45PM +0100, Allan Xavier wrote:
> >> 0000000000000500 g     F .text  0000000000000034 nmi_panic
> >> 0000000000000528 l     F .text  000000000000000c nmi_panic.cold.7
> >>
> >> This doesn't happen with -freorder-functions in the first example as the
> >> symbols don't overlap. 
> > 
> > Urgh and I don't suppose we can 'fix' the overlap in read_symbols() ?
> > 
> 
> It should be fixable in read_symbols too if you don't mind sym->len not being
> the same as sym->st_size in the ELF.
> 
> Is there a particular concern you're trying to address by having the logic there
> instead?
> 
> Will have a look into reworking the patch in any case.

Thanks for the patch and the excellent problem description.  I think the
concern is that the overlap might cause other unforeseen issues (now or
in the future).  How about something like this?  (The diff also includes
a cleanup to reduce the indent level.)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e60e105583e..36518393a960 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -302,19 +302,32 @@ static int read_symbols(struct elf *elf)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
 			coldstr = strstr(sym->name, ".cold.");
-			if (coldstr) {
-				coldstr[0] = '\0';
-				pfunc = find_symbol_by_name(elf, sym->name);
-				coldstr[0] = '.';
-
-				if (!pfunc) {
-					WARN("%s(): can't find parent function",
-					     sym->name);
-					goto err;
-				}
-
-				sym->pfunc = pfunc;
-				pfunc->cfunc = sym;
+			if (!coldstr)
+				continue;
+
+			coldstr[0] = '\0';
+			pfunc = find_symbol_by_name(elf, sym->name);
+			coldstr[0] = '.';
+
+			if (!pfunc) {
+				WARN("%s(): can't find parent function",
+				     sym->name);
+				goto err;
+			}
+
+			sym->pfunc = pfunc;
+			pfunc->cfunc = sym;
+
+			/*
+			 * Unfortunately, -fnoreorder-functions puts the child
+			 * inside the parent.  Remove the overlap so we can
+			 * have sane assumptions.
+			 */
+			if (sym->sec == pfunc->sec &&
+			    sym->offset >= pfunc->offset &&
+			    sym->offset < pfunc->offset + pfunc->len &&
+			    sym->offset + sym->len == pfunc->offset + pfunc->len) {
+				pfunc->len -= sym->len;
 			}
 		}
 	}
