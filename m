Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEB3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DED7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DED7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeGSB4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:56:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbeGSB4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:56:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D89C881663CE;
        Thu, 19 Jul 2018 01:15:29 +0000 (UTC)
Received: from 192-168-1-101.tpgi.com.com (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C752026D69;
        Thu, 19 Jul 2018 01:15:25 +0000 (UTC)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH V4 net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Thu, 19 Jul 2018 11:14:41 +1000
Message-Id: <20180719011444.4694-1-jmaxwell37@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 01:15:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 01:15:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmaxwell37@gmail.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was becoming bigger based on feedback therefore I have
implemented a series of 3 commits instead in V4.

This series is a continuation based on V3 here and associated feedback:

https://patchwork.kernel.org/patch/10516195/

Suggestions by Neal Cardwell:

1) Fix up units mismatch regarding msec/jiffies.
2) Address possiblility of time_remaining being negative.
3) Add a helper routine tcp_clamp_rto_to_user_timeout() to do the rto
calculation.
4) Move start_ts logic into helper routine tcp_retrans_stamp() to
validate tcp_sk(sk)->retrans_stamp.
5) Some u32 declation and return refactoring.
6) Return 0 instead of false in tcp_retransmit_stamp(), it's not a bool.

Suggestions by David Laight:

1) Don't cache rto in tcp_clamp_rto_to_user_timeout().

Suggestions by Eric Dumazet:

1) Make u32 declartions consistent.
2) Use patch series for easier review.
3) Convert icsk->icsk_user_timeout to millisconds to avoid jiffie to
msec dance.
4) Use seperate titles for each commit in the series.
5) Fix fuzzy indentation and line wrap issues.
6) Make commit titles descriptive.

Changes:

1) Call tcp_clamp_rto_to_user_timeout(sk) as an argument to
inet_csk_reset_xmit_timer() to save on rto declaration.

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
  tcp: Add tcp_retransmit_stamp() helper routine
  tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy

 net/ipv4/tcp.c       |  4 ++--
 net/ipv4/tcp_timer.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.13.6

