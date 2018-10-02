Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A95C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCD62082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxhhxR+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCD62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJCCVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:21:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39089 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCCVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:21:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so2527425oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5T+w/12tl2l++Goj1a/6fe16yySVy4EwZwfLXKIyns=;
        b=WxhhxR+uRjDd6o5x++ofOx0bsi1nm31Aopda9QjQm7SQfQL8vv+Jp70E1U+Wt8PsB1
         hk4DDoE9ahDSNqrHtljyVHT3aNjdmfIqnPLBa3mP1Ibevv8CU96J3U9t90dJtUusUZOE
         qbC8oVyqoQlJS/Nbs2mK0Vza3kLf9BSFtymy6uKYjONAbk1LPK1Svp4t5zgYSp0iXaNG
         20Djj4PtziVCqfk+2sc8/oplIgPhyR7WDc4vPcOMZl9rcEpQCP/5IWyVmAeJrb6DJZZi
         siswrzoKX7l+S6cc3Ihaic0glmyEOyQApgz3ux3JE8zZyxIuXJ45IQLkzZbFPFR3pj3M
         y4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5T+w/12tl2l++Goj1a/6fe16yySVy4EwZwfLXKIyns=;
        b=m9uUVNT7WFbMoroK7KhU0ZNczjwxASoWlCYj1IDG8sq5PTe8e1IDxHIdLmo4jKmMYC
         ftWnlx8L8DutTQvgK0Ntnei2q9MT+cdQ2ATZgoZYKumARQiigjrammxHOsZ/9XfX9CMM
         20Ts/lrwqehzo8ajysjKaLJFifTu+UPTp8sGTjwc9AKbQ+FzJoZ4Aq8MRCFuYDLJBJkd
         YPHJ8B7qBmGhXWxKgoqZK18Y4rFkoMUW8kUOlByvxHeGqVYJSJ8ZPSNTL0NT8HoVHiY+
         27Z1AueDSVSFuEMeI+szZ54qI3JMDYCELe+XFC5AKCP1Ujv8TNckz1nkQ1nD+R4dX+OT
         Njsg==
X-Gm-Message-State: ABuFfohff4RDbn43T+as+Q26YUfMSOl/kwcGoRdYK5k7DJ07wEhiEFOL
        tAYibS7to1rzRl5NlXKhNzbFkSEggQzG5q11IQEMRg==
X-Google-Smtp-Source: ACcGV63Ux3jbkFCVrU96TXATLaz/vDyQVfmH3MP1/net+UBouGAwk5inp9FjQmy8bivzj2SO9LRRszAOiF2fdmQUi+o=
X-Received: by 2002:aca:4d51:: with SMTP id a78-v6mr6881638oib.205.1538508992914;
 Tue, 02 Oct 2018 12:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180912142337.21955-1-jlee@suse.com> <20180912142337.21955-2-jlee@suse.com>
 <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com> <20181002075243.GB6040@linux-l9pv.suse>
In-Reply-To: <20181002075243.GB6040@linux-l9pv.suse>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 2 Oct 2018 21:36:05 +0200
Message-ID: <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
To:     joeyli <jlee@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     joeyli.kernel@gmail.com, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        yu.c.chen@intel.com, oneukum@suse.com,
        Yu Chen <yu.chen.surf@gmail.com>, ggherdovich@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andy for opinions on things in write handlers
+Mimi Zohar as EVM maintainer

