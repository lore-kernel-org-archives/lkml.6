Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83532084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544656484;
	bh=R++n8pMaT8jzbJRCkS942AUnQg8hVklSl0keFhlKwR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJDCenIlOg2soQXYago1ZUBxFFP+4chMIB36NYAfet1RfpyR2+jttCjmkkvxy+XKZ
	 vuhPi1wEVADpN/VpFMQR2b+y4ZR9Cd7S+w7WXvM8NzEnCr+NbyxwBB6BMgYK7hlGYp
	 TPIWGEfGMCHNXZnjMZDaP1rAPCxhpLx5ua3wBz18=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83532084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeLLXOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeLLXOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:14:43 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8042084E;
        Wed, 12 Dec 2018 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544656482;
        bh=R++n8pMaT8jzbJRCkS942AUnQg8hVklSl0keFhlKwR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqmJgJLIeKt3W8OFrFrmKeQwDD8ZtxZDNnyFkjGUx7CXk3BNYrDnsOES/zbkrzwG1
         1zhAziRwY0BxH98nuyKsjKuNGaNnA7bi+REX3Aj+Yw+GVrxdQhTwfh2/1fu0js/FCQ
         6HEXzrWZZFsnGq/SYSNVeFN7LjfKafsWTDjFzxDY=
Date:   Wed, 12 Dec 2018 18:14:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 104/123] pstore/ram: Correctly calculate
 usable PRZ bytes
Message-ID: <20181212231441.GG2746@sasha-vm>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-104-sashal@kernel.org>
 <CAGXu5jJuH+Nwh5J=-efDmH__GN9_wPLuX6FoJTUP8CwTxLnHGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGXu5jJuH+Nwh5J=-efDmH__GN9_wPLuX6FoJTUP8CwTxLnHGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:57:08PM -0800, Kees Cook wrote:
>On Wed, Dec 5, 2018 at 1:41 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit 89d328f637b9904b6d4c9af73c8a608b8dd4d6f8 ]
>>
>> The actual number of bytes stored in a PRZ is smaller than the
>> bytes requested by platform data, since there is a header on each
>> PRZ. Additionally, if ECC is enabled, there are trailing bytes used
>> as well. Normally this mismatch doesn't matter since PRZs are circular
>> buffers and the leading "overflow" bytes are just thrown away. However, in
>> the case of a compressed record, this rather badly corrupts the results.
>>
>> This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
>> Any stored crashes would not be uncompressable (producing a pstorefs
>> "dmesg-*.enc.z" file), and triggering errors at boot:
>>
>>   [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!
>>
>> Backporting this depends on commit 70ad35db3321 ("pstore: Convert console
>> write to use ->write_buf")
>
>Please note the above. If this gets backported, this one is needed too.

Okay, I've added 70ad35db3321 for 4.9, 4.4, and 3.18.

--
Thanks,
Sasha
