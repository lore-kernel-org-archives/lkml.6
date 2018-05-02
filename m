Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeEBVGa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:06:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeEBVG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:06:26 -0400
Date: Wed, 2 May 2018 16:06:25 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 2 (objtool bug!)
Message-ID: <20180502210625.pehvcgtlqwqznnry@treble>
References: <20180502165939.2375cf6a@canb.auug.org.au>
 <fb41f3ee-705e-4886-3f78-c7f88db5276d@infradead.org>
 <20180502154319.cbi47tw2fmhxlnr4@treble>
 <5ed0305b-bca8-3b50-7d33-32c5754a81fc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ed0305b-bca8-3b50-7d33-32c5754a81fc@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 08:59:38AM -0700, Randy Dunlap wrote:
> On 05/02/2018 08:43 AM, Josh Poimboeuf wrote:
> > On Wed, May 02, 2018 at 08:37:53AM -0700, Randy Dunlap wrote:
> >> On 05/01/2018 11:59 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20180501:
> >>>
> >>
> >> on x86_64 randconfig:
> >>
> >>   CC      fs/cifs/smbencrypt.o
> >> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
> >> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)
> > 
> > Can you share the object file (or at least the .config and GCC version)?
> > 
> 
> gcc (SUSE Linux) 4.8.5
> 
> config and .o file are attached.

Thanks, can you verify this fixes it?

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..dae568fef2c1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -190,9 +190,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					continue;
 
 				if (recursion == 5) {
-					WARN_FUNC("infinite recursion (objtool bug!)",
-						  dest->sec, dest->offset);
-					return -1;
+					/*
+					 * Infinite recursion: two functions
+					 * have sibling calls to each other.
+					 * This is a very rare case.  It means
+					 * they aren't dead ends.
+					 */
+					return 0;
 				}
 
 				return __dead_end_function(file, dest_func,
