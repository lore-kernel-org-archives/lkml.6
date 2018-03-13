Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELuDpgjeHzHiRmwMwo7RjdCIZVItIZpVMUpQ5skgfDPwoPDHsoG0joo2jk5T1l0mVIiihTAd
ARC-Seal: i=1; a=rsa-sha256; t=1520952677; cv=none;
        d=google.com; s=arc-20160816;
        b=j8Ix/1ydn/MKhZLHpCRIxiRo764rBVuHf5pmolSN+1bcvvCoqePWRX2CUjCLNPwTRG
         n+0CP64MeuBsCyixJZpWAPuMrGXHjnzQXeUP88Ux0HSWAaSixhTaWugZE02B7F0L+0xq
         HNUZFXvArLYEQejkBLKKyYbDFEnZJ6BSHk12xm/QGKxrDqCGuYS82w+3eXPmL6yww7Mn
         SEaTRk8fqNuCnmMqvMKzzEo6K3t+UqlIWeGmnciozgTHAez5aherSo/S7eBwieh1xgJK
         +gSjpMlCRECp1u7cSRHvYrwE4R3VHyPck+ysq4Yg1oU6irrI4asEhff2rSNwXYAIiU5p
         Y7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=FPup2pmCZOvIibavdWFJqsWM53YUd1TPi+QGGl7aLko=;
        b=udimHb/UEVBf9XIgkX3W3R1lWstYkTm3F3ktJwBAeUkCyIbpcCjfxLrW7ZINxPLc2B
         kZDJQkRczGMwlkZg9vktdHC3FmhKTyjlysJyXoqwj3Vopah05343+w1ZwM5i/+uPb9Mw
         pRjlsqekBDNRXbSI/HJ8/cIbfYcS8tFr0oYD5NTR5X4s228d5uZs/GIjb8ESAVhRC0wX
         LfciLF5zxwVqCxVmDMA2xA6fNmaRZVlj3CuxU6d4f5SNFrIx/Ln+/BX+Fffz2N7/qeM0
         92D87OwBiwIBAuy4neUX0+ICG56YutVKUgiirNyfi3YjXOLGSFgUQzk86fgWAidlsDQC
         1GNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Tue, 13 Mar 2018 10:51:15 -0400 (EDT)
Message-Id: <20180313.105115.682846171057663636.davem@davemloft.net>
To: jelsasser@appneta.com
Cc: gregkh@linuxfoundation.org, edumazet@google.com, willemb@google.com,
 glider@google.com, xiyou.wangcong@gmail.com, vyasevich@gmail.com,
 mkubecek@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: check before dereferencing netdev_ops
 during busy poll
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180313053248.13654-2-jelsasser@appneta.com>
References: <20180313053248.13654-1-jelsasser@appneta.com>
	<20180313053248.13654-2-jelsasser@appneta.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594799470799291475?=
X-GMAIL-MSGID: =?utf-8?q?1594834475544813079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josh Elsasser <jelsasser@appneta.com>
Date: Mon, 12 Mar 2018 22:32:00 -0700

> init_dummy_netdev() leaves its netdev_ops pointer zeroed. This leads
> to a NULL pointer dereference when sk_busy_loop fires against an iwlwifi
> wireless adapter and checks napi->dev->netdev_ops->ndo_busy_poll.
> 
> Avoid this by ensuring napi->dev->netdev_ops is valid before following
> the pointer, avoiding the following panic when busy polling on a dummy
> netdev:
 ...
> Commit 79e7fff47b7b ("net: remove support for per driver ndo_busy_poll()")
> indirectly fixed this upstream in linux-4.11 by removing the offending
> pointer usage. No other users of napi->dev touch its netdev_ops.
> 
> Fixes: 060212928670 ("net: add low latency socket poll")
> Fixes: ce6aea93f751 ("net: network drivers no longer need to implement ndo_busy_poll()") - 4.9.y
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>

Ok, queued up for -stable, thanks.
