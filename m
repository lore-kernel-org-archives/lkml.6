Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967241AbeE2Vca (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:32:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966946AbeE2Vc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:32:26 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: Re: [PATCH 6/8] integrity: Factor out common part of integrity_audit_msg()
Date: Tue, 29 May 2018 17:32:22 -0400
Message-ID: <2600105.j2Wzuo56oP@x2>
Organization: Red Hat
In-Reply-To: <20180524201105.3179904-7-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-7-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 24, 2018 4:11:03 PM EDT Stefan Berger wrote:
> Factor out a common part of integrity_audit_msg() that others
> can also call.

After all of these changes, do you mind sending an example event for testing/
review?

Thanks,
-Steve

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  security/integrity/integrity.h       | 16 ++++++++++++++++
>  security/integrity/integrity_audit.c | 24 ++++++++++++++++--------
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/security/integrity/integrity.h
> b/security/integrity/integrity.h index 5e58e02ba8dc..9f2924cafa53 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -15,6 +15,7 @@
>  #include <linux/integrity.h>
>  #include <crypto/sha.h>
>  #include <linux/key.h>
> +#include <linux/audit.h>
> 
>  /* iint action cache flags */
>  #define IMA_MEASURE		0x00000001
> @@ -197,6 +198,11 @@ static inline void evm_load_x509(void)
>  void integrity_audit_msg(int audit_msgno, struct inode *inode,
>  			 const unsigned char *fname, const char *op,
>  			 const char *cause, int result, int info);
> +
> +void integrity_audit_msg_common(struct audit_buffer *ab, struct inode
> *inode, +				const unsigned char *fname, const char *op,
> +				const char *cause, int result);
> +
>  #else
>  static inline void integrity_audit_msg(int audit_msgno, struct inode
> *inode, const unsigned char *fname,
> @@ -204,4 +210,14 @@ static inline void integrity_audit_msg(int
> audit_msgno, struct inode *inode, int result, int info)
>  {
>  }
> +
> +static inline void integrity_audit_msg_common(struct audit_buffer *ab,
> +					      struct inode *inode,
> +					      const unsigned char *fname,
> +					      const char *op,
> +					      const char *cause,
> +					      int result)
> +{
> +}
> +
>  #endif
> diff --git a/security/integrity/integrity_audit.c
> b/security/integrity/integrity_audit.c index 8d25d3c4dcca..8f80b7c042a7
> 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -28,17 +28,12 @@ static int __init integrity_audit_setup(char *str)
>  }
>  __setup("integrity_audit=", integrity_audit_setup);
> 
> -void integrity_audit_msg(int audit_msgno, struct inode *inode,
> -			 const unsigned char *fname, const char *op,
> -			 const char *cause, int result, int audit_info)
> +void integrity_audit_msg_common(struct audit_buffer *ab, struct inode
> *inode, +				const unsigned char *fname, const char *op,
> +				const char *cause, int result)
>  {
> -	struct audit_buffer *ab;
>  	char name[TASK_COMM_LEN];
> 
> -	if (!integrity_audit_info && audit_info == 1)	/* Skip info messages */
> -		return;
> -
> -	ab = audit_log_start(current->audit_context, GFP_KERNEL, audit_msgno);
>  	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
>  			 task_pid_nr(current),
>  			 from_kuid(&init_user_ns, current_cred()->uid),
> @@ -59,5 +54,18 @@ void integrity_audit_msg(int audit_msgno, struct inode
> *inode, audit_log_d_path_exe(ab, current->mm);
>  	audit_log_tty(ab, current);
>  	audit_log_format(ab, " res=%d", !result);
> +}
> +
> +void integrity_audit_msg(int audit_msgno, struct inode *inode,
> +			 const unsigned char *fname, const char *op,
> +			 const char *cause, int result, int audit_info)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (!integrity_audit_info && audit_info == 1)	/* Skip info messages */
> +		return;
> +
> +	ab = audit_log_start(current->audit_context, GFP_KERNEL, audit_msgno);
> +	integrity_audit_msg_common(ab, inode, fname, op, cause, result);
>  	audit_log_end(ab);
>  }
