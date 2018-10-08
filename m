Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5146DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2035120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2035120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJHUlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:41:55 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45118 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJHUly (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 8 Oct 2018 16:41:54 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 08 Oct 2018 15:29:56 +0200
Date:   Mon, 8 Oct 2018 21:29:45 +0800
From:   joeyli <jlee@suse.com>
To:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        joeyli.kernel@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, oneukum@suse.com,
        yu.chen.surf@gmail.com, ggherdovich@suse.cz
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Message-ID: <20181008132945.GV3831@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
 <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
 <20181002075243.GB6040@linux-l9pv.suse>
 <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
 <CALCETrVriVL1uhm_6wOLzCPZ++c3E+O6Yhp4it53+Cz9xu9o7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVriVL1uhm_6wOLzCPZ++c3E+O6Yhp4it53+Cz9xu9o7Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Any, Jann,

On Wed, Oct 03, 2018 at 03:08:12PM -0700, Andy Lutomirski wrote:
> On Tue, Oct 2, 2018 at 12:36 PM Jann Horn <jannh@google.com> wrote:
> >
> > +Andy for opinions on things in write handlers
> > +Mimi Zohar as EVM maintainer
> >
> > On Tue, Oct 2, 2018 at 9:55 AM joeyli <jlee@suse.com> wrote:
> > > On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> > > > On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > > > This patch adds a snapshot keys handler for using the key retention
> > > > > service api to create keys for snapshot image encryption and
> > > > > authentication.
> > > [...snip]
> > > > > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > > > +                             const char *buf, size_t n)
> > > > > +{
> > > > > +       int error = 0;
> > > > > +       char *p;
> > > > > +       int len;
> > > > > +
> > > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > > +               return -EPERM;
> > > >
> > > > This is wrong, you can't use capable() in a write handler. You'd have
> > > > to use file_ns_capable(), and I think sysfs currently doesn't give you
> > > > a pointer to the struct file.
> > > > If you want to do this in a write handler, you'll have to either get
> > > > rid of this check or plumb through the cred struct pointer.
> > > > Alternatively, you could use some interface that doesn't go through a
> > > > write handler.
> > > >
> > >
> > > Thank you for point out this problem.
> > >
> > > Actually the evm_write_key() is the example for my code. The
> > > difference is that evm creates interface file on securityfs, but my
> > > implementation is on sysfs:
> > >
> > > security/integrity/evm/evm_secfs.c
> > >
> > > static ssize_t evm_write_key(struct file *file, const char __user *buf,
> > >                              size_t count, loff_t *ppos)
> > > {
> > >         int i, ret;
> > >
> > >         if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
> > >                 return -EPERM;
> 
> Yeah, that's a bug.
> 
> > > ...
> > >
> > > On the other hand, the writing handler of /sys/power/wake_lock also
> > > uses capable() to check the CAP_BLOCK_SUSPEND capability:
> > >
> > > kernel/power/main.c
> > > static ssize_t wake_lock_store(struct kobject *kobj,
> > >                                struct kobj_attribute *attr,
> > >                                const char *buf, size_t n)
> > > {
> > >         int error = pm_wake_lock(buf);
> > >         return error ? error : n;
> > > }
> > > power_attr(wake_lock);
> > >
> > > kernel/power/wakelock.c
> > > int pm_wake_lock(const char *buf)
> > > {
> > > ...
> > >         if (!capable(CAP_BLOCK_SUSPEND))
> > >                 return -EPERM;
> > > ...
> 
> Also a bug.
> 
> > >
> > >
> > > So I confused for when can capable() be used in sysfs interface? Is
> > > capable() only allowed in reading handler? Why the writing handler
> > > of securityfs can use capable()?
> >
> > They can't, they're all wrong. :P All of these capable() checks in
> > write handlers have to be assumed to be ineffective. But it's not a
> > big deal because you still need UID 0 to access these files.
> 
> Why are there capability checks at all?
> 
> >
> > > > > +static int user_key_init(void)
> > > > > +{
> > > > > +       struct user_key_payload *ukp;
> > > > > +       struct key *key;
> > > > > +       int err = 0;
> > > > > +
> > > > > +       pr_debug("%s\n", __func__);
> > > > > +
> > > > > +       /* find out swsusp-key */
> > > > > +       key = request_key(&key_type_user, skey.key_name, NULL);
> > > >
> > > > request_key() looks at current's keyring. That shouldn't happen in a
> > > > write handler.
> > > >
> > >
> > > The evm_write_key() also uses request_key() but it's on securityfs. Should
> > > I move my sysfs interface to securityfs?
> >
> > I don't think you should be doing this in the context of any
> > filesystem. If EVM does that, EVM is doing it wrong.
> 
> EVM sounds buggy.
> 
> In general if you look at current *at all* in an implementation of
> write() *in any filesystem*, you are doing it wrong.

I have read CVE-2013-1959... Thanks for Jann and Andy's review.

I will create the sysfs interface through other way, then using 
file_ns_capable() for capability checking in next version.

Thanks a lot!
Joey Lee
