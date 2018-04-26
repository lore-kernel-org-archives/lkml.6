Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757050AbeDZVRM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756518AbeDZVRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:17:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AFA21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AB8JxZocxN/3X9DXHLQCA1ho6lbCirZCO3cCZW2QyahMexVIT1/EMRi2vTTd0qFZ35tXYWyh9+y9nyCPz2YqNHUOHBI=
MIME-Version: 1.0
References: <20180425214307.159264-1-edumazet@google.com> <CACSApvZF8CJqcRx7FGkMGitBiC6m0=_FT9XRZ=VV07U62wGM3Q@mail.gmail.com>
 <a2c405e1-0ebc-dd33-fb0d-575bf06a1ff6@gmail.com>
In-Reply-To: <a2c405e1-0ebc-dd33-fb0d-575bf06a1ff6@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 26 Apr 2018 21:16:55 +0000
X-Gmail-Original-Message-ID: <CALCETrVBQD1tPUzc_t7HmoPfApTdFW+x-0DqL8+XHjrmEpYMXQ@mail.gmail.com>
Message-ID: <CALCETrVBQD1tPUzc_t7HmoPfApTdFW+x-0DqL8+XHjrmEpYMXQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/2] tcp: mmap: rework zerocopy receive
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of further muddying the waters, there's another minor tweak
that could improve performance on certain workloads.  Currently you mmap()
a range for a given socket and then getsockopt() to receive.  If you made
it so you could mmap() something once for any number of sockets (by
mmapping /dev/misc/tcp_zero_receive or whatever), then the performance of
the getsockopt() bit would be identical, but you could release the mapping
for many sockets at once with only a single flush.  For some use cases,
this could be a big win.

You could also add this later easily enough, too.
