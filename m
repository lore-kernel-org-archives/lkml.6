Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA308C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519AA2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BtuvPBo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519AA2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH1Xq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:46:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45412 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeH1Xq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:46:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4-v6so1205344pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23K7ZZ9Kt4B3pyDyOBIQU3RWNsZlD/5s/HVCC++bsGE=;
        b=BtuvPBo0L9YY31hFvq4CwynBH7/3XfDxFmXP2pPpxmd2BRI0AbW6giTX8T5VQM5xbc
         9OHNQAuaOANNk7hAET+rW9yg3WbB7ZJIJ/1uxWv2cazgLsJr5OgXCYZr72YuaywSfzJX
         2L44ODQLZH8Azoqf1W2pCeNt3GmvbRGIJYCq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23K7ZZ9Kt4B3pyDyOBIQU3RWNsZlD/5s/HVCC++bsGE=;
        b=WppEghjmlHx1we+gg0r1bMCuYn7YbcMWCjh/YghA5cFMB3xZDHIJG+T2aAfR1ZXrKM
         tUjp/K8sNC35+7/TNUYfjpCLSdrJlQg+JkmkQc2HtA3/04yECUJuINfBY1eFg5Dw9d6s
         iiuyxx601VLlLI+aWvV1eE2j36nZp1Jf+i8UtNR2E3038pi5ZEAwG48R6vBniLOt3+i2
         TPmCHZgFxYg2v0dlKAT5RnZHrn8aB0gfZw84jrvSo4p6asT7AjMXM60rFNDJ2AV/Lby/
         PfQ3IGKJIMCWed5RniEE0Sfj0jws5ApUj2X93jxdgeep+CtWjMWXBLUGlldDkCXU+b0R
         1nqg==
X-Gm-Message-State: APzg51AjL0AJV+PvnEkTqYHkDgaHOopUfxKPoXsGm6BDz26EtV94QNdO
        IDNdeisNKj29nxyOcEvfWOtxsrRy9Qg=
X-Google-Smtp-Source: ANB0VdYgLjeTjolyyeslBASEqh24Ky2+BfT9OV44o3/nqEfQ1tSOMGgxArjT1R/xL3XZIDmjTWfMbA==
X-Received: by 2002:a63:d443:: with SMTP id i3-v6mr2770301pgj.216.1535486028458;
        Tue, 28 Aug 2018 12:53:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3786105pfk.134.2018.08.28.12.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:53:47 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:53:47 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [tracing]  c3bc8fd637:
 WARNING:at_kernel/rcu/tree.c:#rcu_irq_enter
Message-ID: <20180828195347.GA228832@joelaf.mtv.corp.google.com>
References: <20180823023839.GA13343@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823023839.GA13343@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:38:39AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-6):
> 
> commit: c3bc8fd637a9623f5c507bd18f9677effbddf584 ("tracing: Centralize preemptirq tracepoints and unify their usage")
> https://git.kernel.org/cgit/linux/kernel/git/rostedt/linux-trace.git ftrace/core
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/

This appears to not be testing the tip of ftrace/core or Linus's tree which
contains several other patches/fixes ontop.

thanks,

- Joel

