Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78963C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BF620645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMcS4a82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BF620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeIJLjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeIJLjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:39:23 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13C3206BB;
        Mon, 10 Sep 2018 06:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536562013;
        bh=GVl4+/sNvLHGrOCpUCHNIWRQp95ZKs8aAOvG/zdfC84=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=mMcS4a828/eRdeuxRMGoq5z53lYnWuufK4Dgdy4Xp8kH71lotZCp/mF6Zh0e6Y4bV
         8PNPRzyEhOuaNhTZ8LUlmpAL4wuYagBHj3gJzw5vf/lOWeDyCuHNRvV6/jfTCTN91q
         qjKq4I869SQN6obVQZzuuca79WtdXdC/TCow74uU=
Received: by mail-wr1-f50.google.com with SMTP id n2-v6so20599218wrw.7;
        Sun, 09 Sep 2018 23:46:52 -0700 (PDT)
X-Gm-Message-State: APzg51BIvgLMXzvgZ+zqlD6z4E/30KeM8H3daM5tx4TNbZGac07znF50
        WJMZQ8Mi+R+0PZRkmudrmNHxXtAjyhHYG6aBeGI=
X-Google-Smtp-Source: ANB0Vdb/gIu8Y2m1xuui0VElP+YVtDQ9BZWkcbDOnQ/yZ6BTBQtLFT3/7V/44b0vjwMa3OnXqOi3Xz8X7ilfZ/EhBAE=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr12705723wrp.184.1536562011214;
 Sun, 09 Sep 2018 23:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPc49jh8RCDvn2Meci9iDcnnwGEHo6F7RuhkXpen=f_E8w@mail.gmail.com>
 <CAJKOXPfc5O0c6HBtM=h2NUXwaiCWVgFC9eVeirLYynfUpU6d3Q@mail.gmail.com>
In-Reply-To: <CAJKOXPfc5O0c6HBtM=h2NUXwaiCWVgFC9eVeirLYynfUpU6d3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 10 Sep 2018 08:46:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdTigJ7DZO3CiHM=zrWqb9MebNmbpbeJB5w0UDWS9FbqA@mail.gmail.com>
Message-ID: <CAJKOXPdTigJ7DZO3CiHM=zrWqb9MebNmbpbeJB5w0UDWS9FbqA@mail.gmail.com>
Subject: Re: [BUG BISECT] NFS root failure (NULL pointer)
To:     dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 at 08:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 6 Sep 2018 at 09:10, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hi,
> >
> > Today's next fails to mount NFS root under my ARM targets and fails to
> > mount root from file image under QMU.
> >
> > [ 21.512866] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
> > [ 21.695484] [<c03bcc04>] (nfs_fs_mount) from [<c02cf6a4>]
> > (legacy_get_tree+0x34/0xec)
> > [ 21.703225] [<c02cf6a4>] (legacy_get_tree) from [<c029442c>]
> > (vfs_get_tree+0x64/0x180)
> > [ 21.711119] [<c029442c>] (vfs_get_tree) from [<c02b9140>]
> > (do_mount+0x21c/0x958)
> > [ 21.718478] [<c02b9140>] (do_mount) from [<c02b9c38>] (ksys_mount+0x8c/0xbc)
> > [ 21.725513] [<c02b9c38>] (ksys_mount) from [<c0101000>]
> > (ret_fast_syscall+0x0/0x28)
> >
> > Full log from ARM (NFS root):
> > https://krzk.eu/#/builders/25/builds/750/steps/12/logs/serial0
> >
> > The NFS root failure bisected to:
> > bae551929c5433bd56ec4dcb97c7d4a50153d357 is the first bad commit
> > commit bae551929c5433bd56ec4dcb97c7d4a50153d357
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Tue Jul 10 21:43:37 2018 +0100
>
> FYI, the bug is still present in linux-next. All boards fail to boot up.
>
> Let me know if I can help anymore in debugging this.

Hm, my mistake. Today's next boots up fine. Seems fixed. Thanks!

Best regards,
Krzysztof
