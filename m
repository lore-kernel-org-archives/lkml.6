Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F121C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486321A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486321A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeHQT5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:57:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbeHQT5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3545AD48;
        Fri, 17 Aug 2018 16:53:44 +0000 (UTC)
Date:   Fri, 17 Aug 2018 09:53:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        manfred@colorfullife.com
Subject: Re: [PATCH v8 2/5] ipc: IPCMNI limit check for semmni
Message-ID: <20180817165334.GA3677@linux-r8p5>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1529317698-16575-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018, Waiman Long wrote:

>For SysV semaphores, the semmni value is the last part of the 4-element
>sem number array. To make semmni behave in a similar way to msgmni and
>shmmni, we can't directly use the _minmax handler. Instead, a special
>sem specific handler is added to check the last argument to make sure
>that it is limited to the [0, IPCMNI] range. An error will be returned
>if this is not the case.
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> ipc/ipc_sysctl.c | 23 ++++++++++++++++++++++-
> ipc/util.h       |  9 +++++++++
> 2 files changed, 31 insertions(+), 1 deletion(-)
>
>diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>index f87cb29..49f9bf4 100644
>--- a/ipc/ipc_sysctl.c
>+++ b/ipc/ipc_sysctl.c
>@@ -88,12 +88,33 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
> 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
> }
>
>+static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>+	void __user *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	int ret, semmni;
>+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>+
>+	semmni = ns->sem_ctls[3];
>+	ret = proc_ipc_dointvec(table, write, buffer, lenp, ppos);
>+
>+	if (!ret)
>+		ret = sem_check_semmni(current->nsproxy->ipc_ns);
>+
>+	/*
>+	 * Reset the semmni value if an error happens.
>+	 */
>+	if (ret)
>+		ns->sem_ctls[3] = semmni;
>+	return ret;
>+}
>+
> #else
> #define proc_ipc_doulongvec_minmax NULL
> #define proc_ipc_dointvec	   NULL
> #define proc_ipc_dointvec_minmax   NULL
> #define proc_ipc_dointvec_minmax_orphans   NULL
> #define proc_ipc_auto_msgmni	   NULL
>+#define proc_ipc_sem_dointvec	   NULL
> #endif
>
> static int zero;
>@@ -175,7 +196,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
> 		.data		= &init_ipc_ns.sem_ctls,
> 		.maxlen		= 4*sizeof(int),
> 		.mode		= 0644,
>-		.proc_handler	= proc_ipc_dointvec,
>+		.proc_handler	= proc_ipc_sem_dointvec,
> 	},
> #ifdef CONFIG_CHECKPOINT_RESTORE
> 	{
>diff --git a/ipc/util.h b/ipc/util.h
>index 0aba323..8e9c52c 100644
>--- a/ipc/util.h
>+++ b/ipc/util.h
>@@ -218,6 +218,15 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
> void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
> 		void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
>
>+static inline int sem_check_semmni(struct ipc_namespace *ns) {
>+	/*
>+	 * Check semmni range [0, IPCMNI]
>+	 * semmni is the last element of sem_ctls[4] array
>+	 */
>+	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > IPCMNI))
>+		? -ERANGE : 0;
>+}
>+
> #ifdef CONFIG_COMPAT
> #include <linux/compat.h>
> struct compat_ipc_perm {
>-- 
>1.8.3.1
>
