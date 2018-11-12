Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8115522360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="wGvtvYZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8115522360
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeKLUGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:06:41 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:41506 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeKLUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:06:41 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 572C74687AE;
        Mon, 12 Nov 2018 11:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542017646;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72TIsSGXu0dHKG6DZuALJbXW1GCv0RE0crx2Ct5jBss=;
        b=wGvtvYZgO/pweRHU+pieH6jqGL3xrzcJckx1bYs529Aa8eT5udCovgfbhc8dS+sNE1sW4Z
        lCdPLgfph/JEE2pJjWOJ9Y2dOvUf1EzP8Vqghj2U+sVyoKYUG6FH1GCDfF76SbBd0zLHI6
        GChlsGFpu3YiljBGISZ2YR4k+at+DcI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 12 Nov 2018 11:14:06 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
In-Reply-To: <9e8adb3271680165d85994a225713391@natalenko.name>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
Message-ID: <cf9ef5511050f321c358fe70b6b8494c@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542017646;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72TIsSGXu0dHKG6DZuALJbXW1GCv0RE0crx2Ct5jBss=;
        b=P3gXmoMfnc7oYudThdcLy5Me8V0kJh+iwdSusBIjLwWg7tEg4hzG2GD4akBFJYF/hP+emj
        WQqvOgRJSznNuxl0+Lx3b6ELtcqyVyawbbiV1JDi76DgQt5VsS8fB+5mjfi+NiU6qYTH1e
        rHRUVZv8J54CR7ScMvkUX57xh8SMbWY=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542017646; a=rsa-sha256;
        cv=none;
        b=XsW5+1PkZ9EA4FRBvELEUlytL5kkBm3Aa8LSPsr0WYK4Xj5sSV49jy9kSxj8A/v63DEAPRWECQb1F878Ki1ZN/tAs7agBs8iPW4VZ7oueNNCnydGK6/VZpcFGCCU7e/uPGzw7NIdsRsrAyRBZouhEMyjfnE90sp3E3+6XSIpSlI=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.2018 11:00, Oleksandr Natalenko wrote:
> I thought all the legacy stuff including CFS et al. is going to be
> removed in v4.21 completely…

Paolo, [1] and [2].

[1] http://git.kernel.dk/cgit/linux-block/log/?h=for-4.21/block
[2] 
http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.21/block&id=f382fb0bcef4c37dc049e9f6963e3baf204d815c

-- 
   Oleksandr Natalenko (post-factum)