On Tue, Oct 2, 2018 at 9:55 AM joeyli <jlee@suse.com> wrote:
> On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> > On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > This patch adds a snapshot keys handler for using the key retention
> > > service api to create keys for snapshot image encryption and
> > > authentication.
> [...snip]
> > > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > +                             const char *buf, size_t n)
> > > +{
> > > +       int error = 0;
> > > +       char *p;
> > > +       int len;
> > > +
> > > +       if (!capable(CAP_SYS_ADMIN))
> > > +               return -EPERM;
> >
> > This is wrong, you can't use capable() in a write handler. You'd have
> > to use file_ns_capable(), and I think sysfs currently doesn't give you
> > a pointer to the struct file.
> > If you want to do this in a write handler, you'll have to either get
> > rid of this check or plumb through the cred struct pointer.
> > Alternatively, you could use some interface that doesn't go through a
> > write handler.
> >
>
> Thank you for point out this problem.
>
> Actually the evm_write_key() is the example for my code. The
> difference is that evm creates interface file on securityfs, but my
> implementation is on sysfs:
>
> security/integrity/evm/evm_secfs.c
>
> static ssize_t evm_write_key(struct file *file, const char __user *buf,
>                              size_t count, loff_t *ppos)
> {
>         int i, ret;
>
>         if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
>                 return -EPERM;
> ...
>
> On the other hand, the writing handler of /sys/power/wake_lock also
> uses capable() to check the CAP_BLOCK_SUSPEND capability:
>
> kernel/power/main.c
> static ssize_t wake_lock_store(struct kobject *kobj,
>                                struct kobj_attribute *attr,
>                                const char *buf, size_t n)
> {
>         int error = pm_wake_lock(buf);
>         return error ? error : n;
> }
> power_attr(wake_lock);
>
> kernel/power/wakelock.c
> int pm_wake_lock(const char *buf)
> {
> ...
>         if (!capable(CAP_BLOCK_SUSPEND))
>                 return -EPERM;
> ...
>
>
> So I confused for when can capable() be used in sysfs interface? Is
> capable() only allowed in reading handler? Why the writing handler
> of securityfs can use capable()?

They can't, they're all wrong. :P All of these capable() checks in
write handlers have to be assumed to be ineffective. But it's not a
big deal because you still need UID 0 to access these files.

> > > +static int user_key_init(void)
> > > +{
> > > +       struct user_key_payload *ukp;
> > > +       struct key *key;
> > > +       int err = 0;
> > > +
> > > +       pr_debug("%s\n", __func__);
> > > +
> > > +       /* find out swsusp-key */
> > > +       key = request_key(&key_type_user, skey.key_name, NULL);
> >
> > request_key() looks at current's keyring. That shouldn't happen in a
> > write handler.
> >
>
> The evm_write_key() also uses request_key() but it's on securityfs. Should
> I move my sysfs interface to securityfs?

I don't think you should be doing this in the context of any
filesystem. If EVM does that, EVM is doing it wrong.

> > > +       if (IS_ERR(key)) {
> > > +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> > > +               err = PTR_ERR(key);
> > > +               return err;
> > > +       }
> > > +
> > > +       down_write(&key->sem);
> > > +       ukp = user_key_payload_locked(key);
> > > +       if (!ukp) {
> > > +               /* key was revoked before we acquired its semaphore */
> > > +               err = -EKEYREVOKED;
> > > +               goto key_invalid;
> > > +       }
> > > +       if (invalid_key(ukp->data, ukp->datalen)) {
> > > +               err = -EINVAL;
> > > +               goto key_invalid;
> > > +       }
> > > +       skey.key_len = ukp->datalen;
> > > +       memcpy(skey.key, ukp->data, ukp->datalen);
> > > +       /* burn the original key contents */
> > > +       memzero_explicit(ukp->data, ukp->datalen);
> >
> > You just zero out the contents of the supplied key? That seems very
> > unidiomatic for the keys subsystem, and makes me wonder why you're
> > using the keys subsystem for this in the first place. It doesn't look
> > like normal use of the keys subsystem.
> >
>
> Because I want that only one decrypted key in kernel memory. Then hibernation
> can handle the key more easy. In evm_init_key(), it also burned the key
> contents after evm key be initialled:
>
> security/integrity/evm/evm_crypto.c
> int evm_init_key(void)
> {
> [...snip]
>         /* burn the original key contents */
>         memset(ekp->decrypted_data, 0, ekp->decrypted_datalen);
>         up_read(&evm_key->sem);
>         key_put(evm_key);
>         return rc;
> }
>
> The keys subsystem already handles the interactive with userland and TPM.
> That's the reason for using keys subsystem in hibernation.

How do you guarantee that the user is allowed to overwrite that key? I
don't understand the keys subsystem very well - could this be a key on
the trusted keyring, or something like that?
