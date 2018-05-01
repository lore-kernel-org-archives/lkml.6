Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755957AbeEAQlh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:41:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751071AbeEAQld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:41:33 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tyler Hicks <tyhicks@canonical.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] seccomp: Audit attempts to modify the actions_logged sysctl
Date: Tue, 01 May 2018 12:41:30 -0400
Message-ID: <2326710.O3RjXv44ne@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTwrKG2hySCrZaVwHgqyekZXDofkJy9_jCa-CxFgCVUGQ@mail.gmail.com>
References: <1524856562-22566-1-git-send-email-tyhicks@canonical.com> <1524856562-22566-3-git-send-email-tyhicks@canonical.com> <CAHC9VhTwrKG2hySCrZaVwHgqyekZXDofkJy9_jCa-CxFgCVUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 1, 2018 11:18:55 AM EDT Paul Moore wrote:
> On Fri, Apr 27, 2018 at 3:16 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
> > The decision to log a seccomp action will always be subject to the
> > value of the kernel.seccomp.actions_logged sysctl, even for processes
> > that are being inspected via the audit subsystem, in an upcoming patch.
> > Therefore, we need to emit an audit record on attempts at writing to the
> > actions_logged sysctl when auditing is enabled.
> > 
> > This patch updates the write handler for the actions_logged sysctl to
> > emit an audit record on attempts to write to the sysctl. Successful
> > writes to the sysctl will result in a record that includes a normalized
> > list of logged actions in the "actions" field and a "res" field equal to
> > 0. Unsuccessful writes to the sysctl will result in a record that
> > doesn't include the "actions" field and has a "res" field equal to 1.
> > 
> > Not all unsuccessful writes to the sysctl are audited. For example, an
> > audit record will not be emitted if an unprivileged process attempts to
> > open the sysctl file for reading since that access control check is not
> > part of the sysctl's write handler.
> > 
> > Below are some example audit records when writing various strings to the
> > actions_logged sysctl.
> > 
> > Writing "not-a-real-action" emits:
> >  type=CONFIG_CHANGE msg=audit(1524600971.363:119): pid=1651 uid=0
> >  auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
> >  op=seccomp-logging res=1
> > 
> > Writing "kill_process kill_thread errno trace log" emits:
> >  type=CONFIG_CHANGE msg=audit(1524601023.982:131): pid=1658 uid=0
> >  auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
> >  op=seccomp-logging actions="kill_process kill_thread errno trace log"
> >  res=0
> 
> I've got some additional comments regarding the fields in the code
> below, but it would be good to hear Steve comment on the "actions"
> field since his userspace tools are extremely picky about what they
> will accept.

Its not that the audit user space applications are picky, its that we have a 
coding standard that everyone needs to abide by so that any parser coded to 
the specification works. In short, we should not have spaces inside the "" 
because that can trick a naive parser. What we typically do in a situation 
like this is add a comma as a separator. But having "" means that the value 
is untrusted and subject to escaping. I don't think that is the case here. 
Output is not controlled by the user. Its a list of well known names.

> It looks like you are treating the actions as an untrusted string, which is
> good, so I suspect you are okay, but still

The function below that logs names is calling audit_log_format which does not 
handle untrusted strings. I would suggest not treating it as an untrusted 
string, but as a string with no spaces in it. 

actions=kill_process,kill_thread,errno,trace,log


> > Writing the string "log log errno trace kill_process kill_thread", which
> > is unordered and contains the log action twice, results in the same
> > 
> > value as the previous example for the actions field:
> >  type=CONFIG_CHANGE msg=audit(1524601204.365:152): pid=1704 uid=0
> >  auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
> >  op=seccomp-logging actions="kill_process kill_thread errno trace log"
> >  res=0
> > 
> > No audit records are generated when reading the actions_logged sysctl.
> > 
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
> > ---
> > 
> >  include/linux/audit.h |  3 +++
> >  kernel/auditsc.c      | 37 +++++++++++++++++++++++++++++++++++++
> >  kernel/seccomp.c      | 43 ++++++++++++++++++++++++++++++++++---------
> >  3 files changed, 74 insertions(+), 9 deletions(-)
> 
> ...
> 
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 75d5b03..b311d7d 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -233,6 +233,7 @@ extern void __audit_inode_child(struct inode *parent,
> > 
> >                                 const struct dentry *dentry,
> >                                 const unsigned char type);
> >  
> >  extern void __audit_seccomp(unsigned long syscall, long signr, int
> >  code);
> > 
> > +extern void audit_seccomp_actions_logged(const char *names, int res);
> > 
> >  extern void __audit_ptrace(struct task_struct *t);
> >  
> >  static inline bool audit_dummy_context(void)
> > 
> > @@ -502,6 +503,8 @@ static inline void __audit_seccomp(unsigned long
> > syscall, long signr, int code)> 
> >  { }
> >  static inline void audit_seccomp(unsigned long syscall, long signr, int
> >  code) { }
> > 
> > +static inline void audit_seccomp_actions_logged(const char *names, int
> > res) +{ }
> > 
> >  static inline int auditsc_get_stamp(struct audit_context *ctx,
> >  
> >                               struct timespec64 *t, unsigned int *serial)
> >  
> >  {
> > 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 4e0a4ac..3496238 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2478,6 +2478,43 @@ void __audit_seccomp(unsigned long syscall, long
> > signr, int code)> 
> >         audit_log_end(ab);
> >  
> >  }
> > 
> > +void audit_seccomp_actions_logged(const char *names, int res)
> > +{
> > +       struct tty_struct *tty;
> > +       const struct cred *cred;
> > +       struct audit_buffer *ab;
> > +       char comm[sizeof(current->comm)];
> > +
> > +       if (!audit_enabled)
> > +               return;
> > +
> > +       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       if (unlikely(!ab))
> > +               return;
> 
> Instead of NULL, let's pass current->audit_context to
> audit_log_start().  Yes, most of the AUDIT_CONFIG_CHANGE users pass
> NULL but all of that is going to need to change because of 1) the
> audit container ID work and 2) it makes sense to connect records that
> are related.  Let's do it right the first time here :)
> 
> > +       cred = current_cred();
> > +       tty = audit_get_tty(current);
> > +       audit_log_format(ab, "pid=%d uid=%u auid=%u tty=%s ses=%u",
> > +                        task_tgid_nr(current),
> > +                        from_kuid(&init_user_ns, cred->uid),
> > +                        from_kuid(&init_user_ns,
> > +                        audit_get_loginuid(current)),
> > +                        tty ? tty_name(tty) : "(none)",
> > +                        audit_get_sessionid(current));
> > +       audit_put_tty(tty);
> > +       audit_log_task_context(ab);
> > +       audit_log_format(ab, " comm=");
> > +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> > +       audit_log_d_path_exe(ab, current->mm);
> > +       audit_log_format(ab, " op=seccomp-logging");
> > +       if (names)
> > +               audit_log_format(ab, " actions=\"%s\"", names);
> > +
> > +       audit_log_format(ab, " res=%d", res);
> > +       audit_log_end(ab);
> 
> One of the benefits of using current->audit_context is that we get a
> lot of this info from the associated SYSCALL record (assuming the
> admin isn't filtering that, e.g. Fedora defaults).  We can safely drop
> most everything except for the "op" and "actions" fields.
> 
> Steve might also want an "old-actions" field, but I'll let him speak to
> that.

Configuration changes are supposed to show current and new values.

-Steve
