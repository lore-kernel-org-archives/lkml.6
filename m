Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF9CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0FD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fn6xUZwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0FD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeKFS5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:57:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34984 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbeKFS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:57:53 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so10595498itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LS3VgS399YjVSBtEaN4z6eXZYGLCroDqDOQ0mDqlM2Y=;
        b=fn6xUZwDFN1Y7zQBrVcAVIeCfLzEvUil03V59M33yB3znyuPpNvxuohjAWNjfZMUop
         P+f5ulxJAxq2/tOgRdfeCT0xdGjgpB8j9mQfWjuR09+Tvfw4eIzDSc8y2v5dMvnmiuZg
         RTxjhSimRqc5JDdm1k5fXXwZDZ0hPqG0TQIfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LS3VgS399YjVSBtEaN4z6eXZYGLCroDqDOQ0mDqlM2Y=;
        b=onilh/GFIQsucVo3JJ+wkoDVU+apfRf/NXSFo+ulDrBPnxRTC8jfHOe7nRRr9+pHVw
         5qw5fnOEYjpcZxYWbtMWKzYdh0AaO8A/0u/h/vrocq3sZTr8iSmaR2nGC4KmQzOln4FO
         w9D1g60HcTycfMoB2E+zBHQPS1ZhKGwtXrIb9xOMkzl9BqVpMNYQ/e/iuYNmBFH8Q3Nu
         rPgTPbAusUYX2uDNDiMX83b28pSiGN1Z32PBXjSsmVPOyokqBnL9uKgUg5V05yTDLCPh
         9iZNbAB7XJ3N9684wynysraPt4kVu2h9Sd84JMARBNHyRoFuJlbswK0t8J9VpNQdrqEz
         3MCQ==
X-Gm-Message-State: AGRZ1gIHOTh8vhHZEg66lT9uaTjhcCr2pxdbeModKucrc1MNl8yMNfRy
        pb1NRhFHaKMNZnlKkS50Pem8UgF6t0Uf1VAUcfca7w==
X-Google-Smtp-Source: AJdET5clSK7YpCOVsgPFLpu7cSHRDz8PxF3mrCxZpXzOuBjQjeGMcK+g/A6ThEX0rkB13m6WHqkNaCVdIyITGzUmWGo=
X-Received: by 2002:a24:fe88:: with SMTP id w130-v6mr1244258ith.69.1541496812272;
 Tue, 06 Nov 2018 01:33:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 01:33:31 -0800 (PST)
X-Originating-IP: [94.21.144.184]
In-Reply-To: <b3162ccb-f6d8-b0d4-5cfe-313e89c49a1d@virtuozzo.com>
References: <154149557692.17196.12607896696117775780.stgit@localhost.localdomain>
 <CAJfpegtMmrvnZE3xtMDNTmF=pSmqFROtehamivbLeAh2E_qZ6Q@mail.gmail.com> <b3162ccb-f6d8-b0d4-5cfe-313e89c49a1d@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Nov 2018 10:33:31 +0100
Message-ID: <CAJfpegs+kbFqChz0wKEW+nDBH=M+S+UsDW1w7hyvj3yLmHnuWw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Put leaked request on error path of fuse_retrieve()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:25 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 06.11.2018 12:23, Miklos Szeredi wrote:
>> On Tue, Nov 6, 2018 at 10:13 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>> fuse_request_send_notify_reply() may fail, and this case
>>> it remains leaked (fuse_retrieve_end(), which is called
>>> on error path, does not do that). Also, fc->num_waiting,
>>> will never be decremented, and fuse_wait_aborted() will
>>> never finish. So, put the request patently.
>>>
>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> Posted same patch yesterday for a syzbot report.   How did you notice this?
>
> I've found this by code review. I did this last week and I have 10 patches more
> on different theme. I was waiting for when the merge window opens.

Well, the merge window just closed.  But never worry, bugfixes can go
in at anytime.

If you notice a bug, such as this, you don't need to hold back until
any particular time, the sooner it's known, the better.

Thanks,
Miklos
