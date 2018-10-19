Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD7C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97D120866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97D120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJSKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:35:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:35:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so15083328pgq.5;
        Thu, 18 Oct 2018 19:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CkuWs1/I4CX6Jo/ah3za1AwyJl+SDJ2D/39QfJML5A0=;
        b=CVcXyhztzS14ptHUDc22r3XWIbnBj0Mr0O4f+tdZewtplTrROH0PiVNNoDU2Kb7YMW
         cMCV+o19JPF0thGxyzwNd/J8v37TVCevqi9K6aOYUbqQua0NAf+tbz3uIQmkUIsOoObK
         mnbN5qOcbuzShBFFAaTT+BGVWl/p52lGoY+k7Oki8Q4v3nKELP7YBrc8SWKwMWLN5uoZ
         XWb7P1kEThBtD/RfAPef/7QUkarDBVdwitrAcenpIjEFXAZbYi79xZ7hbzr9Kk7o0WYq
         4w0tLGiap1BB1IG7aiE6MtYFbAplv0eZ8sPf4kf65y4F4sZ2wOmyWT7GZIWIqIO8bRiw
         Wrhw==
X-Gm-Message-State: ABuFfogZy5YJ9yMlwQQaFaOy5AYDFGQMZ/cHNP02nRguasEVQhTMYoLy
        buricfo7XJEKeTscHN6vsh4=
X-Google-Smtp-Source: ACcGV62AiDN+jks2/rl1qMeRk1D63I7vg/Ddy2CcuY9rYFpEQ2TIY0HaMDkfvyzFYre5m2phmUV0SA==
X-Received: by 2002:a65:40c2:: with SMTP id u2-v6mr30770260pgp.123.1539916274896;
        Thu, 18 Oct 2018 19:31:14 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id y8-v6sm37296083pfd.168.2018.10.18.19.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 19:31:14 -0700 (PDT)
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     alexander.h.duyck@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain>
 <1539886275.81977.17.camel@acm.org>
 <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
 <1539893636.81977.29.camel@acm.org>
 <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1e061fe5-9be4-77be-5350-4cb7175afdf8@acm.org>
Date:   Thu, 18 Oct 2018 19:31:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 7:20 PM, Alexander Duyck wrote:
> I see what you are talking about now. Actually I think this was an
> existing issue before my patch even came into play. Basically the code
> as it currently stands is device specific in terms of the attach and
> release code.
> 
> I wonder if we shouldn't have the async_synchronize_full call in
> __device_release_driver moved down and into driver_detach before we
> even start the for loop. Assuming the driver is no longer associated
> with the bus that should flush out all devices so that we can then
> pull them out of the devices list at least. I may look at adding an
> additional bitflag to the device struct to indicate that it has a
> driver attach pending. Then for things like races between any attach
> and detach calls the logic becomes pretty straight forward. Attach
> will set the bit and provide driver data, detach will clear the bit
> and the driver data. If a driver loads in between it should clear the
> bit as well.
> 
> I'll work on it over the next couple days and hopefully have something
> ready for testing/review early next week.

Hi Alex,

How about checking in __driver_attach_async_helper() whether the driver 
pointer is still valid by checking whether bus_for_each_drv(dev->bus, 
...) can still find the driver pointer? That approach requires 
protection with a mutex to avoid races with the driver detach code but 
shouldn't require any new flags in struct device.

Thanks,

Bart.
