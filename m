Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6339C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOcaQ2Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJ3AwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:52:24 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:45114 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeJ3AwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:52:24 -0400
Received: by mail-qt1-f171.google.com with SMTP id l9-v6so9791550qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=22zDYaBQAQTYUANz4bSW6gERVTj33l72WDZyoYh36PU=;
        b=BOcaQ2DhF6mDhIhAzD7HLM5Nnm2FFEHtei2KuWTX1s0CmpTXVadi3WLa730GTbovzS
         mwtM6uDqHrVi5ar8lL3im6AQxk94HR2f1ZtiQ+zGImrPPEWVmJ1ekX6XNrofA8FjdAvV
         aQItXO7XoUaojOzrMSlaw5WRzHgS6aUU7gLPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=22zDYaBQAQTYUANz4bSW6gERVTj33l72WDZyoYh36PU=;
        b=ib8GOQ5/u7DGCjY4UOqAhYUtichtAh6b59rGSZwIYDaSUnO1Zfwb8Y7Kde+o3F88+O
         ovzcGw6dWQK9H2no/ZvXOJdz+ZsLp7ReRvJwlhj/p2w7BMWbNgYx8vf9/hSg6cXhKBtV
         CCPS8z6XKnW34BGNkVPqBQ1ZQyUuDWSsb2kOzjEiGxS1u0NThZWpWF9dAGDgF7pOZJA2
         P0+gBsyo9K0S7h3ovLx6OYX8W/bQcMXq0jeSTwPAbC3OXH5FfXd6NzGX8Rry2Nyzow5D
         nqCgnnuidVn1DTVMdH5u3Cq4P8kSLJ0fOsOF//D3ruMc5Pc838Y9DfF/Gi8ig0YPNrOd
         xA5Q==
X-Gm-Message-State: AGRZ1gKu5FfWv5Qc7WHkAw35QD5RRejzEcADRnAnf5pIORowAgClrBA+
        aFNInWfENrIvErQDz9P1h1A0Tu36CsE=
X-Google-Smtp-Source: AJdET5cGpuvhN7uI4H00h1tjoiUDUv+klIIPdAWtAMVdEW+4c0SUlL2yraZcZx+JbQXmob/mVDGHag==
X-Received: by 2002:a05:6214:18e:: with SMTP id q14mr1247482qvr.173.1540828990622;
        Mon, 29 Oct 2018 09:03:10 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id h187sm12601374qke.46.2018.10.29.09.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 09:03:09 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:03:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: Cramfs: "unable to handle kernel paging request" when reading
 a file from a fuzzed FS image
In-Reply-To: <CAE5jQCeN6xsyUsi0RhyDobGqMXO5JA-LtFEV=E=gVZLXSo4Akw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810291150231.1498@knanqh.ubzr>
References: <CAE5jQCdhWVVqf8en9S-3mbDBwuxk481S+hi-uvQSw6Gf6jKujQ@mail.gmail.com> <nycvar.YSQ.7.76.1810282336440.1498@knanqh.ubzr> <CAE5jQCeN6xsyUsi0RhyDobGqMXO5JA-LtFEV=E=gVZLXSo4Akw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, Anatoly Trosinenko wrote:

> > How do I populate /vtmp? Mine is empty at this point. I imagine I 
> > should put the cramfs image somewhere on the host, but I'm not that 
> > familiar withkvm.
> 
> Oops, forgot to say, it is the /tmp/kvm-xfstests-$USER directory on 
> the host (it will be created when you first launch kvm-xfstests and it 
> is "live", i.e. like NFS, not like "pack to ext4 image then boot and 
> mount").

OK, I reproduced it. The fix is as follows:

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index f408994fc6..6e000392e4 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -202,7 +202,8 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 			continue;
 		blk_offset = (blocknr - buffer_blocknr[i]) << PAGE_SHIFT;
 		blk_offset += offset;
-		if (blk_offset + len > BUFFER_SIZE)
+		if (blk_offset > BUFFER_SIZE ||
+		    blk_offset + len > BUFFER_SIZE)
 			continue;
 		return read_buffers[i] + blk_offset;
 	}

User space will get a bunch of zeroes rather than an explicit error in 
this case. There is just so many ways to corrupt a cramfs image without 
detecting it afterwards that I don't think it is worth doing more than 
making sure the system won't be compromized.

> > Hmmm... It doesn't show up on my test system.
> 
> Mounted it on my host Ubuntu 18.10 amd64, executed `cat /mnt/xyz` and
> it was "Killed". Maybe it is something freshly added or
> arch-dependent...

It actually depends on whether there is something mapped immediately 
next to the cramfs cache buffer.

In any case, this is a nice catch. Thank you for reporting it.


Nicolas
