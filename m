Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C2EC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE8C216F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE8C216F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeHNEcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:32:35 -0400
Received: from ozlabs.org ([203.11.71.1]:46843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeHNEce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:32:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qFph0gX5z9s78;
        Tue, 14 Aug 2018 11:47:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        alexander.kapshuk@gmail.com
Subject: Re: [PATCH 1/2] perf tools: Make check-headers.sh check based on kernel dir
In-Reply-To: <20180813111504.3568-1-jolsa@kernel.org>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com> <20180813111504.3568-1-jolsa@kernel.org>
Date:   Tue, 14 Aug 2018 11:47:39 +1000
Message-ID: <87mutplnwk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <jolsa@kernel.org> writes:
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index ea48aa6f8d19..9d466e853aec 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -88,6 +88,8 @@ check () {
>  # differences.
>  test -d ../../include || exit 0
>  
> +pushd ../.. > /dev/null
> +
>  # simple diff check
>  for i in $HEADERS; do
>    check $i -B

This breaks the build when sh is not bash:

  ./check-headers.sh: 91: ./check-headers.sh: pushd: not found
  ./check-headers.sh: 107: ./check-headers.sh: popd: not found
  Makefile.perf:205: recipe for target 'sub-make' failed

cheers
