Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1091C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD723206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfAGPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:37:14 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:38133 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfAGPhO (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 7 Jan 2019 10:37:14 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 07 Jan 2019 16:37:11 +0100
Received: from linux-l9pv.suse (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 07 Jan 2019 15:33:45 +0000
Date:   Mon, 7 Jan 2019 23:33:27 +0800
From:   joeyli <jlee@suse.com>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Message-ID: <20190107153327.GB4210@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190103143227.9138-2-jlee@suse.com>
 <4539995.kc8yiMsNgQ@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4539995.kc8yiMsNgQ@tauon.chronox.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan, 

First, thanks for your review!

On Sun, Jan 06, 2019 at 09:01:27AM +0100, Stephan Mueller wrote:
> Am Donnerstag, 3. Januar 2019, 15:32:23 CET schrieb Lee, Chun-Yi:
> 
> Hi Chun,
> 
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
[...snip]
> > +static int calc_hash(u8 *digest, const u8 *buf, unsigned int buflen,
> > +		     bool may_sleep)
> > +{
> > +	struct shash_desc *desc;
> > +	int err;
> > +
> > +	desc = kzalloc(sizeof(struct shash_desc) +
> > +		       crypto_shash_descsize(hash_tfm),
> > +		       may_sleep ? GFP_KERNEL : GFP_ATOMIC);
> 
> Why not using SHASH_DESC_ON_STACK?
>

Because security concern and bad runtime performance. Please looking at
c2cd0b08e1e patch for hibernation. And reference:

https://lore.kernel.org/lkml/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com/T/#u
https://lwn.net/Articles/749064/
 
> > +	if (!desc)
> > +		return -ENOMEM;
> > +
> > +	desc->tfm = hash_tfm;
> > +	desc->flags = may_sleep ? CRYPTO_TFM_REQ_MAY_SLEEP : 0;
> > +	err = crypto_shash_digest(desc, buf, buflen, digest);
> > +	shash_desc_zero(desc);
> > +	kzfree(desc);
> > +
> > +	return err;
> > +}
> > +
> > +static int calc_key_hash(u8 *key, unsigned int key_len, const char *salt,
> > +			 u8 *hash, bool may_sleep)
> > +{
> > +	unsigned int salted_buf_len;
> > +	u8 *salted_buf;
> > +	int ret;
> > +
> > +	if (!key || !hash_tfm || !hash)
> > +		return -EINVAL;
> > +
> > +	salted_buf_len = strlen(salt) + 1 + SNAPSHOT_KEY_SIZE;
> 
> strlen on binary data? I guess that will not work. May I suggest to hand down 
> the length of salt to this function?
>

hm... The salt is actually a "salt string" that's gave from
snapshot_get_auth_key() or snapshot_get_enc_key(). So I use
strlen() here. I will change the name to salt_string to avoid
confusion. 
 
> > +	salted_buf = kzalloc(salted_buf_len,
> > +			may_sleep ? GFP_KERNEL : GFP_ATOMIC);
> > +	if (!salted_buf)
> > +		return -ENOMEM;
> > +
> > +	strcpy(salted_buf, salt);
> > +	memcpy(salted_buf + strlen(salted_buf) + 1, key, key_len);
> > +
> > +	ret = calc_hash(hash, salted_buf, salted_buf_len, may_sleep);
> > +	memzero_explicit(salted_buf, salted_buf_len);
> > +	kzfree(salted_buf);
> > +
> > +	return ret;
> > +}
> 
> This function looks very much like a key derivation. May I strongly propose to 

Actually key derivation function is modified from the get_derived_key() from
the encrypted.c file in encrypted key.

> use an official KDF type like SP800-108 or HKDF?
> 
> You find the counter-KDF according to SP800-108 in security/keys/dh.c (search 
> for functions *kdf*).
> 
> Or we may start pulling in KDF support into the kernel crypto API via the 
> patches along the line of [1].
> 
> [1] http://www.chronox.de/kdf.html
>

Thanks for your suggestion. I didn't touch any key derivation standard
before. I will study it.

But I still want to use my original function currently. Because the same
logic is also used in trusted key. I will happy to move to SP800-108 or
HKDF when it's available in kernel.  

> > +
> > +/* Derive authentication/encryption key */
> > +static int get_derived_key(u8 *derived_key, const char *derived_type_str,
> > +			   bool may_sleep)
[...snip]
> > +static int trusted_key_init(void)
> > +{
> > +	struct trusted_key_payload *tkp;
> > +	struct key *key;
> > +	int err = 0;
> > +
> > +	pr_debug("%s\n", __func__);
> > +
> > +	/* find out swsusp-key */
> > +	key = request_key(&key_type_trusted, skey.key_name, NULL);
> > +	if (IS_ERR(key)) {
> > +		pr_err("Request key error: %ld\n", PTR_ERR(key));
> > +		err = PTR_ERR(key);
> > +		return err;
> > +	}
> > +
> > +	down_write(&key->sem);
> > +	tkp = key->payload.data[0];
> > +	if (invalid_key(tkp->key, tkp->key_len)) {
> > +		err = -EINVAL;
> > +		goto key_invalid;
> > +	}
> > +	skey.key_len = tkp->key_len;
> > +	memcpy(skey.key, tkp->key, tkp->key_len);
> > +	/* burn the original key contents */
> > +	memzero_explicit(tkp->key, tkp->key_len);
> > +
> > +key_invalid:
> > +	up_write(&key->sem);
> > +	key_put(key);
> > +
> > +	return err;
> > +}
> > +
> > +static int user_key_init(void)
> 
> This function and trusted_key_init look very similar - could they be collapsed 
> into one function?
>

The data structure is different between trusted key with user key. I will try to
extract the duplicate part but may not collapse into one.
 
> > +{
> > +	struct user_key_payload *ukp;
> > +	struct key *key;
> > +	int err = 0;
> > +
> > +	pr_debug("%s\n", __func__);
> > +
> > +	/* find out swsusp-key */
> > +	key = request_key(&key_type_user, skey.key_name, NULL);
> > +	if (IS_ERR(key)) {
> > +		pr_err("Request key error: %ld\n", PTR_ERR(key));
> > +		err = PTR_ERR(key);
> > +		return err;
> > +	}
> > +
> > +	down_write(&key->sem);
> > +	ukp = user_key_payload_locked(key);
> > +	if (!ukp) {
> > +		/* key was revoked before we acquired its semaphore */
> > +		err = -EKEYREVOKED;
> > +		goto key_invalid;
> > +	}
> > +	if (invalid_key(ukp->data, ukp->datalen)) {
> > +		err = -EINVAL;
> > +		goto key_invalid;
> > +	}
> > +	skey.key_len = ukp->datalen;
> > +	memcpy(skey.key, ukp->data, ukp->datalen);
> 
> Where would skey.key be destroyed again?
>

Yes, you saw it in later patch.

Thanks a lot!
Joey Lee 
