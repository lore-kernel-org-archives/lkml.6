Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD599C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69120675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="olpdrQ43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfAOQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:36:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33812 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbfAOQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:46 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so1481868itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld3FJqveh+3j6+uH55ub7TfDDCfe/MQxZuZvzp/WU8Q=;
        b=olpdrQ43g7BH+YnxzwO0QQj5u82FqslAuT0j+OsCcsazL0DNWVbfUIilpqhaM7CUJ7
         pV0Y1nNwF6PMy/1dvKkmJhbVkBSHdfAt/mtJNAI4xdkl1sZcwIZMyLGMuhxFAppTlz0l
         fTKCgibGh2m93MJTCNyakccko1/2lSFBfxLWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld3FJqveh+3j6+uH55ub7TfDDCfe/MQxZuZvzp/WU8Q=;
        b=QXLCruqjLS7TnaijHFJY7LKh8Wuml4kCXJJllyAdn3PRTABY65uFUXCrBhZK+j6BR2
         2ncfWDsd3leHzllgBmMT1f4SMq9MEIsvLPHBdBlzkOw+MnpXOkLtJMXwB/xbGtLiXoC4
         FKIHjgEd+9L8agVIgd2Q63Edv7Kxsm5V0SHdgrYIME4me6p7WN5Bf65KG/Pbm8FyYR+x
         /kVO7LE2qpV9qn1kHEwH1Zv2NSF9re0unmQ+Q8Sx6N7pK70BuyaExd1aoZp0c94eV2Pw
         qKUYaR1/pYrmIctomyvUxQVCwX3c6GKpdBpjuB5qphaw1Dl5MD6nJDKsZ5lCxmFVEiBP
         UsLw==
X-Gm-Message-State: AJcUukdZtxK7gy758kxSuzSVJG3xfoKOFjj42Tnr5Ha9dqaETmTPVEyE
        NzrZyHDXf/YlO3YX6NhjI0IuZHMB6Ct4FtecOy94kQ==
X-Google-Smtp-Source: ALg8bN5GZFiI/lPXXbQPPjtnwSlX4vG4XD+Q+RgnTX1DVZ7ugDXKmQYv4OvAmimtMTO/ZlLeY0bLjQ/diSUQoZ/9tNM=
X-Received: by 2002:a24:e38f:: with SMTP id d137mr2841548ith.69.1547570202473;
 Tue, 15 Jan 2019 08:36:42 -0800 (PST)
MIME-Version: 1.0
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <154322557765.18737.14337090699283695815.stgit@localhost.localdomain>
 <CAJfpegvKxJ06hfXR5yxWkdz0GzTw7vR2x8E5bjdO1df1J1C54w@mail.gmail.com> <30c6d750-01b1-fb7e-eb80-0f60f242974a@virtuozzo.com>
In-Reply-To: <30c6d750-01b1-fb7e-eb80-0f60f242974a@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Jan 2019 17:36:18 +0100
Message-ID: <CAJfpeguXy_Eebok9z_FCGvjGM8_qHHyTqsTMFeaJbmrW12kqYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Replace page without copying in fuse_writepage_in_flight()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:14 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 15.01.2019 18:39, Miklos Szeredi wrote:
> > On Mon, Nov 26, 2018 at 10:46 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> It looks like we can optimize old_req page replacement
> >> and avoid copying by simple updating the request's page.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> ---
> >>  fs/fuse/file.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index c6650c68b31a..83b54b082c86 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -1778,7 +1778,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
> >>         if (old_req->num_pages == 1 && old_req != first_req) {
> >>                 struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
> >>
> >> -               copy_highpage(old_req->pages[0], page);
> >> +               swap(old_req->pages[0], page);
> >
> > This would mess up refcounting for all pages involved.   need to swap
> > with the temp page in new_req.    Fixed version in #for-next.
>
> You are sure, page is just a simple pointer, not struct **page.
> Then we would have had to change fuse_writepage_in_flight() to use ** pointer.

Using a struct page** would still have been broken, not because of
refcounting, but because of putting the wrong page into the request
(we do the temporary copy to avoid some issues with adding the page
cache page directly into the request)

Thanks,
Miklos
