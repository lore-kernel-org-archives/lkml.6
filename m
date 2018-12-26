Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7E220882
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeLZUqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:46:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42190 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeLZUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:46:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so14668089lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwEJGMRqNGMT3lccYYP8q+ZfpQWlm3LN07XfR8UgqwI=;
        b=A5RW3UKuXO1ChkVDGd9qx/gTo/I7LkBORF61WvFmVZX64qhpVH3vBo//XbCXGDzrGk
         AX4/cPRzNzBZ89HaXHm/Q83IWesSFEf/6tT12z0YaBupFaMhq3rHk8kZ6yLqub9AmAWV
         NcNJ9WpTQq9/kFNl8BCir5JoREbSBS0zpmgyejabBK03y9J1PgIoCD9rXNCIJ7Qpee3A
         K4cyUX53oGBCIUXxT/2a02FJLMG+KP9MYPBSscS57U0uXiM3IRnKlCvldWMSFKL6V2JX
         3F4gl1FNtToAso1rlbDIqXjvmPnBf0q6uoTCghUsRRJMf08wSl9w5YpjPQ/FanrNfJ7T
         ZBzA==
X-Gm-Message-State: AJcUukdb3V/Jz874Rqd1zsp8cdEwDrXC+jo6C6lPcGXXKGcFm9xZqPGR
        VE9QegtbJPpzOYaxyquZy6qDMU5V7CamG2k2mWAxJYbTvLg=
X-Google-Smtp-Source: ALg8bN4uSzD1CAJzoyEdmNard2/Ol8Vou2YSsp/QM4KueT7ckRiwd2ngRoHSS2HBdPkpd+TzYp4VYd33oATTHDtS+ok=
X-Received: by 2002:a2e:2246:: with SMTP id i67-v6mr10342311lji.154.1545857160707;
 Wed, 26 Dec 2018 12:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20181216231510.26854-1-mcroce@redhat.com> <87zhsvi0jq.fsf@mail.parknet.co.jp>
In-Reply-To: <87zhsvi0jq.fsf@mail.parknet.co.jp>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 26 Dec 2018 21:45:24 +0100
Message-ID: <CAGnkfhz8pc9UO5Y3NHMFowcMAeNnF3QApvh0N0MhLgRP2Y95FA@mail.gmail.com>
Subject: Re: [PATCH v2] vfat: don't read garbage after last dirent
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Timothy Redaelli <tredaelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 1:14 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Matteo Croce <mcroce@redhat.com> writes:
>
> > The FAT32 File System Specification[1] states that:
> >
> >     If DIR_Name[0] == 0x00, then the directory entry is free, and there
> >     are no allocated directory entries after this one.
> >
> >     The special 0 value, indicates to FAT file system driver code that
> >     the rest of the entries in this directory do not need to be examined
> >     because they are all free.
> >
> > This is not enforced by Linux, and is possible to read garbage if not
> > all dirents after the last one are filled with zeroes.
> >
> > [1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
> >
> > Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> We have to handle all paths that is using fat_get_entry(), to make
> consistent behavior.
>
> With quick check, there are still several issues remaining. Please check
> more. For example, looks like fat_parse_long()/fat_search_long() path is
> missing, and fat_get_dotdot_entry(), fat_subdirs() too.
>

If I put the check in fat_get_short_entry(), then
fat_get_dotdot_entry() and fat_subdirs() are covered too.
Is there any drawback in doing this?

> (while adding new entry, if we found zeroed entry, we would be better to
> warn about fsck.)
>

Ok

> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks,
-- 
Matteo Croce
per aspera ad upstream
