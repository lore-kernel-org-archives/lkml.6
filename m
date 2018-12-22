Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B494C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEE221928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404650AbeLVAGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbeLVAGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:06:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4040621928;
        Sat, 22 Dec 2018 00:06:31 +0000 (UTC)
Date:   Fri, 21 Dec 2018 19:06:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181221190629.6f7fdf74@gandalf.local.home>
In-Reply-To: <20181221181316.6d32bdc8@gandalf.local.home>
References: <20181221181316.6d32bdc8@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 18:13:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static __always_inline int str_has_prefix(const char *str, const char *prefix)

I'm thinking it is cleaner to have two helper functions and have them
both return bool.

static __always_inline bool str_has_prefix(const char *str, const char *prefix)
{
	return !strncmp(str, prefix, strlen(prefix));
}

( I still like to keep the __always_inline, it doesn't hurt )

And I'll make a separate patch that adds:

static __always_inline bool
str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)
{
	*len = strlen(prefix);
	return !strncmp(str, prefix, *len) ? *len : 0;
}

Everyone OK with that?

-- Steve
