Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E6DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB8F25A51
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF/75ep+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB8F25A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeFYNVT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:21:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33283 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeFYNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:21:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id t21-v6so6059107lji.0;
        Mon, 25 Jun 2018 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tC2v87iz4hoLHsE00cmKMxE6yRcmRl3di1/8KkZG+eo=;
        b=EF/75ep+eSfHg0R2LetI2DNyaeOpiH/QqwJQsEbjxDBW5hNXYDIPapsnAW7jE7Hapb
         eh0OKwePvo7YnyR73lmuJsuQbZi1oYi1aAUD8YxsVLjTIqqf7uUy7T05kOdKBiY6gWnN
         mMLV33oHG1goLa6pSlQn1XVS2CXiNfhQCy2y4pq9dAnTrA1JKJIxSR30cfOITxSIINPE
         hWpz0BZK+dws8+kBefQfZqCff/Do2T2x2rAaRCL/f1Jmy2yLf2o3uT280apbsyw7KE3L
         HqP/tmqtqfUFGHrKYrl3COiYhfAI9rUH3xklq5inNcAtO2qJ8sA4V0VE/7qjLbyWMJ/O
         U7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tC2v87iz4hoLHsE00cmKMxE6yRcmRl3di1/8KkZG+eo=;
        b=e8Mme3lXirs64vCLy/KiVFGLhLHL0qeFN6hXjbIbR3cGNVDaJUI6XGXbi333kHlrV2
         Qcy30WYw/ZaQJfjvdqj796DuxgStIjGZnATi6zYJSIp2fC6nYrnKYcytb8sJX9iLsXZx
         FtHyESmOOogNnZDaDVt1JATYOsOc1D9cupNtb7K1gi+R/MOnIjWp7u1D9R15MctUWTdV
         hfZfq36RPgeVjpj3yK7NZHL81iNJmp3iXUJyBmuJDBugZyqtyxGtjmp61z9ACXuAWUgC
         ca7Qtm0IqTBJFw0jtYzS1wANMKBtnfkMQrivobsvwjXlg2c7jc8TVOKtZhjkvuZleytL
         Htuw==
X-Gm-Message-State: APt69E0OuHyAAAtn7jHMq86GJohFi/tWbRpcE9jZ8SYFSOQHoSbKIG7y
        OKgxP7HDqok/gw3kkY13zGc=
X-Google-Smtp-Source: ADUXVKKbgsBVvela9G6FYaVOBV4Af0cEukKxV34X+JCFqrUbPAZ+4YQcuzxjQBiI+bnTofZo0xtK4g==
X-Received: by 2002:a2e:3101:: with SMTP id x1-v6mr8032841ljx.8.1529932876391;
        Mon, 25 Jun 2018 06:21:16 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id r77-v6sm1710589lfe.43.2018.06.25.06.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:21:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fXRQa-00014f-Gh; Mon, 25 Jun 2018 15:21:08 +0200
Date:   Mon, 25 Jun 2018 15:21:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     mika.penttila@nextfour.com
Cc:     Peter.Chen@nxp.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Regression fix for Chipidea USB
Message-ID: <20180625132108.GK26803@localhost>
References: <1529924045-28556-1-git-send-email-mika.penttila@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529924045-28556-1-git-send-email-mika.penttila@nextfour.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:54:05PM +0300, mika.penttila@nextfour.com wrote:
> From: Mika Penttilä <mika.penttila@nextfour.com>
> 
> I started to see usb failures on i.MX6, like "nonzero urb status received" after:
> 
> " commit 4e88d4c083016454f179686529ae65d70b933b58
>  Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>  Date:   Sat Mar 3 22:43:03 2018 +0100
> 
>      usb: add a flag to skip PHY initialization to struct usb_hcd"
> 
> The errors were related to some scpecific scenarios, like usb device
> reset, disappear etc.

This was reported earlier and a fix has been posted here:

	https://marc.info/?l=linux-usb&m=152825077301574

Should be addressed in 4.18-rc shortly.

Thanks,
Johan
