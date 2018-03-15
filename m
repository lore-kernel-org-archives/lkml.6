Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCOADs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:03:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751835AbeCOADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:03:46 -0400
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com> <20180314202020.3794-4-bauerman@linux.vnet.ibm.com> <20180314214045.GC14289@mail.hallyn.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
In-reply-to: <20180314214045.GC14289@mail.hallyn.com>
Date: Wed, 14 Mar 2018 21:03:36 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18031500-0004-0000-0000-000013CD9AE6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008675; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003137; UDB=6.00510491; IPR=6.00782468;
 MB=3.00020039; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 00:03:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031500-0005-0000-0000-000086776C33
Message-Id: <87efkmjjc7.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Serge,

Thanks for quickly reviewing these patches!

Serge E. Hallyn <serge@hallyn.com> writes:

> Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> @@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  	}
>>  
>>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
>> -	if ((status != INTEGRITY_PASS) &&
>> -	    (status != INTEGRITY_PASS_IMMUTABLE) &&
>> -	    (status != INTEGRITY_UNKNOWN)) {
>> -		if ((status == INTEGRITY_NOLABEL)
>> -		    || (status == INTEGRITY_NOXATTRS))
>> -			cause = "missing-HMAC";
>> -		else if (status == INTEGRITY_FAIL)
>> -			cause = "invalid-HMAC";
>> +	switch (status) {
>> +	case INTEGRITY_PASS:
>> +	case INTEGRITY_PASS_IMMUTABLE:
>> +	case INTEGRITY_UNKNOWN:
>
> Wouldn't it be more future-proof to replace this with a 'default', or
> to at least add a "default: BUG()" to catch new status values?

I agree. I like the "default: BUG()" option.

>> +		break;
>> +	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>> +	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>> +		cause = "missing-HMAC";
>> +		goto out;
>> +	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>> +		cause = "invalid-HMAC";
>>  		goto out;
>>  	}
>> +
>>  	switch (xattr_value->type) {
>>  	case IMA_XATTR_DIGEST_NG:
>>  		/* first byte contains algorithm id */
>> @@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else if (status != INTEGRITY_PASS) {
>> +		/* Fix mode, but don't replace file signatures. */
>>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>>  		    (!xattr_value ||
>>  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>>  			if (!ima_fix_xattr(dentry, iint))
>>  				status = INTEGRITY_PASS;
>> -		} else if ((inode->i_size == 0) &&
>> -			   (iint->flags & IMA_NEW_FILE) &&
>> -			   (xattr_value &&
>> -			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
>> +		}
>> +
>> +		/* Permit new files with file signatures, but without data. */
>> +		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>
> This may be correct, but it's not identical to what you're replacing.
> Since in either case you're setting status to INTEGRITY_PASS the final
> result is the same, but with a few extra possible steps.  Not sure
> whether that matters.

Good point. I'll have to defer this one to Mimi though.

>
>> +		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
>>  			status = INTEGRITY_PASS;
>>  		}
>> +
>>  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else {


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
