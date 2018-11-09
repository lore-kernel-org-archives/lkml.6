Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5887C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgfxpAwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4E720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeKIVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:25:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34009 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeKIVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:25:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so978147qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding
         :subject:in-reply-to:references:date;
        bh=7C+NUlU6N/PgacPQ5uFXIgLOoCzqESo5FJDTf+82I1g=;
        b=YgfxpAwh33f5AadYmL5QPZz4rSHU8We6K6uAR6qPw+IdXZzSCPSus+B3kshU0+D6Nd
         lviHEWiXaaZbq5n6lkBasRT3i4wzadSStfUhIKRkqoQcNK1RWJUJFRJZ3Z8yzV7gO/Jq
         Aj2G/K94A/wYoaF0fRcC6yTEF2+Q4U8Gdu078=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:subject:in-reply-to:references:date;
        bh=7C+NUlU6N/PgacPQ5uFXIgLOoCzqESo5FJDTf+82I1g=;
        b=mQwspaqkZ+AwDBECtU7+dMGYWzXujvN63BEIs6s+L10TGVeB50G2Us0vr2T5xlT7Pr
         aFWp8GUlJts91T2uuNNpt/leG930HJy2K7FMr/DABEzxH0+HON8Qtv9MbZrRacHNbung
         lwKZiuLmdIwiNbCEo13sNA54fO9pq4JDQ/1HOB4r+KnNv9gOh3piDQ914Yg+KY0mHJre
         53HBiTlynxT8tpKeKUcMzhHAa/wPwVUNvQRnz5QQO+L0oCN+qQdaj2SmYhWUqGYIJjK3
         Aab7M5M9wXTnjs7NVqG53llleDMK/dUxaNjvcY4XNolmrWlzoPTInGW2X+0DIcjJ/vYR
         XoHg==
X-Gm-Message-State: AGRZ1gIfpND6BJ+lvj9WWCqAJbygtf6lYOwtNP9KZWZJtc+LiMZSuL4U
        uMGIsYhhEQ+wyW0++vX8//CcMg==
X-Google-Smtp-Source: AJdET5e/4TYkJUi4nVsy4fwX07SfoS76mxqrjWJHptIA/jJ1bYNaVyTfVKC72/EtC9YZIPDbsmvirQ==
X-Received: by 2002:a37:15a5:: with SMTP id 37mr8086742qkv.292.1541763938733;
        Fri, 09 Nov 2018 03:45:38 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i26sm3272329qkg.12.2018.11.09.03.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 03:45:37 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id D8A7C23163;
        Fri,  9 Nov 2018 06:45:36 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute1.internal (MEProxy); Fri, 09 Nov 2018 06:45:36 -0500
X-ME-Sender: <xms:YHPlW3pAEpLU_3bAw5WQu4agU_iHKjRt8ub4WgIB7EdMq-f9fLvbZA>
X-ME-Proxy: <xmx:YHPlW6s4oYrpUvrMsOc4pEEkFA7GEq8clk7Vkap3rHvywTPP_WGIgQ>
    <xmx:YHPlW3Z5KWs6np2W5v6vtCYXBtNPsoQBeW3GC9NoL_c1ujdybmYCSw>
    <xmx:YHPlW8_ENkYZEt_h5qB_xsa01kv28lSFGkB2SRcHZbt2I5641NXY3g>
    <xmx:YHPlW7oj2x_-G2i0JQpBt5BAarTPpP0WJB7ga1DxBxVbLz62Osqm6Q>
    <xmx:YHPlW3Gkzl-5bVNSJlyLeu8wF0xeF5XrixOhv5sUhkGGI7ACq8Aa2Q>
    <xmx:YHPlWyfNhTmStyTBshRVuuUQhyjZfBxUgfI8fSTxotUuKFJ86yvYadf9JGZhpjEZ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 5C19D9E49A; Fri,  9 Nov 2018 06:45:36 -0500 (EST)
Message-Id: <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
In-Reply-To: <20181109114123.GK13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
Date:   Fri, 09 Nov 2018 09:45:36 -0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018, at 9:41 AM, Cyrill Gorcunov wrote:
> On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> > Merge proc-self-map-files tests into one since this test should focus in
> > testing readlink in /proc/self/map_files/* only, and not trying to test
> > mapping virtual address 0.
> > 
> > Lowest virtual address for user space mapping in other architectures,
> > like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> > guarantee that when MAP_FIXED flag, important to this test, is given.
> > This patch also fixes this issue in remaining test.
> > 
> > Link: https://bugs.linaro.org/show_bug.cgi?id=3782
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> 
> Wait, Rafael. But we will loose the test of mapping virtual address 0
> then. I though you would move testing of virtual address 0 into
> a separate testcase. I mean testing of first page was a positive
> side effect of the former Alexey's patch, so we definitely should
> keep it on x86 at least. Gimme some time I'll try to address it
> today evening or tomorrow. I think this way everybody will be
> happy: procfs get passed on arm32 and x86 will still have first
> page testing.

Ohh, my understanding was that this was going to be addressed in some other test, like what you said.. I did not understand you wanted me to create a test for it altogether, my bad. I can do it if you want, let me know, pls.

Thanks!
