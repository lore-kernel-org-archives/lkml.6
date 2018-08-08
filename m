Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13747C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C4921767
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYDiH9o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4921767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeHHQ2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:28:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33379 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHHQ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:28:54 -0400
Received: by mail-qk0-f193.google.com with SMTP id 27-v6so1605703qkv.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBrvTr0oqkFhC+9hZyuBbLUuZmwZFVKua5Zc+iy7W68=;
        b=XYDiH9o8/x3TTeob/X/8pR8Bz2MOCWMhaiEVkY1kCmsGShsA2dCgThUrtp20+TEUvv
         dot7fofD6eJpS+vQqxmt6nOuHRxmxwXpWOTiGsHLdPpegxCzRrJLC/euz0VBHLvCtsUD
         3qKQDe9uNdiZO0NBcAa13beqtc9mm98L5q8pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBrvTr0oqkFhC+9hZyuBbLUuZmwZFVKua5Zc+iy7W68=;
        b=DyD/nfibRPnp5xUQfCnuxyByFxCluAVCG+kOpcG0Z7RERV7t1NEhJNOB2kKhRkJmwc
         ylQljdu0F4doNvFtfQ1BneVvWKJGU+14Vko+jh9CZ8PkpJv3q5ehe2KYHIYGXI1le1ll
         rrFyHffUGJ22jB0DkNUwPkdGNkxSi0AXRtazuNZvnioVrA2revDXx9xPB8WhrgjMEQq7
         wxRVpKrkjm6de34zxX5GzS2ErF++IYMfmRZej5YrS0y0a4aL7StkhCTHkkey0HioRrge
         XX5RvjnFbxA/Eb2pynPdIDMKysmOCHd0LcopmdOOXxcn7ix7qA8ZIcVlXw34DXgbxzVu
         VqyQ==
X-Gm-Message-State: AOUpUlEty3KD1W2EwWU8q+m7p1Senpe6VfIgkb3auT1btGSB84uXQdcZ
        pstgnDBnO2qcx8WEf71ibhQ0CDos6G4=
X-Google-Smtp-Source: AA+uWPwHfFPqxRDOOCnlnj8qwmgmxbZHbxcFnoU3zhHOXHSkc9i+N3NcJNUflfSN9MGsxeKlOYp6ag==
X-Received: by 2002:a37:c542:: with SMTP id p63-v6mr2637248qki.242.1533737343482;
        Wed, 08 Aug 2018 07:09:03 -0700 (PDT)
Received: from localhost ([138.204.25.2])
        by smtp.gmail.com with ESMTPSA id r4-v6sm2039433qtm.10.2018.08.08.07.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 07:09:02 -0700 (PDT)
Date:   Wed, 8 Aug 2018 11:09:00 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH] selftests: membarrier: fix test by checking supported
 commands
Message-ID: <20180808140900.mureac7fptuoaba6@mobile.celeiro.br>
References: <20180730160543.19056-1-rafael.tinoco@linaro.org>
 <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
 <20180731031537.bs64cdcxfqgmjwp4@mobile.celeiro.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731031537.bs64cdcxfqgmjwp4@mobile.celeiro.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:15:37AM -0300, Rafael David Tinoco wrote:
> Hello Shuah,
> 
> On Mon, Jul 30, 2018 at 05:32:30PM -0600, Shuah Khan wrote:
> > Hi Rafael,
> >
> > On 07/30/2018 10:05 AM, Rafael David Tinoco wrote:
> > > Makes membarrier_test compatible with older kernels (LTS) by checking if
> > > the membarrier features exist before running the tests.
> > >
> > > Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> > > Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> > > Cc: <stable@vger.kernel.org> #v4.17
> > > ---
> > >  .../selftests/membarrier/membarrier_test.c    | 69 +++++++++++--------
> > >  1 file changed, 41 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
> > > index 6793f8ecc8e7..b96caa096e2f 100644
> > > --- a/tools/testing/selftests/membarrier/membarrier_test.c
> > > +++ b/tools/testing/selftests/membarrier/membarrier_test.c
> > > @@ -225,7 +225,14 @@ static int test_membarrier_global_expedited_success(void)
> > >
> > >  static int test_membarrier(void)
> > >  {
> > > -	int status;
> > > +	int supported, status;
> > > +
> > > +	supported = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> > > +	if (supported < 0) {
> > > +		ksft_test_result_fail(
> > > +			"sys_membarrier() failed to query supported cmds\n");
> > > +		return supported;
> > > +	}
> > >
> >
> > ksft_exit_skip() is the right interface to use here. If feature isn't supported,
> > it should exit skip as opposed fail.
> >
> 
> Not sure this is the case here. This part was just a positional change.
> 
> This check is extending an existing logic (for MEMBARRIER_CMD_PRIVATE_
> EXPEDITED_SYNC_CORE tests). Calling membarrier with MEMBARRIER_CMD_QUERY
> will return us MEMBARRIER_CMD_BITMASK, telling us which features are
> enabled for the running kernel (thus which tests can be executed).
> 
> The query command was added in v4.3 and should (could ?) be considered a
> fundament for a working test by now, I suppose, no ?
> 
> It is used to decide which further tests to run. Not receiving anything
> back from this call would mean something is broken (since at least
> MEMBARRIER_CMD_GLOBAL should have always existed as a membarrier
> feature/command).
> 
> I think your concern is addressed in the beginning of the test.
> test_membarrier_query() tests for ENOSYS and calls ksft_exit_skip() if
> CONFIG_MEMBARRIER is disabled.
> 
> This part is not about checking if the test can run, but which one can.
> What do you think ? Tks for reviewing!

Shuah,

Never mind, I'll remove the 2nd MEMBARRIER_CMD_QUERY call, and cache the
first call results into a global status. This way, the function
test_membarrier_query() will test for availability, and initial issues
(like not having MEMBARRIER_CMD_GLOBAL), and skip or return error
approprietly like you said. No need to call it twice, just use cached
status. Tks for the review.

I'll send a v2.

Thank you
