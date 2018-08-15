Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F5AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F114521565
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bv5yR1a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F114521565
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHPANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:13:14 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:42126 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeHPANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:13:14 -0400
Received: by mail-ua1-f45.google.com with SMTP id w7-v6so2423206uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9aviWD1aKyV9j87EdVfGEpSjhsC88Ppv0brxQVhfRA=;
        b=Bv5yR1a4kZu98xovO+96uasyyQ1JDeahfqknAS5sHdqMw7zxVopEdzhM1I4OGMKbrv
         3iZDr2tSfeaIn4KGN1BVCsQtno/0dACsRdvjaQNpu6cn/LnDwap+WQD06/bnk5beGLj7
         Xw5FwQ30i41PpnzSXOasq5kQ21I83St9tOO0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9aviWD1aKyV9j87EdVfGEpSjhsC88Ppv0brxQVhfRA=;
        b=cDol0MqoRD8KeaaCRknN7Xruajt4hcFG8AT4OupjiyPGqIRFC7qszKrbM+y0rljmS0
         UvyrO8hSF675enFv/693ADzVtMp7vRsK9kmBIH5GtYGPop3k6jXlv0VijXdCLKwtVhJM
         B3kHhGJ2E0J7YXwSrGCBNWhLAyHHd+QlF9HVim5P9d9VNbpNL5JRKaaeaDB6prRugCN4
         G726bLqRs3tZcboDusGcjzsCxf+7lhKlbdGNjh3tjMk8G0B71dvg59WPZrIRK01+sK7E
         QfQ1TdYKGmqHMTaRtmWHQpSXIiVUe+femn/6vkdsdo0qVMSmp/1b53Yg/ODHWMJMAje5
         4l+w==
X-Gm-Message-State: AOUpUlG16WImom33UCfUhOSbmFY72N7JWN/jyWhfZTBjq91xPNJDAjh0
        eSE9FFkNGBLO1WZwhFr/by65pz1maVui6YPrX24zcw==
X-Google-Smtp-Source: AA+uWPxqMUit3krmgaPKcw3XI4c7Kc9FzhgivKb6jKnEBZsYUXO8npIfWd12aDSbyAHyYaVOp4kfO5WEztxuUHFbZZ8=
X-Received: by 2002:ab0:6352:: with SMTP id f18-v6mr17868012uap.76.1534367960057;
 Wed, 15 Aug 2018 14:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180815203708.67090-1-swboyd@chromium.org>
In-Reply-To: <20180815203708.67090-1-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 15 Aug 2018 14:19:06 -0700
Message-ID: <CAODwPW8VfrxkB5Tytts2ASkvqgZ+qR5wJb9iWizBOi7qveKhbQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] firmware: coreboot: Fix probe and simplify code
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the clean-up, looks great now!

For the whole series:
Reviewed-by: Julius Werner <jwerner@chromium.org>
