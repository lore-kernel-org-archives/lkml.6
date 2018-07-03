Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA80C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91932147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+nFdqwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91932147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933954AbeGCQPt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:15:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45305 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbeGCQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:15:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id q5-v6so1997697ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Mf23BocOjkmT1UOBTx+cUgy+bCAfH7DVH0a1RYWhjU=;
        b=W+nFdqwjGTICsC3avADr8P28VILmMNIPMckzkpyQSPNWA6/pWtaAptPPaehJsodses
         gLGzwpUSm2rrKa85b6hNlse0W1VSGu8e1l6tmMjjQk6IuaRCzrtmf/WWzHxCOhiX10yo
         IHCjgZ+984x1lBQVhsxro4j8FnaYxfn1hroSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Mf23BocOjkmT1UOBTx+cUgy+bCAfH7DVH0a1RYWhjU=;
        b=qCBW3n0amDGvTikrDGIq5WDlpUzApIIJGlIWg3AhBE480oyEA/clHdu5qW+oJ85DG/
         qkzi2Zz+dsWmfRlnCpDKdL+NUHF6EW4JYaYigH5QOzr8zSsjhcPIX5BEMu+UF3XQs+CE
         THQx3lEBJlFlt4cCB7fmZVzd2KIVRuXg/Up8lP5HgHOsNKyZEtBwToFTOXckbVpvY+Pc
         bGtZzvRZkUSWoBC4+tbANCtnjjokJ/nH3WFmc3wlYgNEY98fMhdo5PzYodMT4T+vGO5j
         kPLeFtLETbhjQV9eUFY8+JAcXwrj/1OcdJcIvZxNFasXTjUetqd1pkU3TvASiR0EFaw6
         pArw==
X-Gm-Message-State: APt69E1tYx30T2fXrA7VctWv0ARZl4hG+ijYB4bnoRHgA9MjMa49Irwz
        fn4pZP+ROEGNs2udH/L+buH3QA==
X-Google-Smtp-Source: AAOMgperVLJxvbBKv11xrDsu89T0JlOsj904UkhalCkYV9xCTfamWdvJZ4sCDc66i8rhDis4/1CX8A==
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr10692292ljc.107.1530634545226;
        Tue, 03 Jul 2018 09:15:45 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id s80-v6sm315151lfg.89.2018.07.03.09.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:15:44 -0700 (PDT)
Date:   Tue, 3 Jul 2018 18:15:42 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Message-ID: <20180703161542.GA9243@centauri.lan>
References: <20180703072034.20213-7-niklas.cassel@linaro.org>
 <201807032156.Cu0UKJEA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807032156.Cu0UKJEA%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:10:53PM +0800, kbuild test robot wrote:
> Hi Niklas,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on agross/for-next]
> [also build test ERROR on next-20180702]
> [cannot apply to v4.18-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Niklas-Cassel/soc-qcom-Allow-COMPILE_TEST-of-qcom-SoC-Kconfigs/20180703-173055
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
> config: parisc-allmodconfig (attached as .config)
> compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=parisc 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/interrupt.h:6:0,
>                     from drivers//rpmsg/qcom_smd.c:7:
>    drivers//rpmsg/qcom_smd.c: In function 'qcom_smd_channel_open':
> >> drivers//rpmsg/qcom_smd.c:817:36: error: 'SZ_4K' undeclared (first use in this function)
>      bb_size = min(channel->fifo_size, SZ_4K);
>                                        ^

Hi kbuild test robot,

Thank you for your suggestion! Yet something to improve:

This is already fixed in commit
67cd0eec5b62 ("rpmsg: smd: Add missing include of sizes.h")

which is part of the latest linux-next tag.

$ git tag --contains 67cd0eec5b62
next-20180703

This tag already existed before I sent my patch series.

A suggestion is that you use the latest linux-next tag when building.

Best regards,
Niklas
