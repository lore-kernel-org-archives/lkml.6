Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7128D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbeLUXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390930AbeLUXZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:25:11 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8813E21929;
        Fri, 21 Dec 2018 23:25:09 +0000 (UTC)
Date:   Fri, 21 Dec 2018 18:25:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181221182507.2fdc756f@gandalf.local.home>
In-Reply-To: <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
        <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 15:19:33 -0800
Joe Perches <joe@perches.com> wrote:

> I believe this should be bool.
> 
> I don't find a use for non-zero assigned len value in the kernel
> for strncmp and I believe the function should simply be:
> 
> static inline bool str_has_prefix(const char *str, const char prefix[])
> {
> 	return !strncmp(str, prefix, strlen(prefix));
> }

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3bb2b3351e35..e4566b9c2553 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -172,8 +172,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 		 * it's not worth the risk */
 		return -EINVAL;
 
-	if (strncmp(buf, temp, sizeof(temp) - 1) == 0) {
-		buf += sizeof(temp) - 1;
+	if ((len = str_has_prefix(buf, temp))) {
+		buf += len;
 		sdkp->cache_override = 1;
 	} else {
 		sdkp->cache_override = 0;

And there's more places like this.

> 
> It's hard to believe __always_inline vs inline matters
> for any single line function.

I've been burnt by gcc deciding to not inline single functions before.
Why take the chance? It also documents that I must be inlined, and not
just a hint.

-- Steve

