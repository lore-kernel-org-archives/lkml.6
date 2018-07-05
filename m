Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45273C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0055E240B0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="agApkbSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0055E240B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeGEPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:00:41 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:41551 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGEPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:00:39 -0400
Received: by mail-io0-f182.google.com with SMTP id q9-v6so8015173ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ny/z2SWUaMcah9d3wJCn0PNC29of+YLiudElt+yJ9T0=;
        b=agApkbSf/nvm5wQIgbzFRBxaZ31PRATyEDEjPcqodTWGBS5u99Dm8fsuIYIaA/jZ2U
         GFQiecJ/h47TixUwNiXTGCopRCQUklSje0JUtZ7wHyHP/7tJYGVOeuzV0xEwH013m4XB
         pEqED02EY9GHvO3+rAPzCC+rHwJEVHGqV2zgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ny/z2SWUaMcah9d3wJCn0PNC29of+YLiudElt+yJ9T0=;
        b=KdM9JMkPx9q4be4xlMY7EYEFGtvUBSmnJG/y2bCFJS2zFZp86QSdD4WHYEG+C2PEmf
         kiAh7Wz8kYwFculYi584nhJEn38zOOn5bz7FVO4U3C2hVWy64ILVjHU/7cqwZ1JmZKTY
         kBpYVtKM110eF8feGpM3udoCk5yZ9f1tL+ti+AM+RitDh7s2U8jaTMAV0KOCAV1puPPf
         zzsR2+L954H1X1nd0KJzMWnP1607bJm6ibM7QUjJ1mqiUkx86WI5t9ZCZ3jE4kyLHsTg
         2mQndoRNGKRHDekuaR9Ims430SHPuJVd2lyC00KbXCQSKdmjzjtDKkfrKAxErTp4Hok3
         FOSw==
X-Gm-Message-State: APt69E1wPHpjedm3KA0miCay0zn76c7W0cWUf7ZCHIOVVtRHWMsZQ/pM
        prltY/uTVVKqrinvwGpGe7xXfZ+WNCs=
X-Google-Smtp-Source: AAOMgpdBSIe2wIra42hy9LdUuB+HlPFVfw4g3+rkElEatlmmzO6di0XdfLA776w+lfYDZio0y2U0Yg==
X-Received: by 2002:a6b:ac03:: with SMTP id v3-v6mr5244658ioe.71.1530802838814;
        Thu, 05 Jul 2018 08:00:38 -0700 (PDT)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com. [209.85.214.46])
        by smtp.gmail.com with ESMTPSA id r80-v6sm374377ita.20.2018.07.05.08.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:00:37 -0700 (PDT)
Received: by mail-it0-f46.google.com with SMTP id p4-v6so12406375itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:00:37 -0700 (PDT)
X-Received: by 2002:a24:d41:: with SMTP id 62-v6mr5145365itx.14.1530802836894;
 Thu, 05 Jul 2018 08:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
 <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl> <6abf8da2-b2e1-1b4f-2727-f9d074081c30@linaro.org>
In-Reply-To: <6abf8da2-b2e1-1b4f-2727-f9d074081c30@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 6 Jul 2018 00:00:24 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWoysaL_i8i7HaegRCsfF29bnOy2L5ZHgEwDuSJ7HVO2w@mail.gmail.com>
Message-ID: <CAPBb6MWoysaL_i8i7HaegRCsfF29bnOy2L5ZHgEwDuSJ7HVO2w@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 11:52 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi,
>
> On 07/05/2018 05:08 PM, Hans Verkuil wrote:
> > On 05/07/18 16:07, Tomasz Figa wrote:
> >> Hi Stanimir,
> >>
> >> On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
> >> <stanimir.varbanov@linaro.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Changes since v4:
> >>>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
> >>>    moved new structures in 03/27 where they are used
> >>>  * 11/27 exit early if error occur in vdec_runtime_suspend
> >>>    venc_runtime_suspend and avoid ORing ret variable
> >>>  * 12/27 fixed typo in patch description
> >>>  * added a const when declare ptype variable
> >>>
> >>> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404
> >>
> >> Thanks for the patches!
> >>
> >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>
> Thanks Tomasz!
>
> >
> > Are we waiting for anything else? Otherwise I plan to make a pull request for
> > this tomorrow.
>
> I think we are done.

I would just like to give this one last test - will be done by tomorrow JST.
