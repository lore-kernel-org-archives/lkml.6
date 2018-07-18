Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62F22075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifYLrFuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeGRBHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:07:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42348 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbeGRBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:07:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id f4-v6so1178287plb.9;
        Tue, 17 Jul 2018 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JrzGtihrXg9m/GzAN6ahdCyeBGwkiYP0OXywZlaL17Q=;
        b=ifYLrFuL8Mr445OiF5oeHZH9kr1XILTqZ+dTmx1qMHEkg0UwgPg2bfdeaneLyYlHTI
         D0Q8veQ2bf7hbrz+iu/nf3jZKUotorUAoVrV8cuYEzSa+P/mIDOfH8PWMA9OPKM1EE0Q
         PfOTInWwev4xxNA3VBJFjYWLShWMLBC94DoTTjSIiui8QFgzwy/+k0CjKnab5dt/4BWU
         zYb0zFidWLF7xLSCIABfZpTdfLz5rttIa6cmg8wyvjs82UeUQMhJPyRKN0TMn2Sje6+K
         dgwppg7uEAP8YF8R9XuSiLI3Bjfe82U3ymARMSnZk4RfMSRIlbPrLMM4aRSUyuDJ7oqU
         iGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JrzGtihrXg9m/GzAN6ahdCyeBGwkiYP0OXywZlaL17Q=;
        b=ILUtVrc6PTXyop+Ss/7c++Gc8sQgenCwjqtbli4Kc3DKinxqimSIaBwKI19IE63M6S
         bgiVcjC0HbkbTkYVYJTmICB3q0lHha2q991u/sMOBK4a7DhurCsGZDUHmL+4+eobYWml
         9YZ0wWTgH6e7KdxzJ0ty9bQd9aWCmonRkehc1hnw9GB5rAJybdPo55saa8wORVdX2x9D
         fdQ3TxVm0soxIsn6hdQ9ON3LwaBbW84xuZ2b59gBAOvw+l8Tz7du89ZpqARNGbHfPe+a
         GySo0fRr8x4BpljkOS4yP41/6W6+1503PJGMjpewUcwFOgZYmCAPVbmTNGtSaaLT+Ub+
         2knQ==
X-Gm-Message-State: AOUpUlHig7Ft+NN1yGKv0E7WbE66RdYIGFpQPK2iPuHLLcqbfR3Zw82v
        dbX1Ydy/25QOsWGfhfnznRU=
X-Google-Smtp-Source: AAOMgpekWhkAvIDAhbfBpS9hMkYP+rH4yoVcinYuZ6bo0JRTs+Tg06rG2QD/2WsMhVloUZDdYjGNSw==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr3613077plt.237.1531873948333;
        Tue, 17 Jul 2018 17:32:28 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.123.183])
        by smtp.gmail.com with ESMTPSA id d123-v6sm3500973pfa.22.2018.07.17.17.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:32:27 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [PATCH 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Wed, 18 Jul 2018 10:32:00 +1000
Message-Id: <20180718003203.28059-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on:

https://patchwork.kernel.org/patch/10516195/

Every time the TCP retransmission timer fires. It checks to see if 
there is a timeout before scheduling the next retransmit timer. The 
retransmit interval between each retransmission increases 
exponentially. The issue is that in order for the timeout to occur the
retransmit timer needs to fire again. If the user timeout check happens 
after the 9th retransmit for example. It needs to wait for the 10th 
retransmit timer to fire in order to evaluate whether a timeout has 
occurred or not. If the interval is large enough then the timeout will 
be inaccurate.

For example with a TCP_USER_TIMEOUT of 10 seconds without patch:

1st retransmit:

22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Sun Jul  1 22:25:34 EDT 2018

We can see that last retransmit took ~7 seconds. Which pushed the total 
timeout to ~15 seconds instead of the expected 10 seconds. This gets 
more inaccurate the larger the TCP_USER_TIMEOUT value. As the interval 
increases.

Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has 
expired. Or whether the rto interval needs to be recalculated. Use the 
original interval if user rto is not set. 

Test results with the patch is the expected 10 second timeout:

1st retransmit:

01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Mon Jul  2 01:38:09 EDT 2018

Jon Maxwell (3):
  tcp: convert icsk_user_timeout from jiffies to msecs
  tcp: Add tcp_retransmit_time() helper routine
  tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy

 net/ipv4/tcp.c       |  4 ++--
 net/ipv4/tcp_timer.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.13.6

