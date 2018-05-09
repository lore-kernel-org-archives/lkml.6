Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525883932; cv=none;
        d=google.com; s=arc-20160816;
        b=wVHd64+sVBgSaBQokfYSKyDss4VAMeFBr7aU6h61HEBcj5CBi3tfAtIA6a/7fhWd91
         h3rgHCwEK5sNiyHTfpW3VzazTQUIs0DD4EegLQ8Gh9MtBuAaaGJ8BGxyml/o4o0UMn5z
         mtbjc/EKOJY9kBRdzDSSjKryGqA1m4p8DxyPpVuIejZt1SOf7dK+eouDgqa20FCK4Wsk
         Rw4n6rt9BWyrcsQqKT5+LYxU2pp3DbW7DYJIw5bzogQr+zry+atv/dV+6Ug3ngYspwug
         KaQPbtEL4bzTmgTYa71YEkgrpvqlv6Trwwmn1krriNhL1MNTJ8apo8ZVxBIzF3FTDyKO
         PpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tO5P7y86BJh38jpRObhI43FZGnb8CIk4+iCCW2JGYSo=;
        b=EO85LApkyEBckCv0/QMUpzuNIUDq4EJGz2dyZCM2pO3yqaddibH6cLTkmhWLAQxX1V
         N7Gx9NPJbxsHUeDCJcH7xHdS/h9+Iwfooyjl5XDWolMbR+c9p7S3mXX4YBNuCny9Va7G
         U8w5mud/Q4MyT9/OC33beB+XMq6gVQoy7Hye3Cuh+mFpFeyhQRwBGd+ZzkQ4igBOWKd4
         r1d7hHMUMzSlfmCCxhdPkgfdVN2+fQ/pFl4KYWZ6HppDDJL7IN4X8aoD3dHxSPeah6cf
         nAIu0AUImcEDZtuK/Uw8mEr5gmFF1NpX/rJvGALQa0MH8B3Bn/Y1E4nBMSONxRkTE2Dk
         TQyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s3hyPm/7;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s3hyPm/7;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpAzw+tlbmB0xUGzpyUJVKRm70MeOOBov8nQ8s03JN2c7skVT9Q0pM5CRM81p56p+En5zUuwm7cx0tFK6Lj3D0=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com> <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com> <20180509073754.GG711@sol.localdomain> <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 9 May 2018 12:38:11 -0400
Message-ID: <CAF=yD-KGO=+=j3yTr4H8cF_WH3RGtnyMDgYRzd7da-r7D=U=GQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
	alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
	Anoob Soman <anoob.soman@citrix.com>, chris@chris-wilson.co.uk,
	David Miller <davem@davemloft.net>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, Mike Maloney <maloney@google.com>, mchehab@kernel.org,
	netdev <netdev@vger.kernel.org>, "Rosen, Rami" <rami.rosen@intel.com>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, syzkaller-bugs@googlegroups.com,
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1600005271034823393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> But a crash with the same signature is still occurring, so it should eventually
>> get reported again.  C reproducer is here, it works on Linus' tree (commit
>> 036db8bd963): https://syzkaller.appspot.com/text?tag=ReproC&x=105b1ae7800000
>
> This appears to be a separate issue.
>
> This reproducer requires a setsockopt SOL_SOCKET/SO_TIMESTAMPING
> to trigger the use-after-free. And the freed path also points at a timestamping
> skb:
>
> [   31.963619] Freed by task 2672:
> [   31.964006]  __kasan_slab_free+0x125/0x170
> [   31.964509]  kfree+0x8b/0x1a0
> [   31.964875]  skb_free_head+0x6f/0xa0
> [   31.965314]  skb_release_data+0x420/0x5a0
> [   31.965802]  skb_release_all+0x46/0x60
> [   31.966260]  kfree_skb+0x91/0x1c0
> [   31.966669]  __skb_complete_tx_timestamp+0x2e9/0x3d0
> [   31.967273]  __skb_tstamp_tx+0x3b3/0x620
> [   31.967774]  __dev_queue_xmit+0xed5/0x1a20
> [   31.968300]  packet_sendmsg+0x36fd/0x5400
> [   31.968821]  sock_sendmsg+0xc0/0x100
> [   31.969284]  ___sys_sendmsg+0x367/0x880
> [   31.969777]  __sys_sendmmsg+0x178/0x410
> [   31.970267]  __x64_sys_sendmmsg+0x99/0x100
> [   31.970789]  do_syscall_64+0x9a/0x2c0
> [   31.971260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is a rare path taken when the timestamp skb cannot be queued
onto the socket (likely because of insufficient rcvbuf).

Somehow, freeing the timestamp skb triggers this use-after-free in
the original skb from which the timestamp was cloned. As if there
is a bug in the shared info dataref.

The report does occur on reading a shinfo field (gso_size).
