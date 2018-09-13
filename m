Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F8EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E57020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E57020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIMNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:50:25 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:48909 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbeIMNuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:50:24 -0400
Received: from [91.232.154.11] (helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <decoy@iki.fi>)
        id 1g0NCE-0007LU-Nf
        for linux-kernel@vger.kernel.org; Thu, 13 Sep 2018 11:41:54 +0300
Received: from decoy (helo=localhost)
        by lakka.kapsi.fi with local-esmtp (Exim 4.84_2)
        (envelope-from <decoy@iki.fi>)
        id 1g0NBu-0003w2-Jp
        for linux-kernel@vger.kernel.org; Thu, 13 Sep 2018 11:41:34 +0300
Date:   Thu, 13 Sep 2018 11:41:31 +0300 (EEST)
From:   Sampo Syreeni <decoy@iki.fi>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <alpine.DEB.2.11.1809131041000.11646@lakka.kapsi.fi>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-SA-Exim-Connect-IP: 91.232.154.11
X-SA-Exim-Mail-From: decoy@iki.fi
Subject: about timer API's/a possible development idea
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.kapsi.fi)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I'm new to the kernel, but I'd still like to ask a question. Can it 
sleep(3) or somesuch higher resolution version, *without* 
deterministically waking my process up? Are there API's which enable you 
to state to the scheduler: "I'd *like* to be woken up 100ms from here, 
*but* it's okay if you hold off for a minute for your own higher 
purposes"?

If there already is an interface which lets me communicate something 
like that to the scheduler, my point is moot; forget about everything 
I'm about to say.

However, if no such API exists, I'd like to argue why it would be 
useful. Perchance even necessary, and via incorporation into the Linux 
and then the Android kernel, something worthy of POSIX standardization.

My point is that quite a number of applications like phones' radios and 
even your common Intel microprocessors rely on being able to switch off 
or throttle back, intermittently, in order to conserve power and/or 
heat. That can only happen if those chips have nothing to do.

Scheduled wakeups make-do for the chips, and especially so if they 
happen at random intervals. That's the dearth of *my* phone's battery at 
least: constant wakeups from a ton of background apps.

While I don't know *what* those apps are doing for real, I suspect most 
of them are spinning in a while(1) {do-polling; do-advertising; 
sleep(arbitrary-time-constaant);} -kinda loop. So that in toto they end 
up waking up my kernel, and when online even my radio, pretty much all 
the time.

A rather simple means of stopping that sort of behavior would be to 
enable -- not just simple sleep -- but sleep with tolerance. Most of 
those problematic apps don't really need to be woken up *precisely* 
100ms from here, to poll something. They'd be just as well if they were 
woken up a second from now, or even a minute. Yet they might not be able 
to communicaate that to the scheduler right now.

If they could, the scheduler could suddenly batch up operations over 
multiple applications. It could not only wake up cores and do batch 
optimization over the processes woken, but it could also only wake up 
the costly-in-battery-and-latency radio transmitter of your mobile just 
when it has to. Say, in the polling interval of the many low power radio 
protocols which we nowadays have.

Again, I don't know pretty much anything about kernel development, or 
the extant low level API's Linux people have. But I do know something 
like this would be useful, and easy to interface towards any extant 
no-tick scheduler. *NIX-kernel-wise and POSIX-wise even it would be 
rather a simple exercise to just overload any blocking calls which carry 
a deadline with a second call, taking two arguments instead of one. The 
second one being the actual deadline, and the first one being what we 
now experience under POSIX rules. Between those two, the scheduler would 
have much more latitude for optimization.

Such calls could be aliased back from sleep(x,y) to just the current 
sleep(x) without loss of functionality. The second time argument could 
be treated as a hint, even formally, with no loss of functionality. 
However when implemented, that hint could yield real efficiency gains in 
heat expenditure, battery life, and maybe even processing latency, since 
it *does* constitute a kind of implicit barrier device.

Please tell me someone implemented something like that already, and it's 
on its way to standardization? If not, please tell me some of you are 
interested in the idea.
-- 
Sampo Syreeni, aka decoy - decoy@iki.fi, http://decoy.iki.fi/front
+358-40-3255353, 025E D175 ABE5 027C 9494 EEB0 E090 8BA9 0509 85C2
