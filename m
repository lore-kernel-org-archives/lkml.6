Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEAC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20712148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545944500;
	bh=mLotmiNr6dIUJ6upszcjdJYgFHeM4EDlFxzf/om2+sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HuS8+w6UlbLYSrI4zO4uyRa2sVmWojYgqBZcehdgiPIgSJLpUvdH83sBDqQwRQWBG
	 xlMwkExDuh9tuwROtsw3zC6lwcMjjMygbKbbip8jJdGNR8XDRfeK47os32iCw6/zK2
	 RrEOddvt7c6wWSgY/Ra31QGA1n/lsWi8HwIDJ42E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeL0VBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbeL0VBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:01:38 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C2D2148D;
        Thu, 27 Dec 2018 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545944498;
        bh=mLotmiNr6dIUJ6upszcjdJYgFHeM4EDlFxzf/om2+sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgeXbZLgQiQXi3w8Hov71OAufXRXr0b7syJFG1eYIAwuiB9KNDKeVuzCD6I2OtTwE
         tD6/YcvppgAOMxzmAQYGWEgHP/1TNEPHuFzZrtvpTQN+rNV9iZ2I2pnGrcR3iw4OfM
         RedU+uMGdJYy684wTbHTmPr3hUcR5EC8e2GRLEeE=
Date:   Thu, 27 Dec 2018 16:01:36 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        stable@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 4.19.5 and later has tons of false messages "BUG: non-zero
 pgtables_bytes on freeing mm: -16384"
Message-ID: <20181227210136.GV86645@sasha-vm>
References: <4e58571e-1991-4a70-7012-ff9dd76afee3@de.ibm.com>
 <1d6288dd-a65b-463a-8aeb-33904dafa9cc@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1d6288dd-a65b-463a-8aeb-33904dafa9cc@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 10:28:56AM +0100, Christian Borntraeger wrote:
>
>
>On 27.12.2018 10:13, Christian Borntraeger wrote:
>> Martin,
>>
>> Right now you get a message
>> "BUG: non-zero pgtables_bytes on freeing mm: -16384"
>> for EVERY process that exits in 4.19.5 and later.
>>
>> bisect points to
>> commit 4136161d676a93fc8df6bdb80d720c15522d6c24
>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Date:   Mon Oct 15 11:09:16 2018 +0200
>>
>>     s390/mm: fix mis-accounting of pgtable_bytes
>>
>>     [ Upstream commit e12e4044aede97974f2222eb7f0ed726a5179a32 ]
>>
>> Turns out that this patch requires several dependencies so the autoselection of this
>> patch was missing that.
>>
>> Can we either revert this patch or add the dependencies?
>>
>> Christian
>>
>
>It seems that adding
>
>commit 6d212db11947ae5464e4717536ed9faf61c01e86 ("mm: add mm_pxd_folded checks to pgtable_bytes accounting functions")
>fixes the issue.

I've queued 6d212db11947 for 4.19 for now, thank you.

--
Thanks,
Sasha
