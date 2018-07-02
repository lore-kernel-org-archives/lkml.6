Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67412C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DB224EAB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6LlGcsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DB224EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGBRru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:47:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40553 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:47:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id x5-v6so590350pgp.7;
        Mon, 02 Jul 2018 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k0gBLSXRtEXrDoQdns8bdiJ6sbDase3myVCKD4nwK7M=;
        b=E6LlGcshg45rURJQzqjrnsWATIL7TV3TZ0CZl2apa6umvGkh+lTPzQ2P8IRYkXP/fh
         43iBpndH3P4cEoAF0X42GzY25x0aMhDBioODhnCXlElIfytD5+HxR+ud2lRt0luE0j36
         B/x5NC+70+llXjKbtHHPta9RHnCloe26Zz1T9tJxDyY+yWFE6caCMOrqy+3MnxSxMGkg
         ostlJH9LFjX0I4gxTSCmLxWm2XN3scTRo+bymKUgES3fqGb4AaPcwS6n57B9Xdz8OD8J
         3ykWQnVhYUycN89cSodQ/xVkj9Wo/T7JJnuVFdE+JIKp0/cMnbONpN3kUOGg6ih5Zoph
         4FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0gBLSXRtEXrDoQdns8bdiJ6sbDase3myVCKD4nwK7M=;
        b=rxWYNlvdDORhuhQ3fO72d39MhrcChlolcpIaNkyP/nmGtWoqsMoVTKFRPidTE6s9e6
         F4A033OJPHXdmfVG/idGFAd+6Xx2TyyaziGfine8BpV+24uP2awmaklSzwdk5VVA3qu2
         ABDtGN++i/rUUUKnXi2a7L9fX/YMa+e7s35Y83WGOmoADgPfNh4z62+p42yPyuQ4BAlL
         BAfhFYwQTgetnyHxUOyws9Q6SFWjHWOPoDyN20KCeWIeZemDhtXGPgyIOTMtgm53Vzyr
         ZXgCvFYwuhUqYDr9FwLNlIp/IItcGIiFS2jn1SJd8VhnOWOa0Nsgubccp1iGUk5U/Rn7
         jhnw==
X-Gm-Message-State: APt69E2Wsa6q9LlCKfkEUmMzoam168H3HAYCgWHFTJ/y1jUCRQu6xuWU
        B6OSXVDDRVinWHm3Wr5J4KY=
X-Google-Smtp-Source: AAOMgpePmNDTZtG73lXG8vGWA+S2+V83wHJrGoGy+JM14VEA7TvRZP0nCbOz9vl7Z69uDSj5Ksw3bA==
X-Received: by 2002:a62:ee01:: with SMTP id e1-v6mr26107489pfi.2.1530553667444;
        Mon, 02 Jul 2018 10:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id i6-v6sm5025054pfo.107.2018.07.02.10.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 10:47:46 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:47:44 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/6] thermal: tsens: Check if we have valid data
 before reading
Message-ID: <20180702174743.GA25238@localhost.localdomain>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <e2fd1933390c2c1c0fedc6e2c4f2093470c4242a.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fd1933390c2c1c0fedc6e2c4f2093470c4242a.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 06:14:08PM +0530, Amit Kucheria wrote:

Empty description, cannot apply. Please describe your patch.

Thanks

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
