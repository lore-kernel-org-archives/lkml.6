Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C50920894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLS9yHGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C50920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeGaBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:17:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45158 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeGaBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:17:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id j143-v6so9372689lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e6BZWb1k7n/t+az2o9anKHxJCyta5M9Ajf7sUPLRtE=;
        b=FLS9yHGhIp7n3ZuHqjlaHKYOnj7WKeU0cmnU1foAiEMu3JGkebJv8q7H99VerMbEuj
         Xia0NrKK2NRD4fZcobZK0zuTEW9vSFvSM0n+e94PjpPPBVgg8aSecGIIqg5h/xAwZOrr
         iWwbqC3vWqacz4VIyUg+FdyfakAlV0N0K9SpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e6BZWb1k7n/t+az2o9anKHxJCyta5M9Ajf7sUPLRtE=;
        b=Sqfpccihsgm3q5pyxWnElPSDaHvZpF9FCFG96dk+Uro3DVcLCOcwxv7FL0UxlUFZH2
         98Zbg6pTiFuz0vxyvy2dyTfEc9xjj8JYEDSqKHKo0e11HxZ6tCoweltgLu/fTp9SE8MQ
         fi1ExeD4JcGN99tqFoPJgAWQU6sIBLqZdOywerLmB1O02F61FvWtDFWSufHan+EtqI7h
         4YGrOQcI5U4oXH+oCVbpw5Fj6ziZu0jE7CTcTYpcK6VOTpTUOSPwACXpahHxhk0WI+Ei
         Wy2/+wyi+/pQOtGk91tK7HtDMw+QHsI/QdZgn2HDzLTRzADyEHsE0Ofy4IF2Wz2twt8c
         mJnQ==
X-Gm-Message-State: AOUpUlG8fCBo3swRjVGSE+OgWgxpxKZTt09K6QI/gsSZ3iKggmbgvO7Q
        JUl0Nj+MAgXrq4L/xrnagKFjYMPyzwc=
X-Google-Smtp-Source: AAOMgpeGdloOK3r0CaIOjq2neBl9aMwlryd9XU0UeuioMy08EFNdPaFwLG2k9hs/isgJX0XH5nPXWA==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr8969185lfh.125.1532994001621;
        Mon, 30 Jul 2018 16:40:01 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b14-v6sm1724371lfa.62.2018.07.30.16.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 16:40:00 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j143-v6so9372638lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 16:39:59 -0700 (PDT)
X-Received: by 2002:a19:cb44:: with SMTP id b65-v6mr11796574lfg.12.1532993999649;
 Mon, 30 Jul 2018 16:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
 <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org> <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
 <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com> <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
 <8e6af8ed-1ec0-f10e-69b2-08281b638a4b@codeaurora.org>
In-Reply-To: <8e6af8ed-1ec0-f10e-69b2-08281b638a4b@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 30 Jul 2018 16:39:22 -0700
X-Gmail-Original-Message-ID: <CAE=gft4S9_H-PgpUHVrmjq4uah8pGKH+4A9xph+L=yButpqEpA@mail.gmail.com>
Message-ID: <CAE=gft4S9_H-PgpUHVrmjq4uah8pGKH+4A9xph+L=yButpqEpA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs provisioning
To:     sayalil@codeaurora.org
Cc:     Bart.VanAssche@wdc.com, Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-kernel@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, cang@codeaurora.org,
        martin.petersen@oracle.com, subhashj@codeaurora.org,
        linux-scsi@vger.kernel.org, vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        jejb@linux.vnet.ibm.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:46 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>
> Hi Evan,
>
>
> On 7/18/2018 1:53 AM, Evan Green wrote:
...
> > I'm not dead set on binary, since as above I could do it either way,
> > but it seemed worth at least talking through. Let me know what you
> > think.
> > -Evan
>
> I am using ASCII format for reading/writing to config desc as it will be
> more readable for users and easier/comfortable to compare any value to
> default spec value(if required).
> So I don't really see any harm in using current ASCII format for
> provisioning purpose.

I'm not convinced by those arguments, but ultimately it's between you
and the maintainers. If you're going with the ASCII route, then I have
another review comment. Currently in your patch, if kstrtoint fails,
you print, but then break out of the loop and try to write the
partially parsed descriptor anyway. That "break" should probably be
changed to a "goto out".

-Evan
