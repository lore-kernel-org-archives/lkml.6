Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB17208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB17208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbeG0OXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:23:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59023 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbeG0OXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:23:17 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6RD0u1x051504;
        Fri, 27 Jul 2018 22:00:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Fri, 27 Jul 2018 22:00:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6RD0pul051471
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 27 Jul 2018 22:00:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: unregister_netdevice: waiting for DEV to become free
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <000000000000d71bf6056a34b628@google.com>
 <000000000000ed9844056a507832@google.com>
Cc:     syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <50d24879-7f38-f8c5-982f-b3fc5d3a9cc6@I-love.SAKURA.ne.jp>
Date:   Fri, 27 Jul 2018 22:00:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000ed9844056a507832@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since this bug is top crasher (124264 times in 98 days is almost "every minute").
I made a simplified C reproducer based on the C reproducer provided by syzbot.
It seems that setsockopt(SOL_IPV6, IPV6_XFRM_POLICY) is involved to this trouble.

----------------------------------------
#define _GNU_SOURCE
#include <sched.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

/*
  ip6tnl0: flags=128<NOARP>  mtu 1452
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/
#define IP_DEVNAME "ip6tnl0"

int main(int argc, char *argv[])
{
	struct sockaddr_in6 addr = { };
	int fd;
	if (unshare(CLONE_NEWNET))
		return 1;
	fd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_IP);
	if (system("ip link set dev " IP_DEVNAME " up"))
		return 2;
	setsockopt(fd, SOL_IPV6, IPV6_XFRM_POLICY, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377\377\377\377\377\377\377\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\254\24\24\252\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0+\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\7\0\0\0\r5M&", 0xe8);
	addr.sin6_family = AF_INET6;
	inet_pton(AF_INET6, "fe80::bb", &addr.sin6_addr);
	addr.sin6_scope_id = 9;
	connect(fd, (struct sockaddr *) &addr, sizeof(addr));
	return 0;
}
----------------------------------------

