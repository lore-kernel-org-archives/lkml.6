Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0621477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TUpr8MSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbeHPFkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:40:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51228 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbeHPFkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:40:23 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so4447184itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=4NjXMMZ3A4BysZWBrPKppSZgGP8FIbTNVKf2oftvaPY=;
        b=TUpr8MScVCFXjx1mNDA79c+tZSwXLkXRxuYsmKZNDJa/6I6GegawemjiRK/ImHcZ95
         wM/nYTHItk413RGzJRwEXmVtPOMkUmHKaGot68ZgJ4gyb1x2pozdBrdFGoeZgVo9BqJf
         LlR6Q7af5llL74Tj7tbqGPPlu5BMNXTvDGu9gFzVE/jQS1zHY+6RSztv9vh+SjPCgc7u
         Vchha4XkDjtUOoOVt1AgeYus1VLql41OJu7F8G1I07n44XUX8C5nykva4XEAXp4wTj+7
         aaJATbxt/GPsUP3mxHrqPfTLKDoNGwfLPWPgUHXF7D/xiSctKqC8FAPsTRYXL6tNdmnC
         q9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4NjXMMZ3A4BysZWBrPKppSZgGP8FIbTNVKf2oftvaPY=;
        b=VHsqnpfvKbN8g+uCmhONDtxv79LNV0618q5gNGIkvmTMxO+Dd8ewZLBRXbv6dN98yc
         DITVuL2UskmRMmHkKcUFZiZVxaG/cvLVUWmDpxNuCWg8Mez7GGIUnjsdzro3LnynP1MK
         XYxxNyxplCOyJU8YMvvXVES9tVnckk5U9nozmRV0NVWbxVwQ7noj1LhmUPrhW4BXLvgJ
         va7L36BXUlBjoR3zAyjhK2xwLvwzghmqFnoYjrw5baROFYEU4VnZRmqok2m/f4I734Hn
         hSpwUTaGSbzRJkfIOXvFQWT1HLkKVj1QGexaqGQHo3JtQsfSLTD9+NVzwoTUkz08RlEC
         JUiQ==
X-Gm-Message-State: AOUpUlGvh5MU8Ik8UxNBwyIKx5qwYu/bTVDFMfEeWCa99muTVG0v82F3
        /ZJAXfSeMqxInqoEgF5dNYyPlfZIGpq63QoSPAuezw==
X-Google-Smtp-Source: AA+uWPzPt3YxPFbyrBju/clf6/dwdMA79qYHroLiUUsYVf7pSrcd7L4MGLA2jZ4Mu0HCAqNQVXxuq/tONfnFuyQWBRw=
X-Received: by 2002:a02:5f92:: with SMTP id x18-v6mr24376351jad.22.1534387512637;
 Wed, 15 Aug 2018 19:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 19:45:12
 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 16 Aug 2018 10:45:12 +0800
Message-ID: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
Subject: Keyboard lost after exit s2idle on ASUS UX433FN
To:     jacob.jun.pan@linux.intel.com, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We recently hit a weird problem on the ASUS laptop UX433FN with
latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
functioning after exit s2idle. It stops firing interrupts after resume
on any keypress. We thought it should be something wrong with i8042
driver or even atkbd driver, so we tried to skip the suspend/resume
path of i8042 and input devices but no luck.

    Then we tried to hack the s2idle code to fail right before it goes
into the idle state to find out which code really cause the keyboard
broken. It comes with an interesting finding that if it aborts s2idle
before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
aborts after cpuidle_resume, then the keyboard down. At least it
proves that even with dpm_noirq_begin() and
dpm_noirq_suspend_devices() executed, the keyboard is still alive.
There should be something wrong with the cpuidle.

    Going deeper into intel_idle_s2idle() which is invoked by
cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
longer function after mwait_idle_with_hints() which just simply
executing intel monitor and mwait instructions. So I don't know what
should be the next step I can take. Can anyone give some pieces of
advice?

Chris
