Return-Path: <xiyou.wangcong@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520896664; cv=none;
        d=google.com; s=arc-20160816;
        b=I3BiXZOxuuGqCByYo63eTHx2NskszdOKg8I+w+56MuwuQRXV2m5c9aNZ1BmCRNIc4h
         JolbyHpFTeBzIULotTl7szfFUmfBf5Q6k3e82doZxsrkRIShS/fovzTajqIPV2k6W4O7
         x2w3zLrT3pB7v0aeuyZA3X93aVXQcQjiVNTMVAY42DsvJywF44yK+/opc/8E2J7wHx52
         EOJ3QQoB+US3vCSj7AT70kTr47LrLVFeKyKlUopOWN4khpxxQxP6gpVj3woWr/DqR71y
         uCCy0oxr6UXiiX15qvq3gpCebQxdO4T5Mq83QBGpdFIpIgY/P/R9v2lCuxibwyYh/a+3
         bCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=45e5R7C3a2tIDGO+4RIgEQqhsu25yyGeA14liGwEY+w=;
        b=0hcjaLgc0QP6Bj0RRNKMe2GZfTf3TdDxZ/5HlFJJWLmQ7chJ6dKpVAsGSwlFVgMCXe
         JN41Ny3Up8dhUhOZYROFNZWMGPTXOnOwf0nEbpY/HGZhEQ7yVWI7T8QxK5JREmW1785c
         usT70fsNgIzitySuG8/2N4SvecMSoDEbv9nsmzGcCA4AA7Scub9VBBAB4NKCNdcDISQk
         KJwz0hB6PNeV8EqcbSiXQpPfslLaA+pC2dsGxt7XZKsHmT4p6HQsMU3vl5zFzn2Z/L1d
         s6/V5KSPyOCyLsQL2lCc3OUFXqiSHAPcVFem0aJu7qqaXkUIfpbvy/oU2eKLIHJeQXO3
         d8Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hFDza4Ut;
       spf=pass (google.com: domain of xiyou.wangcong@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xiyou.wangcong@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hFDza4Ut;
       spf=pass (google.com: domain of xiyou.wangcong@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xiyou.wangcong@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELviMGNRaksQsAhX2SEUB/o+9wlnQjcW6BGE0uRw+uKFLyqY5PsB7FbIrMrxEnDwEuUq1XDmIgazt2KzXFigU5U=
MIME-Version: 1.0
In-Reply-To: <20180311192322.101598-2-jelsasser@appneta.com>
References: <20180311192322.101598-1-jelsasser@appneta.com> <20180311192322.101598-2-jelsasser@appneta.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 12 Mar 2018 16:17:23 -0700
Message-ID: <CAM_iQpVWQ+4YKX=ZCCpJ3fzbexNVYJ8wONz9QnwuxBtbQwx3Lg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: check dev->reg_state before deref of napi netdev_ops
To: Josh Elsasser <jelsasser@appneta.com>
Cc: David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <alexander.levin@verizon.com>,
	Willem de Bruijn <willemb@google.com>, Alexander Potapenko <glider@google.com>,
	=?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594670494249773186?=
X-GMAIL-MSGID: =?utf-8?q?1594775741015254001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 12:22 PM, Josh Elsasser <jelsasser@appneta.com> wrote:
> init_dummy_netdev() leaves its netdev_ops pointer zeroed. This leads
> to a NULL pointer dereference when sk_busy_loop fires against an iwlwifi
> wireless adapter and checks napi->dev->netdev_ops->ndo_busy_poll.
>
> Avoid this by ensuring that napi->dev is not a dummy device before
> dereferencing napi dev's netdev_ops, preventing the following panic:

Hmm, how about just checking ->netdev_ops? Checking reg_state looks
odd, although works.
