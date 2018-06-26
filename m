Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB523C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9054826477
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9054826477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965384AbeFZC7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965232AbeFZC7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:59:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDA26473;
        Tue, 26 Jun 2018 02:59:39 +0000 (UTC)
Date:   Mon, 25 Jun 2018 22:59:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: INFO: rcu detected stall in vprintk_emit
Message-ID: <20180625225937.43aee76c@vmware.local.home>
In-Reply-To: <20180626014924.GB11229@jagdpanzerIV>
References: <000000000000720530056f7f9b63@google.com>
        <20180626014924.GB11229@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 10:49:24 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> So we can try switching to ratelimited error reporting
> [that would be option A]:
> 
> ---
> 
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..2f3becb709b8 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -755,7 +755,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>  		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>  					 frag_len + LLCP_HEADER_SIZE, &err);
>  		if (pdu == NULL) {
> -			pr_err("Could not allocate PDU\n");
> +			pr_err_ratelimited("Could not allocate PDU\n");
>  			continue;
>  		}
>  
> ---
> 
> 
> Or ratelimited error reporting and cond_resched()
> [that would be option B]:

I don't think this is a printk() issue per se, so I think Option B is
the only option. You should not get stuck in an infinite loop if we run
short on memory. Perhaps we could have an Option C which would exit
this loop gracefully with some kind of error. But I haven't looked at
the surrounding code to be sure if that is possible.

-- Steve

> 
> ---
> 
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..61741db4c4e6 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -755,7 +755,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>  		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>  					 frag_len + LLCP_HEADER_SIZE, &err);
>  		if (pdu == NULL) {
> -			pr_err("Could not allocate PDU\n");
> +			pr_err_ratelimited("Could not allocate PDU\n");
> +			cond_resched();
>  			continue;
>  		}
>  
> ---

