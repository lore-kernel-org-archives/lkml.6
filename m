Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A09C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B927208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceNkI5mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfACQPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:15:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35758 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfACQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:15:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so16193249pgs.2;
        Thu, 03 Jan 2019 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrkgaHMh2u9p8Ns1KqSB3JhFY8xj5t2AtuIXTwcShMI=;
        b=ceNkI5mCYdaCXAtqlgpOS6F9fPgCwkulXAVtmRW5P2h4ZNAgSRlY+1QXRtpG6e+Qqi
         Mtmj2OrY6xR8WqzYuj8rmxbmP+bG7MoFdGGhIqT6+AJ8WapCA7otU0ogJUiVt0D2wUNq
         u/If0xrlavs9WG0jp/oaptJKl0DmbcaQm6OnEMFQSVkAQD30QqNRc5D56UxJmrDbBxYO
         l8xixsLRfXIoiUkFGGgvxDx/RmDWdZS8/AyE5lUxcMElE/shK19lHYSi2K1wiMBUjRay
         1Nb2UrjfVr683MBPPsdiKAulniHumzNNzILMN3Mi6iv0JcAL/Mdfah9CYnoVshN0Xuf0
         hLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrkgaHMh2u9p8Ns1KqSB3JhFY8xj5t2AtuIXTwcShMI=;
        b=hN4ayvfEpsuvNnuND9bRCxMZFcN+6WOyfU1e+oSp4q/Oxc08BtuQHZ20wuxI+Qq73X
         JZcNdel3k/4kgzxgzqrMacTOvQGDkArwl3NjG62dDBW/tbWBtQA4d4c4BmEI+8RVdtEt
         DsbyoprQ/X7Rpx1Z+dIG4gKoGgEN+oxakR/wHOeRFM2r63NcCsXLIvvrIVJjq8omrVpk
         kcTatk4txlP0d53wKP17wW4ovlFoM4bt55DfBnCiuyWfM/zRGqP+XOvyvt9KGt6rUsp0
         ROWr0HgzhUm1bnlDthtooBMh0BOIGJHJlOe/cLdWb1rKMtOAPKdEcVFbUGaVNJiwJjLL
         Xx3g==
X-Gm-Message-State: AJcUukehvUznk1tTI+dhj9U9IRRSK1yvhkEVgdCOmWCOh8gtiqEujCEH
        eY8HE+G7pmJ6ckhUD9D3f+M=
X-Google-Smtp-Source: ALg8bN4Oj2c4/NWxgc0vnc4/+r18Xo8MZf4Vrn8bEtEIMbYHMkoq3XGPnI/ibkqx75cNNQYxdW9qxQ==
X-Received: by 2002:a63:9749:: with SMTP id d9mr17237044pgo.415.1546532127887;
        Thu, 03 Jan 2019 08:15:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm99988266pfd.124.2019.01.03.08.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:15:26 -0800 (PST)
Date:   Thu, 3 Jan 2019 08:15:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        luto@kernel.org, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com
Subject: Re: [PATCH ghak90 (was ghak32) V4 00/10] audit: implement container
 identifier
Message-ID: <20190103161525.GA6551@roeck-us.net>
References: <cover.1533065887.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 31, 2018 at 04:07:35PM -0400, Richard Guy Briggs wrote:
> Implement kernel audit container identifier.
> 

I don't see a follow-up submission of this patch series. Has it been abandoned,
or do I use the wrong search terms ?

Thanks,
Guenter

