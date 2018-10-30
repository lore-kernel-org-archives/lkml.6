Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8BAC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38BB2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFt8KV8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38BB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJ3X7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:59:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36531 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3X7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:59:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so11641568wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8ODo+5nlI/edvBLdzlgQu84w+YBU1p44EcawnET9pk=;
        b=DFt8KV8/ESNPmbJa9+vvQToHWNT0FzKJUHQGMhiF9UkseKZUnzZsto3XXKO0RsvAcs
         5Ch0VQjd56r/6zMlKqg0fTCJBXhnoKFVF3VViUJZlLSza4r80aTTVgBhBlwKu+9wJvTD
         fph0Vae30aLRCbaTKSjWuRJmL2Ii2lHIbRWRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8ODo+5nlI/edvBLdzlgQu84w+YBU1p44EcawnET9pk=;
        b=rXeh7TxMlPrwWP40KWvH3RvOIBGGmLGy0JduFMzNaY+WlEsb3G696pcW6hGsJ0ycPj
         mB5fdh4UBMesbCdUruoVs2PX46Ekgqg0KogtjG8K/6iXJjX5M1dEqb79+IVyk+Q3qcns
         AbVZnDMtXiZkLR2wQYUyr6VHu5UhByiJHqCr7XFGsyyx9yd6T85OXtlVCSI1Vl9BO7AB
         52Q7faZB+NxzTQcASp7aMmNHfFJHp7jqLPjhl9fwbi1mfBoFJNK6J54Bt28EPHI6h7yz
         dKpVe9lLapAiVK6htLdz9K3XSQmEN6lUBxuUtAHQCqop71AbbEePR8KJ5rL42TkJvRvF
         tLUA==
X-Gm-Message-State: AGRZ1gL4OUN7PswSZ0fS32e4jKv4aL4UqooSpAvkxY7wJAAahax3Nnc9
        7GVBx55kyOY7LxNgl7kD0XFWzg==
X-Google-Smtp-Source: AJdET5el3LnPtlk+wgEV79lSay2H2tmyOIh5U+5lKKqkDY/av57R78NgBLDtINHfG0CK6CRE8qICtQ==
X-Received: by 2002:a1c:5a86:: with SMTP id o128-v6mr2035351wmb.138.1540911903380;
        Tue, 30 Oct 2018 08:05:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id y16-v6sm23486186wru.18.2018.10.30.08.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:05:00 -0700 (PDT)
Date:   Tue, 30 Oct 2018 23:04:49 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Correct CPU mode for samples
Message-ID: <20181030150449.GB8344@leoy-ThinkPad-X240s>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030143226.GA23310@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> > Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> > for vdso symbols lookup"), the kernel address cannot be properly parsed
> > to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> > CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> > thus it fails to find corresponding map/dso in below flows:
> > 
> >   process_sample_event()
> >     `-> machine__resolve()
> > 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> > 
> > In this flow it needs to pass argument 'sample->cpumode' to tell what's
> > the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> > any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> > to kallsyms for vdso symbols lookup") has been merged.  The reason is
> > even with the wrong CPU mode the function thread__find_map() firstly
> > fails to find map but it will rollback to find kernel map for vdso
> > symbols lookup.  In the latest code it has removed the fallback code,
> > thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> > anymore with kernel address.
> > 
> > This patch is to correct samples CPU mode setting, it creates a new
> > helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> > the address with the info from machine structure; this patch has a bit
> > extension to check not only kernel and user mode, but also check for
> > host/guest and hypervisor mode.  Finally this patch uses the function
> > in instruction and branch samples and also apply in cs_etm__mem_access()
> > for a minor polishing.
> 
> Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
> quickly on this one! 

Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
as I know he is travelling so might be delay a bit.

Just remind, we might need the similiar change for util/intel-pt.c and
util/intel-bts.c when generate samples, otherwise they might have the
same regression for kernel symbols.  I am not the best person to change
these two files, but bring up this for attention.

> Now processing coresight traces should be faster, less lookups :-)

Thanks!

[...]

Thanks,
Leo Yan
