Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90384C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5403A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5403A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeGYPIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58407 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeGYPIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:08:31 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFCED8764F;
        Wed, 25 Jul 2018 13:56:43 +0000 (UTC)
Received: from treble (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87FEC308332B;
        Wed, 25 Jul 2018 13:56:39 +0000 (UTC)
Date:   Wed, 25 Jul 2018 08:56:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix trace_probe flags in enable_trace_kprobe
Message-ID: <20180725135632.zmjq7cuqc7eshpsh@treble>
References: <20180725102826.8300-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180725102826.8300-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 25 Jul 2018 13:56:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:28:26PM +0200, Artem Savkov wrote:
> If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> it returns an error, but does not unset the tp flags it set previosly.

"previously"

> @@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
>  		else
>  			ret = enable_kprobe(&tk->rp.kp);
>  	}
> +
> +	if (ret) {
> +		if (file) {
> +			list_del(&link->list);

Should this be list_del_rcu(), since it was added to the list with
list_add_tail_rcu()?

-- 
Josh
