Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525851361; cv=none;
        d=google.com; s=arc-20160816;
        b=mwuKJZXIV7aHWTE5JjnM5YiTOl8DM/8G8scpL3sNPlbPZuMFvdBUbIPxt/goZojwU8
         Tki5D8QMiV9eQJ6z3pGPDt6jIftADTLwSFpeQTvdHSvVK0qhiIvCTfIX7iJJqVPDtOOR
         Ot41KVu5I6Z1D2zQ9WZUx6Q9Ho4H/v51n47gtQdnZQXN0zizUpM1eAnlL1fKWDsAob4d
         JEUCgCaTGSz5uAGFGBjnZvRKUUbudyyHQ7SuxN3SlRTZcyjnM8JdwrSxMz8QR0eKz+EF
         T4b41kXX+94nsWXPSBMdsEHOwVmOygcvR2WoSklt7CTekN4Ym0y1JAUqVNha7+sCK5/D
         2igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=J6ZFtrEgtk/aaUaPrdt1hCQtgGzR6HolDuq680c8N40=;
        b=y9a+qkJ6lrMt0NxX70dmCvLzeBnXSoM8XeChVbnKeBctIbydljk7N/3oDF8P3GnEph
         VwLuHzbjlEK8ZrtZUugXBc18QG4BeMHnUTIBOo6q+JYNsE1onkoEbfP9SjhlZT4Kzp25
         y4e64sMfqo+D0s70Zux+iaS99dNrR0n8vId+6qVTcKfYMLCp7AWXmBUMv4NR5heDYZ4m
         gR+T8nw4kmpan1iUAPsCXPWUDYzPv6hSjig+3l7vuzr79Xop5XjUSwD4dZawGfK7/iOY
         kUe4GxVliiNPRyRufyX08sanur3r0RMnBFqRDogSjRF9stwdbF969SlINT61UtcE9MAZ
         XgZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EQ47f0F3;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EQ47f0F3;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrC7qPPP2H+4BNg1yJjZIuDBXSKP1/ld3r8ecpN9lHtmq5CIdAylzBdvG6PpgawtLZefO2yug==
Date: Wed, 9 May 2018 00:37:54 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
	alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
	Anoob Soman <anoob.soman@citrix.com>, chris@chris-wilson.co.uk,
	David Miller <davem@davemloft.net>, elena.reshetova@intel.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mike Maloney <maloney@google.com>, mchehab@kernel.org,
	netdev <netdev@vger.kernel.org>, rami.rosen@intel.com,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	syzkaller-bugs@googlegroups.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
Message-ID: <20180509073754.GG711@sol.localdomain>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com>
 <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1515048794.131759.4.camel@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1599971116734668365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 03, 2018 at 10:53:14PM -0800, Eric Dumazet wrote:
> On Wed, 2018-01-03 at 21:13 -0800, Eric Dumazet wrote:
> > Note: all commands must start from beginning of the line in the email body.
> > 
> > I guess skb_probe_transport_header() should be hardened to reject malicious
> > packets given by user space, instead of being gentle.
> 
> Although bug triggered for this particular repro is in flow dissector
> :/
> 
> I will test :
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 15ce300637650e17fcab7e378b20fe7972686d46..544bddf08e13c7f6e47aadc737244c9ba5af56b2 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -976,8 +976,8 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>  out_good:
>         ret = true;
>  
> -       key_control->thoff = (u16)nhoff;
>  out:
> +       key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
>         key_basic->n_proto = proto;
>         key_basic->ip_proto = ip_proto;
>  
> @@ -985,7 +985,6 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>  
>  out_bad:
>         ret = false;
> -       key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
>         goto out;
>  }
>  EXPORT_SYMBOL(__skb_flow_dissect);

Fix for this was commit d0c081b49137cd:

#syz fix: flow_dissector: properly cap thoff field

But a crash with the same signature is still occurring, so it should eventually
get reported again.  C reproducer is here, it works on Linus' tree (commit
036db8bd963): https://syzkaller.appspot.com/text?tag=ReproC&x=105b1ae7800000

- Eric
