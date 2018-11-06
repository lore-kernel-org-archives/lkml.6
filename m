Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDACC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F5220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oIi9HXph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F5220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbeKFSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:47:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52004 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbeKFSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:47:47 -0500
Received: by mail-it1-f193.google.com with SMTP id h13so16897760itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rlRXtxyBTWqlbWk0rrvDcwsQSfNabCivduvMrSeh33Q=;
        b=oIi9HXphln/F0ZqV2xeDzeRKbXntqPXDvoFnxD5dLaxE9aRulBryf1ae3RhJqkm53l
         +9XvLDLfTgho1rjr90OulrOXTLHHRBmUQmmbhfDtC07iLuqckrCTjzTUCA6fA6ENhceV
         ogaGfmv8P/h2wIOUfgDI3Z+rm2DcbuKjaKuYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rlRXtxyBTWqlbWk0rrvDcwsQSfNabCivduvMrSeh33Q=;
        b=p4vyi9TZEpNcU6XBHxYe2viVAGu0+d/tDtJQnUGORYWxJYMTxydh4GVF+gp75NenGr
         C1+5pu7O1+e1GSBDDxP5yKH1n6SOQ3cM30hP3iiJRvEkzQdoKBcONK5DEyvSfsOTTHTP
         THbdYz4ewrk2xc0eVHxCbaLTqnMSS9u67Uvpfca2nmG7h0lP0C7QD7oR6W7KO7xTAzcA
         tVYDDz/uNdmZkzHh6mY5H6tnAD1gn/xsXwfCareo9aUoJjvGqoyUApKWRZGPPHSCQQGP
         PV/K/LLFM7WC+4sNXQcJuA/Cakj0wYiZhz67jeJay0itL3KEBhM5Cqmsur2cb13VFavo
         SSNw==
X-Gm-Message-State: AGRZ1gLsDbQ6LNqUhyTKryxf9kk3l40MQno4+V1+aBQema2ZuG6UGDtI
        43Q5T96IC1Y1YXyBHAiy+x0u77JGI5kRvzv0a9Y2Kg==
X-Google-Smtp-Source: AJdET5eXCIeBxNmNyMwwJjNHn9VrOSU7eip6yIMu8EvG23Gv2AmlZ/fbNToK5vihDp3rBdWAjNHiNIhq2LhylesmkP4=
X-Received: by 2002:a02:9951:: with SMTP id d17-v6mr22421065jak.78.1541496208782;
 Tue, 06 Nov 2018 01:23:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 01:23:28 -0800 (PST)
X-Originating-IP: [94.21.144.184]
In-Reply-To: <154149557692.17196.12607896696117775780.stgit@localhost.localdomain>
References: <154149557692.17196.12607896696117775780.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Nov 2018 10:23:28 +0100
Message-ID: <CAJfpegtMmrvnZE3xtMDNTmF=pSmqFROtehamivbLeAh2E_qZ6Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Put leaked request on error path of fuse_retrieve()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:13 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> fuse_request_send_notify_reply() may fail, and this case
> it remains leaked (fuse_retrieve_end(), which is called
> on error path, does not do that). Also, fc->num_waiting,
> will never be decremented, and fuse_wait_aborted() will
> never finish. So, put the request patently.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Posted same patch yesterday for a syzbot report.   How did you notice this?

Thanks,
Miklos


> ---
>  fs/fuse/dev.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index ae813e609932..6fe330cc9709 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1768,8 +1768,10 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
>         req->in.args[1].size = total_len;
>
>         err = fuse_request_send_notify_reply(fc, req, outarg->notify_unique);
> -       if (err)
> +       if (err) {
>                 fuse_retrieve_end(fc, req);
> +               fuse_put_request(fc, req);
> +       }
>
>         return err;
>  }
>
