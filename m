Return-Path: <kernel-hardening-return-13120-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrBOX8tGQ08+ngFI2bPE3AHJWfDgRlfsG4j2dJOTDNIah9NEp/XlPKejenfr6DAgpYDVOAP
ARC-Seal: i=1; a=rsa-sha256; t=1524599945; cv=none;
        d=google.com; s=arc-20160816;
        b=m6W5m78aX74YNxEExkuYV5MxlgEe4iXsQYm+UcO2DqR5gLuUsf3R6mqJgMcnIgCBmo
         yqlpoC/e5JgIn6OLE2MaJuwVKcwupPdg3yLp7xDRpvM+iYGVSmMttvIx/MDFkeTYj9Zs
         reTRfegGLimGmJSLv1Wp8bg48rMjzGdQSZivkdFvKVB3FLrFDSpAtqHOsp7/9qWlvJ4W
         PCk2g1MZfgAee9t/IKoQjGb9HmWsMSbIWwBVRfjJtf+E86gRjhJEhcC058SKBXMRz6He
         nHOcPlWujnBkaC59xtB3uTHDevgL9jq1U5Hv9gjHUUliGnhLBqxbO3DhOJTgtw5LA0gO
         mzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=uJZeyUQYJKd8j1WxyqIdFYHwl9Wm9igiU4wvaXJEMzY=;
        b=rF8K/BeU62K/BQAdyCjQgZhMpBtyoR0OLtmvvCAKsm4zTeWexEFs0SbBuRUYTB6L2l
         x/meZ+BqHDCowZPwgXjhMjBj/vdNFSVqiRae3XF4Vdag0rjslHc/jbo8dvOKQB57noHg
         CQ+S2NgU9yUzmqx4Gy2H13G1m1u7pvDLabl9ElA5fJQAUx0nGzDznhECwwmYdIlmsiNt
         J0IXGGW6z47l+9uV+We5N8UJMOxaVK9cjQzibxDgl9uzi7yrVOXS7rB0nPGfvXYuDMwL
         D4mjuyV3outw8UNfpLmF0cAOEn/g51/J0CPz/6q7vewqPbS7Mx2Q+1cLudTlrsyrcFs+
         7hWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13120-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13120-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13120-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13120-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 14:58:45 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, ebiggers3@gmail.com,
	dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, jmorris@namei.org,
	serge@hallyn.com, Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180424195845.GB23575@mail.hallyn.com>
References: <20180424010321.14739-1-tycho@tycho.ws>
 <20180424045015.GA4281@sol.localdomain>
 <20180424143539.GB3125@cisco>
 <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
 <20180424145104.GC3125@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424145104.GC3125@cisco>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598658912206954357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Tycho Andersen (tycho@tycho.ws):
> On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> > Tycho Andersen wrote:
> > > > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > > > +		WARN(1, "big key algorithm changed?");
> > 
> > Please avoid using WARN() WARN_ON() etc.
> > syzbot would catch it and panic() due to panic_on_warn == 1.
> 
> But it is really a programming bug in this case (and it seems better
> than BUG()...). Isn't this exactly the sort of case we want to catch?
> 
> Tycho

Right - is there a url to some discussion about this?  Because not
using WARN when WARN should be used, because it troubles a bot, seems
the wrong solution.  If this *is* what's been agreed upon, then
what is the new recommended thing to do here?

-serge
