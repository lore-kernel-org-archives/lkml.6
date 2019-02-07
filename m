Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF5C21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549554711;
	bh=nHqbXNt/7gA3qqcSHJA9EEffOt58eLJOaWfyatXK+2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5pJQIF83/oNr1NRi8Dd+2yPTDHbjKyR1ZFj9psun8AsOyz3hLkZYGQWnRq05FaNd
	 xgW9n93AbP3hOt/G1upM7qe5+ztrdj7LmNGxjk3McEPHfzT4BIf7YOCKvXoH+3ssRL
	 s+eiGqrOp4IlNPeiShGqXQtWaBS5S4+cbBbkhW/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBGPvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:51:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40824 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:51:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so104698pfo.7;
        Thu, 07 Feb 2019 07:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdE7p3ZozkiBFcZHjh4vHFYprMcrhxGnkk/4zKaTpgQ=;
        b=kXQDHQh+wW4aGmAfdlTtou6KFwz/9dam3zhZaUc0+s5E9K2D8CPWCWEAcOCD3sO1Oq
         JgCWTXe/RWSmD9JJ3xCMSYraZxBMQ094WVHfBgF+jOv3Q/VHmlrmdddglVR4JrH+Rw/a
         CpVzSKy7ymI9HoKKFKpcpJgNr502cIFMXgwX2CtYHjtwenR7YvgcCcT/GrOF9dM8/QRD
         ncwLdctTL0VFiGrAeXXNJ+GJ/2lmJOm/cky1iDarrjMjj1Ihz7q7iMcNHF1dwM9jb18G
         0bBvRzJIOIGobeREtOfDbls9WX/4B1AbDspbsScvfQcy28HZd5ETObqEX9btn8CYu8/q
         K+nQ==
X-Gm-Message-State: AHQUAuZXqBUGe7rns+qS13YZzrAHVCaVthU9luFmzkQoHPPOw1knvzzS
        ZIMh3hMMrOsTw9PpfGMQ7dY=
X-Google-Smtp-Source: AHgI3IawEdEs0ebVhsj7m6oPYHmNvqcEZU/GpYYu39O4oHYTeUilty2j0Ju/30lb4aaIoULks1ZsSQ==
X-Received: by 2002:aa7:8a45:: with SMTP id n5mr8661073pfa.151.1549554708584;
        Thu, 07 Feb 2019 07:51:48 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id 125sm12556803pfg.39.2019.02.07.07.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 07:51:47 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 07 Feb 2019 07:51:44 -0800
Date:   Thu, 7 Feb 2019 07:51:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com
Subject: Re: [PATCH v2 0/3] sysctl: fix range-checking in
 do_proc_dointvec_minmax_conv()
Message-ID: <20190207155144.GH11489@garbanzo.do-not-panic.com>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
 <20190207123426.9202-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207123426.9202-1-zev@bewilderbeest.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:34:23AM -0600, Zev Weiss wrote:
> Hello,
> 
> After being left with an unusable system after a typo executing
> something like 'echo $((1<<24)) > /proc/sys/vm/max_map_count', I found
> that do_proc_dointvec_minmax_conv() was missing a check to ensure that
> the converted value actually fits in an int.
> 
> The first of the following patches enhances the sysctl selftest such
> that it detects this problem; the second provides a minimal fix
> (suitable for -stable) such that the selftest passes.  The third patch
> then performs a more thorough refactoring to eliminate the code
> duplication that led to the bug in the first place (maintaining the
> passing status of the selftest).
> 
> 
> Changes in v2:
>  - Rearranged selftest to also test negative values and provide more
>    info in comments
>  - Added intermediate patch as a minimal fix for -stable without the
>    refactoring

Thanks! For some reason I got all except the last patch, patch #3.
Can you bounce me and others a copy?

  Luis
