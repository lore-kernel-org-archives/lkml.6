Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B248FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BEA208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqHri2Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BEA208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeGaExq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:53:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34396 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeGaExp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:53:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so14480176qth.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7mDageIpgQHLgBzXSjwK8PtcrtBK8jCd2N6g2GVOSM=;
        b=GqHri2XdKPRqoW9FFL88LW0kmZFZKdtabvOa5I9pVFgIN40ycUG4bSYzMzXjotHDVh
         eRWwB0ymUnjuLfkUEo8k3PNN6apktlOXc8bwyhsRyGVT0oncPuH2axpLZ45gWKJWC3ey
         yzqwHpjpQLSs/1ybJjZAakGNA+qHdmpSdxEO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7mDageIpgQHLgBzXSjwK8PtcrtBK8jCd2N6g2GVOSM=;
        b=TDChf7mBFNaG/yR2mT1mWSLArAVoLmhNmFQzJDoJqbBgz3WxJx9Gg/eS4ppPonJS7n
         nUo0CGbg7Qk5m0KMwHmYOb05OjdXQP2N/0w/GL2Cox8N2JKJwfua85hxxKhxVHF5T8tp
         bIt++1rFHN27EpeYyuCd2qxfWYfJRJskfP6d2XIIef6ucQ9kfbbtS1IBHfwRoM68Kydn
         /4gwZ54pFgZpS2nBmeRQEYD3mpKBOu7DYRZAX5RsQBJUVIuKpavuT+f/i8FMTc3ErH2r
         ZM+fSk4CAWb05KNLX6RAjVle6SuG68RJvk9n6L9oPnmedYccs9BD6QVoyqEs07HxUgzL
         eGNw==
X-Gm-Message-State: AOUpUlHoj9yaXrnypz6a2mFaTfi7zf/rT0JPnc0wnnNCa0KWKMXc2vy4
        VkF3TL0pXhJb6l4AePMFDDP4WA==
X-Google-Smtp-Source: AAOMgpeS87uZY6m+PGxuj+MRUNhUaM+flNTOpJ+EtG4/ch/t44wHct8vpnc11VQto3Pc5A8oCVD+bA==
X-Received: by 2002:ac8:2a18:: with SMTP id k24-v6mr19056964qtk.219.1533006941096;
        Mon, 30 Jul 2018 20:15:41 -0700 (PDT)
Received: from localhost ([168.194.163.63])
        by smtp.gmail.com with ESMTPSA id a187-v6sm9000755qkd.47.2018.07.30.20.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 20:15:40 -0700 (PDT)
Date:   Tue, 31 Jul 2018 00:15:37 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH] selftests: membarrier: fix test by checking supported
 commands
Message-ID: <20180731031537.bs64cdcxfqgmjwp4@mobile.celeiro.br>
References: <20180730160543.19056-1-rafael.tinoco@linaro.org>
 <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shuah,

On Mon, Jul 30, 2018 at 05:32:30PM -0600, Shuah Khan wrote:
> Hi Rafael,
>
> On 07/30/2018 10:05 AM, Rafael David Tinoco wrote:
> > Makes membarrier_test compatible with older kernels (LTS) by checking if
> > the membarrier features exist before running the tests.
> >
> > Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> > Cc: <stable@vger.kernel.org> #v4.17
> > ---
> >  .../selftests/membarrier/membarrier_test.c    | 69 +++++++++++--------
> >  1 file changed, 41 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
> > index 6793f8ecc8e7..b96caa096e2f 100644
> > --- a/tools/testing/selftests/membarrier/membarrier_test.c
> > +++ b/tools/testing/selftests/membarrier/membarrier_test.c
> > @@ -225,7 +225,14 @@ static int test_membarrier_global_expedited_success(void)
> >
> >  static int test_membarrier(void)
> >  {
> > -	int status;
> > +	int supported, status;
> > +
> > +	supported = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> > +	if (supported < 0) {
> > +		ksft_test_result_fail(
> > +			"sys_membarrier() failed to query supported cmds\n");
> > +		return supported;
> > +	}
> >
>
> ksft_exit_skip() is the right interface to use here. If feature isn't supported,
> it should exit skip as opposed fail.
>

Not sure this is the case here. This part was just a positional change.

This check is extending an existing logic (for MEMBARRIER_CMD_PRIVATE_
EXPEDITED_SYNC_CORE tests). Calling membarrier with MEMBARRIER_CMD_QUERY
will return us MEMBARRIER_CMD_BITMASK, telling us which features are
enabled for the running kernel (thus which tests can be executed).

The query command was added in v4.3 and should (could ?) be considered a
fundament for a working test by now, I suppose, no ?

It is used to decide which further tests to run. Not receiving anything
back from this call would mean something is broken (since at least
MEMBARRIER_CMD_GLOBAL should have always existed as a membarrier
feature/command).

I think your concern is addressed in the beginning of the test.
test_membarrier_query() tests for ENOSYS and calls ksft_exit_skip() if
CONFIG_MEMBARRIER is disabled.

This part is not about checking if the test can run, but which one can.
What do you think ? Tks for reviewing!

-- Rafael D. Tinoco
