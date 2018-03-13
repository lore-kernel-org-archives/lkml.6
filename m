Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeCMFQn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:16:43 -0400
Received: from namei.org ([65.99.196.166]:52738 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeCMFQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:16:42 -0400
Date: Tue, 13 Mar 2018 16:16:04 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>, Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] exec: Set file unwritable before LSM check
In-Reply-To: <20180309193020.GA5149@beast>
Message-ID: <alpine.LRH.2.21.1803131615390.21929@namei.org>
References: <20180309193020.GA5149@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Kees Cook wrote:

> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a race between the Time of Check
> (the call to security_kernel_read_file() which could read the file and
> make access policy decisions) and the Time of Use (starting with
> kernel_read_file()'s reading of the file contents). In theory, file
> contents could change between the two.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: Clarify the ToC/ToU race (Linus)


I'll merge this unless Al objects (cc'd).

> 
> Only loadpin and SELinux currently implement this hook. From what
> I can see, this won't change anything for either of them. IMA calls
> kernel_read_file(), but looking there it seems those callers won't be
> negatively impacted either. Can folks double-check this and send an
> Ack please?
> ---
>  fs/exec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 7eb8d21bcab9..a919a827d181 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -895,13 +895,13 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
>  		return -EINVAL;
>  
> -	ret = security_kernel_read_file(file, id);
> +	ret = deny_write_access(file);
>  	if (ret)
>  		return ret;
>  
> -	ret = deny_write_access(file);
> +	ret = security_kernel_read_file(file, id);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	i_size = i_size_read(file_inode(file));
>  	if (max_size > 0 && i_size > max_size) {
> 

-- 
James Morris
<jmorris@namei.org>
