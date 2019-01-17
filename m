Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596F120856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547711892;
	bh=k737BUtgiJSYQxUnNYSqndlyw5oWbBeoTcKQjicgsE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Bg06sY2oUlzmNJPv+ZAGnP9f4e6kgv0m3b3PdWTeCWkTGRM9TS3q+PVRYpPPkf88K
	 fl0+Xv1NGFi9k5ThIQc+1aNRC7ZNgBULDUWUd1+rlbenlbDE4d6RMPVz1+zkgvY+bG
	 WF6oKv2uKZGy0riA37MYqeaQIWaONIsTXgi6HJMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfAQH6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfAQH6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:58:10 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F6320851;
        Thu, 17 Jan 2019 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547711889;
        bh=k737BUtgiJSYQxUnNYSqndlyw5oWbBeoTcKQjicgsE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=prZRNz75WgtRRIvSQejvI5H5982OVLJ6nN6joDf9kJFW493X9qfepdSgEtpaeu0XA
         hEO6fbi1lBDZ+cZgkrWJaIQhlrxUOrnfeAdJq0rvl0BGqiJtBChE5rckr2pwaJhmhS
         qTSpjj5n58eNW593gtXm3zDe7Z3+sulzopT84uHE=
Date:   Thu, 17 Jan 2019 16:58:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
Message-Id: <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
In-Reply-To: <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
References: <20190116084021.34b0beee@gandalf.local.home>
        <20190116141629.5752-1-andreas.ziegler@fau.de>
        <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
        <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 08:40:05 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> On 17.01.19 07:01, Masami Hiramatsu wrote:
> > On Wed, 16 Jan 2019 15:16:29 +0100
> > Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> > 
> >> When printing multiple uprobe arguments as strings the output for the
> >> earlier arguments would also include all later string arguments.
> >>
> >> This is best explained in an example:
> >>
> >> Consider adding a uprobe to a function receiving two strings as
> >> parameters which is at offset 0xa0 in strlib.so and we want to print
> >> both parameters when the uprobe is hit (on x86_64):
> >>
> >> $ echo 'p:func /lib/strlib.so:0xa0 +0(%di):string +0(%si):string' > \
> >>     /sys/kernel/debug/tracing/uprobe_events
> >>
> >> When the function is called as func("foo", "bar") and we hit the probe,
> >> the trace file shows a line like the following:
> >>
> >>   [...] func: (0x7f7e683706a0) arg1="foobar" arg2="bar"
> >>
> >> Note the extra "bar" printed as part of arg1. This behaviour stacks up
> >> for additional string arguments.
> >>
> >> The strings are stored in a dynamically growing part of the uprobe
> >> buffer by fetch_store_string() after copying them from userspace via
> >> strncpy_from_user(). The return value of strncpy_from_user() is then
> >> directly used as the required size for the string. However, this does
> >> not take the terminating null byte into account as the documentation
> >> for strncpy_from_user() cleary states that it "[...] returns the
> >> length of the string (not including the trailing NUL)" even though the
> >> null byte will be copied to the destination.
> >>
> >> Therefore, subsequent calls to fetch_store_string() will overwrite
> >> the terminating null byte of the most recently fetched string with
> >> the first character of the current string, leading to the
> >> "accumulation" of strings in earlier arguments in the output.
> >>
> >> Fix this by incrementing the return value of strncpy_from_user() by
> >> one if we did not hit the maximum buffer size.
> >>
> > 
> > Yeah, I had eventually same conclusion. However, you also have to increse
> > the return value of fetch_store_strlen() too. (And I found another issue)
> > 
> 
> I don't think we need to increase that since the documentation for
> strnlen_user() says that it "[r]eturns the size of the string
> INCLUDING the terminating NUL." so its return value will already be
> one more than that of strncpy_from_user().

Ah, I got it.
Hmm, in that case, I have to update my patch in the previous mail.
Anyway,

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!!

> 
> Thanks,
> 
> Andreas
> 
> > Could you fix fetch_store_strlen in the same patch?
> > 
> > Thank you,
> > 
> >> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> >> ---
> >> v2: removed a wrong check for (ret > 0)
> >>
> >>  kernel/trace/trace_uprobe.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> >> index e335576b9411..3a1d5ab6b4ba 100644
> >> --- a/kernel/trace/trace_uprobe.c
> >> +++ b/kernel/trace/trace_uprobe.c
> >> @@ -160,6 +160,13 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> >>  	if (ret >= 0) {
> >>  		if (ret == maxlen)
> >>  			dst[ret - 1] = '\0';
> >> +		else
> >> +			/*
> >> +			 * Include the terminating null byte. In this case it
> >> +			 * was copied by strncpy_from_user but not accounted
> >> +			 * for in ret.
> >> +			 */
> >> +			ret++;
> >>  		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> >>  	}
> >>
> >> --
> >> 2.17.1
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
