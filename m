Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8CFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F0C2124D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F0C2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeHZJ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 05:57:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56088 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeHZJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 05:57:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ftoKt-0005c2-4u; Sun, 26 Aug 2018 06:15:46 +0000
Date:   Sun, 26 Aug 2018 07:15:43 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180826061534.GT6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826055801.GA42063@beast>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:58:01PM -0700, Kees Cook wrote:
> Via u32_change(), TCA_U32_SEL has an unspecified type in the netlink
> policy, so max length isn't enforced, only minimum. This means nkeys
> (from userspace) was being trusted without checking the actual size of
> nla_len(), which could lead to a memory over-read, and ultimately an
> exposure via a call to u32_dump(). Reachability is CAP_NET_ADMIN within
> a namespace.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This should go through -stable please, but I have left off the "Cc:
> stable" as per netdev patch policy. Note that use of struct_size()
> will need manual expansion in backports, such as:
> 	sel_size = sizeof(*s) + sizeof(*s->keys) * s->nkeys;

Saner approach would be sel_size = offsetof(struct tc_u32_sel, keys[s->nkeys])...

> +	sel_size = struct_size(s, keys, s->nkeys);
> +	if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
> +		err = -EINVAL;
> +		goto erridr;
> +	}
>  
> -	n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
> +	n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);

ITYM
	n = kzalloc(offsetof(struct tc_u_common, sel.keys[s->nkeys]), GFP_KERNEL);
