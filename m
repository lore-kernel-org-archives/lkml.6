Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BE1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1186820856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1186820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeGUUSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:18:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727720AbeGUUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:18:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8177181663C8;
        Sat, 21 Jul 2018 19:24:45 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3859B111AF00;
        Sat, 21 Jul 2018 19:24:34 +0000 (UTC)
Date:   Sat, 21 Jul 2018 15:21:47 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 09/10] debug audit: read
 container ID of a process
Message-ID: <20180721192147.vmeq3u2pqheo3trf@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <b1eff0b849cc472f10dee8bd4f2eeb3567f0a459.1528304204.git.rgb@redhat.com>
 <CAHC9VhRhHJV87g+4b2BMxnrpgPvNYMBa1RUQzK3xrK1yugBYzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRhHJV87g+4b2BMxnrpgPvNYMBa1RUQzK3xrK1yugBYzQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 21 Jul 2018 19:24:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 21 Jul 2018 19:24:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 18:15, Paul Moore wrote:
> On Wed, Jun 6, 2018 at 1:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add support for reading the audit container identifier from the proc
> > filesystem.
> >
> > This is a read from the proc entry of the form
> > /proc/PID/audit_containerid where PID is the process ID of the task
> > whose audit container identifier is sought.
> >
> > The read expects up to a u64 value (unset: 18446744073709551615).
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/proc/base.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 318dff4..ca8bfe2 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1303,6 +1303,21 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
> >         .llseek         = generic_file_llseek,
> >  };
> >
> > +static ssize_t proc_contid_read(struct file *file, char __user *buf,
> > +                                 size_t count, loff_t *ppos)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       struct task_struct *task = get_proc_task(inode);
> > +       ssize_t length;
> > +       char tmpbuf[TMPBUFLEN*2];
> > +
> > +       if (!task)
> > +               return -ESRCH;
> > +       length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_contid(task));
> > +       put_task_struct(task);
> > +       return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> > +}
> 
> While I still remain very nervous about opening the audit container ID
> up for abuse by making it accessible, I understand that this would
> make things a lot easier us (e.g. testing) and perhaps the container
> engines as well.  In order to limit the potential for abuse, what do
> you think about restricting read access to those processes which have
> CAP_AUDIT_CONTROL, similar to what we do for setting the audit
> container ID?

That seems like a reasonable restriction.

> >  static ssize_t proc_contid_write(struct file *file, const char __user *buf,
> >                                    size_t count, loff_t *ppos)
> >  {
> > @@ -1333,6 +1348,7 @@ static ssize_t proc_contid_write(struct file *file, const char __user *buf,
> >  }
> >
> >  static const struct file_operations proc_contid_operations = {
> > +       .read           = proc_contid_read,
> >         .write          = proc_contid_write,
> >         .llseek         = generic_file_llseek,
> >  };
> > @@ -3030,7 +3046,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
> >  #ifdef CONFIG_AUDITSYSCALL
> >         REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
> >         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> > -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> > +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
> >  #endif
> >  #ifdef CONFIG_FAULT_INJECTION
> >         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> > @@ -3422,7 +3438,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
> >  #ifdef CONFIG_AUDITSYSCALL
> >         REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
> >         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> > -       REG("audit_containerid", S_IWUSR, proc_contid_operations),
> > +       REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
> >  #endif
> >  #ifdef CONFIG_FAULT_INJECTION
> >         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> 
> --
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
