Return-Path: <kernel-hardening-return-12823-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49pUkSjchd/n/5oLhZXqLpugzmVfc7wExym24Q9f8HCkqHCzRcG/p9b9XY+mQIsQY6S93wX
ARC-Seal: i=1; a=rsa-sha256; t=1522333553; cv=none;
        d=google.com; s=arc-20160816;
        b=1HuMit0MCZDf8lvjQXGyPtlo1OxqeArN3M9oYXmtK6athVs4trRzmpSbKLm4gduBQr
         6+u5C/HuRGDDDEZuSlJmERXXiWAtDA46Z8OSemegEqAcXZMzUenyMm2Wso4winF7yxWg
         jPrGWs6CSE3WoGOZFExuVuMy0K2noeB93jhI9RV3jXkgzWWUNhZ9byzGfV0Vmd6toxuB
         4l+Hxf/sFEs1E4nvkDfTAQeJ9ul0uSfJsRPU+1uYp5xpQf1Ck2G1LgmSuOnwq/VUWoMu
         C4GIM8ULRppeO6iC5hAa34swslYdHSbxQ86TXjvU7Bca5RVWcf4xjkoxSXMZP36Gh84+
         ri4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2YiFcGSh56kIueVXE1OUKezUwQfERPxDTGafgmrD4sI=;
        b=VHL78Su+qv4x7iE00bh8FFkpfqBuNUqNLJ7fvp7DD3t94Q2NxITlnTY7jauSieWOJX
         HmWVo00ZCLXVSAKoQXMFaPX6N1Zm08MfvyEhSYGFsMEw1iqE6yj8+xzLl0OaToVciBfI
         D1YPrr1/zWVaytknymdzlQFNPIg6dJDW7ihrXg82dw1xJIOQ7BHTxJ062rx92IINQC2O
         PW20byKx+j1wiv1L4E8nNU+YpJrojom9qFfI+84Oa/WC5GkcGU1xpbxGVZgFtdIfXacR
         Oy+chaD+tvh2rDH7OXKavTycfrTa8y9x/MQlH44K+tLpjiQ1+g1+s+LWc6oLVa7eMGkP
         2kwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12823-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12823-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12823-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12823-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 29 Mar 2018 16:25:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCHv3] gpio: Remove VLA from gpiolib
Message-ID: <20180329142533.GA15478@wunner.de>
References: <20180328181809.24505-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328181809.24505-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206473991489239?=
X-GMAIL-MSGID: =?utf-8?q?1596282428140867884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:18:09AM -0700, Laura Abbott wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621) to eventually
> turn on -Wvla.
> 
> Using a kmalloc array is the easy way to fix this but kmalloc is still
> more expensive than stack allocation. Introduce a fast path with a
> fixed size stack array to cover most chip with gpios below some fixed
> amount. The slow path dynamically allocates an array to cover those
> chips with a large number of gpios.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Split out from the series since patches have been picked up
> independently. Fold in patch from Lukas Wunner to introduce slow/fast
> paths. I took his suggestions to go with 384 as the maximum number of
> gpios. Also fixed one 0-day bot issue where I forgot to change the
> return type.

I've just given this a whirl with gpio-hammer and it works nicely, so FWIW:

Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>

Thanks a lot for doing this Laura, and most of all thanks for the
proverbial "dogged persistence and patience"!
(https://lwn.net/Articles/697029/)

Lukas
