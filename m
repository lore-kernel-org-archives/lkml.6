Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE720857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEE720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeGaMNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:13:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:35053 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:13:50 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkRyi-0005mQ-0X; Tue, 31 Jul 2018 12:34:08 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkRyh-000Mst-Pb; Tue, 31 Jul 2018 12:34:07 +0200
Subject: Re: [PATCH v4 bpf-next 08/14] bpf: introduce the
 bpf_get_local_storage() helper function
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180727215243.3850-1-guro@fb.com>
 <20180727215243.3850-9-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f07d5417-4a55-c92f-800c-4950f4dc8aee@iogearbox.net>
Date:   Tue, 31 Jul 2018 12:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180727215243.3850-9-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24799/Tue Jul 31 10:44:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 07/27/2018 11:52 PM, Roman Gushchin wrote:
> The bpf_get_local_storage() helper function is used
> to get a pointer to the bpf local storage from a bpf program.
> 
> It takes a pointer to a storage map and flags as arguments.
> Right now it accepts only cgroup storage maps, and flags
> argument has to be 0. Further it can be extended to support
> other types of local storage: e.g. thread local storage etc.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/bpf.h      |  2 ++
>  include/uapi/linux/bpf.h | 13 ++++++++++++-
>  kernel/bpf/cgroup.c      |  2 ++
>  kernel/bpf/core.c        |  1 +
>  kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
>  kernel/bpf/verifier.c    | 18 ++++++++++++++++++
>  net/core/filter.c        | 23 ++++++++++++++++++++++-
>  7 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ca4ac2a39def..cd8790d2c6ed 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -788,6 +788,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
>  extern const struct bpf_func_proto bpf_sock_hash_update_proto;
>  extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
>  
> +extern const struct bpf_func_proto bpf_get_local_storage_proto;
> +
>  /* Shared helpers among cBPF and eBPF. */
>  void bpf_user_rnd_init_once(void);
>  u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a0aa53148763..495180f229ee 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2081,6 +2081,16 @@ union bpf_attr {
>   * 	Return
>   * 		A 64-bit integer containing the current cgroup id based
>   * 		on the cgroup within which the current task is running.
> + *
> + * void* get_local_storage(void *map, u64 flags)
> + *	Description
> + *		Get the pointer to the local storage area.
> + *		The type and the size of the local storage is defined
> + *		by the *map* argument.
> + *		The *flags* meaning is specific for each map type,
> + *		and has to be 0 for cgroup local storage.
> + *	Return
> + *		Pointer to the local storage area.
>   */

I think it would be crucial to clarify what underlying assumption the
program writer can make with regards to concurrent access to this storage.

E.g. in this context, can _only_ BPF_XADD be used for counters as otherwise
any other type of access may race in parallel, or are we protected by the
socket lock and can safely override all data in this buffer via normal stores
(e.g. for socket related progs)? What about other types?

Right now nothing is mentioned here, but I think it must be clarified to
avoid any surprises. E.g. in normal htab case program can at least use the
map update there for atomic value updates, but those are disallowed from
the cgroup local storage, hence my question. Btw, no need to resend, I can
also update the paragraph there.

Thanks,
Daniel
