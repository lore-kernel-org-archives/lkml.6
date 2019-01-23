Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98EFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19A621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAWI60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:58:26 -0500
Received: from www62.your-server.de ([213.133.104.62]:47970 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:58:25 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gmEMY-0004vt-UB; Wed, 23 Jan 2019 09:58:23 +0100
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gmEMY-000H3v-Np; Wed, 23 Jan 2019 09:58:22 +0100
Subject: Re: [PATCH] bpftool: Fix prog dump by tag
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Lance Digby <ldigby@redhat.com>
References: <20190118125817.10763-1-jolsa@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <182563c3-8e11-d489-2e9e-68a391e63f3e@iogearbox.net>
Date:   Wed, 23 Jan 2019 09:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190118125817.10763-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25323/Wed Jan 23 03:43:38 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/2019 01:58 PM, Jiri Olsa wrote:
> Lance reported an issue with bpftool not being able to
> dump program if there are more programs loaded and you
> want to dump any but the first program, like:
> 
>   # bpftool prog
>   28: kprobe  name trace_req_start  tag 1dfc28ba8b3dd597  gpl
>   	loaded_at 2019-01-18T17:02:40+1100  uid 0
>   	xlated 112B  jited 109B  memlock 4096B  map_ids 13
>   29: kprobe  name trace_req_compl  tag 5b6a5ecc6030a683  gpl
>   	loaded_at 2019-01-18T17:02:40+1100  uid 0
>   	xlated 928B  jited 575B  memlock 4096B  map_ids 13,14
>   #  bpftool prog dum jited tag 1dfc28ba8b3dd597
>    0:	push   %rbp
>    1:	mov    %rsp,%rbp
>   ...
> 
>   #  bpftool prog dum jited tag 5b6a5ecc6030a683
>   Error: can't get prog info (29): Bad address
> 
> The problem is in the prog_fd_by_tag function not cleaning
> the struct bpf_prog_info before another request, so the
> previous program length is still in there and kernel assumes
> it needs to dump the program, which fails because there's no
> user pointer set.
> 
> Moving the struct bpf_prog_info declaration into the loop,
> so it gets cleaned before each query.
> 
> Reported-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Applied to bpf and added Fixes tags, thanks!
