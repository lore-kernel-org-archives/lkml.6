Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uhU5HvW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF74320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIKVU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:20:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54265 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeIKVU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:20:29 -0400
Received: by mail-it0-f67.google.com with SMTP id p79-v6so2292415itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJoAZ34MO8hHkyTQ3M1qWaZoZjgVCMt/UUK/nLRY8B8=;
        b=uhU5HvW8Ks5PcIhw0gMGgi0UcYf76LdVQ2jXM+YnkwRHHFF1GV4i+rRflDZ2J9D/GV
         Q7nRDAFE///GCctyL1fANkhKed/NQC+J0jOpzoltRFEoYm6Jo3g4k+4wsZEGitaNgmNZ
         +17EJ4aj/HPc8atFsCIrVtBpSROT9pSQMIekeQYzQbNr+zPGsNYL1o7JM5x/aR/X7x36
         btk/ZQQSlJW9poNYMVD/Ej0w7hyRSsrG/9trwsi467kMAw7I3Zyixc8xeijyetcpWx0m
         Aq17IHL8fHNfzcyiv8RRYIkyNqJthGx1TebEu4/hfaWnIvRPL9QmFiBOWJFAfz+kYT3E
         EAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJoAZ34MO8hHkyTQ3M1qWaZoZjgVCMt/UUK/nLRY8B8=;
        b=PJ5oYBPD+tt86M/Q7rJbHIClEtQQAxwSjT3BDJ96k3mDv4OSKndmUEdm7V8GDnoid6
         pqVJ6+PV/P0+O49AV7h8TzSSSfYv5V56vm9NpFG83kdpnTCS3Z7s/kirZMV3YkABGeO9
         ECMcWu7Q2LoMehR9xHRNxvSaq8cumB1wUwX/GXFyzccbzozQLpJvYXA2OzkoU/2GoBES
         Cmqa8MKM3lOrxpzsttrvDiWxE0aS4Y8fXoUS3NcUPCzwSu2S0Eg300lCqHBxC2RO1tja
         6WAHNDRcir/6IB8JVvb8Uf80Z7yT67e1DX9qeVNv7amA4WdIXA57G7LEj7xt997mk57q
         5OKg==
X-Gm-Message-State: APzg51DO/aW0F9rbM0i4jiN3jQAUPHISf4fLXp3r0StEAEC6Dd24ihEG
        vFu8cGn61wXBcrUWnsuvOkfWmWCykUk=
X-Google-Smtp-Source: ANB0VdZ+X+pZQQricPybbSPsP0CBTC18m7DxfPiH/RKw3fNnM/dAI9ueRclQFzfiRaZnZehXXS76mA==
X-Received: by 2002:a24:27d5:: with SMTP id g204-v6mr2331446ita.47.1536682826143;
        Tue, 11 Sep 2018 09:20:26 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id i2-v6sm5904082ioh.80.2018.09.11.09.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:20:24 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <s5h7ejsnhds.wl-tiwai@suse.de> <s5hy3c8j9g9.wl-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fcd013b-b87a-a603-d010-02d70d6e559d@kernel.dk>
Date:   Tue, 11 Sep 2018 10:20:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <s5hy3c8j9g9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 10:16 AM, Takashi Iwai wrote:
> On Tue, 11 Sep 2018 18:11:43 +0200,
> Takashi Iwai wrote:
>>
>> On Tue, 11 Sep 2018 18:09:44 +0200,
>> Jens Axboe wrote:
>>>
>>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>>> Hi,
>>>>
>>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>>
>>>> Is this already addressed?
>>>
>>> Haven't heard about this one before. What kernel did you last use that
>>> worked?
>>
>> IIRC, 4.18 worked fine.  Let me see whether I have a backup...
> 
> Confirmed that 4.18 worked.  It's also with CONFIG_IOSCHED_BFQ=y and
> CONFIG_BFQ_GROUP_IOSCHED=y.
> 
> And, 4.19-rc3 with CONFIG_BFQ_GROUP_IOSCHED=n seems working, too (as
> expected from the error above).
> 
> 
> (BTW I'll have to leave from this machine now.  For any further
>  inquiry, I'll check tomorrow, sorry.)

Very odd. Maybe try without CONFIG_BLK_CGROUP_IOLATENCY being set?
I'll try and reproduce it here.

-- 
Jens Axboe

