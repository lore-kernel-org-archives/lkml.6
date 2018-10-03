Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB32C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6F21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTlzA4x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE6F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJDE6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDE6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:58:43 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408BA214D5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538604507;
        bh=/iN7H1RjSrpzSOeGcLzEVfS1NIpj7JBmDlarI1OfSb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTlzA4x5/JNKCKA+kC4XjwNDFOvjFppUvNQ1vjToXmr6lxp3Nyh3hGZg7sP3148kd
         leUbijrs3jsSkgCp/k4xbfA7+gVZOD0TTnEadPS5zdl2YfLRbJwx/Rl640Zpxy+0RB
         dbNBwGbc3l8//S8EMXqxsBQue5d0+B4s+pBLA8b4=
Received: by mail-wr1-f52.google.com with SMTP id a2-v6so693434wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:08:27 -0700 (PDT)
X-Gm-Message-State: ABuFfohD5rU6Kw9dVX8izqV1PnVPHGwo8hcsBlUD8Q/Q7lENP/+pJqD/
        3dcNGlwSnekv4E1QKOY12cAf3kc8qqd0A6UIPcuMyg==
X-Google-Smtp-Source: ACcGV60+LTjHXMngLxHLC9pUqipmSsbuZ1ULmRlppClrrd5g1YwNnBGuOptrbKLajrGGenQfAYSSPLRb7to7kiMEnog=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr2779134wrb.283.1538604505500;
 Wed, 03 Oct 2018 15:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180912142337.21955-1-jlee@suse.com> <20180912142337.21955-2-jlee@suse.com>
 <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
 <20181002075243.GB6040@linux-l9pv.suse> <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
In-Reply-To: <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Oct 2018 15:08:12 -0700
X-Gmail-Original-Message-ID: <CALCETrVriVL1uhm_6wOLzCPZ++c3E+O6Yhp4it53+Cz9xu9o7Q@mail.gmail.com>
Message-ID: <CALCETrVriVL1uhm_6wOLzCPZ++c3E+O6Yhp4it53+Cz9xu9o7Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
To:     Jann Horn <jannh@google.com>
Cc:     joeyli <jlee@suse.com>, Andrew Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        joeyli.kernel@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, oneukum@suse.com,
        yu.chen.surf@gmail.com, ggherdovich@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 12:36 PM Jann Horn <jannh@google.com> wrote:
>
> +Andy for opinions on things in write handlers
> +Mimi Zohar as EVM maintainer
>
> On Tue, Oct 2, 2018 at 9:55 AM joeyli <jlee@suse.com> wrote:
> > On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> > > On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > > This patch adds a snapshot keys handler for using the key retention
> > > > service api to create keys for snapshot image encryption and
> > > > authentication.
> > [...snip]
> > > > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > > +                             const char *buf, size_t n)
> > > > +{
> > > > +       int error = 0;
> > > > +       char *p;
> > > > +       int len;
> > > > +
> > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > +               return -EPERM;
> > >
> > > This is wrong, you can't use capable() in a write handler. You'd have
> > > to use file_ns_capable(), and I think sysfs currently doesn't give you
> > > a pointer to the struct file.
> > > If you want to do this in a write handler, you'll have to either get
> > > rid of this check or plumb through the cred struct pointer.
> > > Alternatively, you could use some interface that doesn't go through a
> > > write handler.
> > >
> >
> > Thank you for point out this problem.
> >
> > Actually the evm_write_key() is the example for my code. The
> > difference is that evm creates interface file on securityfs, but my
> > implementation is on sysfs:
> >
> > security/integrity/evm/evm_secfs.c
> >
> > static ssize_t evm_write_key(struct file *file, const char __user *buf,
> >                              size_t count, loff_t *ppos)
> > {
> >         int i, ret;
> >
> >         if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
> >                 return -EPERM;

Yeah, that's a bug.

> > ...
> >
> > On the other hand, the writing handler of /sys/power/wake_lock also
> > uses capable() to check the CAP_BLOCK_SUSPEND capability:
> >
> > kernel/power/main.c
> > static ssize_t wake_lock_store(struct kobject *kobj,
> >                                struct kobj_attribute *attr,
> >                                const char *buf, size_t n)
> > {
> >         int error = pm_wake_lock(buf);
> >         return error ? error : n;
> > }
> > power_attr(wake_lock);
> >
> > kernel/power/wakelock.c
> > int pm_wake_lock(const char *buf)
> > {
> > ...
> >         if (!capable(CAP_BLOCK_SUSPEND))
> >                 return -EPERM;
> > ...

Also a bug.

> >
> >
> > So I confused for when can capable() be used in sysfs interface? Is
> > capable() only allowed in reading handler? Why the writing handler
> > of securityfs can use capable()?
>
> They can't, they're all wrong. :P All of these capable() checks in
> write handlers have to be assumed to be ineffective. But it's not a
> big deal because you still need UID 0 to access these files.

Why are there capability checks at all?

>
> > > > +static int user_key_init(void)
> > > > +{
> > > > +       struct user_key_payload *ukp;
> > > > +       struct key *key;
> > > > +       int err = 0;
> > > > +
> > > > +       pr_debug("%s\n", __func__);
> > > > +
> > > > +       /* find out swsusp-key */
> > > > +       key = request_key(&key_type_user, skey.key_name, NULL);
> > >
> > > request_key() looks at current's keyring. That shouldn't happen in a
> > > write handler.
> > >
> >
> > The evm_write_key() also uses request_key() but it's on securityfs. Should
> > I move my sysfs interface to securityfs?
>
> I don't think you should be doing this in the context of any
> filesystem. If EVM does that, EVM is doing it wrong.

EVM sounds buggy.

In general if you look at current *at all* in an implementation of
write() *in any filesystem*, you are doing it wrong.
