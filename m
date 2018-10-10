Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D842064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D842064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJJUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeJJUkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:40:15 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E972064A;
        Wed, 10 Oct 2018 13:18:05 +0000 (UTC)
Date:   Wed, 10 Oct 2018 09:18:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, stable@vger.kernel.org
Subject: [GIT PULL] vsprintf: Fix off-by-one bug in bstr_printf() processing
 dereferenced pointers
Message-ID: <20181010091803.16e5312c@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus (aka Greg),

It was reported that trace_printk() was not reporting properly
values that came after a dereference pointer.

trace_printk() utilizes vbin_printf() and bstr_printf() to keep the
overhead of tracing down. vbin_printf() does not do any conversions
and just stors the string format and the raw arguments into the
buffer. bstr_printf() is used to read the buffer and does the conversions
to complete the printf() output.

This can be troublesome with dereferenced pointers because the reference
may be different from the time vbin_printf() is called to the time
bstr_printf() is called. To fix this, a prior commit changed vbin_printf()
to convert dereferenced pointers into strings and load the converted
string into the buffer. But the change to bstr_printf() had an off-by-one
error and didn't account for the nul character at the end of the string
and this corrupted the rest of the values in the format that came after
a dereferenced pointer.


Please pull the latest trace-v4.19-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc5

Tag SHA1: b5fc80d980ae316323e88c165084deef39afd168
Head SHA1: 62165600ae73ebd76e2d9b992b36360408d570d8


Steven Rostedt (VMware) (1):
      vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced pointers

----
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 62165600ae73ebd76e2d9b992b36360408d570d8
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Fri Oct 5 10:08:03 2018 -0400

    vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced pointers
    
    The functions vbin_printf() and bstr_printf() are used by trace_printk() to
    try to keep the overhead down during printing. trace_printk() uses
    vbin_printf() at the time of execution, as it only scans the fmt string to
    record the printf values into the buffer, and then uses vbin_printf() to do
    the conversions to print the string based on the format and the saved
    values in the buffer.
    
    This is an issue for dereferenced pointers, as before commit 841a915d20c7b,
    the processing of the pointer could happen some time after the pointer value
    was recorded (reading the trace buffer). This means the processing of the
    value at a later time could show different results, or even crash the
    system, if the pointer no longer existed.
    
    Commit 841a915d20c7b addressed this by processing dereferenced pointers at
    the time of execution and save the result in the ring buffer as a string.
    The bstr_printf() would then treat these pointers as normal strings, and
    print the value. But there was an off-by-one bug here, where after
    processing the argument, it move the pointer only "strlen(arg)" which made
    the arg pointer not point to the next argument in the ring buffer, but
    instead point to the nul character of the last argument. This causes any
    values after a dereferenced pointer to be corrupted.
    
    Cc: stable@vger.kernel.org
    Fixes: 841a915d20c7b ("vsprintf: Do not have bprintf dereference pointers")
    Reported-by: Nikolay Borisov <nborisov@suse.com>
    Tested-by: Nikolay Borisov <nborisov@suse.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d5b3a3f95c01..812e59e13fe6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2794,7 +2794,7 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 						copy = end - str;
 					memcpy(str, args, copy);
 					str += len;
-					args += len;
+					args += len + 1;
 				}
 			}
 			if (process)
