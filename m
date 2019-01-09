Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A759C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2788720883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLzq0nM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAIDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:25:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44625 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIDZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:25:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so2649716pgr.11;
        Tue, 08 Jan 2019 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0ZaESGZ3DWR6K/cxMbCNQ7xXLmeAeWLAg5uKrlD7nss=;
        b=DLzq0nM4e58zkGMWwlXuWaohAARDTN0l4k8fmYpM7I8cuuiydfTcAct1lVd3BDj+fd
         LKRcSSRgm+e1OTcrxmBefEhUd1NtMOt1QemS3Tyc274azPW8tXM1IWl1Di1jCDJ/tTGb
         VhYY3qUSg1/D3usP85BKsdlyHTdJ+gChrnjiUOeHMaOielwO8mHin/lIcL0K6vUDb9lE
         CJ26v8hgRXLYnAg974AuwzV6IcSdt+Pp6yo/J/0nDGJGueTz27TUvRRzqIR1NZPINC+u
         ig3qW7yp3j7ROiLtsAjkhLTLPU3TJoHt5CQAw4MGtFcZyKnhQ1LwwyHCbOTmmS9xz9h+
         XDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0ZaESGZ3DWR6K/cxMbCNQ7xXLmeAeWLAg5uKrlD7nss=;
        b=sF8YC+E8EleUtCobKxV/L9mCVT+Bk5HyAiGczPOEqokvnXrkoqNihK9ZdoskUG0kVP
         13qZbC0lTtMuQLBMKKRj0AAIk9D8qeO6hdsuqlE88yD2/G9LuG9IbSGu+zdQhhu9uXkr
         bhtAI7ROwvYv2PUhnVo0NAs8wa3OuIymUGvNrUdOo97TdBtZHXHnSeB8R0REZsRMNJL5
         6xf4DjXNxxCwdOJHuxB75de6Z00XbwXo49smg2XRv+C80OHWoyzMql0y/5Nh+Rwrs3LT
         sbJenc5cgvsuU7ODX8MnEp2/eCQ/614Uf3QsjXV4jM9WqD00jw1q0jJgLp+5DHi7j5DU
         wzTw==
X-Gm-Message-State: AJcUukd+eUMgIHPpCejKxVNLWpg5AnNBgT6uEQ+66moMmzHRaKhS4h88
        OjL++WWWE5W/qrma80CJ6LjlTdlr
X-Google-Smtp-Source: ALg8bN7+4Zf1q7pboqkBw450C/WUjs+/i30Vi9woI5D3ULEV117LJYnJmb8qpHjZKh1KipCbakhC7g==
X-Received: by 2002:a62:6dc7:: with SMTP id i190mr4326578pfc.166.1547004320678;
        Tue, 08 Jan 2019 19:25:20 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id e128sm104427973pfe.67.2019.01.08.19.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 19:25:20 -0800 (PST)
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Yanjun Zhu <yanjun.zhu@oracle.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
 <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
 <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
 <a1a71d06-9c1c-7e18-0e24-103fa89facf2@gmail.com>
 <a861dacb-c992-13d7-5458-09445183655b@oracle.com>
 <54c2efce-18ac-46d4-7fb5-8510699b528e@gmail.com>
 <cb47b5e1-bac9-b44b-8b47-9e654c7cffc1@oracle.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <b35bda34-e507-5af9-051d-5d15c804db68@gmail.com>
Date:   Wed, 9 Jan 2019 11:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <cb47b5e1-bac9-b44b-8b47-9e654c7cffc1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/9 11:24, Yanjun Zhu wrote:
>
> If you have forcedeth NIC, you can make tests with it.:-)

Ah, I would like to, but I do not have the hardware...


Best wishes,
Jia-Ju Bai
