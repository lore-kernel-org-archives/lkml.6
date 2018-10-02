Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D620645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7D620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJBOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:37:10 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:60707 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJBOhK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 2 Oct 2018 10:37:10 -0400
Received: from linux-l9pv.suse (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 02 Oct 2018 09:55:07 +0200
Date:   Tue, 2 Oct 2018 15:54:39 +0800
From:   joeyli <jlee@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     joeyli.kernel@gmail.com, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        yu.c.chen@intel.com, oneukum@suse.com, yu.chen.surf@gmail.com,
        David Howells <dhowells@redhat.com>, ggherdovich@suse.cz,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Message-ID: <20181002075243.GB6040@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
 <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

Thanks for your review and very sorry for my delay!

On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> +cc keyrings list
> 
> On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > This patch adds a snapshot keys handler for using the key retention
> > service api to create keys for snapshot image encryption and
> > authentication.
[...snip]
> > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +                             const char *buf, size_t n)
> > +{
> > +       int error = 0;
> > +       char *p;
> > +       int len;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> 
> This is wrong, you can't use capable() in a write handler. You'd have
> to use file_ns_capable(), and I think sysfs currently doesn't give you
> a pointer to the struct file.
> If you want to do this in a write handler, you'll have to either get
> rid of this check or plumb through the cred struct pointer.
> Alternatively, you could use some interface that doesn't go through a
> write handler.
>

Thank you for point out this problem.

Actually the evm_write_key() is the example for my code. The
difference is that evm creates interface file on securityfs, but my
implementation is on sysfs:

security/integrity/evm/evm_secfs.c

static ssize_t evm_write_key(struct file *file, const char __user *buf,
			     size_t count, loff_t *ppos)
{
	int i, ret;

	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP)) 
		return -EPERM;
...

On the other hand, the writing handler of /sys/power/wake_lock also
uses capable() to check the CAP_BLOCK_SUSPEND capability: 

kernel/power/main.c     
static ssize_t wake_lock_store(struct kobject *kobj,
			       struct kobj_attribute *attr,
			       const char *buf, size_t n)
{
	int error = pm_wake_lock(buf);
	return error ? error : n;
}
power_attr(wake_lock);

kernel/power/wakelock.c
int pm_wake_lock(const char *buf)
{
...
	if (!capable(CAP_BLOCK_SUSPEND))
		return -EPERM;
...


So I confused for when can capable() be used in sysfs interface? Is
capable() only allowed in reading handler? Why the writing handler
of securityfs can use capable()?

> > +
> > +static int user_key_init(void)
> > +{
> > +       struct user_key_payload *ukp;
> > +       struct key *key;
> > +       int err = 0;
> > +
> > +       pr_debug("%s\n", __func__);
> > +
> > +       /* find out swsusp-key */
> > +       key = request_key(&key_type_user, skey.key_name, NULL);
> 
> request_key() looks at current's keyring. That shouldn't happen in a
> write handler.
>

The evm_write_key() also uses request_key() but it's on securityfs. Should
I move my sysfs interface to securityfs?

> > +       if (IS_ERR(key)) {
> > +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> > +               err = PTR_ERR(key);
> > +               return err;
> > +       }
> > +
> > +       down_write(&key->sem);
> > +       ukp = user_key_payload_locked(key);
> > +       if (!ukp) {
> > +               /* key was revoked before we acquired its semaphore */
> > +               err = -EKEYREVOKED;
> > +               goto key_invalid;
> > +       }
> > +       if (invalid_key(ukp->data, ukp->datalen)) {
> > +               err = -EINVAL;
> > +               goto key_invalid;
> > +       }
> > +       skey.key_len = ukp->datalen;
> > +       memcpy(skey.key, ukp->data, ukp->datalen);
> > +       /* burn the original key contents */
> > +       memzero_explicit(ukp->data, ukp->datalen);
> 
> You just zero out the contents of the supplied key? That seems very
> unidiomatic for the keys subsystem, and makes me wonder why you're
> using the keys subsystem for this in the first place. It doesn't look
> like normal use of the keys subsystem.
> 

Because I want that only one decrypted key in kernel memory. Then hibernation
can handle the key more easy. In evm_init_key(), it also burned the key
contents after evm key be initialled: 

security/integrity/evm/evm_crypto.c
int evm_init_key(void)
{
[...snip]
	/* burn the original key contents */
	memset(ekp->decrypted_data, 0, ekp->decrypted_datalen);
	up_read(&evm_key->sem);
	key_put(evm_key);
	return rc;
}

The keys subsystem already handles the interactive with userland and TPM.
That's the reason for using keys subsystem in hibernation. 

> > +key_invalid:
> > +       up_write(&key->sem);
> > +       key_put(key);
> > +
> > +       return err;
> > +}
> > +
> > +/* this function may sleeps */
> > +int snapshot_key_init(void)
> > +{
> > +       int err;
> > +
> > +       pr_debug("%s\n", __func__);
> > +
> > +       if (skey.initialized)
> > +               return 0;
> > +
> > +       hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
> > +       if (IS_ERR(hash_tfm)) {
> > +               pr_err("Can't allocate %s transform: %ld\n",
> > +                       hash_alg, PTR_ERR(hash_tfm));
> > +               return PTR_ERR(hash_tfm);
> > +       }
> > +
> > +       err = trusted_key_init();
> > +       if (err)
> > +               err = user_key_init();
> > +       if (err)
> > +               goto key_fail;
> > +
> > +       skey.initialized = true;
> 
> Does this need a memory barrier to prevent reordering of the
> "skey.initialized = true" assignment before the key is fully
> initialized?
>

Thanks for your reminding. I will add memory barrier here.


Thank a lot!
Joey Lee 
