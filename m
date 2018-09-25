Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB22DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6658520833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idd4Qr5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6658520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeIZAt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:49:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39142 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeIZAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:49:59 -0400
Received: by mail-ua1-f67.google.com with SMTP id g18-v6so9909507uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bdjn0ilFzbBA2ZmddrPOxNyop81GQOgK/YiRVpxksU=;
        b=idd4Qr5iHlFpznVFf8+SA9O2w5kZiBZDsdZ2T/7uIKa8lbJqEkL/Zu2o0+DETcnHcz
         +fypfIUVADGYus4LJNlgc1qb7d8sJoN59mGOoFgyzjSQTump9eWFKu0rHBAzsNBc80g4
         NpIlH8acnc+68dpaHq+ZO6StWUuIGqN9hWOHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bdjn0ilFzbBA2ZmddrPOxNyop81GQOgK/YiRVpxksU=;
        b=PIOV/+6KojH4idxc8dASLYl2mbpikuaSAx2ve4H5UgstYSWQpH6fferHnrhq2ctmls
         C95JBP5RtY882IdK5Gxl+lQLgqpLyr5YR42Cv4CbqSiRyYS75WSm6EezOMksQII5Msvm
         2v277LkQ5PAQ0E+KpugX0PJ/KGYC6rTlMenDu3QpUOc7kLbDmJcfvIm4ogy7egm7eZyx
         bScfibXL27NHSVr24r6+FM9CxHN3iZEwd221QEOuAMNi0EwCcSyl38bbdtXFCsRGKHAW
         tvz9NU5o7rV75QSrgqVXwd2zfYcDaZA1890lOxRd95MVnsli30RpJUHMmVc/mgl509Ow
         oRhQ==
X-Gm-Message-State: ABuFfoi+LMsQTL5L++fKmXOx5PzMGH6Sxj+LHtwgQLR2mItnvNgc1wyC
        5POtp43QXRmK5ohN+8m0Obwuhfv0MAI=
X-Google-Smtp-Source: ACcGV60cWbORmi+lnsvwFGCPxun6ds56OBFDQGZuoYZ+m9fTnyQbe9I9ThwWgeFWBq37DlIqOufZfw==
X-Received: by 2002:ab0:16dc:: with SMTP id g28-v6mr771625uaf.7.1537900867587;
        Tue, 25 Sep 2018 11:41:07 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id l13-v6sm17951uao.15.2018.09.25.11.41.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:41:06 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id z4-v6so2456786uan.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:41:06 -0700 (PDT)
X-Received: by 2002:ab0:274a:: with SMTP id c10-v6mr774635uap.25.1537900866132;
 Tue, 25 Sep 2018 11:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180808224454.243790-1-evgreen@chromium.org> <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com>
In-Reply-To: <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 11:40:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
Message-ID: <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Evan Green <evgreen@chromium.org>, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, stanislav.nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bart.VanAssche@wdc.com, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 4, 2018 at 3:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 22/08/18 14:00, Adrian Hunter wrote:
> > On 09/08/18 01:44, Evan Green wrote:
> >> This change makes the UFS controller's sysfs attributes writable, which
> >> will enable users to provision unprovisioned UFS devices, or
> >> re-provision unlocked UFS devices.
> >>
> >> Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> This patch has my Ack and Reviewed-by: Stanislav Nijnikov, so can it be
> queued for v4.20?  There is also Evan's "[PATCH] scsi: ufs: Make sysfs flags
> writable"

Ping?

I came across this patch and Evan's other one and noticed that they
haven't been applied though a batch of other SCSI patches for 4.20
were applied about a week ago.  Martin: is there something about these
patches that needs to change before they can land?

We're about to land the two patches into the Chrome OS kernel tree
which will remove any built-in reminders we'll have to keep track of
upstream progress, so this is probably the final ping from this end
until the next major Chrome OS kernel rebase.  ;-)

-Doug
