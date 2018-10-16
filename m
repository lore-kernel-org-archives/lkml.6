Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA58EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691602089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn1DspiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691602089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeJQBHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeJQBHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6936920866;
        Tue, 16 Oct 2018 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710144;
        bh=yPgfc6Vx1ULJjLQWsfGLB0zwD+93pryNAfotWae5c9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dn1DspiP8bQHWJQ6565O0Q3GPB3oVM7u47HGWLdpdUdK8v5DH8ev4Tr7fpsCV6GP4
         a4IZeQ+kXFFh3H5F6n15TkRIU7OjSTXdEurVipW+fxh8zJ4nmE2kcfo7RlJkRhgoxc
         7TeLOjB9eq8wAYvIlMRp+rz0x2K25kZeEP98flGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.18 116/135] vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced pointers
Date:   Tue, 16 Oct 2018 19:05:46 +0200
Message-Id: <20181016170523.328805998@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 62165600ae73ebd76e2d9b992b36360408d570d8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/vsprintf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2769,7 +2769,7 @@ int bstr_printf(char *buf, size_t size,
 						copy = end - str;
 					memcpy(str, args, copy);
 					str += len;
-					args += len;
+					args += len + 1;
 				}
 			}
 			if (process)


