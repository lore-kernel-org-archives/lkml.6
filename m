Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEDBXo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:23:44 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43683 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEDBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:23:42 -0400
X-Google-Smtp-Source: AB8JxZoQFNBPINRZFSRvcOhGTxtsAV5vQM6fj5WfWbvIKur5ljP+RYYjQya6A6QQa4Q3wH7OoLT6Iw==
Date: Thu, 3 May 2018 22:23:31 -0300
From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To: Christian Brauner <christian.brauner@canonical.com>
Cc: linux-next@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] user_namespace: Replace gotos with return
 statements
Message-ID: <20180504012328.GA4719@bebop>
References: <20180419024641.24213-1-marcos.souza.org@gmail.com>
 <CAPP7u0XztHVja18pJV+0cfRNr7cGmKq4i0nYKt03Sd6oyKUuVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPP7u0XztHVja18pJV+0cfRNr7cGmKq4i0nYKt03Sd6oyKUuVQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:12:18PM +0200, Christian Brauner wrote:
> On Wed, Apr 18, 2018 at 11:46:38PM -0300, Marcos Paulo de Souza wrote:
> > Found while inspecting the code that handles the setgroups procfs file.
> 
> This is not really improving anything so I unfortunately don't really
> see why we should take this.

Sorry for the late reply. My idea was to make the code more straightforward,
never happened to me this would led to a worse code being generated. So, please
discard the patch.

Thanks,

> 
> Christian
> 
> >
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> > Tested locally setting up a new userns, and setting setgroups as deny and allow,
> > worked as before.
> >
> >  kernel/user_namespace.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 246d4d4ce5c7..64a01254ac6b 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -1142,22 +1142,18 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
> >   struct user_namespace *ns = seq->private;
> >   char kbuf[8], *pos;
> >   bool setgroups_allowed;
> > - ssize_t ret;
> >
> >   /* Only allow a very narrow range of strings to be written */
> > - ret = -EINVAL;
> >   if ((*ppos != 0) || (count >= sizeof(kbuf)))
> > - goto out;
> > + return -EINVAL;
> >
> >   /* What was written? */
> > - ret = -EFAULT;
> >   if (copy_from_user(kbuf, buf, count))
> > - goto out;
> > + return -EFAULT;
> >   kbuf[count] = '\0';
> >   pos = kbuf;
> >
> >   /* What is being requested? */
> > - ret = -EINVAL;
> >   if (strncmp(pos, "allow", 5) == 0) {
> >   pos += 5;
> >   setgroups_allowed = true;
> > @@ -1167,14 +1163,13 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
> >   setgroups_allowed = false;
> >   }
> >   else
> > - goto out;
> > + return -EINVAL;
> >
> >   /* Verify there is not trailing junk on the line */
> >   pos = skip_spaces(pos);
> >   if (*pos != '\0')
> > - goto out;
> > + return -EINVAL;
> >
> > - ret = -EPERM;
> >   mutex_lock(&userns_state_mutex);
> >   if (setgroups_allowed) {
> >   /* Enabling setgroups after setgroups has been disabled
> > @@ -1194,12 +1189,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
> >
> >   /* Report a successful write */
> >   *ppos = count;
> > - ret = count;
> > -out:
> > - return ret;
> > + return count;
> > +
> >  out_unlock:
> >   mutex_unlock(&userns_state_mutex);
> > - goto out;
> > + return -EPERM;
> >  }
> >
> >  bool userns_may_setgroups(const struct user_namespace *ns)
> > --
> > 2.14.3
> >

-- 
Thanks,
	Marcos
