Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E01EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFE42087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J3Xd7adH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFE42087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbeGKThn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:37:43 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42249 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbeGKThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:37:43 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so25331612ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QaIu+f1W8/f3ynU92NOByujVhXMGp/qH+2Yv84P4M5g=;
        b=J3Xd7adH5w/1d0byk8CvDSIFy1WE7EBxvoSKYl43lpMVHVz21R5RkXmKLtQYp8EVxY
         0LMwWJWgOzX5S57LlObklJocnR7iDV7jG1K0LYED5x0QhB7689u89WrfDhs8AKG9hq/W
         cfoZFEPV+kxrjVeYMyk25rFhXmNFeNA/rYZwvOUtGwhkiwMFsD1AMXEfQSysNCxfM7sb
         raCuWIM4Jloi40f2qiKm3V9ju4z4jUXKmwBLxOEqK68mDxjZ2MI5/A3g9SM/98y59syH
         k+RGLr7Emn9BqW9WsMfwcufdmQQezgZU09W5xfHsuskGq3KPf6AF8SXedUqQWjqn+kXP
         eZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QaIu+f1W8/f3ynU92NOByujVhXMGp/qH+2Yv84P4M5g=;
        b=ZpiBLPEVCoNQyc9+CZmH+oL3A+A8xV8IUwdbgJ3wt+twX25cp7Vp8BXIoEu/yncnY8
         3gVK4uqziHEyj8QzbNP/rtUW3BhFPnSTLmxeRMdUK8ZvWmxt3dIuO4bvQ5xo+hbEpC6H
         5gIW+uhI+j698YpMHdf2QAl6R/0efzrOVx75rsfmxrEbvm/4hF2YVMysd/57D3hZIDox
         7OmpSmw/O+Ylciycf+CBOzJd2C7nYWKCxLiepA1Rs+/bnNVfRgs295PR/2f5BX/yGOky
         8XeKcrtnz0jIV1kXIQpcP3Wwwd4OJDxLhUnocIzFnGuZK1bmm6cezB0wj0CCLhtcatFO
         u4UA==
X-Gm-Message-State: APt69E2pdI7jA72iTXbstkG8fjpeZ8vfXwE8iCZ5RWjveUz846Nan8Aq
        YrsLHW3fBRG7Jwn002ztGk3wSA==
X-Google-Smtp-Source: AAOMgpea1Lfbr/8Jp/yvy8vDWQv1M9Mb7sFszCdLlmwuqpmY4u++IQSRDevst/O7TDiiIt4WMSEiUQ==
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr25293813iof.79.1531337515307;
        Wed, 11 Jul 2018 12:31:55 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 134-v6sm1336554itw.23.2018.07.11.12.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:31:53 -0700 (PDT)
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk>
Date:   Wed, 11 Jul 2018 13:31:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/18 12:50 PM, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 8:30 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> On 7/11/18 10:45 AM, Tejun Heo wrote:
>>> On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
>>>> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
>>>>> Makes the macros resilient against if {} else {} blocks right
>>>>> afterwards.
>>>>>
>>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>>>> Cc: Tejun Heo <tj@kernel.org>
>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>> Cc: Shaohua Li <shli@fb.com>
>>>>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>>
>>>> Jens, it'd probably be best to route this through block tree.
>>>
>>> Oops, this requires an earlier patch to move the for_each_if def to a
>>> common header and should be routed together.
>>
>> Yeah, this is a problem with the submission.
>>
>> Always (ALWAYS) CC folks on at least the cover letter and generic
>> earlier patches. Getting just one patch sent like this is mostly
>> useless, and causes more harm than good.
> 
> Ime sending a patch with more than 20 or so recipients means it gets
> stuck everywhere in moderation queues. Or outright spam filters. I
> thought the correct way to do this is to cc: mailing lists (lkml has
> them all), but apparently that's not how it's done. Despite that all
> the patch series I get never have the cover letter addressed to me
> either.
> 
> So what's the magic way to make this possible?

I don't think there's a git easy way of sending it out outside of
just ensuring that everybody is CC'ed on everything. I don't mind
that at all. I don't subscribe to lkml, and the patches weren't
sent to linux-block. Hence all I see is this stand-alone patch,
and logic would dictate that it's stand-alone (but it isn't).

-- 
Jens Axboe

