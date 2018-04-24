Return-Path: <kernel-hardening-return-13111-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48WzeBa7blgQrt0kvNcmPuzQk26Z59lHfw93fQ1b/SEIwOd+E+SNlmbXgXZfwYeefg+/geb
ARC-Seal: i=1; a=rsa-sha256; t=1524580563; cv=none;
        d=google.com; s=arc-20160816;
        b=Fm88w/fSE9CjJFAZfvtFyiu9ogikuvgSWJeLI2WbZSW9dhcTCS0C1L1NSan2BbSqbA
         WY5/grbUYB3t17pDO8fXp4tfWpAuLWje99VGsEktHJlZn0iZd4PeuQ3oi4eAVAfg9bap
         cfQRTTe65hOt7SDcbfZtGdhQe/GRYXdt/6ILQ3XE/jmU1/XwJkaCazBaR5EGk1eMf8un
         mpBzRLhNmgx8sPup8Ee5LQxHVBN+MXYGGQRIeEJbJSkEnYOkUcM9kJoSI86Djhr8a/L4
         HN2rEZZyzIaBiPYh9VGD/UthZrnOIfdPtiqAZVAmLdmFlxOZraj5BS7MY7oS24vK7+y5
         BmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ap6CK/kvAFtmtUjG6ztmzVrqrS3F/RVS0naL0bKVRc0=;
        b=YjJYXGtHdKK8xYlEfnGUHkcxfxMW40MIkLt2bcHLIVah1wdscdBZsbOklY3V4NABgP
         k7zjN8BYIdwwl7Jo0qbljRThih3bm6fSnqhuechAtXvJgkE1NQiskw2br/C5v2aDU5bH
         rGMXCrPxw2GcI7ELyHiW6pBmui/AhbvOEntApDJzw/Tz0eXpkZftT9/peTa6JrdJUfL3
         OJ476AIXd4CSJkIPYGARCFoxEdpvu6pqWnvONG2p6GhEiyE3kqvUyErdB3I1Y4ZRZzB/
         PKYclVDZDFo0uQ36yypJKLX/NxuMP4bUU/HTCihs3ovL1jV25uVmvAPyhLwaZoudrO2+
         pO8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Y99z8qD1;
       spf=pass (google.com: domain of kernel-hardening-return-13111-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13111-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Y99z8qD1;
       spf=pass (google.com: domain of kernel-hardening-return-13111-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13111-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 08:35:39 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180424143539.GB3125@cisco>
References: <20180424010321.14739-1-tycho@tycho.ws>
 <20180424045015.GA4281@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424045015.GA4281@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598638589298586096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On Mon, Apr 23, 2018 at 09:50:15PM -0700, Eric Biggers wrote:
> Hi Tycho,
> 
> On Mon, Apr 23, 2018 at 07:03:19PM -0600, Tycho Andersen wrote:
> > We're interested in getting rid of all of the stack allocated arrays in the
> > kernel [1]. This patch simply hardcodes the iv length to match that of the
> > hardcoded cipher.
> > 
> > [1]: https://lkml.org/lkml/2018/3/7/621
> > 
> > v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
> >     sanity check in init(), Eric Biggers
> > 
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: David Howells <dhowells@redhat.com>
> > CC: James Morris <jmorris@namei.org>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Jason A. Donenfeld <Jason@zx2c4.com>
> > CC: Eric Biggers <ebiggers3@gmail.com>
> > ---
> >  security/keys/big_key.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> > index 933623784ccd..75c46786a166 100644
> > --- a/security/keys/big_key.c
> > +++ b/security/keys/big_key.c
> > @@ -22,6 +22,7 @@
> >  #include <keys/user-type.h>
> >  #include <keys/big_key-type.h>
> >  #include <crypto/aead.h>
> > +#include <crypto/gcm.h>
> >  
> >  struct big_key_buf {
> >  	unsigned int		nr_pages;
> > @@ -109,7 +110,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
> >  	 * an .update function, so there's no chance we'll wind up reusing the
> >  	 * key to encrypt updated data. Simply put: one key, one encryption.
> >  	 */
> > -	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
> > +	u8 zero_nonce[GCM_AES_IV_SIZE];
> >  
> >  	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
> >  	if (!aead_req)
> > @@ -425,6 +426,12 @@ static int __init big_key_init(void)
> >  		pr_err("Can't alloc crypto: %d\n", ret);
> >  		return ret;
> >  	}
> > +
> > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > +		WARN(1, "big key algorithm changed?");
> > +		return -EINVAL;
> > +	}
> > +
> 
> 'big_key_aead' needs to be freed on error.
> 
> 	err = -EINVAL;
> 	goto free_aead;

oof, yes, thanks.

> Also how about defining the IV size next to the algorithm name?
> Then all the algorithm details would be on adjacent lines:
> 
> static const char big_key_alg_name[] = "gcm(aes)";
> #define BIG_KEY_IV_SIZE         GCM_AES_IV_SIZE

Sounds good, I'll fix both of these for v3.

Cheers,

Tycho
