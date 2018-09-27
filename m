Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458ABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF012215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKD2Xsp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF012215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeI0XiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:38:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42791 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbeI0XiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:38:05 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so2448484ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SyUy1NtD4MVB4YF7XDKbBvxgSa1z3MVFmcZ31Rbs5IY=;
        b=YKD2Xsp4oapJS+i0dJXcAIPNI5WsQhdNpT8VdSZwEn28WimDQyvV/8veFKL9n36To/
         +Yrmancj0wqpsHTKHmddu+bAyVfK7S0DzfMTPmdpdWJUnOSnElKaZO9uNcZUFaDE8EvV
         5zR/TRKkYabD2XOunevQGFTDQBNxNKXrdBfdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SyUy1NtD4MVB4YF7XDKbBvxgSa1z3MVFmcZ31Rbs5IY=;
        b=RVSox4BAd9dkp405CmLgnHedArh3D/nPNJ5bBIvJw3Pqb8xFEpfXWOEGokaWIMlQxG
         g+duBB8aj+eLOylJNOP9qc7CHwJA84uOxPLevqPKqCuno/0+utrobmXr9q5DxCJCnPHP
         22rbYd8ByRzHPmQVj+CWxLMOIFS7aDKnbxthMp+4Dsji8l5Te5fmmC7S7Tvb7OmW/Tjp
         NLwVmnK3ReMmF9D42JFfKjJ55HB50Vwpou+2fMUGhZ0f67M5r3bNa6qNAGfuOANs6kIO
         E0m+XCcIpj2yz1jswWzMXNpjqajnxQE7XYRytM2GE/rhdpxks2xJd8VsYgBTob28pftD
         V/+A==
X-Gm-Message-State: ABuFfojbeVgV+tBbpa7iBygQuFphFZ8qi5jhklmHC70oZ8c8k0nYVwPA
        tJwEgRuUve7s8XMy/NCjRPxiOtJxMSM=
X-Google-Smtp-Source: ACcGV61coYusXdy1Cky9KSL79H8uzcNPo6h0jb+SGzzufjYa2QizuAH2SkOxTI02lPJjjWeu6xaZbg==
X-Received: by 2002:a6b:2b89:: with SMTP id r131-v6mr9495279ior.256.1538068727466;
        Thu, 27 Sep 2018 10:18:47 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x4-v6sm894221ioj.60.2018.09.27.10.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:18:46 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:18:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 00/16] stm class/intel_th: Queued updates for
 v4.20
Message-ID: <20180927171844.GE7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:45:37PM +0300, Alexander Shishkin wrote:
> Hi,
> 
> These are patches I have queued so far, that I'm planning to send to
> Greg for the next merge window. This is mainly support for MIPI SyS-T
> protocol and all the infrastructure changes to make it possible.
> 
> MIPI SyS-T is a public standard [0] for a software-level trace protocol
> that in this instance we use on top of STM devices (if we choose to) and
> MIPI STP protocol.
> 
> The old "protocol" is preserved for compatibility.

I have tested this set on my side and things work as advertised.  Since I do not
have a MIPI SyS-T decoder I can't validate the output, but the mechanic behind
the functionality is simple and trivial to use.  I think you have succeeded in
introducing something that could have otherwise been messy. 

Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> [0] http://www.mipi.org/specifications/sys-t
> 
> Alexander Shishkin (16):
>   stm class: Rework policy node fallback
>   stm class: Clarify configfs root type/operations names
>   stm class: Clean up stp_configfs_init
>   stm class: Introduce framing protocol drivers
>   stm class: Add a helper for writing data packets
>   stm class: Factor out default framing protocol
>   stm class: Switch over to the protocol driver
>   stm class: Add MIPI SyS-T protocol support
>   stm class: p_sys-t: Add support for CLOCKSYNC packets
>   stm class: p_sys-t: Document the configfs interface
>   stm class: Document the MIPI SyS-T protocol usage
>   intel_th: SPDX-ify the documentation
>   stm class: SPDX-ify the documentation
>   stm class: heartbeat: Fix whitespace
>   lib: Add memcat_p(): paste 2 pointer arrays together
>   stm class: Use memcat_p()
> 
>  .../ABI/testing/configfs-stp-policy-p_sys-t   |  41 ++
>  Documentation/trace/intel_th.rst              |   2 +
>  Documentation/trace/stm.rst                   |   2 +
>  Documentation/trace/sys-t.rst                 |  62 +++
>  drivers/hwtracing/stm/Kconfig                 |  29 ++
>  drivers/hwtracing/stm/Makefile                |   6 +
>  drivers/hwtracing/stm/core.c                  | 292 +++++++++++---
>  drivers/hwtracing/stm/heartbeat.c             |   2 +-
>  drivers/hwtracing/stm/p_basic.c               |  47 +++
>  drivers/hwtracing/stm/p_sys-t.c               | 381 ++++++++++++++++++
>  drivers/hwtracing/stm/policy.c                | 148 +++++--
>  drivers/hwtracing/stm/stm.h                   |  57 ++-
>  include/linux/string.h                        |   7 +
>  lib/Kconfig.debug                             |   8 +
>  lib/Makefile                                  |   1 +
>  lib/string.c                                  |  31 ++
>  lib/test_memcat_p.c                           | 115 ++++++
>  17 files changed, 1138 insertions(+), 93 deletions(-)
>  create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_sys-t
>  create mode 100644 Documentation/trace/sys-t.rst
>  create mode 100644 drivers/hwtracing/stm/p_basic.c
>  create mode 100644 drivers/hwtracing/stm/p_sys-t.c
>  create mode 100644 lib/test_memcat_p.c
> 
> -- 
> 2.18.0
> 
