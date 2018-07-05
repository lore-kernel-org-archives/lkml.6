Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2577024181
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYA6tgib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2577024181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeGEJfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:35:02 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:45086 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeGEJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:35:00 -0400
Received: by mail-oi0-f52.google.com with SMTP id m2-v6so15590837oim.12;
        Thu, 05 Jul 2018 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=E80XfWWuOUuLNIHYDTFIVsNCDfZ4pI4I4tzxM0ycr+c=;
        b=OYA6tgiba/5mRFjSNrbWwcGevqdLQsqjThpjV4EJLVDTERC4Rmx7Jwk6CMfbFN4aVo
         JqNGw1SXzCL0p/kHfRn9xnYKGbLNi7Y2HnP/p+rJakIEPise1ZN1eIMH9D5fOkFli8Cw
         pPPH19cdJ9OZ0DMOdM0GCdaqu0cHBLDrrdQk51QU8scOaksb3KGWyk+adb9rORjq72Fv
         9ftJ9JJBlhSM0daM/RZA6vfCcFwYEfdER09pAaCZeeIE+LGMzx7nTzOeqq+CMm6Hd1IZ
         PiXwXOCFXP3VfwEa5cNSp88VXZco7K9LEbMW+P5vUtw9uTsC/P7YEivXLQ6cTuLW39Ql
         kcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=E80XfWWuOUuLNIHYDTFIVsNCDfZ4pI4I4tzxM0ycr+c=;
        b=Uzjt8VmGNfXvM8onNx6lnCu6xhpi/PhqHphYMHFR1+SyhUdSUw45mjWv3eKbgqHjbS
         trWDwflarmz6mYtwNiBbQFvKbkSBAC3UtER3npkGaAOg4sg3uOuB3Px6n7YrkYN9dJQw
         +NSQUCnALcKuJmMpvGv3GzlB34tK0ugI368qbqsAu5+MbRqHMp898iNRdXlnWg/eMveL
         9iPpeahh8DU4rcUuH5xNWKad5NqgC8bYZrTFO5gcHypHJYAD8iVaNb2nozPV0SU/Mq+i
         xpdSaTXS4FPVMI6wPut3i+DLRIvoJoyVmod6STSYkX0znXa6Ugv/gmBm+dKbTm4+2IEk
         aLrA==
X-Gm-Message-State: APt69E2TzPscZVCL18Cg6SDu9jkY+kZcDMlOtvGFjdaLGM2vojdJCMi0
        q5Rhg/UV/RyWCMv4pjZAOUV38yKasPpp9r1U7lY=
X-Google-Smtp-Source: AAOMgpf7yWsZ0XybYedtK0hlqrq9Ba6emStMLspnEv3CfOrVOYIIJLh97k4aeIjwNe+csiqJ0C7g4BCM6v9qpqBZNxI=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr6211233oie.233.1530783299834;
 Thu, 05 Jul 2018 02:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:34:59 -0700 (PDT)
In-Reply-To: <s5hk1qaf9hv.wl-tiwai@suse.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 11:34:59 +0200
X-Google-Sender-Auth: UBe644fg3J_Vu2KqdHeqziTd7Dw
Message-ID: <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> we've got a regression report since 4.17 about the behavior of
> power-off with the power button.  When a machine is powered off with
> the power button on desktop, it reboots after a few seconds instead of
> power down.
>
> The manual power down via "systemctl poweroff" works fine, so it's
> possibly some spurious wakeup by the power button action, and some
> ACPI-related change is suspected.
> The regression still remains in 4.18-rc3.

There are only a few ACPI commits directly related to power management
between 4.16 and 4.17 and none of them looks particularly suspicious.

It looks like the power button state may not be cleared sufficiently
after it's been pressed which is now visible for some reason.

How does the button poweroff work, exactly?  I guess the event is
collected by a user space demon which then triggers power of via sysfs
or similar?

Thanks,
Rafael
