Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9885C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B929206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=postn.eu header.i=@postn.eu header.b="vV0yYqsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfANAiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:38:50 -0500
Received: from postn.eu ([84.200.50.9]:55452 "EHLO postn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfANAit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:38:49 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Jan 2019 19:38:48 EST
Received: from [127.0.0.123] (cloakedhost.private [127.0.0.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by postn.eu (Postfix) with ESMTPSA id 683695FD60;
        Mon, 14 Jan 2019 01:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postn.eu; s=mail;
        t=1547426010; bh=SnEYPrWgZxECJmdZn1G/xduJdCguGJTtiy5Ucx1R+R8=;
        h=Subject:From:To:References:Cc:Date:In-Reply-To:From;
        b=vV0yYqsCrYoBwht7BVdJ6zkfAk8DuSbajxslgdgtbEiW1mIcmyq6lNepyaQ8UcaAW
         jNgFwaelZX6aUgKsDwbuM8LuNFiihLKjFDuJx3FrrwR/XZ9iYdnqBRC9R/sBJ2FYTO
         H+k75wYhvhzfSOTo65LfgCeBh7L1TPpMYNGcS780=
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
From:   Kevin Weidemann <kwe-lnx@postn.eu>
To:     Jan Kara <jack@suse.cz>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
Openpgp: preference=signencrypt
Cc:     linux-kernel@vger.kernel.org
Message-ID: <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
Date:   Mon, 14 Jan 2019 01:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is RE the patch 8515b9edf7a0c9dcf1ad218ccc783700db217336 (Upstream commit a9ad01bc759df79b0012f43ee52164391e31cd96) in 4.18.20.

I have an issue with UDF. I used to be able to create a UDF fs in a way that is very similar to this:

`# mkudffs --label=.... -m dvd -b 512 /dev/mapper/cryptdev1`

I used to proceed mounting it, noticing it got mounted as readonly (because the accesstype of the udf fs is readonly (as decided per -m dvd)), so I remounted it as rw and then was able to fill it with data.[1]

Now, this doesn't work anymore since the last time I did that. I figured out it must have to do with the commit mentioned above.
All I get now, during a remount-as-rw attempt, is:
`cannot remount /dev/mapper/cryptdev1 read-write, is write-protected`.

I am not sure if this counts as a regression, because I see the point in not only auto-mounting such filesystems as readonly, but also preventing remounting as rw, however it breaks my use case.

However, I noticed the following, too:
case A) when having a "readonly udf" on a readwrite device, the filesystem mounts as readonly (old behavior) and also prevents remounting as rw (new behavior)
case B) when having a "readwrite udf" on a readonly device, the filesystem mounts as readwrite (!), but the writes end up being invisibly discarded

To me, B) sounds just like the kind of issue that the commit, that I mentioned above, promised to fix.

In fact, I believe case B to be more severe, because it automatically mounts as rw on a ro device, while the old (pre-patch) behavior of case A correctly mounted as ro and required manual remounting intervention to mount as rw on (potentially) rw - and even then, it's still less of an issue, when the underlying device is writeable.

I feel like the correct solution would be to:
- disallow mounting as rw if the UDF is ro
- disallow mounting as rw if the device is ro
- disallow remounting as rw if the device is ro

As for the case of remounting as rw if the UDF is ro but the device is rw, I am not sure what the best idea is to deal with this.
If this new behavior doesn't count as a regression, is there any way to end up with a UDF filesystem as specced by the command above (-m dvd -b 512, so with it being read-only), but still allow for mounting it as rw if the device supports it? Does udftools offer a way to manipulate the UDF partition descriptor flag in a pre-existing filesystem after it had already been created that I am missing?


[1] sanity check: people actually do this:
- https://unix.stackexchange.com/a/17613
- https://www.g-loaded.eu/2005/11/10/packet-writing-on-cdrw-and-dvdrw-media/
- https://www.altlinux.org/WritingLargeFilesOnDVD
- https://computador.docow.com/como-usair-dvd-rw-udf-tanto-no-windows-quanto-no-linux.html (case 4)

--
Kind regards,
Kevin Weidemann

