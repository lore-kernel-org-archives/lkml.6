Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeDRMqQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:46:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43954 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeDRMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:46:02 -0400
X-Google-Smtp-Source: AIpwx48DyXjsvY9pA1gjISiQvDjxzcsUTArUgRk3J69cedDL8s3rNaahYIkUnsoOF+gzwNO5I69EEg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <201804181718167747438@zte.com.cn>
Date: Wed, 18 Apr 2018 14:45:57 +0200
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org
Message-Id: <F9E297E7-9937-41D8-94E9-D3A9B871D1AA@linaro.org>
References: <1523949033-91148-1-git-send-email-jiang.biao2@zte.com.cn,661CB1A2-5BAC-439D-BCE2-64F9A0CD280E@linaro.org>
 <201804181718167747438@zte.com.cn>
To: jiang.biao2@zte.com.cn
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3ICkQ1Y029245



> Il giorno 18 apr 2018, alle ore 11:18, jiang.biao2@zte.com.cn ha scritto:
> 
> Hi,
>>> Il giorno 17 apr 2018, alle ore 09:10, Jiang Biao <jiang.biao2@zte.com.cn> ha scritto:
>>> 
>>> As described in the comment of blkcg_activate_policy(),
>>> *Update of each blkg is protected by both queue and blkcg locks so
>>> that holding either lock and testing blkcg_policy_enabled() is
>>> always enough for dereferencing policy data.*
>>> with queue lock held, there is no need to hold blkcg lock in
>>> blkcg_deactivate_policy(). Similar case is in
>>> blkcg_activate_policy(), which has removed holding of blkcg lock in
>>> commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.
>>> 
>> 
>> Hi,
>> by chance, did you check whether this may cause problems with bfq,
>> being the latter not protected by the queue lock as cfq?
> Checked the bfq code, bfq seems never used blkcg lock derectly, and 
> update of blkg in the common code is protected by both queue and 
> blkcg locks, so IMHO this patch would not introduce any new problem
> with bfq, even though bfq is not protected by queue lock.

Thank you very much for checking. Then:

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo

> On the other hand, the locks (queue lock/blkcg lock) used to protected
> the update of blkg seems a bit too heavyweight, especially the queue lock 
> which is used too widely may cause races with other contexts. I wonder
> if there is any way to ease the case? e.g. add a new lock for blkg's own.:) 
> 
> Jiang,
> Regards
