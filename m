Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A46C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7DB23C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATNfxex3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7DB23C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934337AbeFVC7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:59:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37982 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934071AbeFVC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:59:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so2482734pfl.5;
        Thu, 21 Jun 2018 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flqJ8NH4Gfcet8yr0+KImBa/i/cqP6uQaRGY7s5ZzPM=;
        b=ATNfxex3ALXYEO4mtVxrpSuO02StEQsb8ZysoLu8joFgb/0CzlgZ+vnX/JsEvIXhXu
         bMVM5TZTBOquAqodF3gc++RNIoPzmOWM6RBnuwlAnFgfexMrqgrYyy0eUrxYiFob48X0
         BF3pAz7ohcaXC5ovnx7ZESeYgV9QRDi+4/XSH5raG5mvoIFNiyDuuoBNVCni01TbN4OH
         TflIHmJbLGiLhewx8TyBW7fU1a+HxZ477Okz1JN6+Qvav7in7jxF2hf8lAVIplxYNlP2
         QOF9x0i2QtAk5xq6RdW29b940ddHzss5hosVyzhbW5MM/A8MZR7xEuhQoraq8UVzQ8Kc
         p0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=flqJ8NH4Gfcet8yr0+KImBa/i/cqP6uQaRGY7s5ZzPM=;
        b=Khp7UPYZZugDvRTV1ga+yP+mgvEcL6x7gV21cEThmMpCROnuOg98SHayP8U7gYsTcv
         XzvhD27qEp49/p920q3YLJE0pyAZyZ9RGa/keJFHMt+xHwGC1qfme3RKiuLBx3rIER8B
         x90Q2WyaOmADYYPR0h2mxiQzRL1cjWYqDf4zETrykNEASqoaTEHDatSDpPSi0cQRRKim
         CLtkfNNrvdPGta9v5hh7JbqonsJ0saCLotp9B7KS1s1Rmhp/x9oQPQM6S2vSzNTzWXTM
         GPJigXCqzEplX0XCoOYWzZoWW10Jq3DChg+3LOcqyobmJVr84SZvPCt07GHlMNPxagiP
         wiEQ==
X-Gm-Message-State: APt69E1mykMcwH7javcHNnuq9or57EBYLKpGIAnh2g7B9aIS2u1NlhrX
        FkRohzB1PZlBE2xoIKC3DbM6iAWM
X-Google-Smtp-Source: ADUXVKItbBP5HHXJNRprhdKazb5Z9S4sZLR0EuQjaQZMTMqL73gbVZmU5VutUYrJ1cVpliCh9wrsqA==
X-Received: by 2002:a65:6319:: with SMTP id g25-v6mr25047660pgv.437.1529636362847;
        Thu, 21 Jun 2018 19:59:22 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id n25-v6sm9433955pff.119.2018.06.21.19.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 19:59:21 -0700 (PDT)
Date:   Thu, 21 Jun 2018 19:59:19 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180622025919.GA702@sol.localdomain>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180620174142.GA76265@gmail.com>
 <20180622023913.GB30305@sandybridge-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622023913.GB30305@sandybridge-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Fri, Jun 22, 2018 at 10:39:13AM +0800, Yu Chen wrote:
> Hi Eric,
> On Wed, Jun 20, 2018 at 10:41:42AM -0700, Eric Biggers wrote:
> > Hi Chen,
> > 
> > On Wed, Jun 20, 2018 at 05:40:51PM +0800, Chen Yu wrote:
> > > crypto_hibernate is a user-space utility to generate
> > > 512bits AES key and pass it to the kernel via ioctl
> > > for hibernation encryption.(We can also add the key
> > > into kernel via keyctl if necessary, but currently
> > > using ioctl seems to be more straightforward as we
> > > need both the key and salt transit).
> > > 
> > > The key derivation is based on a simplified implementation
> > > of PBKDF2[1] in e2fsprogs - both the key length and the hash
> > > bytes are the same - 512bits. crypto_hibernate will firstly
> > > probe the user for passphrase and get salt from kernel, then
> > > uses them to generate a 512bits AES key based on PBKDF2.
> Thanks for reviewing this.
> > 
> > What is a "512bits AES key"?  Do you mean AES-256-XTS (which takes a 512-bit
> > key, which the XTS mode internally splits into two keys)? 
> Yes, it is AES-256-XTS.
> > Do you allow for
> > other algorithms, or is it hardcoded to AES-256-XTS? 
> Currently it is hardcoded to AES-256-XTS. It is copied from implementation
> of PBKDF2 in e2fsprogs, which is hardcoded to useAES-256-XTS for ext4 encryption
> in the kernel(pbkdf2_sha512() in e2fsprogs)
>
> > What if someone wants to
> > use a different algorithm?
> > 
> If user wants to use a different algorithm, then I think we need to
> port the code from openssl, which is the full implementation of PBKDF2
> for:
> https://www.ietf.org/rfc/rfc2898.txt 

