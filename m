Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC1C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hBa/qMSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB3E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeKBAsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:48:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45354 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeKBAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:48:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so18462501ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmsgYUUMV232munx45mIr8u2Y7JVL3hEJA3fsa9frX0=;
        b=hBa/qMSIGqc98QqR3GfRP4fuWwvL2ma5Ggzu/eo5F2uXhnR192OwOlWBJuWfMVNSCp
         VGmgGY2b7LyrCGcBjkQzW4ngAPSJYEZXS1FiArJTHAZciXygKRoSMIHPs1R0LAYZyKks
         WlahtosfHCtBMJ3/ciP+RfQRJbEzEZDyxLq1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmsgYUUMV232munx45mIr8u2Y7JVL3hEJA3fsa9frX0=;
        b=e1MV4d/zqUh0tV5DAWVjZdd6HgITEgSBTuwwBTHnVRxjCmMoTFH6nJXEAqVBIBhegH
         83SoZbBMHTKbNsTfN6OCyel3Dy2zBILAulgLnZargqkCSyDnXwdU/Eq2e7N9AdI9myHf
         jQ+Wdlqu16JDhP7rKzgoob/mOlTWCH+zvURuYOxMmQny+0RgDC2FydNzej1ItBx8gVzz
         xmzrQ+qxHd4F2v95JTfpWPYS3QefHmaEn9aOIcYVk2ceZFmpSnwISzY2rlOEoDA6/J3h
         5OcWMU91kbEoACYYW2cFLKoSMQj6OzZObHjVylEnz5tVS/K99dh8ds64QKSbP9aWvVGj
         zNew==
X-Gm-Message-State: AGRZ1gLYXeS3idPUAu9rkyvZjAkoJaaVXCXYtJ0pfoUq6IAxBrO9/xOP
        ++IwlgQ3RtxsDz8Dz2zSGU3G0RKOuejJ3g==
X-Google-Smtp-Source: AJdET5da34btGeMPwxrz0c1vYN37Qi4Cp+xCm0w6ZdSXJR7aACjDwYQW+BirURF34aiwsHz1HqnKGQ==
X-Received: by 2002:a2e:4811:: with SMTP id v17-v6mr5163140lja.151.1541087102562;
        Thu, 01 Nov 2018 08:45:02 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l8-v6sm2009687ljb.44.2018.11.01.08.45.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:45:01 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z21-v6so18477124ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:45:01 -0700 (PDT)
X-Received: by 2002:a2e:9f42:: with SMTP id v2-v6mr5602608ljk.80.1541087101136;
 Thu, 01 Nov 2018 08:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181101030706.GA9309@fedora.eng.vmware.com>
In-Reply-To: <20181101030706.GA9309@fedora.eng.vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 08:44:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7wHFc9hHdzgKmbRVic5GQmwSwHuwuyupm2-XU5bGyKw@mail.gmail.com>
Message-ID: <CAHk-=wj7wHFc9hHdzgKmbRVic5GQmwSwHuwuyupm2-XU5bGyKw@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.20-1
To:     dvhart@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 8:07 PM Darren Hart <dvhart@infradead.org> wrote:
>
> platform-drivers-x86 for v4.20-1

Pulled,

                  Linus
