Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8B9217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBZOon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:44:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:35114 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:44:43 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gydyK-0000CQ-Id; Tue, 26 Feb 2019 15:44:40 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gydyK-000IE6-BC; Tue, 26 Feb 2019 15:44:40 +0100
Subject: Re: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
To:     zerons <sironhide0null@gmail.com>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <564058e0-1432-676e-2f83-c8694911d8e5@iogearbox.net>
Date:   Tue, 26 Feb 2019 15:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25372/Tue Feb 26 11:34:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2019 03:15 PM, zerons wrote:
> [ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]

Thanks for the fix! What do you mean by "upstream commit" above in this context?

> In bpf/syscall.c, bpf_map_get_fd_by_id() use bpf_map_inc_not_zero() to increase
> the refcount, both map->refcnt and map->usercnt. Then, if bpf_map_new_fd() fails,
> should handle map->usercnt too.
> 
> Signed-off-by: zerons <sironhide0null@gmail.com>
> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cf5040f..db1ed12 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1966,7 +1966,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
> 
>  	fd = bpf_map_new_fd(map, f_flags);
>  	if (fd < 0)
> -		bpf_map_put(map);
> +		bpf_map_put_with_uref(map);
> 
>  	return fd;
>  }
> --
> 2.7.4
> 

