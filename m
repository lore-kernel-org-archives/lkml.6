Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ACBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C6D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDCsgDYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfBYS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:29:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34818 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:29:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so11739766qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zEZnvFZQ4qvqz2Xp+2k+yHrN6CfQJ/bFRwyGjvLe5Fw=;
        b=VDCsgDYrv0GjWSGrWd0nvZvnWO0iLPB0Ei3gWdCrviO/7UgteQcPJsAnoHhyi6xnTS
         7pJLhShSqkBlNDGiZWTDB0L4sauk8Fl/Qmp2Se+jFtMayWbqGSTlMgGn6nuZt+nEdpr1
         r/sxDIIce3Lv7UNCZCyi7CJO6+Yj9439oGRFq3FJN5xdcEIJ2tib7aJx6hCb17PFJYhv
         nAjCgbZ+ysvI/1Q0NSOgDoH22wDLByhfShBCY9MFj+Av2AN6ZslOcsyz+DHJhFAQZSRx
         +pmWZgHkgHyO9mR6OgVBVulihfoyu59pmWEUgnNprej/T259EnGZRrwB5LWx7v7N826d
         2P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zEZnvFZQ4qvqz2Xp+2k+yHrN6CfQJ/bFRwyGjvLe5Fw=;
        b=dcbU9CPLPKhpzrPPoxZp/ydypGVH3heWyb/nftWmn+PmSXhEp1pDx3ZJHZ+NCqyoE2
         f1R0yFQVXlQk0wNRJb3NBxm5hnpWXvYCsv0O1xneWSlc8S21idZmFipbaTX4KvYYfhDY
         KppVfqxrarh5HKa51p3hwhQ5zRGxwdoqUuO1/9YUP1/z4eLYQ8ve7bcIyGWnqdYai+wy
         m92V4zV7xnCErYPSgIRYy7CJy08b0G6CLOLSSSctSDbo1tW0739f4uPA0Vq9kj6pwjy/
         zaQlAVW59csmt841iFFMqnnNLvCF4vF4VLBQpxzZ0l2UzvIaa9dVQhFIXlYNEGAWhdeL
         j8Mw==
X-Gm-Message-State: AHQUAuYAzbpKSBvoOl/4iYpYc/nA3gCL1vezQltJABYD5fCYcAOFIKns
        CeD1Oq9GhDyYqTGuCSKqtviC1Q==
X-Google-Smtp-Source: AHgI3IZSZ2RbSSjODvkapWiSMxq9QFArnu7OMQrmQYtlSL3N5Sg7+CR9yq186qeg9co7M6TXGberQA==
X-Received: by 2002:ac8:3251:: with SMTP id y17mr9440551qta.152.1551119354114;
        Mon, 25 Feb 2019 10:29:14 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id v80sm6834590qkv.34.2019.02.25.10.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 10:29:13 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:29:12 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Yifeng Li <tomli@tomli.me>
cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Mike Frysinger <vapier@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC 1/1] tty: vt.c: Fix TIOCL_BLANKSCREEN VT console blanking
 if blankinterval == 0
In-Reply-To: <20190225164346.1359-2-tomli@tomli.me>
Message-ID: <nycvar.YSQ.7.76.1902251314490.1971@knanqh.ubzr>
References: <20190225164346.1359-1-tomli@tomli.me> <20190225164346.1359-2-tomli@tomli.me>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019, Yifeng Li wrote:

> In vt.c, "blank_state" will be initialized to "blank_normal_wait" in
> con_init() if AND ONLY IF ("blankinterval" > 0). If "blankinterval" is 0,
> "blank_state" will be "blank_off" (== 0), and a call to do_blank_screen()
> will always abort. Even if a forced blanking is required from the user by
> calling TIOCL_BLANKSCREEN, the console won't be blanked.
> 
> In this commit,  we introduce a 4th "blank_state" - "blank_normal_notimer",
> it indicates the console can be blanked, but not automatically by a timer.
> Then, we made a change to "con_init()" - if (blankinterval == 0),
> "blank_state" will be set to "blank_normal_notimer" (we have similar
> changes to "do_unblank_screen()" and "poke_blanked_console()"). Finally,
> we change do_blank_screen() - now it will return if "blank_state" is
> neither "blank_normal_wait" nor "blank_normal_notimer", thus allowing
> the console to be blanked even if there's no timed autoblanking.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Wouldn't this problem be fixed simply by the following:

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9646ff63e7..41b17c4b5a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4151,8 +4151,6 @@ void do_blank_screen(int entering_gfx)
 		return;
 	}
 
-	if (blank_state != blank_normal_wait)
-		return;
 	blank_state = blank_off;
 
 	/* don't blank graphics */

I just can't find a logical reason for that conditional return.


Nicolas
