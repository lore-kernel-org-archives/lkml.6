Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F380ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D534214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D534214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeIRCOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:14:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39395 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIRCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:14:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g20OT-0002Ce-4W; Mon, 17 Sep 2018 14:45:17 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g20OR-0004HG-Qt; Mon, 17 Sep 2018 14:45:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <20180914105310.6454-2-jlayton@kernel.org>
        <20180915160423.GA31461@redhat.com> <87o9cxv2wh.fsf@xmission.com>
        <20180917152424.GA25173@redhat.com>
Date:   Mon, 17 Sep 2018 22:45:09 +0200
In-Reply-To: <20180917152424.GA25173@redhat.com> (Oleg Nesterov's message of
        "Mon, 17 Sep 2018 17:24:24 +0200")
Message-ID: <87d0tbn99m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g20OR-0004HG-Qt;;;mid=<87d0tbn99m.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/W/7Q2oggmGeRygdT+pGu/tSABJRA1kj4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/3] exec: separate thread_count for files_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/16, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > As for binder.c, in this case we probably actually want to unshare ->files
>> > on exec so we can ignore it?
>>
>> Looking at the binder case it only captures ->files on mmap.  Exec
>> ditches the mmap.  So if the order of operations are correct than
>> the dropping of the old mm will also drop the count on files_struct
>> held by binder.
>>
>> So semantically binder should not effect locks on exec,
>
> Agreed, but it does.
>
> Before your "[PATCH 0/3] exec: Moving unshare_files_struct" unshare_files()
> is called before exec_mmap().
>
> And even with this series we can have another CLONE_VM process.
>
> Howver, I think this doesn't really matter. binder does __fd_install(files),
> so if it actually has a reference to execing_task->files, I think it should
> be unshared anyway.
>
>> In short as long as we get the oder of operations correct we should be
>> able to safely ignore binder, and not have binder affect the results of
>> this code.
>
> Agreed.

I may have spoken too soon.  Binder uses schedule_work to call
put_files_struct from munmap.  So the files->count may still be elevated
after the mm is put.  Ick.

Eric

