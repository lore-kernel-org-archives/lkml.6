Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A51C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E26320989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjhtrzOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E26320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeK2KXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbeK2KXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:23:38 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D5F2081C;
        Wed, 28 Nov 2018 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543447221;
        bh=4hVC0bXJdusco9DiSuVeg0iyg9NsTVT28sGOmQsqEN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjhtrzOtBlOP48oyhELZgJIbocw+HSDX+DVoeC1v/oF5PDl/GBxWFBYkcrD0xGFoJ
         xwhRhPbuxUT30JyQhbnrGwik+zoD1w1jmigVT/Mvs4wkNXykwFZS4W+KRprcmyVI7o
         Xa1UkVACudhFsUM91NO5LQ5OtUXJp+u02yC1AkSI=
Date:   Wed, 28 Nov 2018 15:20:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, dhowells@redhat.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] KEYS: fix parsing invalid pkey info string
Message-ID: <20181128232019.GC131170@gmail.com>
References: <000000000000c220960579c4936d@google.com>
 <20181103173035.23974-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103173035.23974-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 10:30:35AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> We need to check the return value of match_token() for Opt_err (-1)
> before doing anything with it.
> 
> Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/keys/keyctl_pkey.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 783978842f13a..987fac8051d70 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
>  		if (*p == '\0' || *p == ' ' || *p == '\t')
>  			continue;
>  		token = match_token(p, param_keys, args);
> +		if (token == Opt_err)
> +			return -EINVAL;
>  		if (__test_and_set_bit(token, &token_mask))
>  			return -EINVAL;
>  		q = args[0].from;
> -- 
> 2.19.1

Ping.  David, are you planning to apply this?

- Eric
