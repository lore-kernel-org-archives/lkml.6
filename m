Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988CC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57412084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfAYDVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:21:02 -0500
Received: from mail.hallyn.com ([178.63.66.53]:52676 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfAYDVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:21:02 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DBF63C8A; Thu, 24 Jan 2019 21:20:59 -0600 (CST)
Date:   Thu, 24 Jan 2019 21:20:59 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@redhat.com>, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak103 V1] audit: add support for fcaps v3
Message-ID: <20190125032059.GA10044@mail.hallyn.com>
References: <f8348d1e67d66e8e5d42e3bdfbda7e88139f2d31.1548297089.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8348d1e67d66e8e5d42e3bdfbda7e88139f2d31.1548297089.git.rgb@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:36:25PM -0500, Richard Guy Briggs wrote:
> V3 namespaced file capabilities were introduced in
> commit 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> 
> Add support for these by adding the "frootid" field to the existing
> fcaps fields in the NAME and BPRM_FCAPS records.
> 
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/103
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Looks like good info to have,

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> Passes audit-testsuite.
> 
>  include/linux/capability.h | 5 +++--
>  kernel/audit.c             | 6 ++++--
>  kernel/audit.h             | 1 +
>  kernel/auditsc.c           | 4 ++++
>  security/commoncap.c       | 2 ++
>  5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index f640dcbc880c..f6bb691547fd 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -14,7 +14,7 @@
>  #define _LINUX_CAPABILITY_H
>  
>  #include <uapi/linux/capability.h>
> -
> +#include <linux/uidgid.h>
>  
>  #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
>  #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
> @@ -25,11 +25,12 @@
>  	__u32 cap[_KERNEL_CAPABILITY_U32S];
>  } kernel_cap_t;
>  
> -/* exact same as vfs_cap_data but in cpu endian and always filled completely */
> +/* exact same as vfs_ns_cap_data but in cpu endian and always filled completely */
>  struct cpu_vfs_cap_data {
>  	__u32 magic_etc;
>  	kernel_cap_t permitted;
>  	kernel_cap_t inheritable;
> +	kuid_t rootid;
>  };
>  
>  #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ca55ccb46b76..6f5eeb658ccb 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2083,8 +2083,9 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>  {
>  	audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
>  	audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
> -	audit_log_format(ab, " cap_fe=%d cap_fver=%x",
> -			 name->fcap.fE, name->fcap_ver);
> +	audit_log_format(ab, " cap_fe=%d cap_fver=%x cap_frootid=%d",
> +			 name->fcap.fE, name->fcap_ver,
> +			 from_kuid(&init_user_ns, name->fcap.rootid));
>  }
>  
>  static inline int audit_copy_fcaps(struct audit_names *name,
> @@ -2103,6 +2104,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  	name->fcap.permitted = caps.permitted;
>  	name->fcap.inheritable = caps.inheritable;
>  	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> +	name->fcap.rootid = caps.rootid;
>  	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
>  				VFS_CAP_REVISION_SHIFT;
>  
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 6ffb70575082..deefdbe61a47 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -69,6 +69,7 @@ struct audit_cap_data {
>  		kernel_cap_t	effective;	/* effective set of process */
>  	};
>  	kernel_cap_t		ambient;
> +	kuid_t			rootid;
>  };
>  
>  /* When fs/namei.c:getname() is called, we store the pointer in name and bump
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b585ceb2f7a2..461c52eff870 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1358,6 +1358,9 @@ static void audit_log_exit(void)
>  			audit_log_cap(ab, "pi", &axs->new_pcap.inheritable);
>  			audit_log_cap(ab, "pe", &axs->new_pcap.effective);
>  			audit_log_cap(ab, "pa", &axs->new_pcap.ambient);
> +			audit_log_format(ab, " frootid=%d",
> +					 from_kuid(&init_user_ns,
> +						   axs->fcap.rootid));
>  			break; }
>  
>  		}
> @@ -2355,6 +2358,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  	ax->fcap.permitted = vcaps.permitted;
>  	ax->fcap.inheritable = vcaps.inheritable;
>  	ax->fcap.fE = !!(vcaps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> +	ax->fcap.rootid = vcaps.rootid;
>  	ax->fcap_ver = (vcaps.magic_etc & VFS_CAP_REVISION_MASK) >> VFS_CAP_REVISION_SHIFT;
>  
>  	ax->old_pcap.permitted   = old->cap_permitted;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 232db019f051..c097f3568001 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -643,6 +643,8 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
>  	cpu_caps->permitted.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
>  	cpu_caps->inheritable.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
>  
> +	cpu_caps->rootid = rootkuid;
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
