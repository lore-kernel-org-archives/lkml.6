Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017162152F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017162152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeI1SfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:35:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:39444 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1SfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:35:20 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5rcb-0001fR-Fr; Fri, 28 Sep 2018 14:11:49 +0200
Received: from [178.197.248.15] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5rcb-000HfH-Az; Fri, 28 Sep 2018 14:11:49 +0200
Subject: Re: [PATCH bpf-next] bpf: fix flags check in
 bpf_percpu_cgroup_storage_update()
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180928110648.22973-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c093c1ec-2da4-59ef-4617-f494b48952f0@iogearbox.net>
Date:   Fri, 28 Sep 2018 14:11:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180928110648.22973-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24989/Fri Sep 28 10:53:45 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 01:06 PM, Roman Gushchin wrote:
> Fix an issue in bpf_percpu_cgroup_storage_update(): it should return
> -EINVAL on an attempt to pass BPF_NOEXIST rather than BPF_EXIST.
> 
> Cgroup local storage is automatically created on attaching of a bpf
> program to a cgroup, and it can't be done from the userspace.
> 
> Fixes: 0daef9b42374 ("bpf: introduce per-cpu cgroup local storage")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/local_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index c739f6dcc3c2..190535f6d5e2 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -191,7 +191,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
>  	int cpu, off = 0;
>  	u32 size;
>  
> -	if (unlikely(map_flags & BPF_EXIST))
> +	if (map_flags & BPF_NOEXIST)
>  		return -EINVAL;

Hmm, this is also incorrect as any future reserved flag would be accepted here and
couldn't be extended anymore. :/ And it looks like cgroup_storage_update_elem() is
doing the same today, given the cgroups local storage is still early, we should route
a patch to stable for fixing this.

Wrt this series, given the series is top of tree right now, I would prefer a fresh
respin so we have the fix integrated properly w/o follow-up. Perhaps this could also
incorporate Alexei's previous cleanup suggestions as well from today if you have a
chance.

Thanks,
Daniel
