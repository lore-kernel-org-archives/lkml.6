Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBJq1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:46:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44175 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:46:24 -0400
X-Google-Smtp-Source: AB8JxZpF3BJec12zyOwpqCRaejH8YWHGA5VfwERpM8gcgjIJSAzVr2a711cVM7hIkeFJNsDlHmJ46bdYYD8G4XNwPDQ=
MIME-Version: 1.0
In-Reply-To: <20180502090639.j55mnclmkzdts6xb@unicorn.suse.cz>
References: <20180502090639.j55mnclmkzdts6xb@unicorn.suse.cz>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 2 May 2018 17:46:23 +0800
Message-ID: <CADvbK_fT5qYmOKHgBf6KWyuRcDUT3Fa8DyMQkN75C8PFkPKLXw@mail.gmail.com>
Subject: Re: non-blocking connect for kernel SCTP sockets
To: Michal Kubecek <mkubecek@suse.cz>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, Gang He <ghe@suse.com>,
        GuoQing Jiang <gqjiang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 5:06 PM, Michal Kubecek <mkubecek@suse.cz> wrote:
> Hello,
>
> while investigating a bug, we noticed that DLM tries to connect an SCTP
> socket in non-blocking mode using
>
>         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
>                                     O_NONBLOCK);
>
> which does not work. The reason is that inet_dgram_connect() cannot pass
> its flags argument to sctp_connect() so that __sctp_connect() which does
> the actual waiting resorts to checking sk->sk_socket->file->f_flags
> instead. As the socket used by DLM is a kernel socket with no associated
> file, it ends up blocking.
>
> TCP doesn't suffer from this problem as for TCP, the waiting is done in
> inet_stream_connect() which has the flags argument. I also checked other
> proto::connect handlers and sctp_connect() seems to be the only one with
> this kind of problem.
>
> This could be worked around in DLM and further experiments indicate
> current DLM code wouldn't actually handle the non-blocking connect
> properly. But I still feel ignoring the flags argument is rather a trap
> that should be fixed.
It is a bug, https://bugzilla.redhat.com/show_bug.cgi?id=1251530

We have the fix which also includes some cleanup, and needs to do
more testing.

>
> I have prepared a series adding flags argument to proto::connect and
> using it in sctp_connect() and __sctp_connect(). But I'm not sure if
> it's not too big hammer to address issue only affecting one handler.
> So my question is: would such generic approach be preferred or should we,
> rather make SCTP work the way TCP does, i.e. move the waiting from,
> proto::connect() to proto_ops::connect()? This would require introducing
> inet_seqpacket_connect() as inet_dgram_connect() is primarily intended
> for use with UDP.)
We don't fix it in the generic proto::connect, which will afftect
many other places.

We're replacing only sctp's proto_ops::connect with sctp_connect and
leave its proto::connect as NULL, so that it can get this flags param
without touching the generic struct and code.
