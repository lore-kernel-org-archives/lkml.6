Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeCKDIS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 22:08:18 -0500
Received: from alln-iport-4.cisco.com ([173.37.142.91]:49691 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeCKDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 22:08:15 -0500
X-IronPort-AV: E=Sophos;i="5.47,453,1515456000";
   d="scan'208";a="82242987"
Date: Sat, 10 Mar 2018 19:08:13 -0800 (PST)
From: Victor Kamensky <kamensky@cisco.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Taras Kondratiuk <takondra@cisco.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v3 15/15] selinux: delay sid population for rootfs till
 init is complete
In-Reply-To: <1519152994.14218.15.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.00.1803101900250.24419@sjc-ads-6991.cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>  <1518813234-5874-19-git-send-email-takondra@cisco.com> <1519152994.14218.15.camel@tycho.nsa.gov>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Feb 2018, Stephen Smalley wrote:

> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>> From: Victor Kamensky <kamensky@cisco.com>
>>
>> With initramfs cpio format that supports extended attributes
>> we need to skip sid population on sys_lsetxattr call from
>> initramfs for rootfs if security server is not initialized yet.
>>
>> Otherwise callback in selinux_inode_post_setxattr will try to
>> translate give security.selinux label into sid context and since
>> security server is not available yet inode will receive default
>> sid (typically kernel_t). Note that in the same time proper
>> label will be stored in inode xattrs. Later, since inode sid
>> would be already populated system will never look back at
>> actual xattrs. But if we skip sid population for rootfs and
>> we have policy that direct use of xattrs for rootfs, proper
>> sid will be filled in from extended attributes one node is
>> accessed and server is initialized.
>>
>> Note new DELAYAFTERINIT_MNT super block flag is introduced
>> to only mark rootfs for such behavior. For other types of
>> tmpfs original logic is still used.
>
> (cc selinux maintainers)
>
> Wondering if we shouldn't just do this always, for all filesystem
> types.

Ok, I think it makes sense. The one that do not support xattrs
will not reach selinux_inode_post_setxattr anyway. And try
to cache sid while !ss_initialized is not good idea for any
filesystem types.

> Also, I think this should likely also be done in
> selinux_inode_setsecurity() for consistency.

I am not sure that I follow selinux_inode_setsecurity suggestion.
selinux_inode_setsecurity is about permission check. And
selinux_inode_post_setxattr deals with processing and setting
side effects if xattr was "security.selinux", it does not
matter what happens in selinux_inode_setsecurity if it
returns access_ok, LSM will still call selinux_inode_post_setxattr
and we would need to check and not produce any sid caching
side effects if !ss_initialized.

Sitll keeping logic in selinux_inode_post_setxattr, checked
that the following with much simple code works too:

>From bfc54e4805f3059671417ff2cda1266bc68e18f9 Mon Sep 17 00:00:00 2001
From: Victor Kamensky <kamensky@cisco.com>
Date: Fri, 9 Mar 2018 23:06:08 -0800
Subject: [PATCH 2/2] selinux: delay sid population in setxattr till policy
  loaded

With initramfs cpio format that supports extended attributes
we need to skip sid population on sys_lsetxattr call from
initramfs for rootfs if security server is not initialized yet.

Otherwise callback in selinux_inode_post_setxattr will try to
translate give security.selinux label into sid context and since
security server is not available yet inode will receive default
sid (typically kernel_t). Note that in the same time proper
label will be stored in inode xattrs. Later, since inode sid
would be already populated system will never look back at
actual xattrs. But if we skip sid population for rootfs and
we have policy that direct use of xattrs for rootfs, proper
sid will be filled in from extended attributes one node is
accessed and server is initialized.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
  security/selinux/hooks.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 31303ed..4c13759 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3197,6 +3197,10 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
  		return;
  	}

+        if (!ss_initialized) {
+                return;
+        }
+
  	rc = security_context_to_sid_force(value, size, &newsid);
  	if (rc) {
  		printk(KERN_ERR "SELinux:  unable to map context to SID"
-- 
2.7.4

Thanks,
Victor

>>
>> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
>> ---
>>  security/selinux/hooks.c            | 9 ++++++++-
>>  security/selinux/include/security.h | 1 +
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index f3fe65589f02..bb25268f734e 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -716,7 +716,7 @@ static int selinux_set_mnt_opts(struct
>> super_block *sb,
>>  			 */
>>  			if (!strncmp(sb->s_type->name, "rootfs",
>>  				     sizeof("rootfs")))
>> -				sbsec->flags |= SBLABEL_MNT;
>> +				sbsec->flags |=
>> SBLABEL_MNT|DELAYAFTERINIT_MNT;
>>
>>  			/* Defer initialization until
>> selinux_complete_init,
>>  			   after the initial policy is loaded and
>> the security
>> @@ -3253,6 +3253,7 @@ static void selinux_inode_post_setxattr(struct
>> dentry *dentry, const char *name,
>>  {
>>  	struct inode *inode = d_backing_inode(dentry);
>>  	struct inode_security_struct *isec;
>> +	struct superblock_security_struct *sbsec;
>>  	u32 newsid;
>>  	int rc;
>>
>> @@ -3261,6 +3262,12 @@ static void selinux_inode_post_setxattr(struct
>> dentry *dentry, const char *name,
>>  		return;
>>  	}
>>
>> +	if (!ss_initialized) {
>> +		sbsec = inode->i_sb->s_security;
>> +		if (sbsec->flags & DELAYAFTERINIT_MNT)
>> +			return;
>> +	}
>> +
>>  	rc = security_context_to_sid_force(value, size, &newsid);
>>  	if (rc) {
>>  		printk(KERN_ERR "SELinux:  unable to map context to
>> SID"
>> diff --git a/security/selinux/include/security.h
>> b/security/selinux/include/security.h
>> index 02f0412d42f2..585acfd6cbcf 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -52,6 +52,7 @@
>>  #define ROOTCONTEXT_MNT	0x04
>>  #define DEFCONTEXT_MNT	0x08
>>  #define SBLABEL_MNT	0x10
>> +#define DELAYAFTERINIT_MNT 0x20
>>  /* Non-mount related flags */
>>  #define SE_SBINITIALIZED	0x0100
>>  #define SE_SBPROC		0x0200
>
