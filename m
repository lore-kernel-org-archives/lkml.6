Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D806C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C491720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPSw42+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C491720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965883AbeFOPlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:41:46 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40856 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964778AbeFOPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:41:44 -0400
Received: by mail-yb0-f193.google.com with SMTP id v17-v6so3656098ybe.7;
        Fri, 15 Jun 2018 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQqufL1AJ0hin8mmegtZrm7Q1uCOPJvPz79HadixPSo=;
        b=QPSw42+0cLnRhrTWTvfC1TbIJ9h7g3F45g68aPrYdZ8RkIsSqS2CM9Nuq387yimndr
         Gl+FzDlU22WS28nlmhhViopvwfAsignuoxKC+fXaxye6nR38SIgRmf5+jED9uIQAzp1i
         HJ3VKXx4hEBAhFbx0AEpegYt8Z7tJ9GW9hiFpG2o/1l4+KYmFMCRXk5TOso5XPyC9EIh
         Zm7gBzeYcgn55W5NvmUu9P2gPvLt9v8fsBqOUX1kzgTuQctrqQGfj+Y2L4Wv+U5rY3cK
         DQ0CZ56guBQUrQ8UYDXSu1X8k5JfmciXBkJA0lcywZRCxEY4e14xlHsjgFgtHg5N/9QQ
         15AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQqufL1AJ0hin8mmegtZrm7Q1uCOPJvPz79HadixPSo=;
        b=kCaItS+vLzGmJSLq3MU7wcmSyJwDKsC0v9bPJomOugOkIfrApt98GoJzbw9QBKiDd0
         i2GbHLt2klMy3K9ER0IMhBgNT+RYjmJ7X/xhjd5iSV47JJwmivYKvWtaShPTC5bvtgFh
         bPrwdiVbO6kjKTvk3sVjE5wB+hA4PaY29GjBLfFaqvjuDKvg3nJiQwJnU3SuTI5uJw81
         K4AqNgJGIplcz/vH9nQEGq9njtaRdnMX/BPisWI9ITnHrMvSQPFUSBDcK6qmAvpLSySJ
         CM1oJBUXHtSw4fKw0ugJWhbHWRLvpOFOT3ZZVOkaPDIKX3m5KcHW1crCK/Gj+4RDrtJO
         FKbg==
X-Gm-Message-State: APt69E3jXNbDoG/2bSVFos168pTMgsL5FFZ6nUWCnPdJxYBjF/4j/h+1
        7sChUiTP8vn+X21PRcgmcMc=
X-Google-Smtp-Source: ADUXVKJ71/Cq4iseAo4FH4lODW/dYwYfVPXdkE9PAqDUN2Nul9orW0gUdIVpG8xca2GyHeE4QmdJbQ==
X-Received: by 2002:a25:90b:: with SMTP id 11-v6mr1149745ybj.10.1529077303747;
        Fri, 15 Jun 2018 08:41:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:f114])
        by smtp.gmail.com with ESMTPSA id d4-v6sm3109102ywa.82.2018.06.15.08.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 08:41:42 -0700 (PDT)
Date:   Fri, 15 Jun 2018 08:41:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
Message-ID: <20180615154140.GV1351649@devbig577.frc2.facebook.com>
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
 <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 15, 2018 at 05:26:04PM +0300, Ivan Zahariev wrote:
> The standard RLIMIT_NPROC does not suffer from such accounting
> discrepancies at any time.

RLIMIT_NPROC uses a dedicated atomic counter which is updated when the
process is getting reaped; however, that doesn't actually coincide
with the pid being freed.  The base pid ref is put then but there can
be other refs and even after that it has to go through RCU grace
period to be actually freed.

They seem equivalent but serve a bit different purposes.  RLIMIT_NPROC
is primarily about limiting what the user can do and doesn't guarantee
that that actually matches resource (pid here) consumption.  pid
controller's primary role is limiting pid consumption - ie. no matter
what happens the cgroup must not be able to take away more than the
specified number from the available pool, which has to account for the
lazy release and draining refs and stuff.

> The "memory" cgroups controller also does
> not suffer from any discrepancies -- it accounts memory usage in
> real time without any lag on process start or exit. The "tasks" file
> list is also always up-to-date.

The memory controller does the same thing, actually way more
extensively.  It's just less noticeable because people generally don't
try to control at individual page level.

> Is it really technically not possible to make "pids.current" do
> accounting properly like RLIMIT_NPROC does? We were hoping to
> replace RLIMIT_NPROC with the "pids" controller.

It is of course possible but at a cost.  The cost (getting rid of lazy
release optimizations) is just not justifiable for most cases.

Thanks.

-- 
tejun
