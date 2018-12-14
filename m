Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66962080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66962080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeLNDlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:41:18 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42514 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNDlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:41:18 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 085F4161688;
        Fri, 14 Dec 2018 12:41:17 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE3fFnY019587
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 12:41:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE3fFTa018938
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 12:41:15 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBE3fFMT018937;
        Fri, 14 Dec 2018 12:41:15 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Timothy Redaelli <tredaelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat: don't read garbage after last dirent
References: <20181207013410.7050-1-mcroce@redhat.com>
Date:   Fri, 14 Dec 2018 12:41:15 +0900
In-Reply-To: <20181207013410.7050-1-mcroce@redhat.com> (Matteo Croce's message
        of "Fri, 7 Dec 2018 02:34:10 +0100")
Message-ID: <87lg4sdbc4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matteo Croce <mcroce@redhat.com> writes:

> The FAT32 File System Specification[1] states:
>
>     If DIR_Name[0] == 0x00, then the directory entry is free, and there
>     are no allocated directory entries after this one.
>
>     The special 0 value, indicates to FAT file system driver code that
>     the rest of the entries in this directory do notneed to be examined
>     because they are all free.
>
> This is not enforced by Linux, and is possible to read garbage if
> not all the dirents after the last one are filled with zeroes.
>
> [1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
>
> Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

I know this spec. But name[0] == 0 means - the rest of the entries in
this directory must be 0. Otherwise, overwriting zeroed entry by adding
new dir entry, then shows garbage as dir entry. So "stop at zero" is
just a optimization.

On other hand, I know there is buggy formatters don't clear that
garbage, and uses it on read-only storage area. 

So I will agree to supporting "stop at zero" though (and keep assuming
dir is initialized with zero clear. i.e. don't add tricky workaround to
support buggy formatters.), the implementation should handle it for
whole path, not only readdir().

E.g. I recall lookup, dir empty check path, and maybe there are others I
can't recall immediately.

>  get_new:
> -	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +	if (fat_get_entry(inode, &cpos, &bh, &de) == -1 || !de->name[0])
>  		goto end_of_dir;
>  parse_record:
>  	nr_slots = 0;

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
