Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14467C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B062B21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DH645j2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B062B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeK3HDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:03:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44046 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK3HDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:03:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so3395784qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=el2/ekc41aWY1xfXpezXjS5XXMk7zVkzQG1LQP2kbJA=;
        b=DH645j2JRlqQv6JJNhdoWD1GEg1yDdrvmqo7eQJsF7DDNUnam6LM26ot4zyrAJqcJ5
         KYZbVP8jI3+27UrY8TVL3Fig0JnqWbc60FWZ6rAoMo8aZ8LQoyqBuod+nqaff/b9sQ70
         wz/AFBdKHAf84Qo1BWs+gcFfDSwp7hqNtPo+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=el2/ekc41aWY1xfXpezXjS5XXMk7zVkzQG1LQP2kbJA=;
        b=lmqnLjnfEWj8vkptWdB9aQNi6SSTggs/MWWSuIbrEVimD4ymsH160SBGmnjZUztLoc
         RKzNHJrxuQdOOpKnz27X5SZyi4EOCn+UKieWkO7WGdvvenzcjMGO8GTZ0VwtNewgLWpf
         3uA0U4+7Yo9pAdM+lhIWq+QY8SzlJJ8FoKqxO8Ooj/Vo/Hp458cG114weTCBK1N50hhc
         +z9ShKXiMw2g624VGKhCHQ6n1K4gEKBHGpjUzMdpMIXvGSo2yU0/y48PUXCkd29iwyS0
         SiksiWK9LNgiSg/OqNt8UUR2g97J87hZ2EtdwnBxworH+HlkCHAWJGrIzkATX/k+v9PP
         KmmQ==
X-Gm-Message-State: AA+aEWZgKoJyudlhWDYnK5XYf76j39cc01Jmszl9kXyGvv57/xNsEYoX
        SlQA746Bg8hGIpecsAwl28pe8A==
X-Google-Smtp-Source: AFSGD/WIMXXtqO1X3ou1osTz4Me9lXjlz5Pr+2r1Blv4CVBDePub8GmpltpPLRXopQv2UUdrklnByQ==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr2840270qvi.90.1543521430582;
        Thu, 29 Nov 2018 11:57:10 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id d50sm1787542qta.31.2018.11.29.11.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:57:09 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: timers: move PIE tests out of rtctest
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
 <20180419125030.5076-2-alexandre.belloni@bootlin.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <a304b6f1-11db-543b-2cb3-372f34dc7697@linaro.org>
Date:   Thu, 29 Nov 2018 17:57:05 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20180419125030.5076-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/18 9:50 AM, Alexandre Belloni wrote:
> Since commit 6610e0893b8bc ("RTC: Rework RTC code to use timerqueue for
> events"), PIE are completely handled using hrtimers, without actually using
> any underlying hardware RTC.
> 
> Move PIE testing out of rtctest. It still depends on the presence of an RTC
> (to access the device file) but doesn't depend on it actually working.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  tools/testing/selftests/timers/.gitignore |   1 +
>  tools/testing/selftests/timers/Makefile   |   2 +-
>  tools/testing/selftests/timers/rtcpie.c   | 132 ++++++++++++++++++++++
>  tools/testing/selftests/timers/rtctest.c  |  83 +-------------
>  4 files changed, 138 insertions(+), 80 deletions(-)
>  create mode 100644 tools/testing/selftests/timers/rtcpie.c
> 
...
> +	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
> +	for (tmp=2; tmp<=64; tmp*=2) {
> +
> +		retval = ioctl(fd, RTC_IRQP_SET, tmp);
> +		if (retval == -1) {
> +			/* not all RTCs can change their periodic IRQ rate */
> +			if (errno == EINVAL) {
> +				fprintf(stderr,
> +					"\n...Periodic IRQ rate is fixed\n");
> +				goto done;
> +			}
> +			perror("RTC_IRQP_SET ioctl");
> +			exit(errno);
> +		}

Hello Alexandre,

In our tests, having failures under 64Hz is quite common in embedded
systems with few number of CPUs/Cores:

--------
root@bug3402:opt$ find /sys -name rtc0
/sys/devices/platform/9010000.pl031/rtc/rtc0
/sys/class/rtc/rtc0

selftests: timers: rtcpie
Periodic IRQ rate is 1Hz.
Counting 20 interrupts at:
2Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:	
PIE delta error: 0.017697 should be close to 0.015625
not ok 1..9 selftests: timers: rtcpie [FAIL]
--------

Mainly because 64Hz gives us.. ~16ms in the test, and the variation
being taken in consideration for an error, for this test, is 10%, which
is ~1.6ms... pretty close to scheduler limit for lower number of CPUs in
a functional testing environment.

Would you mind if we change the default for up to 32Hz ? Or, do you have
any other suggestion ?

Best Rgds
Rafael

-- 
Rafael D. Tinoco
Linaro - Kernel Validation
