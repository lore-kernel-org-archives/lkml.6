Return-Path: <kernel-hardening-return-13114-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrJfLJSrYABpjsAiMnq4ae4URYd9O9H+9DMYmBJvve0e9vpatz9xwr+yas9EzLpFYuy4NTw
ARC-Seal: i=1; a=rsa-sha256; t=1524581488; cv=none;
        d=google.com; s=arc-20160816;
        b=KrG4IaLAL28CJxKxDVBrbCfxOr2grCuR6Rk0/XAyVwHYqWyq/g99XOB4rfSkRl2nq2
         7PH2KRfU66n09M+Ne7ordeW869Vu3Ui1ZKx1M02HTiO+yXa1YXZOr9GhDMWDhtxT6tAz
         lz4J1AdNIm9t8ZmuPQUzSarhsyjx0Dvjac++u+Kbs6tZNg3aBCxrjUBqMz83yd0W7TBB
         Ex78amxtkb8Hr4NQI7W1HFFebPN8/Ojcbv7d8H8/Fykk6AJ6dumRFJIOZ7tS0geM1PXG
         4QH7RBWCjFnR++Zt+JH4935BrG0w7uE3WkRxvnKBl4Ke6JAAnnHNbVA2CRsvcVOEa37F
         HYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=kdL4JGFE3ryE5U1EgjLo8vjSQt2sKWgOGPYUOuv2aC4=;
        b=1DGcErRUVdVeBcWgqYVzaQ8vVzx2oxXwCcmvjUYyoZ1Bco51t4UJAYZzKLANBXxHln
         u6wpT8Dc9++WHSolrL5ck1/mcbyP/viWdijQ6CAoLeDqWZ8w0Ui+5QyOT5AtPc62TqzE
         2Frvw+NWsI/x8KdfjN89ntFo8RlEtti+/HQH8KTGprehU/gTyS8YOgmInVB53FG1p1ZJ
         iPvI0l7a/qi5uqmDjFl3adxifQbB7nk4ovJQkzI3Z2gC93FvhAnP17E1UXi3eMdfEP9D
         HzqxbCAy3phgg4fDUOSRdbUgRaORLKjoj4SkuixNuEabrLVgVsIu3sw5DmrAjBCJ+lHT
         zCGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=sZkFzkU4;
       spf=pass (google.com: domain of kernel-hardening-return-13114-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13114-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=sZkFzkU4;
       spf=pass (google.com: domain of kernel-hardening-return-13114-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13114-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 08:51:04 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, jmorris@namei.org,
	serge@hallyn.com, Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180424145104.GC3125@cisco>
References: <20180424010321.14739-1-tycho@tycho.ws>
 <20180424045015.GA4281@sol.localdomain>
 <20180424143539.GB3125@cisco>
 <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598639558459310812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> Tycho Andersen wrote:
> > > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > > +		WARN(1, "big key algorithm changed?");
> 
> Please avoid using WARN() WARN_ON() etc.
> syzbot would catch it and panic() due to panic_on_warn == 1.

But it is really a programming bug in this case (and it seems better
than BUG()...). Isn't this exactly the sort of case we want to catch?

Tycho