> This patchset is a fourth based on the proposal document (V3)
> posted:
> 	https://www.redhat.com/archives/linux-audit/2018-January/msg00014.html
> 
> The first patch is the last patch from ghak81 that is included here as a
> convenience.
> 
> The second patch implements the proc fs write to set the audit container
> identifier of a process, emitting an AUDIT_CONTAINER_OP record to announce the
> registration of that audit container identifier on that process.  This patch
> requires userspace support for record acceptance and proper type
> display.
> 
> The third implements the auxiliary record AUDIT_CONTAINER if an
> audit container identifier is identifiable with an event.  This patch
> requires userspace support for proper type display.
> 
> The 4th adds signal and ptrace support.
> 
> The 5th creates a local audit context to be able to bind a standalone
> record with a locally created auxiliary record.
> 
> The 6th patch adds audit container identifier records to the tty
> standalone record.
> 
> The 7th adds audit container identifier filtering to the exit,
> exclude and user lists.  This patch adds the AUDIT_CONTID field and
> requires auditctl userspace support for the --contid option.
> 
> The 8th adds network namespace audit container identifier labelling
> based on member tasks' audit container identifier labels.
> 
> The 9th adds audit container identifier support to standalone netfilter
> records that don't have a task context and lists each container to which
> that net namespace belongs.
> 
> The 10th implements reading the audit container identifier from the proc
> filesystem for debugging.  This patch isn't planned for upstream
> inclusion.
> 
> 
> Example: Set an audit container identifier of 123456 to the "sleep" task:
> 
>   sleep 2&  
>   child=$!
>   echo 123456 > /proc/$child/audit_containerid; echo $?
>   ausearch -ts recent -m container
>   echo child:$child contid:$( cat /proc/$child/audit_containerid)
> 
> This should produce a record such as:
> 
>   type=CONTAINER_OP msg=audit(2018-06-06 12:39:29.636:26949) : op=set opid=2209 old-contid=18446744073709551615 contid=123456 pid=628 auid=root uid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=bash exe=/usr/bin/bash res=yes 
> 
> 
> Example: Set a filter on an audit container identifier 123459 on /tmp/tmpcontainerid:
> 
>   contid=123459
>   key=tmpcontainerid
>   auditctl -a exit,always -F dir=/tmp -F perm=wa -F contid=$contid -F key=$key
>   perl -e "sleep 1; open(my \$tmpfile, '>', \"/tmp/$key\"); close(\$tmpfile);" &
>   child=$!
>   echo $contid > /proc/$child/audit_containerid
>   sleep 2
>   ausearch -i -ts recent -k $key
>   auditctl -d exit,always -F dir=/tmp -F perm=wa -F contid=$contid -F key=$key
>   rm -f /tmp/$key
> 
> This should produce an event such as:
> 
>   type=CONTAINER msg=audit(2018-06-06 12:46:31.707:26953) : op=task contid=123459 
>   type=PROCTITLE msg=audit(2018-06-06 12:46:31.707:26953) : proctitle=perl -e sleep 1; open(my $tmpfile, '>', "/tmp/tmpcontainerid"); close($tmpfile); 
>   type=PATH msg=audit(2018-06-06 12:46:31.707:26953) : item=1 name=/tmp/tmpcontainerid inode=25656 dev=00:26 mode=file,644 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
>   type=PATH msg=audit(2018-06-06 12:46:31.707:26953) : item=0 name=/tmp/ inode=8985 dev=00:26 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
>   type=CWD msg=audit(2018-06-06 12:46:31.707:26953) : cwd=/root 
>   type=SYSCALL msg=audit(2018-06-06 12:46:31.707:26953) : arch=x86_64 syscall=openat success=yes exit=3 a0=0xffffffffffffff9c a1=0x5621f2b81900 a2=O_WRONLY|O_CREAT|O_TRUNC a3=0x1b6 items=2 ppid=628 pid=2232 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=tmpcontainerid 
> 
> 
> Includes: https://github.com/linux-audit/audit-kernel/issues/81
> See: https://github.com/linux-audit/audit-kernel/issues/90
> See: https://github.com/linux-audit/audit-userspace/issues/40
> See: https://github.com/linux-audit/audit-testsuite/issues/64
> See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> 
> Changelog:
> 
> v4
> - preface set with ghak81:"collect audit task parameters"
> - add shallyn and sgrubb acks
> - rename feature bitmap macro
> - rename cid_valid() to audit_contid_valid()
> - rename AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP
> - delete audit_get_contid_list() from headers
> - move work into inner if, delete "found"
> - change netns contid list function names
> - move exports for audit_log_contid audit_alloc_local audit_free_context to non-syscall patch
> - list contids CSV
> - pass in gfp flags to audit_alloc_local() (fix audit_alloc_context callers)
> - use "local" in lieu of abusing in_syscall for auditsc_get_stamp()
> - read_lock(&tasklist_lock) around children and thread check
> - task_lock(tsk) should be taken before first check of tsk->audit
> - add spin lock to contid list in aunet
> - restrict /proc read to CAP_AUDIT_CONTROL
> - remove set again prohibition and inherited flag
> - delete contidion spelling fix from patchset, send to netdev/linux-wireless
> 
> v3
> - switched from containerid in task_struct to audit_task_info (depends on ghak81)
> - drop INVALID_CID in favour of only AUDIT_CID_UNSET
> - check for !audit_task_info, throw -ENOPROTOOPT on set
> - changed -EPERM to -EEXIST for parent check
> - return AUDIT_CID_UNSET if !audit_enabled
> - squash child/thread check patch into AUDIT_CONTAINER_ID patch
> - changed -EPERM to -EBUSY for child check
> - separate child and thread checks, use -EALREADY for latter
> - move addition of op= from ptrace/signal patch to AUDIT_CONTAINER patch
> - fix && to || bashism in ptrace/signal patch
> - uninline and export function for audit_free_context()
> - drop CONFIG_CHANGE, FEATURE_CHANGE, ANOM_ABEND, ANOM_SECCOMP patches
> - move audit_enabled check (xt_AUDIT)
> - switched from containerid list in struct net to net_generic's struct audit_net
> - move containerid list iteration into audit (xt_AUDIT)
> - create function to move namespace switch into audit
> - switched /proc/PID/ entry from containerid to audit_containerid
> - call kzalloc with GFP_ATOMIC on in_atomic() in audit_alloc_context()
> - call kzalloc with GFP_ATOMIC on in_atomic() in audit_log_container_info()
> - use xt_net(par) instead of sock_net(skb->sk) to get net
> - switched record and field names: initial CONTAINER_ID, aux CONTAINER, field CONTID
> - allow to set own contid
> - open code audit_set_containerid
> - add contid inherited flag
> - ccontainerid and pcontainerid eliminated due to inherited flag
> - change name of container list funcitons
> - rename containerid to contid
> - convert initial container record to syscall aux
> - fix spelling mistake of contidion in net/rfkill/core.c to avoid contid name collision
> 
> v2
> - add check for children and threads
> - add network namespace container identifier list
> - add NETFILTER_PKT audit container identifier logging
> - patch description and documentation clean-up and example
> - reap unused ppid
> 
> Richard Guy Briggs (10):
>   audit: collect audit task parameters
>   audit: add container id
>   audit: log container info of syscalls
>   audit: add containerid support for ptrace and signals
>   audit: add support for non-syscall auxiliary records
>   audit: add containerid support for tty_audit
>   audit: add containerid filtering
>   audit: add support for containerid to network namespaces
>   audit: NETFILTER_PKT: record each container ID associated with a netNS
>   debug audit: read container ID of a process
> 
>  drivers/tty/tty_audit.c    |   5 +-
>  fs/proc/base.c             |  56 ++++++++++++++
>  include/linux/audit.h      |  95 ++++++++++++++++++++---
>  include/linux/sched.h      |   5 +-
>  include/uapi/linux/audit.h |   8 +-
>  init/init_task.c           |   3 +-
>  init/main.c                |   2 +
>  kernel/audit.c             | 137 +++++++++++++++++++++++++++++++++
>  kernel/audit.h             |   4 +
>  kernel/auditfilter.c       |  47 ++++++++++++
>  kernel/auditsc.c           | 183 ++++++++++++++++++++++++++++++++++++++++-----
>  kernel/fork.c              |   4 +-
>  kernel/nsproxy.c           |   4 +
>  net/netfilter/xt_AUDIT.c   |  12 ++-
>  14 files changed, 526 insertions(+), 39 deletions(-)
> 
> -- 
> 1.8.3.1
> 
