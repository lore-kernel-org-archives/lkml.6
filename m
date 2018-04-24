Return-Path: <kernel-hardening-return-13113-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+gwH5SVMo2EwyMIZbFc49BSRyfzoR19NhMXg8MHX/WkNjl60Q9bQ9f97IYmdnGqOA2O2Le
ARC-Seal: i=1; a=rsa-sha256; t=1524581235; cv=none;
        d=google.com; s=arc-20160816;
        b=d4XuwbC4dLNLyfamTvJHuYNFuuTmToQ7Fqtma76xe6ShT1bMZYt6QuC/Er8AbS7h7l
         n40HK2NvFSy8jepBmOYcVvmr8w8csv5m3oO0md30LhgidTN3k8Xue9lZFDdnaRlQ1X1w
         Ei9trm5faDmpBtRcPSm0PG+N8QMCkqDu54v8GfR0e/ttRbSlMvxnrQ3g8L5HtAXLNIJS
         tN+N3OUiFGNk2RgwJkAQoCBgHTz/CR4O2tdnfsQkXzCXOmToQMiOGWbMPbP3R+MshVCf
         ZkHkvThWAKVSaYFWC+tcWzN6uyxKga6qqR0Dhy6Zb6vYJJ+aX/ytxG1Z6aQZ0z7QyIFM
         pwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:message-id:in-reply-to:references:from:subject:cc
         :to:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=s7LA3ztr0rni7rujFX5JK6hqvHfs3+AgILYSd2ifIw4=;
        b=ahsLoAYzzNY4hB0x9HmGsaRNtOw37tUIggeznb3NtbkeJ47D40fNwSKr6CjHMfdv+d
         JqOWBCNRNIo8ZcjTUQNvr7fWsgXHAY8LzT/+5yLQMmhaUc9FEX5prBY2oy+QHXs9RujN
         ZH3/AxtoLPttDw9gPNGFuOKVZQhT1pph49jEdB2x5OqlqMIhnZ2ucpXrq/bIycyrv+zW
         w8Jo3oOp0pwzzP7G7aN0ByvU5nDl3lo3rVSCGpnSWT6a7fttw3VmN5QfqH46vA7egBfj
         YaOu+asblcjoM4rJaCt+3Ywb6YEiukTIFr+E8dpk7/QTWjvWg5kNSSj2h3ZIbmHgUIAD
         WDcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13113-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13113-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13113-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13113-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: tycho@tycho.ws, ebiggers3@gmail.com
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, jmorris@namei.org,
        serge@hallyn.com, Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180424010321.14739-1-tycho@tycho.ws>
	<20180424045015.GA4281@sol.localdomain>
	<20180424143539.GB3125@cisco>
In-Reply-To: <20180424143539.GB3125@cisco>
Message-Id: <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 24 Apr 2018 23:46:38 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598639294022014214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tycho Andersen wrote:
> > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > +		WARN(1, "big key algorithm changed?");

Please avoid using WARN() WARN_ON() etc.
syzbot would catch it and panic() due to panic_on_warn == 1.
