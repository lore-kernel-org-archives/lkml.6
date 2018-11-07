Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AACCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240962081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J3AL4yUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240962081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKHFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:12:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34599 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHFMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:12:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so15858869ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ogO04l67QrtAJ/O6VzeozkfRVw3EdlHoB1F4zuJ9fY=;
        b=J3AL4yUTHWuTSpvInmSCNMmjbPsV/Bf6wPlZDnv2jDlyAmvZF/QC/3/g1BMZqKAItq
         0p9YC8nyBEkz4UIlF1PeMdhFLPL27fiFqNi/fzy9Q5WwlZ9HOB4kqKmRQa81BFlNnxIH
         kGWnaaV5TTP0b0w8pqyVSZkvdsgISTf7Ms6qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ogO04l67QrtAJ/O6VzeozkfRVw3EdlHoB1F4zuJ9fY=;
        b=P34g6AKqlMl/NTqg6S8OlFj2//jk0yESga1gOqKhjGc67KSBItxJvsjpKgFi+gKHNB
         zMSo2ufom7bWlPZmDdc2RYv7EIv83bN9BboxOmWi9mX+o0PwcjAvN1CST9pFp2RLccUg
         v8/jfT/Nu8K/b+2OlHG0HPXYW+71woHip/yDZZkYfVDzsFZSPkaSZxZ54V0KIB9bsYqJ
         l2mSZS6XMOJQqhjYa+W5kxA1DD0OjWIkZcQ/56skAr1XiVFamxERC161ZhHxvaLpC5pD
         4fy+hclJwFwGvJaGL0jZDqoEStnBtePY7cBvPhieeQ/1eXzgP2MCd+AwPFT0IakhEnKi
         OTWg==
X-Gm-Message-State: AGRZ1gJS0/pRvwwq/g/keLK9zBXAhVYBWf6ky7lbEhlxcF4BjCEZ2puN
        cN2/EU9pMoy2lF09PUuJ5SVoxhyOIdc=
X-Google-Smtp-Source: AJdET5f5OjhqRRCicX4un/qhNv3tyr0CmLt5m19RbaM9BPIH4Jh+IjNnHzYst530t/fhIBN+2nArwg==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr969517ljj.95.1541619628318;
        Wed, 07 Nov 2018 11:40:28 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f15-v6sm331019lfc.9.2018.11.07.11.40.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:40:27 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id u6-v6so15858761ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:40:27 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr951285ljh.59.1541619626780;
 Wed, 07 Nov 2018 11:40:26 -0800 (PST)
MIME-Version: 1.0
References: <1541616529-6076-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1541616529-6076-1-git-send-email-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Nov 2018 11:40:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz-QUo1h=PW5DuNaRoatUrvrCX0Qc5=7rtro1VXzkDvw@mail.gmail.com>
Message-ID: <CAHk-=wjz-QUo1h=PW5DuNaRoatUrvrCX0Qc5=7rtro1VXzkDvw@mail.gmail.com>
Subject: Re: [GIT PULL] hwmon fixes for v4.20-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 10:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> - Remove bogus __init annotations in ibmpowernv driver
> - Fix double-free in error handling of __hwmon_device_register()

Pulled,

             Linus
