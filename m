Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA66C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9D208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9D208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeGJPED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:04:03 -0400
Received: from h2.hallyn.com ([78.46.35.8]:59818 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933709AbeGJPD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:03:59 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 58E98120D23; Tue, 10 Jul 2018 10:03:58 -0500 (CDT)
Date:   Tue, 10 Jul 2018 10:03:58 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] apparmor: Fully initialize aa_perms struct when
 answering userspace query
Message-ID: <20180710150358.GD1661@mail.hallyn.com>
References: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
 <1530854701-7348-3-git-send-email-tyhicks@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530854701-7348-3-git-send-email-tyhicks@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tyler Hicks (tyhicks@canonical.com):
> Fully initialize the aa_perms struct in profile_query_cb() to avoid the
> potential of using an uninitialized struct member's value in a response
> to a query from userspace.
> 
> Detected by CoverityScan CID#1415126 ("Uninitialized scalar variable")
> 
> Fixes: 4f3b3f2d79a4 ("apparmor: add profile permission query ability")
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/apparmorfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 949dd8a48164..e09fe4d7307c 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -603,7 +603,7 @@ static const struct file_operations aa_fs_ns_revision_fops = {
>  static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
>  			     const char *match_str, size_t match_len)
>  {
> -	struct aa_perms tmp;
> +	struct aa_perms tmp = { };
>  	struct aa_dfa *dfa;
>  	unsigned int state = 0;
>  
> @@ -613,7 +613,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
>  		dfa = profile->file.dfa;
>  		state = aa_dfa_match_len(dfa, profile->file.start,
>  					 match_str + 1, match_len - 1);
> -		tmp = nullperms;
>  		if (state) {
>  			struct path_cond cond = { };
>  
> @@ -627,8 +626,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
>  					 match_str, match_len);
>  		if (state)
>  			aa_compute_perms(dfa, state, &tmp);
> -		else
> -			tmp = nullperms;
>  	}
>  	aa_apply_modes_to_perms(profile, &tmp);
>  	aa_perms_accum_raw(perms, &tmp);
> -- 
> 2.7.4
