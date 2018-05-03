Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeECBnO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:43:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751861AbeECBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:43:10 -0400
Subject: Re: [PATCH] evm: Don't update hmacs in user ns mounts
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <james.l.morris@oracle.com>
Date: Wed, 02 May 2018 21:43:03 -0400
In-Reply-To: <87r2mtybhf.fsf@xmission.com>
References: <87r2mtybhf.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050301-0040-0000-0000-000004355780
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050301-0041-0000-0000-0000263977BC
Message-Id: <1525311783.3238.19.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030012
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 16:49 -0500, Eric W. Biederman wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
> Date: Fri, 22 Dec 2017 15:32:35 +0100
> 
> The kernel should not calculate new hmacs for mounts done by
> non-root users. Update evm_calc_hmac_or_hash() to refuse to
> calculate new hmacs for mounts for non-init user namespaces.
> 
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
> Mimi this patch has been floating around for a while and it appears to
> be the only piece missing from the vfs to make unprivileged mounts safe
> (at least semantically).  Do you want to merge this through your integrity
> tree or should merge this through my userns tree?

Matthew's EVM patches don't conflict with this change, so either way
is fine.

Mimi

> 
>  security/integrity/evm/evm_crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index a46fba322340..facf9cdd577d 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -200,7 +200,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  	int size;
>  	bool ima_present = false;
> 
> -	if (!(inode->i_opflags & IOP_XATTR))
> +	if (!(inode->i_opflags & IOP_XATTR) ||
> +	    inode->i_sb->s_user_ns != &init_user_ns)
>  		return -EOPNOTSUPP;
> 
>  	desc = init_desc(type);
