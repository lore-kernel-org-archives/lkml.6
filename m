Return-Path: <kernel-hardening-return-12725-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELueUpEMZmnLRS2ghLHRXxESO+DJ3HAX/Kf9o7amQBk5el+Ij4ECq2cGFZETPh1xI7qewWO4
ARC-Seal: i=1; a=rsa-sha256; t=1521819445; cv=none;
        d=google.com; s=arc-20160816;
        b=rXM25s6+MOvQ1UNBghhrCD82F5Iscqe2zjQ2Q/UgdpaCHwj/fpGeRW1+tcqVikwIZe
         I0IsDklRq8PfMA1exN52GkjFZkeDS/tZWNPmJLUrFQnkeAlHlHvR3c7u61CZWOECplkZ
         85EOHi/ahGCu+5sC5yfausEYckKtZ1HMuZ/wtRdB4f7USRV562cwMQBCwnuFQUxoAFof
         J0VHBwNME3TNFjKkAaa2Geq4EOO2mCyptXKIHyxX/TNwyavLHSKhPn59bhhrRHCBHqWp
         cxKTxCkKvNn15fIyMotq9Euc6SH2lbIBWfb+Q/LuaZ3RsWKpn3p0L4oLcRmISwzCQUWr
         Fmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=F6Ov7VKY1kRTgpncyN7viPaDcM4ShwIU3IYlc4M7eKM=;
        b=0i6uojtCmUMZB0nZkCECyYhrTdOnNHBZFByu3tkR2sA0yXOMjEmKGooaiLVqDOkY30
         Lj2S3e9x6qtMDGCJ42JvpjlLjJUbh6k35pmY2x9JRvYBf7B3c0A+6VOhNJ5Bnk4alt1Y
         pZTGE7HD6ytbUbvpXWb8ZD3lbmUylg/20ttYxrsV4vTOVi5CWNU77ss6zsI2ZyeeFb5G
         Sn/r0iZr1irWvJXWl3LivgCZauxYQu2FSEXxYPkKeCiDxv5DnoZ1geTh0JbO3F0OWuzo
         bBpw8rmqczVXnv9RhBRQCIZ8UkFvxf6AnnhPdUDD99080iXE8wRg6ZA8fEOoXwF8E0qV
         nReA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12725-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12725-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12725-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12725-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 23 Mar 2018 23:36:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v2] crypto: ctr - avoid VLA use
Message-ID: <20180323153652.GA1760@gondor.apana.org.au>
References: <1521112738-13250-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521112738-13250-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595002335438491834?=
X-GMAIL-MSGID: =?utf-8?q?1595743346795989635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:18:58PM +0100, Salvatore Mesoraca wrote:
>
> +#define MAX_BLOCKSIZE 16
> +
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#define MAX_ALIGNMASK 15
> +#else
> +#define MAX_ALIGNMASK 0
> +#endif
> +

Hmm, this won't work.  Just because you have efficient unaligned
access in general doesn't mean that every implementation can live
with unaligned access.  In particular, on x86 there are quite a
few implementations that require alignment or they will fault.

So please just make it 15 unconditionally.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
