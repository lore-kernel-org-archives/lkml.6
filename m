Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDEA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDEA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeJARY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:24:57 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:57054 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeJARY5 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 1 Oct 2018 13:24:57 -0400
Received: from linux-l9pv.suse (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 01 Oct 2018 12:47:39 +0200
Date:   Mon, 1 Oct 2018 18:47:34 +0800
From:   joeyli <jlee@suse.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Message-ID: <20181001104722.GI23244@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
 <20180913135832.GA8155@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913135832.GA8155@chenyu-desktop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Chen, 

Thanks for your review and very sorry for my delay!

On Thu, Sep 13, 2018 at 09:58:32PM +0800, Yu Chen wrote:
> On Wed, Sep 12, 2018 at 10:23:33PM +0800, Lee, Chun-Yi wrote:
> > This patch adds a snapshot keys handler for using the key retention
> > service api to create keys for snapshot image encryption and
> > authentication.
> > 
> > This handler uses TPM trusted key as the snapshot master key, and the
> > encryption key and authentication key are derived from the snapshot
> > key. The user defined key can also be used as the snapshot master key
> > , but user must be aware that the security of user key relies on user
> > space.
> > 
> In case the kernel provides mechanism to generate key from passphase,
> the master key could also be generated in kernel space other than TPM.
> It seems than snapshot_key_init() is easy to add the interface for that,
> right?

The user defined key can be used to carry the blob from user space. User
sapce can use keyctl tool to enroll the blob. We can design a structure of
blob that it carries the hash of passphase, salt... so on. Then kernel
parses the blob to generate the key for encryption/authentication.

> > The name of snapshot key is fixed to "swsusp-kmk". User should use
> > the keyctl tool to load the key blob to root's user keyring. e.g.
> > 
> >  # /bin/keyctl add trusted swsusp-kmk "load `cat swsusp-kmk.blob`" @u
> > 
> > or create a new user key. e.g.
> > 
> >  # /bin/keyctl add user swsusp-kmk password @u

The above password can be a blob. The user defined key can carries the
blob to kernel. We can design the blob with userland tool later.

> > 
> > Then the disk_kmk sysfs file can be used to trigger the initialization
> > of snapshot key:
> > 
> >  # echo 1 > /sys/power/disk_kmk
> > 
> > After the initialization be triggered, the secret in the payload of
> > swsusp-key will be copied by hibernation and be erased. Then user can
> > use keyctl to remove swsusp-kmk key from root's keyring.
> > 
> > If user does not trigger the initialization by disk_kmk file after
> > swsusp-kmk be loaded to kernel. Then the snapshot key will be
> > initialled when hibernation be triggered.
> > 
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Oliver Neukum <oneukum@suse.com>
> > Cc: Ryan Chen <yu.chen.surf@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
[...snip]
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index abef759de7c8..18d13cbf0591 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -1034,6 +1034,39 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  
> >  power_attr(disk);
> >  
> > +#ifdef CONFIG_HIBERNATION_ENC_AUTH
> > +static ssize_t disk_kmk_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +			     char *buf)
> > +{
> > +	if (snapshot_key_initialized())
> > +		return sprintf(buf, "initialized\n");
> > +	else
> > +		return sprintf(buf, "uninitialized\n");
> > +}
> > +
> > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +			      const char *buf, size_t n)
> > +{
> Does kmk mean kernel master key? It might looks unclear from first glance,
> how about disk_genkey_store()?

Yes, it's the kernel maskter key for disk (hibernate).

The sysfs interfaces is used to load the master key from keyring, then
kernel parses the encrypted key or user defined key to grab the plaintext
key. So sysfs triggered the initial process of the master key.

Even user space didn't trigger the process through sysfs, kernel will
still runs the initial process when hibernation be triggered. Then
kernel uses the master key to derive encrypte key and authenticate key. 

I prefer to keep the name of sysfs and the function name. 

> > +	int error = 0;
> > +	char *p;
> > +	int len;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	p = memchr(buf, '\n', n);
> > +	len = p ? p - buf : n;
> > +	if (strncmp(buf, "1", len))
> > +		return -EINVAL;
> Why user is not allowed to disable(remove) it by
> echo 0 ?

Similar with evm, this sysfs interface gives user space a chance
to ask kernel to initial master key. Once the master key be
initialled and loaded, kernel doesn't want the key to be removed
because the key is unsealed by TPM. The PCRs may already capped
then there have no other master key can be unsealed and enrolled.

So, I prefer that do not give user space the function to
remove an enrolled master key. Once the master key be loaded,
kernel will use the key to encrypt snapshot image.   

> > +
> > +	error = snapshot_key_init();
> > +
> > +	return error ? error : n;
> > +}
> > +
> > +power_attr(disk_kmk);
> > +#endif /* !CONFIG_HIBERNATION_ENC_AUTH */
[...snip]
> > diff --git a/kernel/power/snapshot_key.c b/kernel/power/snapshot_key.c
> > new file mode 100644
> > index 000000000000..091f33929b47
> > --- /dev/null
> > +++ b/kernel/power/snapshot_key.c
[...snip]
> > +
> > +static int calc_hash(u8 *digest, const u8 *buf, unsigned int buflen,
> > +		     bool may_sleep)
> calc_hash() is used for both signature and encryption,
> could it be integrated in snapshot_key_init() thus
> the code could be re-used?

The snapshot_key_init() is used to parse the blob of master key for
grabbing the plaintext of key. It doesn't relate to encryption
key and authentication key.

The snapshot_key_init() reuses calc_hash() to calculate the fingerprint
of master key in 0004 patch. The get_key_fingerprint() is a wrapper of
calc_hash(). 

> > +{
> > +	SHASH_DESC_ON_STACK(desc, hash_tfm);
> Per commit c2cd0b08e1efd9ee58d09049a6c77e5efa0ef627
>  SHASH_DESC_ON_STACK() should not be used.

Thank you for point out! I will avoid to use VLA in next version.

> > +	int err;
> > +
> > +	desc->tfm = hash_tfm;
> > +	desc->flags = may_sleep ? CRYPTO_TFM_REQ_MAY_SLEEP : 0;
> > +
> > +	err = crypto_shash_digest(desc, buf, buflen, digest);
> Check the err?

I will check the err, thanks!

> > +	shash_desc_zero(desc);
> > +	return err;
> > +}
> > +
[...snip]

Thanks a lot!
Joey Lee
