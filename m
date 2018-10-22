Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C98C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E4420674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrqhqQ6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E4420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeJWFBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:01:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41392 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeJWFBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:01:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so6683781qke.8;
        Mon, 22 Oct 2018 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TGvCF9ub5PAI2ebNEZmszxfZE4WwA0zkhCb6jevYu0s=;
        b=DrqhqQ6ID18cuZiD1ChY2nehAxIUF8MkB+Fcl5D8Z+curvm22Xr/ct+YGidZffNFOd
         qBZTosrQiXOJ2TB3TUShbjL0oclB3aA4LdsYP0F1IdpgjzRAuQOWuPJixfHOoIyZ7qQg
         IEY03SWUuJ2YhHT21095hQGro+HjP71rhufj80uja6JfBhDuRK1+tO9UDDmZeaj/bG/F
         k7I8J1MBSOAs5VuBjREAQe58cKFpDwlPcrLVQNyEYVrBpE0S+crP3v/3g0DT0T7FLZJU
         KOX6/5Z3WFrbIEz3UoJVy88WZEYcVK4N0qxExDS+IN6loYJCApsWZd4Em7tSGia47ZoP
         OE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TGvCF9ub5PAI2ebNEZmszxfZE4WwA0zkhCb6jevYu0s=;
        b=YC4xS+1KbCVDjnm/AiPNroKKo72dLVkklOrGNCNSeVrz6DuQvsQLgHIwGlYnd3eeCB
         LpfOdsSDQQcnCwVESvBr23IRYM8d6c4C6YhXPP3SCB/OiRdNZlsy2ci/n190yoo5xHRI
         S3mL6VJMSOo+i14qC0fnC6afl4ex96xtPyW67O0qIj6rfpfgXqC+grSY/gNwfqlheLCy
         o1aQaZB/3nvDqCmXOC9m5zr2aOth+6FuaBj6VocPM2CD6VTCFWwgUIYoEax4nbiOZQHK
         mOK+wxePQpQgdSyZ7gjf6r2O3jbOUwkZ3GyCSzFxHtZGe0BFHohANnx343ZkhjopFKSJ
         nKsw==
X-Gm-Message-State: ABuFfogqGNiqRCU8rT9pMGuK6XrN0Ma0ec6Lo55uJWSLMdk8qQTq2JSx
        BiQ9ev6U3aBEVfHPaBcGtjU=
X-Google-Smtp-Source: ACcGV63NSi4pdOA2UmiFXxkPQM+wXq6jsoO0NG5vShMmxZ607JubVJ92e++E5prJvtSdq0T4dRMdcQ==
X-Received: by 2002:a37:8c42:: with SMTP id o63-v6mr42829816qkd.187.1540240892106;
        Mon, 22 Oct 2018 13:41:32 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o7-v6sm21709170qkc.67.2018.10.22.13.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:41:31 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:41:27 -0300
From:   Victor Colombo <victorcolombo@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/2] staging: iio: ad5933: Remove unnecessary blank line
Message-ID: <20181022204127.ususo2472wcum24f@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 7a216ea90784..f9bcb8310e21 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -267,7 +267,6 @@ static void ad5933_calc_out_ranges(struct ad5933_state *st)
 
 	for (i = 0; i < 4; i++)
 		st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
-
 }
 
 /*
-- 
2.19.1