You seem to be confusing the key derivation function (KDF) with the encryption
algorithm the derived key is used for.  The purpose of a KDF is to derive key
material.  The resulting key material can be used for any encryption algorithm,
provided that you derive the needed amount of key material.  Note that different
encryption algorithms can use the same length key, e.g. SERPENT-256-XTS and
AES-256-XTS are both examples of algorithms that use a 64 byte (512-bit) key.
So your design probably should provide a way for an *algorithm* to be selected,
not just a key length.

> > BTW, it's difficult to review this with only patch 3/3 Cc'ed to me, as there is
> > no context about the problem you are trying to solve and what your actual
> > proposed kernel changes are.  I suggest Cc'ing linux-crypto on all 3 patches.
> > 
> Ok, I'll send a refreshed version.
> > A few more comments below, from a very brief reading of the code:
> > 
> > [...]
> > > +
> > > +#define PBKDF2_ITERATIONS          0xFFFF
> > > +#define SHA512_BLOCKSIZE 128
> > > +#define SHA512_LENGTH 64
> > > +#define SALT_BYTES	16
> > > +#define SYM_KEY_BYTES SHA512_LENGTH
> > > +#define TOTAL_USER_INFO_LEN	(SALT_BYTES+SYM_KEY_BYTES)
> > > +#define MAX_PASSPHRASE_SIZE	1024
> > > +
> > > +struct hibernation_crypto_keys {
> > > +	char derived_key[SYM_KEY_BYTES];
> > > +	char salt[SALT_BYTES];
> > > +	bool valid;
> > > +};
> > > +
> > > +struct hibernation_crypto_keys hib_keys;
> > > +
> > > +static char *get_key_ptr(void)
> > > +{
> > > +	return hib_keys.derived_key;
> > > +}
> > > +
> > > +static char *get_salt_ptr(void)
> > > +{
> > > +	return hib_keys.salt;
> > > +}
> > [...]
> > > +
> > > +
> > > +#define HIBERNATE_SALT_READ      _IOW('C', 3, struct hibernation_crypto_keys)
> > > +#define HIBERNATE_KEY_WRITE     _IOW('C', 4, struct hibernation_crypto_keys)
> > 
> > Why are the ioctl numbers defined based on the size of 'struct
> > hibernation_crypto_keys'?  It's not a UAPI structure, right?
> > 
> It's not a UAPI structure, and it is defined both in user space tool
> and in kernel. Do you mean, I should put the defination of this
> structure under include/uapi ?

No, I'm saying that you shouldn't define ioctl numbers (permanent ABI) based on
the size of some random structure that is subject to change.

> > > +
> > > +static void get_passphrase(char *passphrase, int len)
> > > +{
> > > +	char *p;
> > > +	struct termios current_settings;
> > > +
> > > +	assert(len > 0);
> > > +	disable_echo(&current_settings);
> > > +	p = fgets(passphrase, len, stdin);
> > > +	tcsetattr(0, TCSANOW, &current_settings);
> > > +	printf("\n");
> > > +	if (!p) {
> > > +		printf("Aborting.\n");
> > > +		exit(1);
> > > +	}
> > > +	p = strrchr(passphrase, '\n');
> > > +	if (!p)
> > > +		p = passphrase + len - 1;
> > > +	*p = '\0';
> > > +}
> > > +
> > > +#define CRYPTO_FILE	"/dev/crypto_hibernate"
> > > +
> > > +static int write_keys(void)
> > > +{
> > > +	int fd;
> > > +
> > > +	fd = open(CRYPTO_FILE, O_RDWR);
> > > +	if (fd < 0) {
> > > +		printf("Cannot open device file...\n");
> > > +		return -EINVAL;
> > > +	}
> > > +	ioctl(fd, HIBERNATE_KEY_WRITE, get_key_ptr());
> > > +	return 0;
> > 
> > No error checking on the ioctl?
> > 
> Ok, will add error checking for it.
> > Also, how is the kernel supposed to know how long the key is, and which
> > algorithm it's supposed to be used for?  I assume it's hardcoded to AES-256-XTS?
> > What if someone wants to use a different algorithm?
> > 
> Yes, the length in both user space and kernel are hardcoded to AES-256-XTS.
> I can add the support for other algorithm, but might need to port from
> openssl first.

The kernel crypto API already supports many other ciphers.  It's the kernel that
actually does the encryption, right?

Again, you should Cc the whole patchset to linux-crypto so that people can
review it context, including your new kernel code that actually does the
encryption, and see what problem you are actually trying to solve.

Thanks!

- Eric
