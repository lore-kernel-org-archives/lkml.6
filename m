Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCQPJs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 11:09:48 -0400
Received: from h2.hallyn.com ([78.46.35.8]:59750 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbeCQPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 11:09:43 -0400
Date: Sat, 17 Mar 2018 10:09:42 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
Message-ID: <20180317150942.GA10607@mail.hallyn.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
 <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
 <20180314214045.GC14289@mail.hallyn.com>
 <87efkmjjc7.fsf@morokweng.localdomain>
 <1521141514.3547.637.camel@linux.vnet.ibm.com>
 <874llhoz89.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874llhoz89.fsf@morokweng.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> 
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > On Wed, 2018-03-14 at 21:03 -0300, Thiago Jung Bauermann wrote:
> >> Hello Serge,
> >> 
> >> Thanks for quickly reviewing these patches!
> >> 
> >> Serge E. Hallyn <serge@hallyn.com> writes:
> >> 
> >> > Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> >> >> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >> >> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
> >> >>  	}
> >> >>  
> >> >>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> >> >> -	if ((status != INTEGRITY_PASS) &&
> >> >> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
> >> >> -	    (status != INTEGRITY_UNKNOWN)) {
> >> >> -		if ((status == INTEGRITY_NOLABEL)
> >> >> -		    || (status == INTEGRITY_NOXATTRS))
> >> >> -			cause = "missing-HMAC";
> >> >> -		else if (status == INTEGRITY_FAIL)
> >> >> -			cause = "invalid-HMAC";
> >> >> +	switch (status) {
> >> >> +	case INTEGRITY_PASS:
> >> >> +	case INTEGRITY_PASS_IMMUTABLE:
> >> >> +	case INTEGRITY_UNKNOWN:
> >> >
> >> > Wouldn't it be more future-proof to replace this with a 'default', or
> >> > to at least add a "default: BUG()" to catch new status values?
> >> 
> >> I agree. I like the "default: BUG()" option.
> >
> > Agreed. I would put it at the end after INTEGRITY_FAIL.
> 
> Ok, what about the version below?

Since the status is returned by evm, it seems like an actual BUG() is
appropriate, but ok.

Acked-by: Serge Hallyn <serge@hallyn.com>

> 
> >> 
> >> >> +		break;
> >> >> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
> >> >> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
> >> >> +		cause = "missing-HMAC";
> >> >> +		goto out;
> >> >> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
> >> >> +		cause = "invalid-HMAC";
> >> >>  		goto out;
> >> >>  	}
> >> >> +
> >> >>  	switch (xattr_value->type) {
> >> >>  	case IMA_XATTR_DIGEST_NG:
> >> >>  		/* first byte contains algorithm id */
> >> >> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
> >> >>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> >> >>  				    op, cause, rc, 0);
> >> >>  	} else if (status != INTEGRITY_PASS) {
> >> >> +		/* Fix mode, but don't replace file signatures. */
> >> >>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
> >> >>  		    (!xattr_value ||
> >> >>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> >> >>  			if (!ima_fix_xattr(dentry, iint))
> >> >>  				status = INTEGRITY_PASS;
> >> >> -		} else if ((inode->i_size == 0) &&
> >> >> -			   (iint->flags & IMA_NEW_FILE) &&
> >> >> -			   (xattr_value &&
> >> >> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
> >> >> +		}
> >> >> +
> >> >> +		/* Permit new files with file signatures, but without data. */
> >> >> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
> >> >
> >> > This may be correct, but it's not identical to what you're replacing.
> >> > Since in either case you're setting status to INTEGRITY_PASS the final
> >> > result is the same, but with a few extra possible steps.  Not sure
> >> > whether that matters.
> >> 
> >> Good point. I'll have to defer this one to Mimi though.
> >
> > The end result is the same, but add some needed comments.

Yes, the same, but with a few extra possible steps, impacting performance,
so I just wanted to call that out.

-serge
