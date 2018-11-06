Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB47C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C0D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeKFSuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:50:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:58920 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFSuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:50:07 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxcJ-0002tc-Vc; Tue, 06 Nov 2018 12:25:48 +0300
Subject: Re: [PATCH] fuse: Put leaked request on error path of fuse_retrieve()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <154149557692.17196.12607896696117775780.stgit@localhost.localdomain>
 <CAJfpegtMmrvnZE3xtMDNTmF=pSmqFROtehamivbLeAh2E_qZ6Q@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b3162ccb-f6d8-b0d4-5cfe-313e89c49a1d@virtuozzo.com>
Date:   Tue, 6 Nov 2018 12:25:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegtMmrvnZE3xtMDNTmF=pSmqFROtehamivbLeAh2E_qZ6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2018 12:23, Miklos Szeredi wrote:
> On Tue, Nov 6, 2018 at 10:13 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> fuse_request_send_notify_reply() may fail, and this case
>> it remains leaked (fuse_retrieve_end(), which is called
>> on error path, does not do that). Also, fc->num_waiting,
>> will never be decremented, and fuse_wait_aborted() will
>> never finish. So, put the request patently.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> Posted same patch yesterday for a syzbot report.   How did you notice this?

I've found this by code review. I did this last week and I have 10 patches more
on different theme. I was waiting for when the merge window opens.
 
> 
>> ---
>>  fs/fuse/dev.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index ae813e609932..6fe330cc9709 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1768,8 +1768,10 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
>>         req->in.args[1].size = total_len;
>>
>>         err = fuse_request_send_notify_reply(fc, req, outarg->notify_unique);
>> -       if (err)
>> +       if (err) {
>>                 fuse_retrieve_end(fc, req);
>> +               fuse_put_request(fc, req);
>> +       }
>>
>>         return err;
>>  }
>>
