Return-Path: <kernel-hardening-return-12625-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvRjZYj7OYH30/HRHOvhzMCOnS0xgo+piqCqE6lHO5OZ3do4vdQodsFELFF9uTGsC45gIWp
ARC-Seal: i=1; a=rsa-sha256; t=1521107700; cv=none;
        d=google.com; s=arc-20160816;
        b=FPt7azq0W5TB8obauP7XE9wbeS4QU+1ce5emdPY4PoOnznuod5WviLS0Yqo5Z6Qve5
         bJqYhnw+Qn6M5ld8G0nIUaohXdKNgGksNFHZS9VsKef5PWxMFeGqJMBo8suUKmYej+rX
         CEVwWeckRRKiLRSIq1ZVHsJLxQSAkTAm/w6ztf2dEno3q8mDhyzL60E6PA5jHETSp9MF
         HkfxtsY9mPpRzLL4fBh4zQFlTvZq+5JEMws6au7kJ8rWcIdrO1m4U8pxfE5yahcEphaw
         vL3Ms3wP+vpfHzH0WvXyOn5khQGM3pkG8lWOX994mPy3mU13CA2oR9q2yJVNa7jbB2W4
         ntYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=0i66+ZPfgz5GcBvspqo1mvUHmb40zlQYqV3c0y1h+Co=;
        b=bFY62Nu33mSDk9wB/hEgWVy0sBuf0KTdTJdCQ6kiHorpZ327TLPFTFH8o0u3Hychzu
         4/T33df48eef8rAE561IGKatgkzNakuYEP7syPlItSChT1og/SVe5HVDWv89NizztcoF
         p72VkhOTlif0PeAZiz+SiDZthb2LohNp3pTwUdyC2wg7dXL+DKhpF5/HcDvGXxPNdXxj
         DUb7K8GjMJbE1/iVutpw6MrBgkz5lw2mnM4WClVhGVwIl4DnbiNEX2Ck4agOQjvm7oFJ
         n1gkFp+9Xzo58sub/Y64f72WSZ2ivCWGuNnHN7mGpaBTCRaWICqVff7X/iB2Z4meQgFm
         VyDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12625-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12625-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12625-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12625-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Mar 2018 17:54:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
Message-ID: <20180315095428.GA31069@gondor.apana.org.au>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594997028072289557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:17:30PM +0100, Salvatore Mesoraca wrote:
> All ciphers implemented in Linux have a block size less than or
> equal to 16 bytes and the most demanding hw require 16 bits
> alignment for the block buffer.
> We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bits
> alignment, unless the architecture support efficient unaligned
> accesses.
> We also check, at runtime, that our assumptions still stand,
> possibly dynamically allocating a new buffer, just in case
> something changes in the future.

Please move the check to ctr instance creation time.  That is,
if the underlying blocksize is greater than 16 bytes than simply
fail the creation.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
