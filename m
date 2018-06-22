Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C67AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64223C63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D64223C63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934206AbeFVCdm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:33:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:11249 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933905AbeFVCdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:33:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 19:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="51294413"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2018 19:33:38 -0700
Date:   Fri, 22 Jun 2018 10:39:13 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180622023913.GB30305@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180620174142.GA76265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620174142.GA76265@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
On Wed, Jun 20, 2018 at 10:41:42AM -0700, Eric Biggers wrote:
> Hi Chen,
> 
> On Wed, Jun 20, 2018 at 05:40:51PM +0800, Chen Yu wrote:
> > crypto_hibernate is a user-space utility to generate
> > 512bits AES key and pass it to the kernel via ioctl
> > for hibernation encryption.(We can also add the key
> > into kernel via keyctl if necessary, but currently
> > using ioctl seems to be more straightforward as we
> > need both the key and salt transit).
> > 
> > The key derivation is based on a simplified implementation
> > of PBKDF2[1] in e2fsprogs - both the key length and the hash
> > bytes are the same - 512bits. crypto_hibernate will firstly
> > probe the user for passphrase and get salt from kernel, then
> > uses them to generate a 512bits AES key based on PBKDF2.
Thanks for reviewing this.
> 
> What is a "512bits AES key"?  Do you mean AES-256-XTS (which takes a 512-bit
> key, which the XTS mode internally splits into two keys)? 
Yes, it is AES-256-XTS.
> Do you allow for
> other algorithms, or is it hardcoded to AES-256-XTS? 
Currently it is hardcoded to AES-256-XTS. It is copied from implementation
of PBKDF2 in e2fsprogs, which is hardcoded to useAES-256-XTS for ext4 encryption
in the kernel(pbkdf2_sha512() in e2fsprogs)
> What if someone wants to
> use a different algorithm?
> 
If user wants to use a different algorithm, then I think we need to
port the code from openssl, which is the full implementation of PBKDF2
for:
https://www.ietf.org/rfc/rfc2898.txt 
> BTW, it's difficult to review this with only patch 3/3 Cc'ed to me, as there is
> no context about the problem you are trying to solve and what your actual
> proposed kernel changes are.  I suggest Cc'ing linux-crypto on all 3 patches.
> 
Ok, I'll send a refreshed version.
> A few more comments below, from a very brief reading of the code:
> 
> [...]
> > +
> > +#define PBKDF2_ITERATIONS          0xFFFF
> > +#define SHA512_BLOCKSIZE 128
> > +#define SHA512_LENGTH 64
> > +#define SALT_BYTES	16
> > +#define SYM_KEY_BYTES SHA512_LENGTH
> > +#define TOTAL_USER_INFO_LEN	(SALT_BYTES+SYM_KEY_BYTES)
> > +#define MAX_PASSPHRASE_SIZE	1024
> > +
> > +struct hibernation_crypto_keys {
> > +	char derived_key[SYM_KEY_BYTES];
> > +	char salt[SALT_BYTES];
> > +	bool valid;
> > +};
> > +
> > +struct hibernation_crypto_keys hib_keys;
> > +
> > +static char *get_key_ptr(void)
> > +{
> > +	return hib_keys.derived_key;
> > +}
> > +
> > +static char *get_salt_ptr(void)
> > +{
> > +	return hib_keys.salt;
> > +}
> [...]
> > +
> > +
> > +#define HIBERNATE_SALT_READ      _IOW('C', 3, struct hibernation_crypto_keys)
> > +#define HIBERNATE_KEY_WRITE     _IOW('C', 4, struct hibernation_crypto_keys)
> 
> Why are the ioctl numbers defined based on the size of 'struct
> hibernation_crypto_keys'?  It's not a UAPI structure, right?
> 
It's not a UAPI structure, and it is defined both in user space tool
and in kernel. Do you mean, I should put the defination of this
structure under include/uapi ?
> > +
> > +static void get_passphrase(char *passphrase, int len)
> > +{
> > +	char *p;
> > +	struct termios current_settings;
> > +
> > +	assert(len > 0);
> > +	disable_echo(&current_settings);
> > +	p = fgets(passphrase, len, stdin);
> > +	tcsetattr(0, TCSANOW, &current_settings);
> > +	printf("\n");
> > +	if (!p) {
> > +		printf("Aborting.\n");
> > +		exit(1);
> > +	}
> > +	p = strrchr(passphrase, '\n');
> > +	if (!p)
> > +		p = passphrase + len - 1;
> > +	*p = '\0';
> > +}
> > +
> > +#define CRYPTO_FILE	"/dev/crypto_hibernate"
> > +
> > +static int write_keys(void)
> > +{
> > +	int fd;
> > +
> > +	fd = open(CRYPTO_FILE, O_RDWR);
> > +	if (fd < 0) {
> > +		printf("Cannot open device file...\n");
> > +		return -EINVAL;
> > +	}
> > +	ioctl(fd, HIBERNATE_KEY_WRITE, get_key_ptr());
> > +	return 0;
> 
> No error checking on the ioctl?
> 
Ok, will add error checking for it.
> Also, how is the kernel supposed to know how long the key is, and which
> algorithm it's supposed to be used for?  I assume it's hardcoded to AES-256-XTS?
> What if someone wants to use a different algorithm?
> 
Yes, the length in both user space and kernel are hardcoded to AES-256-XTS.
I can add the support for other algorithm, but might need to port from
openssl first.
> > +}
> > +
> > +static int read_salt(void)
> > +{
> > +	int fd;
> > +
> > +	fd = open(CRYPTO_FILE, O_RDWR);
> > +	if (fd < 0) {
> > +		printf("Cannot open device file...\n");
> > +		return -EINVAL;
> > +	}
> > +	ioctl(fd, HIBERNATE_SALT_READ, get_salt_ptr());
> > +	return 0;
> > +}
> 
> No error checking on the ioctl?
> 
Ok, will add checkings.
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt, option_index = 0;
> > +	char in_passphrase[MAX_PASSPHRASE_SIZE];
> > +
> > +	while ((opt = getopt_long_only(argc, argv, "+p:s:h",
> > +				NULL, &option_index)) != -1) {
> > +		switch (opt) {
> > +		case 'p':
> > +			{
> > +				char *p = optarg;
> > +
> > +				if (strlen(p) >= (MAX_PASSPHRASE_SIZE - 1)) {
> > +					printf("Please provide passphrase less than %d bytes.\n",
> > +						MAX_PASSPHRASE_SIZE);
> > +					exit(1);
> > +				}
> > +				strcpy(in_passphrase, p);
> 
> I haven't read this super closely, but this really looks like an off-by-one
> error.  It seems you intended MAX_PASSPHRASE_SIZE to include a null terminator,
> so the correct check would be 'strlen(p) >= MAX_PASSPHRASE_SIZE'.
> 
Ah, right, will change it.
> > +			}
> > +			break;
> > +		case 's':
> > +			{
> > +				char *p = optarg;
> > +
> > +				if (strlen(p) != (SALT_BYTES - 1)) {
> > +					printf("Please provide salt with len less than %d bytes.\n",
> > +						SALT_BYTES);
> > +					exit(1);
> > +				}
> > +				strcpy(get_salt_ptr(), p);
> > +			}
> > +			break;
> 
> Salts don't need to be human-readable.  How about making the salt binary?  So, a
> salt specified on the command-line would be hex.
>
Ok, I will change it to hex form.
Best,
Yu
> Eric
