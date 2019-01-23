Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED8320870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548252917;
	bh=lFNDwoR0OhL3bWZay1O52231t/GK0UdyOgwDnab9cec=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RIDQ5s+cR0IPN4dWrqCouDPlhiE2Ah1XJMwl+/CdNiCbcBf7fgK1i2x3ddDhz4SZU
	 cObX/Pd5sbvLjZSHsbc3PAaM3s7LnSQbavRBytyKlctD8q779hEVueuE5tAXacdAJ8
	 1XewaJAa4dd+DgvTlnHx2onmrrjEnatigV2zfSg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAWOPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfAWOPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:15 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E649E20870;
        Wed, 23 Jan 2019 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548252914;
        bh=lFNDwoR0OhL3bWZay1O52231t/GK0UdyOgwDnab9cec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lzv0ByXn4Aazb34IYd0TxPekxlAfmQr7KYpXgUfIU9DbT+6+Yq2SezxS1HLJq2XI8
         ZQ+rjxWtG7RFCvE3vIdRr1q1PwtVe/2yjyP3DJIxrSSakepP2l7xWVDC3+bb2pyyS3
         /CmyZYN5a6WGksX7Pn7hajX+k9tZ1cLtq8dlS8Og=
Subject: Re: [PATCH v3] selftests: add binderfs selftests
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah <shuah@kernel.org>
References: <20190117114854.15132-1-christian@brauner.io>
 <20190123105457.k7oobylgq6rwka55@brauner.io>
 <20190123110052.GB22520@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d1893da7-1222-d303-04c7-fb0500b55088@kernel.org>
Date:   Wed, 23 Jan 2019 07:15:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123110052.GB22520@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 4:00 AM, Greg KH wrote:
> On Wed, Jan 23, 2019 at 11:54:58AM +0100, Christian Brauner wrote:
>> On Thu, Jan 17, 2019 at 12:48:54PM +0100, Christian Brauner wrote:
>>> This adds the promised selftest for binderfs. It will verify the following
>>> things:
>>> - binderfs mounting works
>>> - binder device allocation works
>>> - performing a binder ioctl() request through a binderfs device works
>>> - binder device removal works
>>> - binder-control removal fails
>>> - binderfs unmounting works
>>>
>>> The tests are performed both privileged and unprivileged. The latter
>>> verifies that binderfs behaves correctly in user namespaces.
>>>
>>> Cc: Todd Kjos <tkjos@google.com>
>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>
>> Hey Shuah,
>>
>> If you're ok with the patch in its current form, can you please make
>> sure that this still lands in 5.0? If at all possible I'd like to have
>> all ducks in a row and release binderfs with selftests and everything.
>> :)
> 

The patch is good and I was planning to get this into 5.1.

> I can take it in my tree with the other binderfs patches if I can get an
> ack from Shuah.
> 

Great. It is good for the test patch to go with the other binderfs
patches.

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah

