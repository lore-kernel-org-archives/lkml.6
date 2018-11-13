Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8908C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D702087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D702087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeKMUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:25:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731276AbeKMUZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:25:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A107B6D0;
        Tue, 13 Nov 2018 10:27:43 +0000 (UTC)
Date:   Tue, 13 Nov 2018 11:27:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: load_script: don't blindly truncate shebang
 string
Message-ID: <20181113102741.GN15120@dhcp22.suse.cz>
References: <20181112160931.GA28463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160931.GA28463@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-11-18 17:09:31, Oleg Nesterov wrote:
> load_script() simply truncates bprm->buf and this is very wrong if the
> length of shebang string exceeds BINPRM_BUF_SIZE-2. This can silently
> truncate i_arg or (worse) we can execute the wrong binary if buf[2:126]
> happens to be the valid executable path.
> 
> Change load_script() to return ENOEXEC if it can't find '\n' or zero in
> bprm->buf. Note that '\0' can come from either prepare_binprm()->memset()
> or from kernel_read(), we do not care.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

A bit cryptic to my taste but it looks correct. I have tried to come up
with something more tasty but I am afraid it would be just a matter of
taste.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/binfmt_script.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 7cde3f4..d0078cb 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -42,10 +42,14 @@ static int load_script(struct linux_binprm *bprm)
>  	fput(bprm->file);
>  	bprm->file = NULL;
>  
> -	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
> -	if ((cp = strchr(bprm->buf, '\n')) == NULL)
> -		cp = bprm->buf+BINPRM_BUF_SIZE-1;
> +	for (cp = bprm->buf+2;; cp++) {
> +		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
> +			return -ENOEXEC;
> +		if (!*cp || (*cp == '\n'))
> +			break;
> +	}
>  	*cp = '\0';
> +
>  	while (cp > bprm->buf) {
>  		cp--;
>  		if ((*cp == ' ') || (*cp == '\t'))
> -- 
> 2.5.0
> 
> 

-- 
Michal Hocko
SUSE Labs
