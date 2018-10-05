Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3009208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3009208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeJEXYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:24:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34194 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeJEXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:24:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 84C8B60A3592;
        Fri,  5 Oct 2018 18:24:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q6DABu4H239c; Fri,  5 Oct 2018 18:24:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 34FC560A357F;
        Fri,  5 Oct 2018 18:24:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DUUgsbLgRoBf; Fri,  5 Oct 2018 18:24:43 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E904D60A0E1A;
        Fri,  5 Oct 2018 18:24:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH AUTOSEL 3.18 6/6] ubifs: Check for name being NULL while mounting
Date:   Fri, 05 Oct 2018 18:24:42 +0200
Message-ID: <4196827.3PtsAkI51k@blindfold>
In-Reply-To: <20181005161750.20823-6-sashal@kernel.org>
References: <20181005161750.20823-1-sashal@kernel.org> <20181005161750.20823-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha,

Am Freitag, 5. Oktober 2018, 18:17:50 CEST schrieb Sasha Levin:
> From: Richard Weinberger <richard@nod.at>
> 
> [ Upstream commit 37f31b6ca4311b94d985fb398a72e5399ad57925 ]
> 
> The requested device name can be NULL or an empty string.
> Check for that and refuse to continue. UBIFS has to do this manually
> since we cannot use mount_bdev(), which checks for this condition.
> 
> Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
> Reported-by: syzbot+38bd0f7865e5c6379280@syzkaller.appspotmail.com
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

I'm not sure whether it makes sense to apply this patch to stable.
1. You need to be the real root to hit this code path.
2. Access is read-only, for an attacker it is useless.

If we look at the code:
        if (name[0] != 'u' || name[1] != 'b' || name[2] != 'i')
                return ERR_PTR(-EINVAL);

        /* ubi:NAME method */
        if ((name[3] == ':' || name[3] == '!') && name[4] != '\0')

name can be NULL, so we access just a few bytes.

Thanks,
//richard


