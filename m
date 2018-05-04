Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEDXo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:44:58 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38198 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeEDXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:44:55 -0400
X-Google-Smtp-Source: AB8JxZoipnWzw6Rieh8qLBmdOc/x8J3K90ShFcsW5xQUpvmDjDbbSulVjIXsxJ2J8dKVjufMX21YlQ==
Subject: Re: [PATCH] net: disable UDP punt on sockets in RCV_SHUTDWON
To: Chintan Shah <chintsha@cisco.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org,
        kaber@trash.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kamensky@cisco.com, takondra@cisco.com, xe-linux-external@cisco.com,
        enkechen@cisco.com
References: <1525468117-61242-1-git-send-email-chintsha@cisco.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7ef94995-9c5b-4f53-e1e3-e12e74817e9f@gmail.com>
Date: Fri, 4 May 2018 16:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1525468117-61242-1-git-send-email-chintsha@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 02:08 PM, Chintan Shah wrote:
> A UDP application which opens multiple sockets with same local
> address/port combination (using SO_REUSEPORT/SO_REUSEADDR socket options);
> and issues connect to a remote socket (using one of these local socket).
> Now if the same socket, which issued connect, issues shutdown (SHUT_RD);
> packets would still be queued to this socket (if sent from same remote
> client, which the local socket connected to), and not delivered to the
> other socket in the normal state.
> 

Confusing changelog.

sk_shutdown is on a different cache line, so this additional fetch would cause
loss of performance if many sockets are scanned in the hash bucket.

If you are trying to add full 4-tuple hash table to UDP, and accept() ability,
this would require a bit more than this hack...
