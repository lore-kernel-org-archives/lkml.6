Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C582C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iqUB7ULJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C582C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeKVFM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:12:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39326 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeKVFM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:12:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so5700182edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0su6oURGKqv/GMdbO1Wuhg9ZK12XXPJa4ke6ZkQeCGg=;
        b=iqUB7ULJJZR8jssJUWl2G1QCWqzhVnFUoKilD9sefMlVNdu5klukUSTCls0XLPNJD8
         T4BHEepx9iYXnHV2W2gm+MfYKcaURDCa6Cf/KD7hW3r/ZngXJD6jQycRmm4Z+WKyeSc8
         YvAIe4V+0E2iQ3Abh7LkYeDYLd+IZO/NEgD9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0su6oURGKqv/GMdbO1Wuhg9ZK12XXPJa4ke6ZkQeCGg=;
        b=LeCMRrG1dH876JGaD2TTiCmA5mncOieQtbGiYgjjDc15JmxWERbuY3pDgtsuODl1OY
         1sDgk6cdGZVekbki/hGf0+wh1fg5yr0W8fl5dFj6q16GJr/+vSDkPAJ9+Q50ftsHLKcS
         EMoIXFXXU+PfOIOR0H9JXk/i5Wy9p8VR50RFAuVah8V4QgVGCeZAYhcPP9v5G79nqxOF
         sejO9k7bpQMdj6MLTgd3EUawwOpVNjbv+IT29zFRtpmDX1Ei/OKFGSU1Vozsa9FhsTz5
         eAcmqceSNqalo1RKS5g2lskbBrF9+MNWz+qdmKFVksNLxrHeaBne8DGk4zEoO0CDtVQG
         ZtXA==
X-Gm-Message-State: AA+aEWbzF26xxLD6Y0t79o2N58x2lks8VvkNeQvDaF1H0B99sg7u1QKy
        +mzRnMbVqmFzDM6vdVhTgzlA3N14JxI=
X-Google-Smtp-Source: AFSGD/WatSwP/MTV+iktFJpRDk425Fx3WKUlEPIdUV0Tlo+3qBVcU+sc0Dj2fgYYqQRv08cs1kO1Lg==
X-Received: by 2002:a05:6402:184e:: with SMTP id v14mr6618562edy.147.1542825448178;
        Wed, 21 Nov 2018 10:37:28 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id n7-v6sm12571874edq.66.2018.11.21.10.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:37:27 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id y1so3303198wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:37:26 -0800 (PST)
X-Received: by 2002:a1c:3489:: with SMTP id b131mr6207272wma.44.1542825446198;
 Wed, 21 Nov 2018 10:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Wed, 21 Nov 2018 10:37:13 -0800
X-Gmail-Original-Message-ID: <CA+jURctziob_scb36s-JxvD-FFrH1xn4Npd_i56g3DxxVEpZ4A@mail.gmail.com>
Message-ID: <CA+jURctziob_scb36s-JxvD-FFrH1xn4Npd_i56g3DxxVEpZ4A@mail.gmail.com>
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel support
To:     benjamin.tissoires@redhat.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 at 07:27, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> The TL;DR, we need to revert the current series before it gets out in
> a released kernel and work on a better approach for 4.21.
>
> This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> and Peter, but I wouldn't mind a public ack before I push this to
> the for-linus branch.

Thanks Benjamin!

For the series:
Acked-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
