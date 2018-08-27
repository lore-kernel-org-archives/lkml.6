Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44286C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E697421722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgptUWcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E697421722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeH0G44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:56:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41976 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeH0G44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:56:56 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so11711079iob.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=314VfoTDKwrBprzTKAsKNAhUC2hj6gFDlxIyDvFDwC8=;
        b=DgptUWcsmC0J7mKuV/d3CrV+bfA88Y8++41BLUEF4hkQeCoAJh92ylfZPlHRmFZO1r
         TmkWQnJG9mJJ2IWg5U7uekIYrIq/5lmBYBWaoD0rvq88ifNOru1VIDJ+7YOOTeES3IRs
         Jy5dK6AR048jUNlidsyI6Bowyy6ePeeXc7l6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=314VfoTDKwrBprzTKAsKNAhUC2hj6gFDlxIyDvFDwC8=;
        b=n2Auw5kDk+U4DKGKUTWOHOZ6EhMopLBlzFWo6AbUdoquA27adv/Sks2wShNIPVAUj2
         doKZoRMOQ4memuRKn09veDYQtAS0lR6ak7b1VT/IBp/z/UT+F9fNkEJNJ2nSeNIWqxl9
         WBwQ4ILHFFOJetRH05rKgO8dcnDMscga0ryQ/jP2WpF5otheRVLEtiPGBFstE3fux09b
         9e6vRcawq/bmswMKCHQewFUzFM/3CXN+2PnQ3e9geItRKFRv3fV68I2tO81gDPxeigYC
         UHTk2vU3L7Q9AkcZIkKdD+OTxV2Yn9X8qVFbfDKIQPeThAFQDBUKqf031ZODAH03FYAY
         Bwkg==
X-Gm-Message-State: APzg51Bo7sy+V0171KzzqfpV25PhwixHicrxAwMTkod+WJddp1YABFkk
        AKEt+a44xNTmloZLJg0kDsAsRkCOVA9sQw==
X-Google-Smtp-Source: ANB0Vda5/hnwPnkPd+6GyG5gaCUQwDgHy/OZLw0bD3HyE088pYyxPgFkCZTg/zeqaqYYCqhmRf+mZA==
X-Received: by 2002:a6b:bc41:: with SMTP id m62-v6mr9215894iof.64.1535339534292;
        Sun, 26 Aug 2018 20:12:14 -0700 (PDT)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com. [209.85.214.41])
        by smtp.gmail.com with ESMTPSA id j78-v6sm3366622itj.44.2018.08.26.20.12.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 20:12:14 -0700 (PDT)
Received: by mail-it0-f41.google.com with SMTP id e14-v6so9196857itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:12:14 -0700 (PDT)
X-Received: by 2002:a24:b842:: with SMTP id m63-v6mr5263857ite.31.1535339066987;
 Sun, 26 Aug 2018 20:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-2-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com> <51cc9d6b-0483-76a6-d413-3f5cc63f3f56@linaro.org>
In-Reply-To: <51cc9d6b-0483-76a6-d413-3f5cc63f3f56@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Aug 2018 12:04:15 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWMQeXAabnis0iJxE91MCSscacbim3T_K6VF6OODw5TuQ@mail.gmail.com>
Message-ID: <CAPBb6MWMQeXAabnis0iJxE91MCSscacbim3T_K6VF6OODw5TuQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] venus: firmware: add routine to reset ARM9
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     vgarodia@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:57 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 08/24/2018 10:38 AM, Alexandre Courbot wrote:
> > On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> >>
> >> Add routine to reset the ARM9 and brings it out of reset. Also
> >> abstract the Venus CPU state handling with a new function. This
> >> is in preparation to add PIL functionality in venus driver.
> >>
> >> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/core.h         |  2 ++
> >>  drivers/media/platform/qcom/venus/firmware.c     | 33 ++++++++++++++++++++++++
> >>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
> >>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
> >>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
> >>  5 files changed, 57 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> >> index 2f02365..dfd5c10 100644
> >> --- a/drivers/media/platform/qcom/venus/core.h
> >> +++ b/drivers/media/platform/qcom/venus/core.h
> >> @@ -98,6 +98,7 @@ struct venus_caps {
> >>   * @dev:               convenience struct device pointer
> >>   * @dev_dec:   convenience struct device pointer for decoder device
> >>   * @dev_enc:   convenience struct device pointer for encoder device
> >> + * @no_tz:     a flag that suggests presence of trustzone
> >>   * @lock:      a lock for this strucure
> >>   * @instances: a list_head of all instances
> >>   * @insts_count:       num of instances
> >> @@ -129,6 +130,7 @@ struct venus_core {
> >>         struct device *dev;
> >>         struct device *dev_dec;
> >>         struct device *dev_enc;
> >> +       bool no_tz;
> >>         struct mutex lock;
> >>         struct list_head instances;
> >>         atomic_t insts_count;
> >> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> >> index c4a5778..a9d042e 100644
> >> --- a/drivers/media/platform/qcom/venus/firmware.c
> >> +++ b/drivers/media/platform/qcom/venus/firmware.c
> >> @@ -22,10 +22,43 @@
> >>  #include <linux/sizes.h>
> >>  #include <linux/soc/qcom/mdt_loader.h>
> >>
> >> +#include "core.h"
> >>  #include "firmware.h"
> >> +#include "hfi_venus_io.h"
> >>
> >>  #define VENUS_PAS_ID                   9
> >>  #define VENUS_FW_MEM_SIZE              (6 * SZ_1M)
> >
> > This is making a strong assumption about the size of the FW memory
> > region, which in practice is not always true (I had to reduce it to
> > 5MB). How about having this as a member of venus_core, which is
>
> Why you reduced to 5MB? Is there an issue with 6MB or you don't want to
> waste reserved memory?

The DT layout of our board only has 5MB reserved for Venus.

> > initialized in venus_load_fw() from the actual size of the memory
> > region? You could do this as an extra patch that comes before this
> > one.
> >
>
> The size is 6MB by historical reasons and they are no more valid, so I
> think we could safely decrease to 5MB. I could prepare a patch for that.

Whether we settle with 6MB or 5MB, that size remains arbitrary and not
based on the actual firmware size. And __qcom_mdt_load() does check
that the firmware fits the memory area. So I don't understand what
extra safety is added by ensuring the memory region is larger than a
given number of megabytes?
