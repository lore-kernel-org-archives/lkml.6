Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEBJGo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:06:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:36019 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeEBJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:06:42 -0400
Date: Wed, 2 May 2018 11:06:39 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Cc: linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, Gang He <ghe@suse.com>,
        GuoQing Jiang <gqjiang@suse.com>
Subject: non-blocking connect for kernel SCTP sockets
Message-ID: <20180502090639.j55mnclmkzdts6xb@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while investigating a bug, we noticed that DLM tries to connect an SCTP
socket in non-blocking mode using

	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
				    O_NONBLOCK);

which does not work. The reason is that inet_dgram_connect() cannot pass
its flags argument to sctp_connect() so that __sctp_connect() which does
the actual waiting resorts to checking sk->sk_socket->file->f_flags
instead. As the socket used by DLM is a kernel socket with no associated
file, it ends up blocking.

TCP doesn't suffer from this problem as for TCP, the waiting is done in
inet_stream_connect() which has the flags argument. I also checked other
proto::connect handlers and sctp_connect() seems to be the only one with
this kind of problem.

This could be worked around in DLM and further experiments indicate
current DLM code wouldn't actually handle the non-blocking connect
properly. But I still feel ignoring the flags argument is rather a trap
that should be fixed.

I have prepared a series adding flags argument to proto::connect and
using it in sctp_connect() and __sctp_connect(). But I'm not sure if
it's not too big hammer to address issue only affecting one handler.
So my question is: would such generic approach be preferred or should we
rather make SCTP work the way TCP does, i.e. move the waiting from
proto::connect() to proto_ops::connect()? This would require introducing
inet_seqpacket_connect() as inet_dgram_connect() is primarily intended
for use with UDP.)

Michal Kubecek
