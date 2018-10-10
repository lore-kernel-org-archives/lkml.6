Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62188C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F972150B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDHusQoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F972150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJJWWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeJJWWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:22:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD9D214DA;
        Wed, 10 Oct 2018 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539183609;
        bh=7WMlCnDZ2qkZY/q6XozeZLIfwN9KJC9ax3saxAPKn/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDHusQoqjdkTIY2txj+LgVvUlwRaRw+K6cRoKwLOL8GalG9oyxFNiTU+jzntIAjbf
         76TBqlqmJyTc0p6qTqpp0JluA/kV2c4+Msj0etHL3FYE92XmmfJeWvhrP4CYSKROEZ
         JK6ychjEjQiAyLFTMnwwgooMXWGt2UJp/43Vs9VM=
Date:   Wed, 10 Oct 2018 11:00:07 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH AUTOSEL 3.18 6/6] ubifs: Check for name being NULL while
 mounting
Message-ID: <20181010150007.GH32006@sasha-vm>
References: <20181005161750.20823-1-sashal@kernel.org>
 <20181005161750.20823-6-sashal@kernel.org>
 <4196827.3PtsAkI51k@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4196827.3PtsAkI51k@blindfold>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 06:24:42PM +0200, Richard Weinberger wrote:
>Sasha,
>
>Am Freitag, 5. Oktober 2018, 18:17:50 CEST schrieb Sasha Levin:
>> From: Richard Weinberger <richard@nod.at>
>>
>> [ Upstream commit 37f31b6ca4311b94d985fb398a72e5399ad57925 ]
>>
>> The requested device name can be NULL or an empty string.
>> Check for that and refuse to continue. UBIFS has to do this manually
>> since we cannot use mount_bdev(), which checks for this condition.
>>
>> Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
>> Reported-by: syzbot+38bd0f7865e5c6379280@syzkaller.appspotmail.com
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>I'm not sure whether it makes sense to apply this patch to stable.
>1. You need to be the real root to hit this code path.
>2. Access is read-only, for an attacker it is useless.
>
>If we look at the code:
>        if (name[0] != 'u' || name[1] != 'b' || name[2] != 'i')
>                return ERR_PTR(-EINVAL);
>
>        /* ubi:NAME method */
>        if ((name[3] == ':' || name[3] == '!') && name[4] != '\0')
>
>name can be NULL, so we access just a few bytes.
>
>Thanks,
>//richard

Hi Richard,

I wasn't really looking at it from a security perspective. My thought
process was that if a user (root or not) is doing action A, expecting
result B but instead unexpectedly sees result C then it's a bug worth
fixing in stable.

If you think it's a risky change for stable I'd be happy to drop it.


--
Thanks,
Sasha
