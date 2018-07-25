Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14AF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPHkag17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14AF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeGYPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbeGYPZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:25:58 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1D120843;
        Wed, 25 Jul 2018 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532528046;
        bh=IsArdNKx9qLUg3zCYe5+tgSxzAOsxWouKewk9UZgGb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aPHkag173/tIGR2JRNBj1oyai0bYHyY/DTHm2tL2rf5ouEx9xNGChArMtcH+zILRT
         /gOzMiCGKbo5mDufs+9rbVWfuj0522bN8V3LoqUDnHhIoyST/fCjAEwMeIeUYipmta
         srdThTU3uig46+g4+USYNdjZgDjxPLcObOXdtfN8=
Date:   Wed, 25 Jul 2018 23:14:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-Id: <20180725231402.1f9d8754cee6b35b7dee7b3c@kernel.org>
In-Reply-To: <20180724224149.0767fd13@gandalf.local.home>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
        <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
        <20180724164959.3cbc1422@gandalf.local.home>
        <20180724173008.454cdf10@gandalf.local.home>
        <20180724191331.738eb819@gandalf.local.home>
        <20180725101653.09e095092a4bb77e6fc558df@kernel.org>
        <20180724224149.0767fd13@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 22:41:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 25 Jul 2018 10:16:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hm, as far as I can see, when register_trigger() returns >= 0, it already
> > calls ->init the trigger_data. This means its refcount++, and in that
> > case, below patch will miss to free the trigger_data.
> > How about below for tentative fix?
> > 
> > 	if (!ret) {
> > 		ret = -ENOENT;
> > 		/* We have to forcibly free the trigger_data */
> > 		goto out_free;
> > 	} else if (ret > 0)
> > 		ret = 0;
> 
> Or better yet, match it properly:

OK, this looks good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> out_reg:
> 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
> 	event_trigger_init(trigger_ops, trigger_data);
> 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> 	/*
> 	 * The above returns on success the # of functions enabled,
> 	 * but if it didn't find any functions it returns zero.
> 	 * Consider no functions a failure too.
> 	 */
> 	if (!ret) {
> 		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
> 		ret = -ENOENT;
> 	} else if (ret > 0)
> 		ret = 0;
> 
> 	/* Down the counter of trigger_data or free it if not used anymore */
> 	event_trigger_free(trigger_ops, trigger_data);
>  out:
> 	return ret;
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
