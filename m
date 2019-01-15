Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3369220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfAOQOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:14:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:51454 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfAOQOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:14:43 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gjRMO-0004Af-Sc; Tue, 15 Jan 2019 19:14:41 +0300
Subject: Re: [PATCH 2/2] fuse: Replace page without copying in
 fuse_writepage_in_flight()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <154322557765.18737.14337090699283695815.stgit@localhost.localdomain>
 <CAJfpegvKxJ06hfXR5yxWkdz0GzTw7vR2x8E5bjdO1df1J1C54w@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <30c6d750-01b1-fb7e-eb80-0f60f242974a@virtuozzo.com>
Date:   Tue, 15 Jan 2019 19:14:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvKxJ06hfXR5yxWkdz0GzTw7vR2x8E5bjdO1df1J1C54w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.2019 18:39, Miklos Szeredi wrote:
> On Mon, Nov 26, 2018 at 10:46 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> It looks like we can optimize old_req page replacement
>> and avoid copying by simple updating the request's page.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/fuse/file.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index c6650c68b31a..83b54b082c86 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1778,7 +1778,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
>>         if (old_req->num_pages == 1 && old_req != first_req) {
>>                 struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
>>
>> -               copy_highpage(old_req->pages[0], page);
>> +               swap(old_req->pages[0], page);
> 
> This would mess up refcounting for all pages involved.   need to swap
> with the temp page in new_req.    Fixed version in #for-next.

You are sure, page is just a simple pointer, not struct **page.
Then we would have had to change fuse_writepage_in_flight() to use ** pointer.

Updated version looks good for me.

Thanks,
Kirill
