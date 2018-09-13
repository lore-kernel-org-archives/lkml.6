Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6336F81833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4113E215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IggVjLzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4113E215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIMVma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:42:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41601 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:42:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so2836964plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pf6OkK8djwhkhMDYw62KDVUBpw3fMLEWWaac+NLWwaQ=;
        b=IggVjLzyk1VtW6W1hn/uJT5kZ/BGubreRxlFF0dHwnhbr2xDOMQfr59yl7LYtGY9qK
         E01Ceex2JLl0UalwcusqUlmhn6pfgWQD8LUwVG+4ykciWnSmDxcZCiwFzefiu4hELMqT
         bE98rjHGaT5QcfpFbX8f7GfCAll45ZRhAyEu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pf6OkK8djwhkhMDYw62KDVUBpw3fMLEWWaac+NLWwaQ=;
        b=g1Jo7qtLVKEFZGiM/PSq3oUz7EOOJXc3qsCdF8DQt7HBcHGRHsbCnB4D/wrLTUEU2d
         OxDwbV6sJYdOk1/ePcijT4+4QN0OqcPoi9b9T0JyxPc1Z07KtouzDRLwarSVnbkqVjIA
         c3FZ4ykxhWkktrcqD6ghXc6Uny16DvdgvK+aDB8/s1rN4fR06XX0ETzbUiJSMUh2/r06
         q7atWLHhpAHPoT4FLmsv3CYiZ0GyiXNWdisrKfVtfCIlJjm21Ye0TTxumCLdc3VYiro2
         C7FvBinIBqTAgb7ilm6v8PjkWSmIeOMWEQyhdnAKf38iiYZkbYkUYTVqsAr5f/GrafE9
         S/Bw==
X-Gm-Message-State: APzg51Dq/Ypscy1AUX8YVSy5WoT5dbrCxM6P2KoM5IAr+9aqNGkJR85u
        6iO7ByeZ6DthXMyd4+jEdMrtIc0Bfzs=
X-Google-Smtp-Source: ANB0Vda0JKdnWT+Lq5nI95GDBzF+/s6lXdBJIzKtfm8jIhtEN0wqupe4T5qf5fegc9yUhPaM10qGtA==
X-Received: by 2002:a17:902:59ce:: with SMTP id d14-v6mr8055417plj.42.1536856335338;
        Thu, 13 Sep 2018 09:32:15 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v72-v6sm8889319pfj.22.2018.09.13.09.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 09:32:14 -0700 (PDT)
Date:   Thu, 13 Sep 2018 09:32:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bin Yang <bin.yang@intel.com>
Subject: [GIT PULL] pstore fixes for v4.19-rc4
Message-ID: <20180913163212.GA36793@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore fix for v4.19-rc4. It fixes a 6 year old pstore
bug that everyone just got lucky in avoiding, likely due only using
page-aligned persistent ram regions.

Thanks!

-Kees

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.19-rc4

for you to fetch changes up to 831b624df1b420c8f9281ed1307a8db23afb72df:

  pstore: Fix incorrect persistent ram buffer mapping (2018-09-13 09:14:57 -0700)

----------------------------------------------------------------
pstore fixes for v4.19-rc4:

- Handle page-vs-byte offset handling between iomap and vmap (Bin Yang)

----------------------------------------------------------------
Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

 fs/pstore/ram_core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
Kees Cook
Pixel Security
