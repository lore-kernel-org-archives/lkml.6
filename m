Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E2218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbeLUXoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:44:46 -0500
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:32906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729993AbeLUXoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:44:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BBBEB837F243;
        Fri, 21 Dec 2018 23:44:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crime30_8085851411b13
X-Filterd-Recvd-Size: 2862
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Dec 2018 23:44:43 +0000 (UTC)
Message-ID: <75e15c5d66ecd6964231be0f5b3cf702ac242bc1.camel@perches.com>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 21 Dec 2018 15:44:41 -0800
In-Reply-To: <20181221182507.2fdc756f@gandalf.local.home>
References: <20181221181316.6d32bdc8@gandalf.local.home>
         <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
         <20181221182507.2fdc756f@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 18:25 -0500, Steven Rostedt wrote:
> On Fri, 21 Dec 2018 15:19:33 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > I believe this should be bool.
> > 
> > I don't find a use for non-zero assigned len value in the kernel
> > for strncmp and I believe the function should simply be:
> > 
> > static inline bool str_has_prefix(const char *str, const char prefix[])
> > {
> > 	return !strncmp(str, prefix, strlen(prefix));
> > }
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
[]
> @@ -172,8 +172,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  		 * it's not worth the risk */
>  		return -EINVAL;
>  
> -	if (strncmp(buf, temp, sizeof(temp) - 1) == 0) {
> -		buf += sizeof(temp) - 1;
> +	if ((len = str_has_prefix(buf, temp))) {
> +		buf += len;

That's not really a use of the non-zero strncmp return value.

You are attempting an optimization not already done.
I also wonder if it's actually an optimization as the
return value may not be precomputed.

Also the assignment in the test isn't preferred style.

> And there's more places like this.

Any where the non-zero return value is actually used?

> > It's hard to believe __always_inline vs inline matters 
> > for any single line function.
> 
> I've been burnt by gcc deciding to not inline single functions before.

Complex single functions sure, but single line inlines?
I haven't seen that externed anywhere.

Today no inline function is marked __always_inline in
string.h

I don't doubt there should be some standardization
of inline vs __always_inline in the kernel, but this
right now seems different just for difference sake.

cheers, Joe

