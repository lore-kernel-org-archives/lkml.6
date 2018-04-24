Return-Path: <kernel-hardening-return-13123-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqfozNicTO4GxVBFiWSZgVkcxAbtOQAoDjF5snZYIB4MJ0qwLF3X+FvzSIB2La0RBOs8wQ9
ARC-Seal: i=1; a=rsa-sha256; t=1524600568; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWnELqxmoN/CYyQPl3eXZ0pwO9JtOjhGnlnOn2FdcY7W8YR/wgKaMoS5W1yc/0qag4
         qQyFBwihjCDBJIWek2YeYt/RQywvfDrjmfsHQLHqQnjTdLwsHDyRgtQYbfUuRGd+7GuL
         7tzKVN+DiAD6gtPnyVKzthIpBKsIJ6SfoMt48E1kZHGwfYBSQfy4EDRWqmGrCU9n09cj
         S/dKLSriVUifTbtP3NZbXmnj8E9zN9VcCVTbWzGOE19wIAdMuT1LU6KkO/fwNzWBd7ks
         ixh84DhxYcSTYM7YqbP2+j2Y0Umdq/ugrjnFYH2k0ZDhTtgeA1O5L1w/eTFjcgVGHkzA
         hjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=1AzYsEusJnjbpCN63PRR5Bh2ap3ZWjGS2AO9QDNcbIM=;
        b=VTHoFQTY/D2rA0ZmMzcF9/iii81kHDT/vOr0lPPaJn1mO5HQ/VTalXD2uzBXVBQ1OE
         ADj/+Ud/OdbnLwIGvNPLW7hDSb/1TYvyaJ5/rEJF29qwYmfzQx7L2a4wLbZeRWho1MrB
         uwB62uyQtNmDVRHJJOd6IXdgB6unPTJG9AppicMU+4irWwb0ucVlwZ4JMdZkT6QQB1+O
         u7M26B3l+VCingDa3p0RWuznUMVJ24ngF22L5y1MAdaqqzYeFMAGVRmdpxDuil2JuhUl
         iEIWZkUl57yG7dWZ7S0PTs7CZGxMmqJZITxs9EfWskV7WgTZSlkG8Hbd6hqEuvfioAQM
         avkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SeKDQZYC;
       spf=pass (google.com: domain of kernel-hardening-return-13123-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13123-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SeKDQZYC;
       spf=pass (google.com: domain of kernel-hardening-return-13123-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13123-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 13:09:06 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Tycho Andersen <tycho@tycho.ws>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, jmorris@namei.org,
	Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180424200906.GC174675@gmail.com>
References: <20180424010321.14739-1-tycho@tycho.ws>
 <20180424045015.GA4281@sol.localdomain>
 <20180424143539.GB3125@cisco>
 <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
 <20180424145104.GC3125@cisco>
 <20180424195845.GB23575@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424195845.GB23575@mail.hallyn.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598659565737004192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 02:58:45PM -0500, Serge E. Hallyn wrote:
> Quoting Tycho Andersen (tycho@tycho.ws):
> > On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> > > Tycho Andersen wrote:
> > > > > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > > > > +		WARN(1, "big key algorithm changed?");
> > > 
> > > Please avoid using WARN() WARN_ON() etc.
> > > syzbot would catch it and panic() due to panic_on_warn == 1.
> > 
> > But it is really a programming bug in this case (and it seems better
> > than BUG()...). Isn't this exactly the sort of case we want to catch?
> > 
> > Tycho
> 
> Right - is there a url to some discussion about this?  Because not
> using WARN when WARN should be used, because it troubles a bot, seems
> the wrong solution.  If this *is* what's been agreed upon, then
> what is the new recommended thing to do here?
> 
> -serge

WARN() is for recoverable kernel bugs, which this is, so WARN() is correct here.
Fuzzers often find cases where WARN() is used on invalid user input or other
cases that are not kernel bugs, and then it has to be removed or replaced with
pr_warn().  But here it is appropriate.  Unfortunately a lot of developers still
seem confused; improving the comments in include/asm-generic/bug.h might help.

Eric
