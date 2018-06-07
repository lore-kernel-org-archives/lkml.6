Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7EBdM6JUGVuaLwAAmS7hNA
	; Thu, 07 Jun 2018 15:53:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3AAA607E7; Thu,  7 Jun 2018 15:53:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4BE99601D2;
	Thu,  7 Jun 2018 15:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BE99601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934305AbeFGPxk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:53:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40361 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932649AbeFGOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:47 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbu-0005Zk-6y; Thu, 07 Jun 2018 15:09:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002m5-5p; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Thomas Richter" <tmricht@linux.vnet.ibm.com>,
        "Hendrik Brueckner" <brueckner@linux.vnet.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Ravi Bangoria" <ravi.bangoria@linux.vnet.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.73630898@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 073/410] perf annotate: Fix objdump comment parsing
 for Intel mov dissassembly
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

commit 35a8a148d8c1ee9e5ae18f9565a880490f816f89 upstream.

The command 'perf annotate' parses the output of objdump and also
investigates the comments produced by objdump. For example the
output of objdump produces (on x86):

23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
                                # 234008 <stderr@@GLIBC_2.2.5+0x9a8>

and the function mov__parse() is called to investigate the complete
line. Mov__parse() breaks this line into several parts and finally
calls function comment__symbol() to parse the data after the comment
character '#'. Comment__symbol() expects a hexadecimal address followed
by a symbol in '<' and '>' brackets.

However the 2nd parameter given to function comment__symbol()
always points to the comment character '#'. The address parsing
always returns 0 because the character '#' is not a digit and
strtoull() fails without being noticed.

Fix this by advancing the second parameter to function comment__symbol()
by one byte before invocation and add an error check after strtoull()
has been called.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 6de783b6f50f ("perf annotate: Resolve symbols using objdump comment")
Link: http://lkml.kernel.org/r/20171128075632.72182-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/annotate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -146,6 +146,8 @@ static int comment__symbol(char *raw, ch
 		return 0;
 
 	*addrp = strtoull(comment, &endptr, 16);
+	if (endptr == comment)
+		return 0;
 	name = strchr(endptr, '<');
 	if (name == NULL)
 		return -1;
@@ -251,8 +253,8 @@ static int mov__parse(struct ins_operand
 	while (comment[0] != '\0' && isspace(comment[0]))
 		++comment;
 
-	comment__symbol(ops->source.raw, comment, &ops->source.addr, &ops->source.name);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->source.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 
@@ -298,7 +300,7 @@ static int dec__parse(struct ins_operand
 	while (comment[0] != '\0' && isspace(comment[0]))
 		++comment;
 
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 }
