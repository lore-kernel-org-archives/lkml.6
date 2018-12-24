Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2778C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C379021908
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbeLXMOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:14:53 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59388 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:14:53 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 6588F12B609;
        Mon, 24 Dec 2018 21:14:51 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBOCEofE009655
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 21:14:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBOCEne6029174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 21:14:50 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBOCEn7w029173;
        Mon, 24 Dec 2018 21:14:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Timothy Redaelli <tredaelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfat: don't read garbage after last dirent
References: <20181216231510.26854-1-mcroce@redhat.com>
Date:   Mon, 24 Dec 2018 21:14:49 +0900
In-Reply-To: <20181216231510.26854-1-mcroce@redhat.com> (Matteo Croce's
        message of "Mon, 17 Dec 2018 00:15:10 +0100")
Message-ID: <87zhsvi0jq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matteo Croce <mcroce@redhat.com> writes:

> The FAT32 File System Specification[1] states that:
>
>     If DIR_Name[0] == 0x00, then the directory entry is free, and there
>     are no allocated directory entries after this one.
>
>     The special 0 value, indicates to FAT file system driver code that
>     the rest of the entries in this directory do not need to be examined
>     because they are all free.
>
> This is not enforced by Linux, and is possible to read garbage if not
> all dirents after the last one are filled with zeroes.
>
> [1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
>
> Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

We have to handle all paths that is using fat_get_entry(), to make
consistent behavior.

With quick check, there are still several issues remaining. Please check
more. For example, looks like fat_parse_long()/fat_search_long() path is
missing, and fat_get_dotdot_entry(), fat_subdirs() too.

(while adding new entry, if we found zeroed entry, we would be better to
warn about fsck.)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
