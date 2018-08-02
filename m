Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F15C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA38721581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA38721581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=torlan.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeHBXZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:25:23 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:50565 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbeHBXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:25:22 -0400
Received: from mxback13g.mail.yandex.net (mxback13g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:92])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 588D1186079;
        Fri,  3 Aug 2018 00:32:22 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback13g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id cJsTVhmsOi-WL1SrXlm;
        Fri, 03 Aug 2018 00:32:22 +0300
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id F6RQvjLbN1-WLOaOZJt;
        Fri, 03 Aug 2018 00:32:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
From:   WGH <wgh@torlan.ru>
Openpgp: preference=signencrypt
Message-ID: <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
Date:   Fri, 3 Aug 2018 00:32:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 09:32 PM, Linus Torvalds wrote:
> WGH (sorry, no idea what your real name is) - what's the source of the
> script that broke? Was it some system script you got from outside and
> likely to affect others too?
>
> Or was it just some local thing you wrote yourself and was
> unintentionally buggy and nobody else is likely to hit this?
>
> Because if the latter, if you can work around it and you're the only
> user this hits, we might just be able to ignore it.

The script in question is written by me and contains literally two lines:

    lvcreate --size 5G --snapshot --name snap0 --permission r
/dev/mapper/vg0-lvol_rootfs
    mount /dev/mapper/vg0-snap0 /mnt/rootfs_snapshot

The script is not buggy (I think), it was written under simple
assumption that --permission r works. And it does - unless you happen to
have combination of kernel >=4.16 and lvm2 <2.02.178.

The commit in question appeared only in 4.16, and this kernel version is
not widespread yet. You have to be running both recent kernel and
not-so-recent lvm2 to be bitten by this. This probably explains why no
one else reported this problem.

Workaround certainly exists: I can just create read-write snapshot, but
mount it read-only. The reason why I didn't discover the workaround
earlier is that after unsuccessful read-only snapshot creation system
ends up in some weird state where read-write snapshots are also failing
with the same error (until reboot). So I got a wrong impression that
read-write snapshots were broken as well.

