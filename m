Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DrtlBXQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9B1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJRHsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:48:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46277 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:48:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so13938923pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VouO04QRaIBjzO+RSNJ9hEYO7dF/UmzI2scWHWf/bk=;
        b=DrtlBXQCohvGNZnl38voyWsyjdZguj/ylNWj8RZbD35CKbzr42acg/caPP/BRff+le
         ucoTmyJ5Hj0z69RXaDoyPfKMNuy5fYjDUi1YBAwJE0Gfh5B0VKiyYMHw9V94D96crR02
         e7XewtcER2t2Glj1eBZdeZ+aOa6ikl5pbGB18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VouO04QRaIBjzO+RSNJ9hEYO7dF/UmzI2scWHWf/bk=;
        b=RtZUikX1k7qjoQB2o7JEDyBgYm8qu/SNDp96WyugCLFOu3+8eI8aR3DoTIcSzTnz3A
         dnD4VBw3VpO150vw+uJ6s7aTnyvksOez3WPmsVX+7g97Lwl10G+bMMjE8thClcV8523e
         gUcwYKFPuncZerjDvqLogZAj9HgAoZneVFC33iBSOPn03MkQETCj0zEKyGJQPSV2algJ
         7TR+tFVZ80Xhkw+FOjQiFZoC0rHMM+YjkI2WWuOTqdP/IrV78Vyijc9j73t5PH0dVROC
         e0J7h4SG28aB+a1dL7MJyks6+QAtcj7rA69papO5yKjG68FVbqoR2fwsPS7AiYGAJmoH
         yYmg==
X-Gm-Message-State: ABuFfogEv7Y5BiwNbKs/QvOSC5pYh86ndFEB3F6qrIq1krXZcEo80KQl
        dwJ+RHMfv/QgodXXK69mSYrnBg==
X-Google-Smtp-Source: ACcGV61cFSfdBntPaVH1T9pN6hAm56tnIi+5nz/5xF7SjsQrRsb87YoutZ0ki2ho/BT1VYXOE5Zjig==
X-Received: by 2002:a63:de46:: with SMTP id y6-v6mr26182145pgi.198.1539820200300;
        Wed, 17 Oct 2018 16:50:00 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 187-v6sm28544629pfu.129.2018.10.17.16.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 16:49:58 -0700 (PDT)
Date:   Wed, 17 Oct 2018 16:49:56 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20181017234954.GA179852@rodete-desktop-imager.corp.google.com>
References: <20180925080607.30565-1-bjorn.andersson@linaro.org>
 <20180925172943.GA118699@ban.mtv.corp.google.com>
 <20181002193445.GP2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002193445.GP2523@minitux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Sorry for getting back to this late.

On Tue, Oct 02, 2018 at 12:34:45PM -0700, Bjorn Andersson wrote:
> On Tue 25 Sep 10:29 PDT 2018, Brian Norris wrote:
> For the record; I did consider making the rmtfs implementation the one
> driving the remoteproc state through /sys/class/remoteproc, but that
> would not cope with abnormal termination of the rmtfs implementation.

It could, if you had rmtfs always power cycle the modem on startup. But
we'd be in a bad situation in the meantime, so that might not be great.

> I will work up a patch making the remoteproc driver observe the presence
> of the RMTFS_QMI_SERVICE and see how that looks.

I believe Sibi Sankar already sent a v2 with the rmtfs driver doing this
instead. He also replied to this email with slightly different
suggestions; I'll try to reply to both of those.

Thanks,
Brian
