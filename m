Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94151C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D220881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9D220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJPB3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:29:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37384 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJPB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:29:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gC6tP-0002HK-NM; Mon, 15 Oct 2018 11:42:59 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gC6tO-0006KR-Sa; Mon, 15 Oct 2018 11:42:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     nagarathnam.muthusamy@oracle.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        serge.hallyn@ubuntu.com, oleg@redhat.com,
        prakash.sangappa@oracle.com, khlebnikov@yandex-team.ru,
        luto@amacapital.net, jannh@google.com
References: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
Date:   Mon, 15 Oct 2018 12:42:44 -0500
In-Reply-To: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        (nagarathnam muthusamy's message of "Mon, 15 Oct 2018 11:10:27 -0600")
Message-ID: <874ldnnm23.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gC6tO-0006KR-Sa;;;mid=<874ldnnm23.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19b7oQjZYAa5xEASyK7ymh37aCcz5drflE=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] Allow user namespace inside chroot
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Have you considered using pivot_root to drop all of the pieces of the
filesystem you don't want to be visible?  That should be a much better
solution overall.

It is must a matter of:
mount --bind /path/you/would/chroot/to
pivot_root /path/you/would/chroot/to /put/old
umount -l /put/old

You might need to do something like make --rprivate before calling
pivot_root to stop mount propagation to the parent.  But I can't
image it to be a practical problem.


Also note that being in a chroot tends to indicate one of two things,
being in an old build system, or being in some kind of chroot jail.
Because of the jails created with chroot we want to be very careful
with enabling user namespaces in that context.

There have been some very clever people figuring out how to get out of
chroot jails by passing file descriptors between processes and using
things like pivot root.

Even if your analysis is semantically perfect there is the issue of
increasing the attack surface of preexising chroot jails.  I believe
that would make the kernel more vulnerable overall, and for only
a very small simplification of implementation details.

So unless I am missing something I don't see the use case for this that
would not be better served by just properly setting up your mount
namespace, and the attack surface increase of chroot jails makes we
very relucatant to see a change like this.

Eric

nagarathnam.muthusamy@oracle.com writes:

> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>
> Following commit disables the creation of user namespace inside
> the chroot environment.
>
> userns: Don't allow creation if the user is chrooted
>
> commit 3151527ee007b73a0ebd296010f1c0454a919c7d
>
> Consider a system in which a non-root user creates a combination
> of user, pid and mount namespaces and confines a process to it.
> The system will have multiple levels of nested namespaces.
> The root namespace in the system will have lots of directories
> which should not be exposed to the child confined to the set of
> namespaces.
>
> Without chroot, we will have to hide all unwanted directories
> individually using bind mounts and mount namespace. Chroot enables
> us to expose a handpicked list of directories which the child
> can see but if we use chroot we wont be able to create nested
> namespaces.
>
> Allowing a process to create user namespace within a chroot
> environment will enable it to chroot, which in turn can be used
> to escape the jail.
>
> This patch drops the chroot privilege when user namespace is
> created within the chroot environment so the process cannot
> use it to escape the chroot jail. The process can still modify
> the view of the file system using mount namespace but for those
> modifications to be useful, it needs to run a setuid program with
> that intented uid directly mapped into the user namespace as it is
> which is not possible for an unprivileged process.
>
> If there were any other corner cases which were considered while
> deciding to disable the creation of user namespace as a whole
> within the chroot environment please let me know.
>
> Signed-off-by: Nagarathnam Muthusamy<nagarathnam.muthusamy@oracle.com>
> ---
>  kernel/user_namespace.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index e5222b5..83d2a70 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -44,7 +44,7 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>  	return dec_ucount(ucounts, UCOUNT_USER_NAMESPACES);
>  }
>  
> -static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
> +static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns, int is_chrooted)
>  {
>  	/* Start with the same capabilities as init but useless for doing
>  	 * anything as the capabilities are bound to the new user namespace.
> @@ -55,6 +55,11 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  	cred->cap_effective = CAP_FULL_SET;
>  	cred->cap_ambient = CAP_EMPTY_SET;
>  	cred->cap_bset = CAP_FULL_SET;
> +	if (is_chrooted) {
> +		cap_lower(cred->cap_permitted, CAP_SYS_CHROOT);
> +		cap_lower(cred->cap_effective, CAP_SYS_CHROOT);
> +		cap_lower(cred->cap_bset, CAP_SYS_CHROOT);
> +	}
>  #ifdef CONFIG_KEYS
>  	key_put(cred->request_key_auth);
>  	cred->request_key_auth = NULL;
> @@ -78,6 +83,7 @@ int create_user_ns(struct cred *new)
>  	kgid_t group = new->egid;
>  	struct ucounts *ucounts;
>  	int ret, i;
> +	int is_chrooted = 0;
>  
>  	ret = -ENOSPC;
>  	if (parent_ns->level > 32)
> @@ -88,14 +94,12 @@ int create_user_ns(struct cred *new)
>  		goto fail;
>  
>  	/*
> -	 * Verify that we can not violate the policy of which files
> -	 * may be accessed that is specified by the root directory,
> -	 * by verifing that the root directory is at the root of the
> -	 * mount namespace which allows all files to be accessed.
> +	 * Drop the chroot privilege when a user namespace is created inside
> +	 * chrooted environment so that the file system view presented to a
> +	 * non-admin process is preserved.
>  	 */
> -	ret = -EPERM;
>  	if (current_chrooted())
> -		goto fail_dec;
> +		is_chrooted = 1;
>  
>  	/* The creator needs a mapping in the parent user namespace
>  	 * or else we won't be able to reasonably tell userspace who
> @@ -140,7 +144,7 @@ int create_user_ns(struct cred *new)
>  	if (!setup_userns_sysctls(ns))
>  		goto fail_keyring;
>  
> -	set_cred_user_ns(new, ns);
> +	set_cred_user_ns(new, ns, is_chrooted);
>  	return 0;
>  fail_keyring:
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
> @@ -1281,7 +1285,7 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>  		return -ENOMEM;
>  
>  	put_user_ns(cred->user_ns);
> -	set_cred_user_ns(cred, get_user_ns(user_ns));
> +	set_cred_user_ns(cred, get_user_ns(user_ns), 0);
>  
>  	return commit_creds(cred);
>  }
