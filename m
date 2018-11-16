Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434B62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NrT7CWKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434B62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeKQHaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:30:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:30:10 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so4462887itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GUJO5+tQdOo9kFid1q3KbvTQlvQqWwECmztiVrNno4=;
        b=NrT7CWKhojxLHU8rzOF8DY86z+3nLTk+RCtNH8jneiso8jYyDlhVw2gXMKHZ4TCX9W
         ba1PeQChRbH7WMN1mNruyFcqHybgtsUWzdCf/QoZ4BwQbudf3huxSld7hO6TerI7Mkqr
         ILp46/2uC/cUS+BYWKQuCJB5QDZnlY11OdUSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GUJO5+tQdOo9kFid1q3KbvTQlvQqWwECmztiVrNno4=;
        b=C1AtWnSqgwDzT2aqZAr9idxCaX4n0a61xRmPGVOcRN9666TArPoz7zGTBlO1fDPqWq
         NEsLez5FrOCc42pLZ0W44Tp/z+rkYXcVu1/pUJIQ5S/9AIAhTDY+uU+YK+7gNrbnhk7w
         JN6wgXgoagxBvOrzZrm6eCSKl/8EQXVd4UD5TqKs4osOewN2GvbMzotAN2nTq/r9cbYY
         DamxdQRCMtyr90u0kCyduQzG+LofWMKThQOKWyNRalgTMwrOYB0BxoZgXElEiI+p2Hky
         L0qo6XTPPCN6raTRRmvuf2QQ7Exe2TdDPK+e6uoc8wk3rx5XED/N/xUsEE0Xf3TX+4Gh
         6hzA==
X-Gm-Message-State: AGRZ1gLdA+L8exXCv6GNgh9IOQT1k+tTsIkB5KQA90iH8MBJj6bKJ8t0
        0WvzMNRsIpQMQETZvIIlTJ1jSBaSxmk=
X-Google-Smtp-Source: AJdET5fblAIaol7C0NCulZ6fbEFW5SNJg6c1anD5/ThNg9so7MlD3rHfp2faLziJDtsGST4b6wGQ9A==
X-Received: by 2002:a24:1007:: with SMTP id 7-v6mr10825988ity.80.1542402966552;
        Fri, 16 Nov 2018 13:16:06 -0800 (PST)
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id v185-v6sm609399itb.21.2018.11.16.13.16.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 13:16:05 -0800 (PST)
Received: by mail-it1-f171.google.com with SMTP id e11so36219935itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:16:05 -0800 (PST)
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr2747326ith.169.1542402964658;
 Fri, 16 Nov 2018 13:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107185643.240346-1-briannorris@chromium.org>
 <7f2ef494f4a2aba1845a157da8fec449@codeaurora.org> <b1a64bd66fa25f274af8c018c6fc02f4@codeaurora.org>
 <CA+ASDXOqJ1-G2amyu7sJCnzKf1oY_2j9Qw4WS0VTf8EqGr6Uqw@mail.gmail.com> <87k1ld72ho.fsf@codeaurora.org>
In-Reply-To: <87k1ld72ho.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 16 Nov 2018 13:15:52 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNOaZ3oWttEm9M4fQPjjHCfNi34VPTmKd9whE7xsQUVLw@mail.gmail.com>
Message-ID: <CA+ASDXNOaZ3oWttEm9M4fQPjjHCfNi34VPTmKd9whE7xsQUVLw@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] Revert "ath10k: add quiet mode support for QCA6174/QCA9377"
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     govinds@codeaurora.org, yyuwang@codeaurora.org,
        rmanohar@codeaurora.org, linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org, pillair@codeaurora.org,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 2:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Thanks Brian for investigating this and providing the revert!

I think Govind did most of the investigation, but I did at least do
the hard work of submitting the revert ;)
