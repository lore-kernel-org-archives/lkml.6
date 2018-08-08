Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEDC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8A3216EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8A3216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHFzH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:55:07 -0400
Received: from ozlabs.org ([203.11.71.1]:58043 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeHHFzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:55:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lcXF1vZ7z9s4c;
        Wed,  8 Aug 2018 13:37:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   mpe@ellerman.id.au
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390 auxiliary trace
In-Reply-To: <20180802074622.13641-3-tmricht@linux.ibm.com>
References: <20180802074622.13641-1-tmricht@linux.ibm.com> <20180802074622.13641-3-tmricht@linux.ibm.com>
Date:   Wed, 08 Aug 2018 13:37:26 +1000
Message-ID: <87r2j9bkax.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Richter <tmricht@linux.ibm.com> writes:
> Add support for s390 auxiliary trace support.
> Use 'perf record -e rbd000' to create the perf.data file.
> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
...
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
>  2 files changed, 314 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h


I'm seeing a build break on ppc64le which seems to be caused by this
commit (I haven't bisected):

  util/s390-cpumsf.c: In function ‘trailer_timestamp’:
  util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
    return *((unsigned long long *) &te->timestamp[te->t]);
    ^


And on powerpc big endian:
  In file included from util/cpumap.h:10:0,
                   from util/s390-cpumsf.c:150:
  util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
  util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
     pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
            ^

cheers
