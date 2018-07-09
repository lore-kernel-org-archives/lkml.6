Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393BCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CF720881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CF720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeGIJ03 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:26:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932366AbeGIJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DA4A40201A2;
        Mon,  9 Jul 2018 09:26:24 +0000 (UTC)
Received: from localhost (unknown [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9D92156889;
        Mon,  9 Jul 2018 09:26:22 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:26:21 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC][PATCH v2] selftest: timers: Tweak raw_skew to SKIP when
 ADJ_OFFSET/other clock adjustments are in progress
Message-ID: <20180709092621.GC1285@localhost>
References: <1530813031-19243-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530813031-19243-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 09:26:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 09:26:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mlichvar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:50:31AM -0700, John Stultz wrote:
> In the past we've warned when ADJ_OFFSET was in progress, usually
> caused by ntpd or some other time adjusting daemon running in non
> steady sate, which can cause the skew calculations to be incorrect
> 
> Thus, this patch sets a flag which we check if the clock was being
> adjusted when we fail so that we don't cause false negatives.

The commit message might need an update as the code no longer sets a
flag. Other than that, it looks good to me.

Thanks,

> --- a/tools/testing/selftests/timers/raw_skew.c
> +++ b/tools/testing/selftests/timers/raw_skew.c
> @@ -134,6 +134,11 @@ int main(int argv, char **argc)
>  	printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
>  
>  	if (llabs(eppm - ppm) > 1000) {
> +		if (tx1.offset || tx2.offset ||
> +		    tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
> +			printf("	[SKIP]\n");
> +			return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
> +		}
>  		printf("	[FAILED]\n");
>  		return ksft_exit_fail();
>  	}
> -- 
> 2.7.4
> 

-- 
Miroslav Lichvar
