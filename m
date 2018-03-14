Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCNVkt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:40:49 -0400
Received: from h2.hallyn.com ([78.46.35.8]:45498 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeCNVkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:40:47 -0400
Date: Wed, 14 Mar 2018 16:40:45 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
Message-ID: <20180314214045.GC14289@mail.hallyn.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
 <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Replace nested ifs in the EVM xattr verification logic with a switch
> statement, making the code easier to understand.
> 
> Also, add comments to the if statements in the out section and constify the
> cause variable.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_appraise.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 0c5f94b7b9c3..dd10ecbdce45 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -215,7 +215,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  			     int xattr_len, int opened)
>  {
>  	static const char op[] = "appraise_data";
> -	char *cause = "unknown";
> +	const char *cause = "unknown";
>  	struct dentry *dentry = file_dentry(file);
>  	struct inode *inode = d_backing_inode(dentry);
>  	enum integrity_status status = INTEGRITY_UNKNOWN;
> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>  
>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> -	if ((status != INTEGRITY_PASS) &&
> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
> -	    (status != INTEGRITY_UNKNOWN)) {
> -		if ((status == INTEGRITY_NOLABEL)
> -		    || (status == INTEGRITY_NOXATTRS))
> -			cause = "missing-HMAC";
> -		else if (status == INTEGRITY_FAIL)
> -			cause = "invalid-HMAC";
> +	switch (status) {
> +	case INTEGRITY_PASS:
> +	case INTEGRITY_PASS_IMMUTABLE:
> +	case INTEGRITY_UNKNOWN:

Wouldn't it be more future-proof to replace this with a 'default', or
to at least add a "default: BUG()" to catch new status values?

> +		break;
> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
> +		cause = "missing-HMAC";
> +		goto out;
> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
> +		cause = "invalid-HMAC";
>  		goto out;
>  	}
> +
>  	switch (xattr_value->type) {
>  	case IMA_XATTR_DIGEST_NG:
>  		/* first byte contains algorithm id */
> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>  				    op, cause, rc, 0);
>  	} else if (status != INTEGRITY_PASS) {
> +		/* Fix mode, but don't replace file signatures. */
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>  		    (!xattr_value ||
>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>  			if (!ima_fix_xattr(dentry, iint))
>  				status = INTEGRITY_PASS;
> -		} else if ((inode->i_size == 0) &&
> -			   (iint->flags & IMA_NEW_FILE) &&
> -			   (xattr_value &&
> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
> +		}
> +
> +		/* Permit new files with file signatures, but without data. */
> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&

This may be correct, but it's not identical to what you're replacing.
Since in either case you're setting status to INTEGRITY_PASS the final
result is the same, but with a few extra possible steps.  Not sure
whether that matters.

> +		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
>  			status = INTEGRITY_PASS;
>  		}
> +
>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>  				    op, cause, rc, 0);
>  	} else {
