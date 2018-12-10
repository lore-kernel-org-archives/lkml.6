Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03582084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544467693;
	bh=4tqcwQamZZd3CT3WdPjFGDU/ENYpSRFOjKMtvmhwaLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTrS7xrI9KmjGbKcbd75DJ9rmp1zeiX2H4jBcHM+rQvIs+WuOTz4d8QmcO0GV1gL8
	 iMG95DzetlqXQF/GgPAYnBvkErFqhD44HS7AHeakD8fzTwjStKs1kNpyxusDq8QK3O
	 jXzcY2xuqKSLPIg0ajplyu9izWZO2/e+DaI3ys8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03582084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeLJSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeLJSsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:48:12 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D2E2081F;
        Mon, 10 Dec 2018 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544467691;
        bh=4tqcwQamZZd3CT3WdPjFGDU/ENYpSRFOjKMtvmhwaLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4oKBn7gIUHHgOkWXHHErg5rHXeHz0nmOchamOnllIWKHWL8/CkF5qJbfLoyxuLxD
         JoPfbT3KV46XO0PXRXOuAnnwIkUK296oL02hWl8PPbFGePcHLYKZ9d9WhbIygU2aft
         qFL6oelGQdIEu9ZLuywE1sAoYcjaaib8TMpa+0v4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFF954042C; Mon, 10 Dec 2018 15:48:07 -0300 (-03)
Date:   Mon, 10 Dec 2018 15:48:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/lib/traceevent: Fix processing of dereferenced
 args in bprintk events
Message-ID: <20181210184807.GA26445@kernel.org>
References: <20181210134522.3f71e2ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210134522.3f71e2ca@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 10, 2018 at 01:45:22PM -0500, Steven Rostedt escreveu:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In the case that a bprintk event has a dereferenced pointer that is stored
> as a string, and there's more values to process (more args), the arg was not
> updated to point to the next arg after processing the dereferenced pointer,
> and it screwed up what was to be displayed.

Thanks, applied.
 
> Cc: stable@vger.kernel.org
> Fixes: 7db96bb49629 ("tools lib traceevent: Handle new pointer processing of bprint strings")

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/lib/traceevent/event-parse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 3692f29fee46..70144b98141c 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -4970,6 +4970,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
>  
>  				if (arg->type == TEP_PRINT_BSTRING) {
>  					trace_seq_puts(s, arg->string.string);
> +					arg = arg->next;
>  					break;
>  				}
>  
> -- 
> 2.19.1

-- 

- Arnaldo
