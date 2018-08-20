Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EDC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0792174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0792174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHUBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:41:04 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33052 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:41:03 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 914A615AF4C;
        Tue, 21 Aug 2018 07:23:37 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7KMNa40018476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Aug 2018 07:23:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7KMNaHL007600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Aug 2018 07:23:36 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w7KMNZcj007599;
        Tue, 21 Aug 2018 07:23:35 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup "fat: propagate 64-bit inode timestamps" patch
References: <87zhxkjyww.fsf@mail.parknet.co.jp>
        <CAK8P3a3SVi2odjavRy-ktzcU2sMREVc+8EKxmDq3cv2nGeTeCg@mail.gmail.com>
Date:   Tue, 21 Aug 2018 07:23:35 +0900
In-Reply-To: <CAK8P3a3SVi2odjavRy-ktzcU2sMREVc+8EKxmDq3cv2nGeTeCg@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 20 Aug 2018 14:39:09 +0200")
Message-ID: <87h8jo4qzc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

>>  /* Linear day numbers of the respective 1sts in non-leap years. */
>> -static time64_t days_in_year[] = {
>> +static long days_in_year[] = {
>>         /* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
>>         0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
>>  };
>
> While this is correct, changing it back to a signed 'long' type seems
> rather arbitrary. I tried to pick a type that would be the same on 32-bit
> and 64-bit architectures, the other choice would have been 'u16',
> which saves a few bytes.

Right. However, "long long" on 32bit arch is not same. In this implement
"long long" works though, Some calculation needs libgcc helper (in
kernel, div64 stuff).  I want to avoid it early than later, and I don't
care saving a few memory in here (I would not care if it was u16).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
