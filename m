Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5410C2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jG524Guf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5410C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeJTBxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:53:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50981 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeJTBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:53:23 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so5244919ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IO1973WRgfLLNX1toZfekCZsGx6Fuh6uNEskmFyMtSY=;
        b=jG524GuflIHnWUI/34mATY28ajyjM9EOJDzsGi73wuT5GF0r14M8/XNNMjryITF0QZ
         nYjWHPPTD1ehXUfioEh5tFuj62F+rqvTZ6n3D/h1jwQZ3o14z1xzVLLPGThfISuSgBDh
         +LeERrn8RV7L3MzRCsJTL5vnqmTHCs3F+TL98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IO1973WRgfLLNX1toZfekCZsGx6Fuh6uNEskmFyMtSY=;
        b=cWdulKC5os+ik65/vZBfWiL82Zvy9lfUkcpIg2NC1nNvAYXpSPuXLjicHFl8mYNoSW
         TS3vUVKZpRK40fgDegoW9S1mlA1/hezt0JoGGs9Z1749ujBPaFeJD9g9jLtsQCiu7dG5
         EqHadz8NjWE16ACq4uEnka0pwCflVWxJS/0cDlMHggPsNUS3cyfa1gUfoSlF9thU+8A1
         Ap6mf5/uPrYhwoQo3NXO4Eubfb7mymHlmV+E9kFDtlTMjCWQKocW4N/s6OL3NJMi6fY4
         6BxUepIewRMi9Z8zwEstAwLcjdh8AzJtOEszPmbtq+cT8KT7GYmvQV1fMDbqDWKvQgW0
         xPmg==
X-Gm-Message-State: ABuFfoh59SfeGJaHOApCEY+tLMlXsPv+rHu3fbxJEEoad/mijAQlf3dM
        GCyIJgd63XkO2HL3EgU3cdB+HDgEpWjGR36jMCV5hw==
X-Google-Smtp-Source: ACcGV61GQOZUfh6LkIihSaWUF91ITxU6vIFGvGlge3UbkScPS+igA5HhZa1KnM3TG+uOfYV8ECWyHx6Q4Kv1iEQ77r4=
X-Received: by 2002:a24:75d6:: with SMTP id y205-v6mr3981082itc.1.1539971177009;
 Fri, 19 Oct 2018 10:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 10:46:16
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
References: <20181019122049.27121-1-mszeredi@redhat.com> <20181019122049.27121-5-mszeredi@redhat.com>
 <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Oct 2018 19:46:16 +0200
Message-ID: <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:52 PM, Trond Myklebust
<trondmy@hammerspace.com> wrote:
> On Fri, 2018-10-19 at 14:20 +0200, Miklos Szeredi wrote:
>> As per statx(2) man page only clear out flags that are unsupported by
>> the
>> fs or have an unrepresentable value.  Atime is supported by NFS as
>> long as
>> it's supported on the server.
>>
>> So the STATX_ATIME flag should not be cleared in the result_mask if
>> the
>> operation was requested on a MNT_NOATIME or MNT_NODIRATIME mount.
>>
>> This patch doesn't change the revalidation algorithm in any way, just
>> the
>> clearing of flags in stat->result_mask.
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> Fixes: 9ccee940bd5b ("Support statx() mask and query flags
>> parameters")
>> Cc: Trond Myklebust <trond.myklebust@primarydata.com>
>> ---
>>  fs/nfs/inode.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index b65aee481d13..34bb3e591709 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -811,7 +811,7 @@ int nfs_getattr(const struct path *path, struct
>> kstat *stat,
>>       if (!(request_mask &
>> (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
>>                                       STATX_MTIME|STATX_UID|STATX_GID
>> |
>>                                       STATX_SIZE|STATX_BLOCKS)))
>> -             goto out_no_revalidate;
>> +             goto out_no_update;
>>
>>       /* Check whether the cached attributes are stale */
>>       do_update |= force_sync || nfs_attribute_cache_expired(inode);
>> @@ -833,9 +833,6 @@ int nfs_getattr(const struct path *path, struct
>> kstat *stat,
>>                       goto out;
>>       } else
>>               nfs_readdirplus_parent_cache_hit(path->dentry);
>> -out_no_revalidate:
>> -     /* Only return attributes that were revalidated. */
>> -     stat->result_mask &= request_mask;
>>  out_no_update:
>>       generic_fillattr(inode, stat);
>>       stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
>
> NACK.
>
> When we don't revalidate the attribute, then the content of the field
> contains junk values. The above code is very intentional.

How is it then that only STATX_ATIME is cleared and not the other fields?

Note: junk != stale.  The statx definition doesn't talk about the
fields being up-to-date, except for AT_STATX_FORCE_SYNC, so stale
attributes are okay, and do not warrant clearing the result_mask.

Thanks,
Miklos
