Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB94C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807B621780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9rslgN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807B621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeKPEd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:33:56 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35843 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:33:56 -0500
Received: by mail-yb1-f194.google.com with SMTP id g192-v6so8757235ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWGsYY2WBAue45wXSHggFPHaeGjGKdWGIkOcDsY+UOY=;
        b=T9rslgN2HwFUWbjSTY+ZqTYxgUQtofr4FviGU6KmUiH6kDl92awST4i7QEiXhtk9dJ
         hItPPXj/VgMD/5nMT5evd/QqbhdHxUOIvioCQ56ya099sxsTlSHjiuZlfIQKMMyk7chD
         DPq532u0HS+dv6cDtNYE3eA9txaSl8r0Iuf74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWGsYY2WBAue45wXSHggFPHaeGjGKdWGIkOcDsY+UOY=;
        b=HcioOvzxVtWrVtlGA7fdl990xlfDaoapZqyq0z6w4MMmKDT1lnjqYvEOXblTwBoYT8
         7cFcfh+3HGm6BZ1cnBQUmOFzzs4I0JoBFJXUN0aroOV8j02dxzSHcTrLDTnbAqZRpiZP
         Xqxh4v+kkw1eO4/UvaiPGj4CBJKSrjsFm3wyj5hNA20XBqsjMJHbDfjW+s/UkQBiilUv
         prYM30rdf28hKodONlwk540nBgYy7IOXAOlxGKylnRd451UGIBoSYCu/24nCUP4/kJlM
         A7RHJdyJCGo9lXN5iPJ1SQSfQfZDmHm74sn6OOhIOl5msoLFzUE/2CzW9e4iIBwIfcLv
         YPNA==
X-Gm-Message-State: AGRZ1gKJZwm/qJjSd0JP1M9uWow4vfLFt9LudUzM3PwECs8YVcfiK8/B
        XB3wLA4OTXQpEzxva9Xri7GIa4wo1ebEdA==
X-Google-Smtp-Source: AJdET5cwn+Be+SXSfy5TGNIzAZAcNSGj0UvaXf6IuZBZDnDrWC99FmSExjNZWwaDLtSv7ZFlzfSq/g==
X-Received: by 2002:a25:c695:: with SMTP id k143-v6mr6750908ybf.171.1542306301736;
        Thu, 15 Nov 2018 10:25:01 -0800 (PST)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id n66-v6sm1259232ywe.37.2018.11.15.10.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:25:00 -0800 (PST)
Received: by mail-yw1-f50.google.com with SMTP id h32so2975896ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:25:00 -0800 (PST)
X-Received: by 2002:a0d:e984:: with SMTP id s126-v6mr6879709ywe.47.1542306299729;
 Thu, 15 Nov 2018 10:24:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 10:24:58
 -0800 (PST)
In-Reply-To: <20181109151520.GD3645@cisco>
References: <20181102201822.12518-1-tycho@tycho.ws> <20181107222042.GA24927@redhat.com>
 <20181109151520.GD3645@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 15 Nov 2018 12:24:58 -0600
X-Gmail-Original-Message-ID: <CAGXu5jLEjLyp+nNd1f-m+NZa+KVW5DNC+kD2zqubddzAM7aVdA@mail.gmail.com>
Message-ID: <CAGXu5jLEjLyp+nNd1f-m+NZa+KVW5DNC+kD2zqubddzAM7aVdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dlm: fix various incorrect behaviors
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     David Teigland <teigland@redhat.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 9:15 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Wed, Nov 07, 2018 at 04:20:42PM -0600, David Teigland wrote:
>> On Fri, Nov 02, 2018 at 02:18:19PM -0600, Tycho Andersen wrote:
>> > Hi,
>> >
>> > here's a series to fix some bugs I noticed in the DLM. The third patch
>> > in the series and maybe the first should probably go to stable, assuming
>> > everyone agrees they're indeed bugs.
>> >
>> > Thanks,
>> >
>> > Tycho
>> >
>> > Tycho Andersen (3):
>> >   dlm: fix invalid free
>> >   dlm: don't allow zero length names
>> >   dlm: don't leak kernel pointer to userspace
>> >
>> >  fs/dlm/lockspace.c | 2 +-
>> >  fs/dlm/member.c    | 5 +++--
>> >  fs/dlm/user.c      | 2 +-
>> >  3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> I've pushed these to linux-dlm next.
>
> Great, thanks! Should we send 1 and 3 to stable?

Yes please! :)

-- 
Kees Cook
