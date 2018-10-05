Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB79C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DDF21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DDF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJFApQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:45:16 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:43234 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbeJFApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:45:16 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 36E9848007F;
        Fri,  5 Oct 2018 17:45:30 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 5 Oct 2018 10:45:26 -0700
Subject: Re: [PATCH] bpf: 32-bit RSH verification must truncate input before
 the ALU op
To:     Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
References: <20181005161759.177992-1-jannh@google.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <c34442b0-be90-450e-8c20-6e490cc45be9@solarflare.com>
Date:   Fri, 5 Oct 2018 18:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181005161759.177992-1-jannh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24136.004
X-TM-AS-Result: No-10.338800-4.000000-10
X-TMASE-MatchedRID: zGP2F0O7j/sOwH4pD14DsPHkpkyUphL9Kx5ICGp/WtE0QmmUihPzrOml
        /E2CK49bhG04o5fV97QPqYE5DXxgAseorcZK7iR7LUfH1TEwaN1flOpBqBHTt2HZ+cd7VyKXU7g
        EPucszGdOFu8ssjxG87BRsLxMbb3GkbPwnUYuDtM00dkxYNMRt78+q17GFLKR/uymSAhGxLJIkz
        YW7SvSIVp6dl1Bg4OErCdjRFVGO+tNfs8n85Te8oMbH85DUZXyseWplitmp0j6C0ePs7A07V9vM
        TaVNFNzhvIj0jzYPjbfQ6mqnEeeF3nyxugVZZoyTLJG1hhay74=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.338800-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24136.004
X-MDID: 1538761531-6x6hiOD_0UzQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/18 17:17, Jann Horn wrote:
> When I wrote commit 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification"), I
> assumed that, in order to emulate 64-bit arithmetic with 32-bit logic, it
> is sufficient to just truncate the output to 32 bits; and so I just moved
> the register size coercion that used to be at the start of the function to
> the end of the function.
>
> That assumption is true for almost every op, but not for 32-bit right
> shifts, because those can propagate information towards the least
> significant bit. Fix it by always truncating inputs for 32-bit ops to 32
> bits.
>
> Also get rid of the coerce_reg_to_size() after the ALU op, since that has
> no effect.
Might be worth saying something like "because src_reg is passed by value".
> Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
Acked-by: Edward Cree <ecree@solarflare.com>
>  kernel/bpf/verifier.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb07e74b34a2..465952a8e465 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2896,6 +2896,15 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>  	u64 umin_val, umax_val;
>  	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
Incidentally, I don't see why this needs to be a u64 (rather than say a u8).

-Ed
>  
> +	if (insn_bitness == 32) {
> +		/* Relevant for 32-bit RSH: Information can propagate towards
> +		 * LSB, so it isn't sufficient to only truncate the output to
> +		 * 32 bits.
> +		 */
> +		coerce_reg_to_size(dst_reg, 4);
> +		coerce_reg_to_size(&src_reg, 4);
> +	}
> +
>  	smin_val = src_reg.smin_value;
>  	smax_val = src_reg.smax_value;
>  	umin_val = src_reg.umin_value;
> @@ -3131,7 +3140,6 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>  	if (BPF_CLASS(insn->code) != BPF_ALU64) {
>  		/* 32-bit ALU ops are (32,32)->32 */
>  		coerce_reg_to_size(dst_reg, 4);
> -		coerce_reg_to_size(&src_reg, 4);
>  	}
>  
>  	__reg_deduce_bounds(dst_reg);


