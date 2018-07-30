Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA101625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31DB20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CoYnAPgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31DB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeG3TdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:33:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42078 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbeG3TdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:33:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so4491410edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFxQXp3UPeQj+uHoFvEPUzjheaVeUEGzDq5QlhBNtUI=;
        b=CoYnAPgFqoS+2IE27iHI2Ic9T6AjsNQt4GQ6ZVCyQBbKZREf/fgdEtNvdm8G73u2dh
         9tnjb7BKohTLTOyFOm4QfoGITlJfniA1No0zL1Qk+K+37ZH4XSjvCnADDCHZ0dkzfobC
         un7tuQZEyR72hpn6dQng2qezUeDntqC52c11c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFxQXp3UPeQj+uHoFvEPUzjheaVeUEGzDq5QlhBNtUI=;
        b=ArRxPTZLO9qx5Rp6BsyAa8Grb9ArxD7i1CJpHGMLtnzuOEhe4bEPWzn4WoXV3Oagmm
         RYaX6dxQNHDx6xXa8BJUkX+Wn0L1F4c2EAiiWPFLqEmVEtHZ/Bz3FSgKco1w9mw17UPo
         uGzJMXzVwqe9VjuIkBvl+d3OS9GYvhebXDQC8gXLhWeIkrHWfMATrWp6BnwRR8cVkO5D
         GLSmHaOl93bJAMh9ZKjZ1Ou34Xpk4sPAxVCFViMR1IQPqXW1hSQiTWY51qSVtkibKr66
         feMBQozeO5RUL966seBg4psjqF09oo/fWeOw1gQmuBR0Pasvrub/qY4H5ZHtYwZ1I/9S
         7suw==
X-Gm-Message-State: AOUpUlHEw84W2FLquSjUEWzRrtWLUS5AIFMNFnDi3Y7BsHYt+2metGQ8
        1aWjK4LvF3tqWo5bvpRHlADW9QWMHA0=
X-Google-Smtp-Source: AAOMgpdvKslNVmEXgV/6catUMYe1DjRZ0WmAlflPSxDlTnGkeLBj6+CbVDMYqPPB1fnm10z7zsPcFQ==
X-Received: by 2002:a50:8103:: with SMTP id 3-v6mr9081555edc.131.1532973420827;
        Mon, 30 Jul 2018 10:57:00 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id n64-v6sm2697167edc.49.2018.07.30.10.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 10:56:59 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id s12-v6so314882wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:56:59 -0700 (PDT)
X-Received: by 2002:a1c:9bc5:: with SMTP id d188-v6mr200627wme.33.1532973419064;
 Mon, 30 Jul 2018 10:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180729193646.201721-1-toddpoynor@gmail.com> <20180729193646.201721-5-toddpoynor@gmail.com>
In-Reply-To: <20180729193646.201721-5-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 30 Jul 2018 10:56:46 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ_vRx6BbidM==ryBh0+4t+FHJg4-55XDHJjm1=2VfMDMg@mail.gmail.com>
Message-ID: <CAE_wzQ_vRx6BbidM==ryBh0+4t+FHJg4-55XDHJjm1=2VfMDMg@mail.gmail.com>
Subject: Re: [PATCH 04/13] staging: gasket: core: allow root access based on
 user namespace
To:     toddpoynor@gmail.com
Cc:     rspringer@google.com, jnjoseph@google.com, benchan@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

On Sun, Jul 29, 2018 at 12:37 PM Todd Poynor <toddpoynor@gmail.com> wrote:
> @@ -1064,7 +1067,8 @@ static int gasket_open(struct inode *inode, struct file *filp)
>         char task_name[TASK_COMM_LEN];
>         struct gasket_cdev_info *dev_info =
>             container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
> -       int is_root = capable(CAP_SYS_ADMIN);
> +       struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +       int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);

ns_capable() returns bool, why did you make is_root an integer?

Thanks,
Dmitry
