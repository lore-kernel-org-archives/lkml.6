Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E5C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E222F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="afimZFby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E222F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJ1BBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:01:45 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33149 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeJ1BBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 21:01:45 -0400
Received: by mail-lf1-f47.google.com with SMTP id w16-v6so3118258lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDSicMW0z8SGDwdIqvc/Qsng9H4xaZNrzywoGEdklko=;
        b=afimZFbyRyyVny5/PrOj9QJ/jX1fbXTwCz+pBzJc1cQq+X1NL45eRd2KUV2Gyhp8hr
         LK7UfqpXeiS+YAiK6vyGqC2av0ATz+PLkHLteK2CzKW7OW0z1Xyovqia2pFPkKRcNtJm
         eTlx2mQ+arCBEC1wxCXgWbH9BewR/af6HFIQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDSicMW0z8SGDwdIqvc/Qsng9H4xaZNrzywoGEdklko=;
        b=AgAPPw2ZVJx+ZBqD8zMe2IKpUMRfx0SsUL8jTyyjEs91f/mWKuFQ2PYDT/zCh/zriF
         KdJP2wvxt4f27q4LfTbVioWbiNJyUk0tJep77u+BG2P8tpFt3ULjZ1lEdCFbR+41c72Y
         vvO5I6DwO+OpyqIzbZAC3eGZ3dtob7OKCh/frnTJHGgSlcZXoYzzcB4g0VFjlwc2uZ8D
         NIeIwc840Z8bpgQEcoxQUHyYTyAOdivuCFCCLyeji5nFcHdbw1A80UfCF++ZJqzF3u7O
         /OnG1tYSdgLumiG8O2MFQuIP/x4EYG+rrSY2OP+01puCB64mB+rsYe+ZIqOhdj7tSgAk
         5hQA==
X-Gm-Message-State: AGRZ1gJqzjqCn6co42lsv6Ie4ZeuOXL6b8s3Xnn2lkVRAYZW1JKXpim+
        7fiIlQI0KyEeg2RDCyzu7w5qvjgz+svrgA==
X-Google-Smtp-Source: AJdET5fRB+AM1cHVgTYeYcGniXINT73u4murEqzmugw46GnAK3ZqeLAET1g7xOtidRBgBPojnOpDJQ==
X-Received: by 2002:a19:6719:: with SMTP id b25mr4386255lfc.38.1540657214059;
        Sat, 27 Oct 2018 09:20:14 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q124-v6sm2068906ljb.89.2018.10.27.09.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 09:20:13 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w16-v6so3118233lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:20:13 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4515350lfi.138.1540657212651;
 Sat, 27 Oct 2018 09:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
In-Reply-To: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 09:19:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOan5tQR_vxpq2qX6Nus8NZoFcHBL7KJ4QAxetDXHX-g@mail.gmail.com>
Message-ID: <CAHk-=wgOan5tQR_vxpq2qX6Nus8NZoFcHBL7KJ4QAxetDXHX-g@mail.gmail.com>
Subject: Re: Oops in current tree in i2c
To:     Jiri Kosina <jkosina@suse.cz>, Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 9:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> isn't terminated by a NULL entry, and I will test that next.

Confirmed.  That makes my laptop boot cleanly.

See commit b59dfdaef173 ("i2c-hid: properly terminate
i2c_hid_dmi_desc_override_table[] array")

                       Linus
