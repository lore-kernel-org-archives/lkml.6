Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBUG5G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 01:57:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750740AbeBUG5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 01:57:05 -0500
Date: Wed, 21 Feb 2018 01:52:59 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH] audit: return on memory error to avoid null pointer
 dereference
Message-ID: <20180221065259.k4nj4yio2l5gkcxw@madcap2.tricolour.ca>
References: <c2736eba58e5eb8e1f977ff1d0a98644592be847.1519194702.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2736eba58e5eb8e1f977ff1d0a98644592be847.1519194702.git.rgb@redhat.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-21 01:47, Richard Guy Briggs wrote:
> If there is a memory allocation error when trying to change an audit
> kernel feature value, the ignored allocation error will trigger a NULL
> pointer dereference oops on subsequent use of that pointer.  Return
> instead.
> 
> See: https://github.com/linux-audit/audit-kernel/issues/76
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Self-NACK.  It was based on local development and won't compile on
upstream.  Fix pending.

> ---
>  kernel/audit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 196d327..31cb11d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1063,6 +1063,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>  		return;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> +	if (!ab)
> +		return;
>  	audit_log_task_info(ab, current);
>  	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
>  			 audit_feature_names[which], !!old_feature, !!new_feature,
> -- 
> 1.8.3.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
