Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE94421471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNiWQ1mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeISC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeISC3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:29:17 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2B520880;
        Tue, 18 Sep 2018 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537304096;
        bh=F1WH/U6bPk8Uvpvs8aklRFpZaEnNChdYNexZU3P97UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNiWQ1mOnOF6KFsqWYggtlqq3AJjPc6UR5M7e1ZVHiUPNh0+vqUgt4AIYcJoEMfSP
         s2aqqg0JWT2l40Fy43Q0Ep6U+4aCeLNc0VaSfY7Dajdx9MbD+QGehw5b25zb5eWpW0
         aCeXOPXVgZbJt1zTs3CTzYDOQ4gBVZ5/yvnkqmRo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id F2413140260; Tue, 18 Sep 2018 17:54:50 -0300 (-03)
Date:   Tue, 18 Sep 2018 17:54:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 09/48] perf tools: Make copyfile_offset global
Message-ID: <20180918205450.GA311@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-10-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 13, 2018 at 02:54:11PM +0200, Jiri Olsa escreveu:
> It will be used outside of util object in following patches.

Had to add fcntl.h to have loff_t to fix the build in some systems,
moved the prototype closer to the other copyfile_ prefixed functions in
util.h.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-xgiypvcrmc12u7czcrc27en2@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/util.c | 2 +-
>  tools/perf/util/util.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index eac5b858a371..093352e93d50 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -221,7 +221,7 @@ static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
>  	return err;
>  }
>  
> -static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
> +int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
>  {
>  	void *ptr;
>  	loff_t pgoff;
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index dc58254a2b69..7fc171b20671 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -80,4 +80,6 @@ void perf_set_multithreaded(void);
>  #endif
>  #endif
>  
> +int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
> +
>  #endif /* GIT_COMPAT_UTIL_H */
> -- 
> 2.17.1
