Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8641DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B17E20833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B17E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeIMQqA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:46:00 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:36116 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbeIMQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:46:00 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 12:45:59 EDT
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 429xK10gFMzMkw5;
        Thu, 13 Sep 2018 13:30:13 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     netdev@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Thu, 13 Sep 2018 13:30:12 +0200
Message-ID: <5781211.jtEvgqSZyO@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks to the fix from Steffen Klassert I could now run 4.14.69 + his patch 
and 4.18.7 + his patch without oopsing immediately.

But I found that those kernels perform very bad. They perform so bad that they 
are unusable for our router with about 3000 ipsec tunnels (tunnel mode network 
<-> network).

With 4.9. (and all other kernels I used in the last 10 years with much less 
potent hardware) I never had an comparable performance issue with networking.

4.18.7 is better then 4.14.69 but still remains unusuable for us.

Even with very little traffic all 8 cores are working 100% in ksoftirqd. As 
soon as there is real traffic network gets rather unusuable.

Latency of packets goes from between 0.1ms to 1ms up to 100ms to 500ms (4.14) 
or between 15ms to 90ms (4.18).

Throughput also suffers a lot.

I have a simple test I run after every upgrade. This test basically copies 
with scp large files to 60 different remote locations (involving ipsec), 
limited to 1GBit/s combined, and in paralled I ping from different networks 
over this router to machines in other networks of this router (no ipsec-
tunnels involved).

With 4.9 and earlier copying needs about 2 minutes and the pings all remain 
under 2ms roundtrip. 

With 4.14 copying these files needs more than one our. The roundtrip time of 
the ping is > 1 second.

With 4.18 this is much better, copying needs around 6 minutes and ping 
roundtrip is between 30ms and 180ms. But even that is much worse then 4.9.

I think this dramatic loss in performance is due to the removal of the flow 
cache. I propose to revert that for 4.14. I also propose to revert it for the 
next longterm kernel if no other solution is found bringing back 4.9 
performance (at least about the same order of magnitude).

Maybe it should generally be reverted until a solution to the problem exists.

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
