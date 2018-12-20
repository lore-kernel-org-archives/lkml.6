Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C9D21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecVgviHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeLTT7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:59:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56008 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLTT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:59:01 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so3783253ith.5;
        Thu, 20 Dec 2018 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FiNUnM1PobeyvXKfXY8tw1lGWmdJa+39PNs2l1woFL0=;
        b=ecVgviHxIKhwKuJEp9F3Jd54zKvZrgLqQMShSVFqB++AE75BaqWd5c45F9fimwGYml
         RlIrX0E/fn5NUEcFpTHgmmgMa3ntFTRJIQ62pON6HcU1KwML6752hvq+0D7LlbtXgei0
         OyG2R24ldicQ1Had8LKMgenYXZc+NVX1jG9bWfrCkgKAX8213QMilBONFQoX4wi0k97K
         iQKLEsbdDzR+l0hpPx1GrEVDDuGoyVVg1tyrI6xJGfcB7HjlcsScz/xCDINdOVYxKoV4
         OBsIJYZgkZAbcg882dIzFf03orD659YsJ5j8/Uu/iCGpwSYJN8XnPhct/YNBHIF58w62
         yS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FiNUnM1PobeyvXKfXY8tw1lGWmdJa+39PNs2l1woFL0=;
        b=X+c6iLR4/FQmYhKNJtxDbnSHasLKjpeUCp8A4SAh2xzHJPYp6ylTBM+4/Ottj/6Ups
         /gg3XGe3BvWstsCwOrl+xHOUS3sUXRFBVPeyTE10b15fBFZPG+hOo2oBT/myoyRGPlA1
         NPaF+6kiXi0deBcf69udPi+SdCi4HaHo7wzeD0khpljdUmVZrE+9XcS71bBd8mGKqw/J
         jlypchOJLPJPpHqbHLODVyIxR29BiYlTWHBIuq+nr1m+cEcGu5OA0rLbeFPPPt9ODo+1
         IqzaxL+FcjDg2TuQThqaYG/eU90DquE8v37a82wGJUNrpkFpYvbmB+2Ye9i27uwNMJjK
         zg4Q==
X-Gm-Message-State: AJcUukez6R+M9VtP0ZQYrJnuqroIt8EQ6k7P2MYC/xgRc3tpHPcvtbuN
        Kf1clegxeM0524SWquRSHQ8=
X-Google-Smtp-Source: ALg8bN4x0UWQieGCr+XQTGrK85W5zYSmjFGB7+HhwqUjFGe2BGVmvCgj29BBn1Lj3obvLu8/Zbej8w==
X-Received: by 2002:a24:9b87:: with SMTP id o129mr44423itd.128.1545335940624;
        Thu, 20 Dec 2018 11:59:00 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:5dec])
        by smtp.gmail.com with ESMTPSA id r63sm5464831ita.2.2018.12.20.11.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:58:59 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:58:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix a missing check of return value
Message-ID: <20181220195855.akmg7dcg2njz25gs@ast-mbp.dhcp.thefacebook.com>
References: <20181220194557.29196-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220194557.29196-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:45:56PM -0600, Kangjie Lu wrote:
> check_reg_arg() may fail and not mark correct data in "env".  This
> fix inserts a check that ensures check_reg_arg() is successful, and
> if it is not, the fix stops further operations and returns an error
> upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 51ba84d4d34a..ced8cc6470b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2619,7 +2619,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	/* after the call registers r0 - r5 were scratched */
>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>  		mark_reg_not_init(env, caller->regs, caller_saved[i]);
> -		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> +		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> +		if (err)
> +			return err;

it cannot fail here.
we have the same pattern in few other places where we know it cannot fail.
I prefer to leave the code as-is.

