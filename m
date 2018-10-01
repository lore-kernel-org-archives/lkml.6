Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F5FC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D286C2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IrvMAwu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D286C2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeJAQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:02:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32816 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbeJAQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:02:33 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so8852812ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b143ZQiP+DIxMDp1sBV+3LZK4i+kPJwYRbOJFGnM3M8=;
        b=IrvMAwu5uy/WtnIJpxUa6408YegSi9UqW13kgQW1T88Y1m5UaoREGk9uMimZZdEWES
         AhBLx+wk2o4v5UBmmLcoDgZ8geSHptTmdLzhuLOn6bKgsaR70/zlWULb/zMzpdiL7xgV
         QHEgPwc+sw/eYdPUouLJQdgin1O8DtkyCFeFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b143ZQiP+DIxMDp1sBV+3LZK4i+kPJwYRbOJFGnM3M8=;
        b=GEzwEnjnLkGDM0kmyO+b6kS8C5B9oz7cmWTWWcdN7m67iLckOU9Fu1A9/HwmL1Ntjb
         Lt7SQpZ23qZmYFNz1ql0QKmWGb4DGmn0a37gaCI+o97OKPyJLEXtppLJgg6lfaqe+FI9
         FAw0gU0/qgvhFW64h5oUAMHRQcnZu5thSMK4jeqiydyl4M5rGzS1Vqsx7ODSVe3BVmsV
         SWVVOQAe/QzB0BJ8Dmmei6bUwWl6PvOQciNME+JSENHb+tm0rvahaYErPUIV6rXDTovU
         ZLr9m9pdNdBhMsVd0gnX0+v8g5dnG0Zi3/xqzJFBIBdDjqEC5wIcHCg7+dMeUd7vYWpm
         8lSw==
X-Gm-Message-State: ABuFfohw7VbWLwCZdL7PrTBY+TSTIS8BLMBmPUiKWqE8v7IhyOrIcxNo
        NjbJ6vF87FW8Uf/dRiDL537SxdBgxwsVv9Hd61aUU3nE
X-Google-Smtp-Source: ACcGV61aCpH4Cz3sTMQfxJKNHNBwruLqqmQgHpUk1cw9J1XTbChlWfWd1ysNjJXwxpU0uSNE8IKtvN43ICYG5zLh5d0=
X-Received: by 2002:a6b:fe09:: with SMTP id x9-v6mr6063659ioh.294.1538385943104;
 Mon, 01 Oct 2018 02:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:25:42 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <153786771676.20496.9149001582398031266.stgit@localhost.localdomain>
References: <153786771676.20496.9149001582398031266.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Oct 2018 11:25:42 +0200
Message-ID: <CAJfpegugvGFMYHCCTewcFe67XwVgRQrXnnucGZg=W+uqnj93=Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix use-after-free in fuse_dev_do_read()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:28 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> We may pick freed req in this way:
>
> [cpu0]                                              [cpu1]
> fuse_dev_do_read()                                  fuse_dev_do_write()
>    list_move_tail(&req->list, &fpq->processing);      ...
>    spin_unlock(&fpq->lock);                           ...
>    ...                                                request_end(fc, req);
>    ...                                                  fuse_put_request(fc, req);
>    if (test_bit(FR_INTERRUPTED, &req->flags))
>          queue_interrupt(fiq, req);
>
> Fix that by keeping req alive till we finish all manipulations.
>
> Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Applied.

Thanks,
Miklos
