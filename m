Return-Path: <kernel-hardening-return-12712-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsSWGQwWdAmU5XVtjErlaks1i6GvErEvxvn1xQyr3oTePffnDn/dW/ud9pX+fAKw//EV/C8
ARC-Seal: i=1; a=rsa-sha256; t=1521605142; cv=none;
        d=google.com; s=arc-20160816;
        b=gmH+EJ3az8ag9OL/JtAZqy87EFOrZ9M+4vqx6RixY1a3mB5t8kUSXTxdE1UKfZju2B
         0JnsrYnoKCyrv15N/wm4ZGGNi/yQaKs+p1L4bc5VnphA8F/BgtpN1ud8CYsv6r7nRj9l
         +48NVoDHW/Z4EiPVSz2WIuORfaeZ7wd0O5waOIOspMSskznhZnAMmhdi94FyquA7fy0F
         2kyJCwLsKQT1zhk8lUIeUFVEKtJKcXtrQO8n6CqQ14aYwh/y80n65rntywqva8D7mXIf
         Fp2q/hxRql88ghXCI0nwhhe6YrkqvbYs5zhRIRr9FzYzFgLHjSRX9SIgxsoHuh6cc6n2
         ZPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=212K1GA4IIKbnBTt3r6PDb7WhFM4f8RN/+lmfj97vxU=;
        b=yg5Sd4ihAR6hkvjHt00Iy6+a/uycRvx+j3ZW304vio/Gxh29IDIV4s1MeC0v9hf+JC
         GTbsEHvK6tERRz/mFt/0FLb9dcJ1RTngY/EmebYrUvQ0VXaeqEywGWNRFa1DVQ+HP7QH
         nV6uB2k2Jf2YUvFN15o/JrO/bihI+3nSV8esweabBLoQPbxzZvAKM0XEpEKAFZ5KSug7
         t3vUoG6HtKSix9CmCbOF5C6p3z3kuR8qcHSvTEjrrux12h5kh9vIULQdZTkXcBGzFW2S
         xvXIn2CYhRrj2R9lE2vZoLIUJ60zmpymFIAPIEGku/F91cHMVJfLvEArbL0L5ZkK+tm0
         gdiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=AyteNvwb;
       spf=pass (google.com: domain of kernel-hardening-return-12712-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12712-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=AyteNvwb;
       spf=pass (google.com: domain of kernel-hardening-return-12712-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12712-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Mar 2018 22:05:11 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 2/2] dh key: get rid of stack array allocation
Message-ID: <20180321040511.GB18067@cisco>
References: <20180313042907.29598-1-tycho@tycho.ws>
 <20180313042907.29598-2-tycho@tycho.ws>
 <20180315022112.GB641@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315022112.GB641@zzz.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795386978188484?=
X-GMAIL-MSGID: =?utf-8?q?1595518634063945449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On Wed, Mar 14, 2018 at 07:21:12PM -0700, Eric Biggers wrote:
> On Mon, Mar 12, 2018 at 10:29:07PM -0600, Tycho Andersen wrote:
> > Similarly to the previous patch, we would like to get rid of stack
> > allocated arrays: https://lkml.org/lkml/2018/3/7/621
> > 
> > In this case, we can also use a malloc style approach to free the temporary
> > buffer, being careful to also use kzfree to free them (indeed, at least one
> > of these has a memzero_explicit, but it seems like maybe they both
> > should?).
> > 
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: David Howells <dhowells@redhat.com>
> > CC: James Morris <jmorris@namei.org>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > ---
> >  security/keys/dh.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/keys/dh.c b/security/keys/dh.c
> > index d1ea9f325f94..f02261b24759 100644
> > --- a/security/keys/dh.c
> > +++ b/security/keys/dh.c
> > @@ -162,19 +162,27 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
> >  			goto err;
> >  
> >  		if (zlen && h) {
> > -			u8 tmpbuffer[h];
> > +			u8 *tmpbuffer;
> >  			size_t chunk = min_t(size_t, zlen, h);
> > -			memset(tmpbuffer, 0, chunk);
> > +
> > +			err = -ENOMEM;
> > +			tmpbuffer = kzalloc(chunk, GFP_KERNEL);
> > +			if (!tmpbuffer)
> > +				goto err;
> >  
> >  			do {
> >  				err = crypto_shash_update(desc, tmpbuffer,
> >  							  chunk);
> > -				if (err)
> > +				if (err) {
> > +					kzfree(tmpbuffer);
> >  					goto err;
> > +				}
> >  
> >  				zlen -= chunk;
> >  				chunk = min_t(size_t, zlen, h);
> >  			} while (zlen);
> > +
> > +			kzfree(tmpbuffer);
> >  		}
> 
> This is just hashing zeroes.  Why not use the zeroes at the end of the 'src'
> buffer which was allocated as 'outbuf' in __keyctl_dh_compute()?  It's already
> the right size.  It might even simplify the code a bit since
> crypto_shash_update() would no longer need to be in a loop.

Can you clarify what you mean by the "end" here? It looks like the end
is copied over with the user string just before it's passed into
keyctl_dh_compute_kdf().

In any case, I agree that it's dumb to do this allocation in a loop
now. What if instead we just do one big long allocation of zlen, hash
it, and then free it? This has the advantage that it's not allocated
two functions away from where it's used...

> >  
> >  		if (src && slen) {
> > @@ -184,13 +192,20 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
> >  		}
> >  
> >  		if (dlen < h) {
> > -			u8 tmpbuffer[h];
> > +			u8 *tmpbuffer;
> > +
> > +			err = -ENOMEM;
> > +			tmpbuffer = kzalloc(h, GFP_KERNEL);
> > +			if (!tmpbuffer)
> > +				goto err;
> >  
> >  			err = crypto_shash_final(desc, tmpbuffer);
> > -			if (err)
> > +			if (err) {
> > +				kzfree(tmpbuffer);
> >  				goto err;
> > +			}
> >  			memcpy(dst, tmpbuffer, dlen);
> > -			memzero_explicit(tmpbuffer, h);
> > +			kzfree(tmpbuffer);
> >  			return 0;
> >  		} else {
> >  			err = crypto_shash_final(desc, dst);
> > -- 
> 
> Why not instead round the allocated size of 'outbuf' in keyctl_dh_compute_kdf()
> up to the next 'crypto_shash_digestsize()'-boundary?  Then this temporary buffer
> wouldn't be needed at all.

Thanks, I've made this change (and split it out into a separate patch)
for v2.

Tycho
