Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED65C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC5E20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw4cyCe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC5E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbeKGBQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387905AbeKGBQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:16:04 -0500
Received: from localhost (mobile-107-77-164-88.mobile.att.net [107.77.164.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2C92085B;
        Tue,  6 Nov 2018 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541519414;
        bh=YVC/luPMLY71W7yKEzwQ3tOZSW6tJyF/FPit6g/6YOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jw4cyCe854I9xnHEgWHo4I1PKuulPr4M497PyupluV5jojcXe0vHraMcyPXxHtnvK
         0tM1N1YZT1arrxUBy0R3DJMzXaYERB3lnc30K1HtV+uqbsKN8lQTiesHW/v4IecY/V
         uvzhI6m5yL8UznOK4F8ZobH9DK7Kfony+yTNYHSE=
Date:   Tue, 6 Nov 2018 10:50:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jack Wang <jack.wang.usish@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org, shli@fb.com
Subject: Re: [PATCH AUTOSEL 4.19 118/146] MD: fix invalid stored role for a
 disk
Message-ID: <20181106155012.GC151445@sasha-vm>
References: <20181031230541.28822-1-sashal@kernel.org>
 <20181031230541.28822-118-sashal@kernel.org>
 <CA+res+QxUmb2B=Owy3+PV_Jgsm0DBshF3RYzhcTEMnGepOZ_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+res+QxUmb2B=Owy3+PV_Jgsm0DBshF3RYzhcTEMnGepOZ_qg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:37:32AM +0100, Jack Wang wrote:
>Sasha Levin <sashal@kernel.org> 于2018年11月1日周四 上午12:45写道：
>>
>> From: Shaohua Li <shli@fb.com>
>>
>> [ Upstream commit d595567dc4f0c1d90685ec1e2e296e2cad2643ac ]
>>
>> If we change the number of array's device after device is removed from array,
>> then add the device back to array, we can see that device is added as active
>> role instead of spare which we expected.
>>
>> Please see the below link for details:
>> https://marc.info/?l=linux-raid&m=153736982015076&w=2
>>
>> This is caused by that we prefer to use device's previous role which is
>> recorded by saved_raid_disk, but we should respect the new number of
>> conf->raid_disks since it could be changed after device is removed.
>>
>> Reported-by: Gioh Kim <gi-oh.kim@profitbricks.com>
>> Tested-by: Gioh Kim <gi-oh.kim@profitbricks.com>
>> Acked-by: Guoqing Jiang <gqjiang@suse.com>9e753ba9b9b405e3902d9f08aec5f2ea58a0c317
>> Signed-off-by: Shaohua Li <shli@fb.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>Hi Sasha,
>
>This patch breaks linear hotadd please also include  commit
>9e753ba9b9b405e3902d9f08aec5f2ea58a0c317
>MD: fix invalid stored role for a disk - try2

I'll queue it up, thanks Jack!

--
Thanks,
Sasha
