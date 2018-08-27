Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F80C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A52208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A52208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeH0OXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:23:23 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:52087 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbeH0OXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:23:23 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 27 Aug 2018 19:37:15 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 27 Aug 2018 19:37:15 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 27 Aug 2018 19:37:15 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Message-ID: <20180827103715.GB8065@sejong>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška wrote:
> The patch changes interpretation of:
> callq  *0x8(%rbx)
> 
> from:
>   0.26 │     → callq  *8
> to:
>   0.26 │     → callq  *0x8(%rbx)
> 
> in this can an address is followed by a register, thus
> one can't parse only address.

Also there's a case with no offset like:  callq  *%rbx


> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/util/annotate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> 

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e4268b948e0e..e32ead4744bd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  
>  indirect_call:
>  	tok = strchr(endptr, '*');
> -	if (tok != NULL)
> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
> +	if (tok != NULL) {
> +		endptr++;
> +
> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
> +		 * Do not parse such instruction.  */
> +		if (strstr(endptr, "(%r") == NULL)
> +			ops->target.addr = strtoull(endptr, NULL, 16);

It seems too x86-specific, what about this? (not tested)


indirect_call:
	tok = strchr(endptr, '*');
	if (tok != NULL) {
		endptr++;
		if (!isdigit(*endptr))
			return 0;

		addr = strtoull(endptr, &endptr, 0);
		if (*endptr != '('))
			ops->target.addr = addr;


Thanks,
Namhyung


> +	}
>  	goto find_target;
>  }
>  
> 

