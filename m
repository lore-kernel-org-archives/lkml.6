Return-Path: <jelsasser@appneta.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520918279; cv=none;
        d=google.com; s=arc-20160816;
        b=BmWkR/qt134JAwFrJU0vuXJjFFey6YYSSdQyCo+ArYkqRFl4wy/UBgQ597hAiPWU+/
         eOqAaz+tkZqqym9eV4nIbJA235nwtjNtz3X3fViA/OduRpIsmlq1c/SVXql2687XUk9b
         P95Ged7odw7DPu3RQDxROG8DgPc/54pLttarkgec8eAkC/KFkufNA9ydY2L3B+wlY0bC
         rhniF4dD+2zNA8eeRMRxapaXarQmcKPdSJVFaKI1xltpPI6sB2QJF6VyA4gDsDya7Zaz
         BsHoVJHodPw99jZdk9XW3sbtumuXTjiN19EkTcgZLGVru013zayzywhaZB4haxcEDA6P
         hOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0fU8BHKc6qdxM6D9uAz1kxmQRSyZl337IwCo36G8Fbw=;
        b=PYUQb6BEamCSLB4v0XaD4Uhs+9gAR3FEl1W7kZPYr1E8JCu3FnVZmOLU69FvEGoRaQ
         vjArIV6hYH8F3ZT9rM7cR/8tN/Fmqca9sRL/tY9NHvIuDX/zn3aZCjikWK5mzxPjjpMo
         ZqRJzuggLsJ4CU1ZsZl3MyCEnA5WTTRuP0Qr4TBlDOkOgQcMcbRHFLxpJ/psYQLuvZl8
         x29Qa0Oe9W0bhkXHh7nMXC/mOt8eYPrL+w7hA3H/iUVo3JIUBejAmzAuLp+YUfgWV98S
         G+ePsCV4xeFWrgIfaaLHW7++ocA7pZgyixmauHjOLtUqcnz89vIWB3G+jB/gTUMJpqZ2
         KsCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=dNVkN+l1;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=dNVkN+l1;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
X-Google-Smtp-Source: AG47ELstaUiJoDFXv4pSI8moimfH+k0cK3LT2MrcJljcfkUxeIs5QLCcejApfpCPwJYuVErAq1fL4gxIUITDlnjzrjQ=
MIME-Version: 1.0
In-Reply-To: <CAM_iQpVWQ+4YKX=ZCCpJ3fzbexNVYJ8wONz9QnwuxBtbQwx3Lg@mail.gmail.com>
References: <20180311192322.101598-1-jelsasser@appneta.com>
 <20180311192322.101598-2-jelsasser@appneta.com> <CAM_iQpVWQ+4YKX=ZCCpJ3fzbexNVYJ8wONz9QnwuxBtbQwx3Lg@mail.gmail.com>
From: Josh Elsasser <jelsasser@appneta.com>
Date: Mon, 12 Mar 2018 22:17:58 -0700
Message-ID: <CAFKWs58UYJzM+ei7HLUPWW1-78OaQ=faBs7tjSipYGgETcsrAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: check dev->reg_state before deref of napi netdev_ops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <alexander.levin@verizon.com>,
	Willem de Bruijn <willemb@google.com>, Alexander Potapenko <glider@google.com>,
	=?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594670494249773186?=
X-GMAIL-MSGID: =?utf-8?q?1594798405609442034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 4:17 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Sun, Mar 11, 2018 at 12:22 PM, Josh Elsasser <jelsasser@appneta.com> wrote:
>> init_dummy_netdev() leaves its netdev_ops pointer zeroed. This leads
>> to a NULL pointer dereference when sk_busy_loop fires against an iwlwifi
>> wireless adapter and checks napi->dev->netdev_ops->ndo_busy_poll.
>>
>> Avoid this by ensuring that napi->dev is not a dummy device before
>> dereferencing napi dev's netdev_ops, preventing the following panic:
>
> Hmm, how about just checking ->netdev_ops? Checking reg_state looks
> odd, although works.

Fair point. I was trying to differentiate between an unexpected
NULL pointer and a dummy netdev, but I guess it was clever
at the expense of readability.

I'll push up a v2 that just does the obvious.
