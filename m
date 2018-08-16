Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ADEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843520870
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dpF4+l/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4843520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392294AbeHPTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:19:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36922 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHPTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:19:06 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so4338625ioh.4;
        Thu, 16 Aug 2018 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8ObAOw2LGoCOaPVuGK9EAPp+FDDdbxaX498z0OSutg=;
        b=dpF4+l/YmCBdo+18IMFCFnzw2qTTorfh5Sen8/h89hHgsoDEZ/n91k9HNFgKOv7e1S
         eVk7S3KMJoncelWKbNRWERXj4TM+lbrqokzn9h35qaO7PS2wN2c3Age8ip4t3N3NadnH
         hAtvHhIeCDDogvVsJHFVWBB1jIjYEuZvGcdEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8ObAOw2LGoCOaPVuGK9EAPp+FDDdbxaX498z0OSutg=;
        b=AO/mavS2lw77OSJLe22aenrkjCVmq/h0/quHv8zLptPSTYNZOLoGfZT+gmjPkeH/UG
         97OZvh7vv0QfvUw27lsxphlDbHogQMqA+WggPWdsA92bTZ++ATkbC7ooXbcfTb9g38p0
         rIaRY6giWV1lP/HXiyFKdAjlc32EsPrMklNr6gDrClPG4KpDL5s4yecHUmGlZplNk9Tw
         s4GEeaPPVD+olEaag0HcDq8sxl23OL8Zu7ArxeWl4/8lPkNSHwQzRQ9cK5Ctlcsx0jQv
         pcP0MSlN2g7jV+b2RDXe+LbtPxbKe1kQXxLfu1UkXH3Xi1E5LXG6njzho4WrvLjXdUoJ
         tuPQ==
X-Gm-Message-State: AOUpUlFZ8kqRpt4Jk/YD76r2T7aPsAVP++KbwqFQ40hnSujWLyUErCY+
        Nx1SgvbsHvvG76r1r6QpUeg+JUtDF/DheQeNwQ59yQ==
X-Google-Smtp-Source: AA+uWPyWG6S55gIIM6rPK3Mwtq4WsaYujeVMng1pL2tvO8W9mxe0J2vg0VBsfBr+v5Odw2Y/itx5uTa6/XBUa3qebsM=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr22278916iom.238.1534436379005;
 Thu, 16 Aug 2018 09:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
 <CA+55aFxRPLjo_XnWDw5sYLnSjNhf8iPHGXomQitnGJjyuViXCQ@mail.gmail.com> <CAK7LNASWKrg=U+a1NJW-2SEp2LtG9wwDHQbPdYk=nDHCVSMeEA@mail.gmail.com>
In-Reply-To: <CAK7LNASWKrg=U+a1NJW-2SEp2LtG9wwDHQbPdYk=nDHCVSMeEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Aug 2018 09:19:28 -0700
Message-ID: <CA+55aFwZqfnA-Pteoq_S=2A905FonVi9AcwD5o2esvNzpE3-bA@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] Kconfig updates for v4.19
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:54 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I wrote this patch:
> https://patchwork.kernel.org/patch/10567117/

Looks good to me.

> I will apply it to my tree with some other fixes
> and send another pull request in this MW.

Thanks,
              Linus
