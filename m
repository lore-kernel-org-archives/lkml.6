Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F6C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8814620658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDCPtHyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8814620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJMA26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:28:58 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33689 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJMA25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:28:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id e206so12524480vsd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R929EaBe0W3kh5OjD+Vgb97Bpbuzg/E4XQiZt9oqg3U=;
        b=FDCPtHybZdhG/xm4ZRwkRl4jA/YNNaRc9qediLmTwZ0bX+e5xum7Qu8oO37jafCLat
         RAdDlxxB7u3WL9kHJJNTRyx95pDLNe+SsK9ra2/ZHOyFUcDW8ru/vXid2MWacTn3l/4r
         6YXUBiDDXOtYXowLWDTLqYonU/78NU7XXC+7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R929EaBe0W3kh5OjD+Vgb97Bpbuzg/E4XQiZt9oqg3U=;
        b=UGgs9UbH+ZEbf2n0YGZ1V3kgGOZYP5ZtF+2K3SyLgEFtCe+hNkv6kjtCfPFabEutYj
         mZfj70JHuUje4Rdzs9fApZY7a2nfcwQcC5Rs+UkbB/+rQgwdX1ETJHgaXxZTyzteNXWZ
         T1ibHr/LCECeWn7a6XmYW05zB/eCAfrpOOWHbsaKgtDOaawfdRbLHERVTjMQu4JYPe5p
         hqerHW+c1YfhnzRVgNGi9KZz00QOfFw5+imUTHA8LVk8eFpN8IzHVHmN9emhgM/fRn4W
         CfPI30PGpeLgFy4NLmM9Rr5Yf5M16I9v4l32VYIziHRT3ve+Q2dV9hSdNZr52Um0XUSc
         PLhw==
X-Gm-Message-State: ABuFfoh96+B3GcCxfvtkUE5rs0clmWSEFVkVj1Py458E9H7SJRJic2l4
        1qbbzleA2t/ADXUXnCM8RURHo0vs/sI=
X-Google-Smtp-Source: ACcGV62C3suqWAaCf+yy5t8x30PlmmZeBMMaC2id0fpdwrh4Wbg8jhdnQmaKmCgmZKPae02OOIrgOw==
X-Received: by 2002:a67:7242:: with SMTP id n63-v6mr2662785vsc.227.1539363333054;
        Fri, 12 Oct 2018 09:55:33 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id w2sm265453vsg.29.2018.10.12.09.55.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 09:55:31 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id m5so12487996vsk.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:55:31 -0700 (PDT)
X-Received: by 2002:ab0:150:: with SMTP id 74mr3079130uak.83.1539363331073;
 Fri, 12 Oct 2018 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539306736-9519-1-git-send-email-cang@codeaurora.org>
In-Reply-To: <1539306736-9519-1-git-send-email-cang@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Oct 2018 09:55:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjO9YvKHDiEDt8+8TJ_JjnzcVAqB99nhP5LwnWO0fuLw@mail.gmail.com>
Message-ID: <CAD=FV=WjO9YvKHDiEDt8+8TJ_JjnzcVAqB99nhP5LwnWO0fuLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        venkatg@codeaurora.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 11, 2018 at 6:12 PM Can Guo <cang@codeaurora.org> wrote:
> +       if (err != -EPROBE_DEFER)
> +               dev_err(dev, "failed to get %s err %d",
> +                               name, err);

I wouldn't spin just for this, but if you spin for some other reason
you could move the above "dev_err" onto one line now.  Sorry: I should
have noticed that / done that on my patch...


> @@ -141,24 +147,21 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)

Idea for a future patch: now that I look at what's left of this
function you're basically re-implementing clk_bulk_prepare_enable()
and clk_bulk_disable_unprepare() now.  I bet your code would be
cleaner / nicer by switching to that.

...possibly you might need to improve the clk_bulk_get() API to allow
for some clock to be optional, but that would be a pretty easy patch
to post up.

In any case I think it's better to do the clk_bulk switch in a future
/ separate patch, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
