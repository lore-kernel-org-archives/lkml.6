Return-Path: <kernel-hardening-return-12713-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvAgEV1F84bUFs0sBZ5EyhlIWwcN9tHUtm8jUE4XzBg8J0sQZ0KRBrZDWq0iAV7xgUia9uy
ARC-Seal: i=1; a=rsa-sha256; t=1521605176; cv=none;
        d=google.com; s=arc-20160816;
        b=FklpXzi7BrepqD+7NDviF6r55VdLQ1369ViwqTODlGxdrLRQ0fQXsJeziSVEION8I7
         mqWZRl+egS4ApLNJDbEMpSX+xNK8zNcKh6m8uN6J0ah0lwixjeEBKZHSWPljX4am0jjb
         sFIIo0kz3yzhsbafDT/h+LGnXDd1Lam/iB1CSgpxuWMTb5UY96UnfegJ+kD72YUDX1kj
         MPbKL0zUgCtp1kirgQ+sPLwU870r7C8DtrC/zTwSXTFAKggfgQAPYuppHT2dI/3h2KIL
         EKpB0UokQmeeDZS4HXhbJPYmt4uaVVQY2dlP7XoyV7VafwuvflyRP3hm+4RA5UAJ6QSg
         m5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=E2LIocWiokbgsXrBr+6kSkZ4TGkhxU+9FlfI9rmuzjE=;
        b=RvB1jXBWwSBcQlKxBS0geNijrMFISKiCCxlgVN++BE9UoYU4TBVwOzJGECaVOfvxsX
         n4WAqKVH0kJ6Pc/xxaBHAPmpCmIuIhQISOOtybSFZhBWFPrPnnbK0QNUcpQioxFdJcHU
         VHjm3HJ4C9mcnwJ2csgSTyOxj5zeP4t4OKxw6RKBok5+qzzSDwakoLpKYsO4HOVaDja+
         BkS/0bz9/gakE52F/EUrvVd//2KlL4jv4073Drhm7mNtzwrJGXt/iK9Cp71418cwSPt7
         L2LXYIOnCBcDSNl/drniUUuD2ROm2lltpw6M+Txahya1dq9qCuX/GmnSR2jPHCAoVim/
         f53w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=ncO766/r;
       spf=pass (google.com: domain of kernel-hardening-return-12713-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12713-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=ncO766/r;
       spf=pass (google.com: domain of kernel-hardening-return-12713-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12713-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Mar 2018 22:05:53 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/2] big key: get rid of stack array allocation
Message-ID: <20180321040553.GC18067@cisco>
References: <20180313042907.29598-1-tycho@tycho.ws>
 <20180315015139.GA641@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315015139.GA641@zzz.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795410426531293?=
X-GMAIL-MSGID: =?utf-8?q?1595518669922839334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On Wed, Mar 14, 2018 at 06:51:39PM -0700, Eric Biggers wrote:
> On Mon, Mar 12, 2018 at 10:29:06PM -0600, Tycho Andersen wrote:
> > We're interested in getting rid of all of the stack allocated arrays in the
> > kernel [1]. This patch removes one in keys by switching to malloc/free.
> > Note that we use kzalloc, to avoid leaking the nonce. I'm not sure this is
> > really necessary, but extra paranoia seems prudent.
> > 
> > Manually tested using the program from the add_key man page to trigger
> > big_key.
> > 
> > [1]: https://lkml.org/lkml/2018/3/7/621
> > 
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: David Howells <dhowells@redhat.com>
> > CC: James Morris <jmorris@namei.org>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  security/keys/big_key.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> > index fa728f662a6f..70f9f785c59d 100644
> > --- a/security/keys/big_key.c
> > +++ b/security/keys/big_key.c
> > @@ -108,13 +108,18 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
> >  	 * an .update function, so there's no chance we'll wind up reusing the
> >  	 * key to encrypt updated data. Simply put: one key, one encryption.
> >  	 */
> > -	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
> > +	u8 *zero_nonce;
> > +
> > +	zero_nonce = kzalloc(crypto_aead_ivsize(big_key_aead), GFP_KERNEL);
> > +	if (!zero_nonce)
> > +		return -ENOMEM;
> >  
> >  	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
> > -	if (!aead_req)
> > +	if (!aead_req) {
> > +		kfree(zero_nonce);
> >  		return -ENOMEM;
> > +	}
> >  
> > -	memset(zero_nonce, 0, sizeof(zero_nonce));
> >  	aead_request_set_crypt(aead_req, buf->sg, buf->sg, datalen, zero_nonce);
> >  	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
> >  	aead_request_set_ad(aead_req, 0);
> > @@ -131,6 +136,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
> >  error:
> >  	mutex_unlock(&big_key_aead_lock);
> >  	aead_request_free(aead_req);
> > +	kzfree(zero_nonce);
> >  	return ret;
> 
> A dynamic allocation here doesn't make sense -- the algorithm is hard-coded to
> AES-GCM, so the IV size is fixed.  You should just include <crypto/gcm.h> and
> use GCM_AES_IV_LEN.  As a sanity check you can add
> 'BUG_ON(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_LEN' to big_key_init().
> 
> kzfree() also doesn't make sense since the nonce is not secret information.

Thanks, I've fixed this for v2.

Cheers,

Tycho
