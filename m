Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB9BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05393242A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05393242A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGDHtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:49:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932290AbeGDHtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 397FD401DEA8;
        Wed,  4 Jul 2018 07:49:21 +0000 (UTC)
Received: from localhost (unknown [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD9BF111C4A2;
        Wed,  4 Jul 2018 07:49:19 +0000 (UTC)
Date:   Wed, 4 Jul 2018 09:49:18 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC][PATCH] selftest: timers: Tweak raw_skew to SKIP when
 ADJ_OFFSET is in progress
Message-ID: <20180704074918.GE22600@localhost>
References: <1530646587-12101-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530646587-12101-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 07:49:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 04 Jul 2018 07:49:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mlichvar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:36:27PM -0700, John Stultz wrote:
> In the past we've warned when ADJ_OFFSET was in progress, usually
> caused by ntpd or some other time adjusting daemon running in non
> steady sate, which can cause the skew calculations to be incorrect

Good idea.

> Thus, this patch sets a flag which we check when we fail so that
> we don't cause false negatives.

I'd suggest to check few more things to better detect when something
is adjusting the clock. The offset should be zero also at the end of
the test and the frequency and tick should be the same as at the
beginning of the test. This will detect daemons that set the frequency
of the clock directly, not using adjtime() or the PLL.

Something like this:

@@ -137,9 +135,10 @@ int main(int argv, char **argc)
        printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
 
        if (llabs(eppm - ppm) > 1000) {
-               if (adj_offset_bad) {
+               if (tx1.offset || tx2.offset ||
+                   tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
                        printf("        [SKIP]\n");
-                       return ksft_exit_skip("ADJ_OFFSET in progress. Shutdown NTPd or other time steering daemons\n");
+                       return ksft_exit_skip("The clock was adjusted. Shutdown ntpd or other time steering daemons\n");
                }
                printf("        [FAILED]\n");
                return ksft_exit_fail();


-- 
Miroslav Lichvar
