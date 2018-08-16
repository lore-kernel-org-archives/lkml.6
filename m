Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD25C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365D2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4365D2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbeHPQQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:16:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbeHPQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:16:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so2034878pfh.2;
        Thu, 16 Aug 2018 06:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVOogphfoUoqVe11v/FgNwAU7mg07cE6fQjsyPCQ5pU=;
        b=gwEVcDJ5/yjUvYqwHRuNXUgOEOFztJgLOcGSNsMTVWdNgfu2VYq6KrTYaHCEugdVo+
         2xEVk/4wwUmEtCC5tsyKxYBDlYHWUR0doWk9V+WXJjMihCuSvROO5xJ1o0LcDThCTves
         l1HLawnQjlLurR+jGj98cIqdz+NRpkbKmvadUtTX5iphzApnvwgazukzoj2/HhnHShtW
         tQHPIu7/GzJUDsxh1+/yEqrX8hbYv4YdHurN43k5yhWRvJp4HLsop5/a/PcWvSaU+qnX
         BsDMG9gZNg1eezpCHdN3g74hn9WrIHJ/yTjOuNPj1M9+FLQ7oEgkKc3KOYI56yoGl6o8
         c+uA==
X-Gm-Message-State: AOUpUlFPGhBShmI5Juq8/dNxJbgi6fTUowcI3zbfIYbCgbnaOO0ADJoE
        IDYuMxikAfA5NtMsRinBv8Q=
X-Google-Smtp-Source: AA+uWPyI/zfkN5/nodFa0L8StGIT1ckQdaYZIeecRecW2szvfJMyThzKhf0Ad7ve9W8ckxAEVhOgPA==
X-Received: by 2002:a63:af14:: with SMTP id w20-v6mr29840859pge.47.1534425454377;
        Thu, 16 Aug 2018 06:17:34 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id p5-v6sm29705642pfn.57.2018.08.16.06.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 06:17:33 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 16 Aug 2018 06:17:31 -0700
Date:   Thu, 16 Aug 2018 06:17:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Srikanth K H <srikanth.h@samsung.com>
Cc:     keescook@chromium.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] Preventive patch in the proc file-system to handle
 NULL check.
Message-ID: <20180816131731.GB1457@garbanzo.do-not-panic.com>
References: <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcas2p2.samsung.com>
 <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:04:13PM +0530, Srikanth K H wrote:
> If the make directory for "sys" interface fail's then its
> dereferenced without even checking for its validity which
> will lead to crash, hence added preventive code to check
> for NULL and accordingly dereference.
> 
> Signed-off-by: Srikanth K H <srikanth.h@samsung.com>

Thanks for the patch! Do you have a reproducer or is this theoretical?
This will affect if it should go to stable or not.

  Luis
