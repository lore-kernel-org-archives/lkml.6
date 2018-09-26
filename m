Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2019C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B2B214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ANwIlYuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B2B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeIZH4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:56:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35196 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeIZH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:56:49 -0400
Received: by mail-vs1-f66.google.com with SMTP id l3-v6so5093647vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 18:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIdCX1P/3N4ijAlB9N6TwddYepO/n9WhVab1UreJ+WM=;
        b=ANwIlYuQyFE8BM7O+bANzobc+EiK0IfNUROjQDBUgnWkc5WGdwsC0/7bKDcwr4MKYJ
         o0VnP3lJZEWkQGcloN0KAkBkm1nJ/11BvdkMg8rmwCJkES0ENbRMUkkHxVF/S2tYiUJZ
         xFRR+sEeq2w8owBk+9O1yQz0X74+n3dfl5Yhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIdCX1P/3N4ijAlB9N6TwddYepO/n9WhVab1UreJ+WM=;
        b=GRy0kPa6e9HILRhn9w84fil9ZUTnkDcup59dVXMYgKJdJnlplSVhGcdiDUMnE8yVvQ
         zc8jCZpg3MpkStgx+zCFPusjZDcMZxDC5feT16zg4S+aFAO3WdJBSCrkTvfYdxEgSD34
         EneKGMfxAewQxrIhM4P1qGPaNXeWtmFEk4kA/SYp/yHSVSsBbx/Fr5GWT1Ry+j5d86Kj
         FOQ0s+sRZQPVsH+fqlY6kxWMC9qzJGCNiUuduSdiYlimkI3vNBsUL4wabAKIW+1ob4nb
         1wJgyAn1D0LoqARfhylOSm9MmjUzy3qdEzSE61cMsDHq4B0CswtZ/BzL2ifUKqnJydEY
         vJPA==
X-Gm-Message-State: ABuFfoifYcU120JkqQHs7R2wUty/UKOkuWK5AzN/gLqIXn37wCWPU/2z
        tKXvxTM8K1CnQ4UJTXDoQ2hhNUxtLAg=
X-Google-Smtp-Source: ACcGV6027Qn2jvaO2HWbebqpKquBNvxQ+mHwfIC8Tz3KumOiRKsULhaP6Blrt6U+cA+Mx5bUxUoyGA==
X-Received: by 2002:a67:2154:: with SMTP id u81-v6mr1140127vsf.168.1537926387432;
        Tue, 25 Sep 2018 18:46:27 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id j70-v6sm1300904vkj.55.2018.09.25.18.46.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 18:46:26 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id e139-v6so5297244vkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 18:46:26 -0700 (PDT)
X-Received: by 2002:a1f:4c86:: with SMTP id z128-v6mr1093990vka.73.1537926386051;
 Tue, 25 Sep 2018 18:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180808224454.243790-1-evgreen@chromium.org> <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com> <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
 <yq1h8idgj5y.fsf@oracle.com>
In-Reply-To: <yq1h8idgj5y.fsf@oracle.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 18:46:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
Message-ID: <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, stanislav.nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bart.VanAssche@wdc.com, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

On Tue, Sep 25, 2018 at 6:08 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Doug,
>
> > I came across this patch and Evan's other one and noticed that they
> > haven't been applied though a batch of other SCSI patches for 4.20
> > were applied about a week ago.  Martin: is there something about these
> > patches that needs to change before they can land?
>
> I have simply been awaiting some sort of consensus on the various
> competing approaches. Lots of patches posted with tiny incremental fixes
> but very little discussion about the merits of one over the other.

Ah, perfect information!  Thank you!  I was just confused because I
didn't understand all the status and it just looked like silence here.

Maybe someone on this thread can start a discussion with all the
stakeholders (people who have been involved in competing patches or
other tiny bits and pieces) and summarize their view of the current
status?  Maybe that would help get the ball rolling again?

Thanks again!  :)

-Doug
