Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A63120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIKVvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:51:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKVvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:51:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E6927DAC2;
        Tue, 11 Sep 2018 16:51:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11ADC10073D6;
        Tue, 11 Sep 2018 16:51:28 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
References: <s5ha7ooxbps.wl-tiwai@suse.de>
        <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
        <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
        <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date:   Tue, 11 Sep 2018 12:51:27 -0400
In-Reply-To: <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk> (Jens Axboe's
        message of "Tue, 11 Sep 2018 10:49:05 -0600")
Message-ID: <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 16:51:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 16:51:28 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmoyer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 9/11/18 10:48 AM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
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
>> I'm guessing you just need to update the maximum number of policies:
>> 
>> /*
>>  * Maximum number of blkcg policies allowed to be registered concurrently.
>>  * Defined here to simplify include dependency.
>>  */
>> #define BLKCG_MAX_POLS          3
>
> That is my guess too, hence the suggestion to try and disable the
> iolatency policy. Just tried here without, and it works, rebooting
> with to verify that we're running out of policy slots.

Functions calling this function: blkcg_policy_register

  File                      Function       Line
0 block/bfq-iosched.c       bfq_init       5675 ret =
                                                blkcg_policy_register(&blkcg_pol
                                                icy_bfq);
1 block/blk-iolatency.c     iolatency_init  946 return
                                                blkcg_policy_register(&blkcg_pol
                                                icy_iolatency);
2 block/blk-throttle.c      throtl_init    2511 return
                                                blkcg_policy_register(&blkcg_pol
                                                icy_throtl);
3 block/cfq-iosched.c       cfq_init       4869 ret =
                                                blkcg_policy_register(&blkcg_pol
                                                icy_cfq);

And then there were 4...

-Jeff
