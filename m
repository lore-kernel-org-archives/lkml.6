Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E304DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB39820664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB39820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbeKXG4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:56:15 -0500
Received: from www62.your-server.de ([213.133.104.62]:54140 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeKXG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:56:14 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gQHmT-0007PL-If; Fri, 23 Nov 2018 21:10:25 +0100
Received: from [178.197.248.22] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gQHmT-0008kW-Bn; Fri, 23 Nov 2018 21:10:25 +0100
Subject: Re: [PATCH 1/3] bpf/verifier: Log instruction patching when verbose
 logging is enabled
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
 <20181123183455.qjokyt6zpa2yck6s@xylophone.i.decadent.org.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b1d395a1-076a-054d-09ae-9d9242b1c29a@iogearbox.net>
Date:   Fri, 23 Nov 2018 21:10:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181123183455.qjokyt6zpa2yck6s@xylophone.i.decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25146/Fri Nov 23 15:18:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2018 07:34 PM, Ben Hutchings wrote:
> User-space does not have access to the patched eBPF code, but we
> need to be able to test that patches are being applied.  Therefore
> log distinct messages for each case that requires patching.

Thanks for the patches, Ben! Above is actually not the case, e.g. privileged
admin can use something like 'bpftool prog dump xlated id <id>' and then the
BPF insns are dumped to user space for the program /after/ the verification,
so the rewrites can then be seen. test_verifier temporarily drops caps to
load and run the unprivileged cases, but we can extend the test suite to
retrieve and check the final insns after that happened. I think this would be
a nice extension to the test suite for cases like these and would also provide
better insight than verbose() statement saying that something has been
patched (but not the actual result of it).

Thanks,
Daniel

> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  kernel/bpf/verifier.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ce049cd30a3..ea4bc796e545 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5844,6 +5844,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			verbose(env, "bpf verifier is misconfigured\n");
>  			return -EINVAL;
>  		} else if (cnt) {
> +			verbose(env, "patching in prologue\n");
>  			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
> @@ -5892,6 +5893,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			};
>  
>  			cnt = ARRAY_SIZE(patch);
> +			verbose(env,
> +				"patching in sanitization against SSB at %d\n",
> +				i + delta);
>  			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
> @@ -5973,6 +5977,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			}
>  		}
>  
> +		verbose(env, "patching explicit ctx access at %d\n", i + delta);
>  		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  		if (!new_prog)
>  			return -ENOMEM;
> @@ -6225,6 +6230,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 1 : 0);
>  			}
>  
> +			verbose(env, "patching in divide-by-zero check at %d\n",
> +				i + delta);
>  			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
> @@ -6244,6 +6251,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  				return -EINVAL;
>  			}
>  
> +			verbose(env, "patching implicit ctx access at %d\n",
> +				i + delta);
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
> @@ -6307,6 +6316,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  								 map)->index_mask);
>  			insn_buf[2] = *insn;
>  			cnt = 3;
> +			verbose(env, "patching in tail-call bounds check at %d",
> +				i + delta);
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
> @@ -6342,6 +6353,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> +				verbose(env, "patching in map lookup at %d",
> +					i + delta);
>  				new_prog = bpf_patch_insn_data(env, i + delta,
>  							       insn_buf, cnt);
>  				if (!new_prog)
> 

