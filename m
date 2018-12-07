Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF31720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544171247;
	bh=0G+JB5IDKSLM70xCfkWICSmxYpy4H+Eq5zqc04Yl8Is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xVHhijwORD7t3JnofngoSBOJHSYcJiaM7Yg78mHBRkK8mSk9xlEmf384MWQH/q4+E
	 h1qUZDXQ5KUUf3xSsykHYTWXPk2W3vxbivsRvqHY5gY4vboQW1KO19udTM+qpKAtHj
	 zmzJ7xzHrB//OZ3/E+KMuVEOcANQOW+Ps4zuBvrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF31720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLGI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:27:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33965 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLGI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:27:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so3095032otk.1;
        Fri, 07 Dec 2018 00:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVsry+TpL4tLe4ztLKEQIrx5ivjL4iVmmn74UXxkvNg=;
        b=MbLA4C7ScsQaI52Ig4RgDPyIwrbCQ8hAb/szqaF2SGdUa/xNdawAZRVLneTu6D+YHM
         oKCR5TWI8XSb+oGoKOvdv/3iEd9DLHcfyLr+rKz3Iyoax4VV+yBygXptXWGNuWXZks+L
         a5JddVSJ/D1qFuE5hDdzwQ44i8/+WjJoWOJoLeGbcmAdMbmMeLBcli9qsj/Elk+suuRD
         MB/pkwz4ucl/8UvDPfZqlcbagOE5R2nlVWj5uKl9GYk7ceiMMLynquA+OvSVdZlh2ngx
         7ijPjfNmk9JA/niBLxWQBUoyNw1oEJfn0AHUsIrmYKVmWH45NXJ6RNXzB9sHdp57lAEw
         8ySg==
X-Gm-Message-State: AA+aEWaK68tm0ueBeUA2YmtOfTKU1ztYACribaXi6ctTgEfl3795mbK9
        sKyEc4GyFjmRXNTZybxTVbrsRMzQSBT3kfS9HPEyYA==
X-Google-Smtp-Source: AFSGD/VuKywzI6ECUoKZCFBJwQ9vBX355mUviiL+y/93xYIhDaXcpOadUwv7U6zhnP7vtfb7AX9CVKlR4/O8oVsg96w=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr888914oti.258.1544171244130;
 Fri, 07 Dec 2018 00:27:24 -0800 (PST)
MIME-Version: 1.0
References: <2047881.s5VBHReNGT@aspire.rjw.lan> <20181207075840.5881-1-hu1.chen@intel.com>
In-Reply-To: <20181207075840.5881-1-hu1.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Dec 2018 09:27:12 +0100
Message-ID: <CAJZ5v0g6cw7WS9Jv109AJU2HTLzGr9BE_LJ=PGFxRNGx9SHVQQ@mail.gmail.com>
Subject: Re: [RFC/RFT,v7] cpuidle: New timer events oriented governor for
 tickless systems
To:     hu1.chen@intel.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 9:00 AM Chen, Hu <hu1.chen@intel.com> wrote:
>
> From: Chen Hu <hu1.chen@intel.com>
>
> Hi Rafael,
>
> I run several popular Android performance benchmarks on teov7, using kernel
> 4.19.0 as my baseline because I happen to work on it. To backport teov7 to
> kernel 4.19.0, I also backport patch 5f26bdc: "cpuidle: menu: Fix wakeup
> statistics updates for polling state". The teov7 doesn't show regressions on
> such perf KPIs.
>
> Compare "4.19 + 5f26bdc" and "4.19 + 5f26bdc + teov7" on Android with Intel
> Apollo Lake SoC:
>
> Test Case                               Diff after appling teov7
> Antutu_6                                0.51%
> GFX5_openGL_Car_Chase                   0.43%
> GFX5_openGL_Car_Chase_offscreen         0.25%
> GFX5_openGL_Manhattan31                 0.75%
> GFX5_openGL_Manhattan31_1080_offscreen  -0.10%
> Geekbench3.3                            -0.13%
> H264_1080P_60FPS                        0.00%
> H264_2160P_60FPS                        0.00%
> H265_2K_10bit                           0.00%
> H265_2K_8bit                            0.00%
> Resume_time                             1.31%
> full_boot                               -0.39%

Thank you!
