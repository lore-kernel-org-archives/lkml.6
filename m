Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933541AbeEICHM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:07:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50747 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932115AbeEICHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:07:05 -0400
X-ME-Sender: <xms:yFfyWjyWSQpK1QM8nMmyNWOQxPMUcReGjCeOXBQFx7KCVDrU18uIPg>
Date: Wed, 9 May 2018 12:07:00 +1000
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH ghak81 RFC V1 4/5] audit: use inline function to set
 audit context
Message-ID: <20180509020700.GE7517@eros>
References: <cover.1525466167.git.rgb@redhat.com>
 <2f0566af8ccafdaf400a3d002cb4aef9b80e44cf.1525466167.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0566af8ccafdaf400a3d002cb4aef9b80e44cf.1525466167.git.rgb@redhat.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:54:37PM -0400, Richard Guy Briggs wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to set the audit context pointer for the task
> rather than reaching directly into the task struct to set it.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 8 ++++++++
>  kernel/auditsc.c      | 6 +++---
>  kernel/fork.c         | 2 +-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 93e4c61..dba0d45 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -235,6 +235,10 @@ extern void __audit_inode_child(struct inode *parent,
>  extern void __audit_seccomp(unsigned long syscall, long signr, int code);
>  extern void __audit_ptrace(struct task_struct *t);
>  
> +static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
> +{
> +	task->audit_context = ctx;
> +}
>  static inline struct audit_context *audit_context(struct task_struct *task)
>  {
>  	return task->audit_context;
> @@ -472,6 +476,10 @@ static inline bool audit_dummy_context(void)
>  {
>  	return true;
>  }
> +static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
> +{
> +	task->audit_context = ctx;
> +}

If audit_context is an internal audit value why do we set it when
CONFIG_AUDITSYSCALL is not set?

thanks,
Tobin.
