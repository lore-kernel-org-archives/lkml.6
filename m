Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD890C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BED02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfAGXDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:03:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:03:38 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4378A5AA;
        Mon,  7 Jan 2019 23:03:37 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:03:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: allow the null signal in rt_sigqueueinfo()
Message-Id: <20190107150336.4fc75d2aa20b637a259e50b3@linux-foundation.org>
In-Reply-To: <20190105054729.40397-1-cai@lca.pw>
References: <20190105054729.40397-1-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Jan 2019 00:47:29 -0500 Qian Cai <cai@lca.pw> wrote:

> Running the trinity fuzzer triggered this,
> 
> UBSAN: Undefined behaviour in kernel/signal.c:2946:7
> shift exponent 4294967295 is too large for 64-bit type 'long unsigned
> int'
> [ 3752.406618]  dump_stack+0xe0/0x17a
> [ 3752.419817]  ubsan_epilogue+0xd/0x4e
> [ 3752.423429]  __ubsan_handle_shift_out_of_bounds+0x1d6/0x227
> [ 3752.447269]  known_siginfo_layout.cold.9+0x16/0x1b
> [ 3752.452105]  __copy_siginfo_from_user+0x4b/0x70
> [ 3752.466620]  do_syscall_64+0x164/0x7ea
> [ 3752.565030]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> This is because signo is 0 from userspace, and then it ends up calling
> (1UL << -1) in sig_specific_sicodes(). Since the null signal (0) is
> allowed in the spec, just deal with it accordingly.
> 
> ...
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2943,7 +2943,7 @@ static bool known_siginfo_layout(unsigned sig, int si_code)
>  	if (si_code == SI_KERNEL)
>  		return true;
>  	else if ((si_code > SI_USER)) {
> -		if (sig_specific_sicodes(sig)) {
> +		if (sig && sig_specific_sicodes(sig)) {
>  			if (si_code <= sig_sicodes[sig].limit)
>  				return true;
>  		}

Maybe.

- What happens if userspace passes in si_code == -1?  

- If we are to check the validity of the userspace-provided input
  then it would be better to do that up-front, right at the point where
  the data is copied in from userspace.  That's better than checking it
  several layers deep in one particular place which hit an issue.

