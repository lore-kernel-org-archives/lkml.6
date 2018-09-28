Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F46C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67E8216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67E8216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeI1URG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:17:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:46673 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1URF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:17:05 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5tCh-0002Pp-3A; Fri, 28 Sep 2018 15:53:11 +0200
Received: from [178.197.248.15] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5tCg-000C35-U5; Fri, 28 Sep 2018 15:53:10 +0200
Subject: Re: [PATCH bpf] bpf: harden flags check in
 cgroup_storage_update_elem()
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180928133321.31121-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2b829425-96c7-aa51-d783-f727c4ef96d6@iogearbox.net>
Date:   Fri, 28 Sep 2018 15:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180928133321.31121-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24989/Fri Sep 28 10:53:45 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 03:33 PM, Roman Gushchin wrote:
> cgroup_storage_update_elem() shouldn't accept any flags
> argument values except BPF_ANY and BPF_EXIST to guarantee
> the backward compatibility, had a new flag value been added.
> 
> Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/local_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index f8746e6a9a35..2a7680106320 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -130,7 +130,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
>  	struct bpf_cgroup_storage *storage;
>  	struct bpf_storage_buffer *new;
>  
> -	if (flags & BPF_NOEXIST)
> +	if (flags != BPF_ANY && flags != BPF_EXIST)
>  		return -EINVAL;
>  
>  	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
> 

Applied to bpf, thanks!
