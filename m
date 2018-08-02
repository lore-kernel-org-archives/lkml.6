Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620AFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06883208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwYxIE7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06883208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeHBEcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:32:25 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44393 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBEcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:32:25 -0400
Received: by mail-pg1-f177.google.com with SMTP id r1-v6so361455pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 19:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OBHs2kurEdkJWw8/esjjVtV5dWZZ3HkiBKOBuurG/kQ=;
        b=kwYxIE7oN+IY/WpickmgIRBOhF6hdsAV3N7Kw4MEtKqcHqmf2YH6As+OSh77rWuLXp
         BTFRCYo25vJAS3+i5JQfo852tjWI0bR32HoVdyeEVjg9rt3fwDfISVxk8aIrjXArshFX
         EnWjXZc1kP/QVt5DMYssJdK0ymvrapZTu+ZtWgUefXJe8rbVhsgopF1wu5/nFytkQzmm
         +8qSuxMGrmGuGvk2oqzXAcykDVc7s4zPAza+zXruYUcjtl7FQa4Yg0m0hx/8riefync8
         UMr9OIJRRPNfk4/ghjBEJoG8QGERjRTPgJWN7Eo5ub+2YyJVG53ZKJfq8y/cyTkSF9Wi
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OBHs2kurEdkJWw8/esjjVtV5dWZZ3HkiBKOBuurG/kQ=;
        b=VZNlOTcfG+y83eeBR+vwEVylffUYzYJmeJhx9MbKi8kBkQdCmbX3wi/Cm53uODvXoD
         POtQCtd2G5VsEHnyAl/Na+SmbC/wk96bMbLR1UbmU2Yp8sD04G+qFLgHNGCEyZgVIuDe
         p7pJraW6wLGsfX8fayrus8qrts0Ljl+YuAU95o7g5hydgASIbsiiuap7AMsJRDxVma4Q
         2oHvctQIG45UNLr6JZRvvpgbHPfT+p7r2LnOT/wwDapC90Rt1vsbTzEGc4t+0zAnMRro
         vqMjfcyJoJeMt33FaSY9/ftoH5B1ciy6uGGaeHml63OOWUcVXnpVMTn1h6f00bQHYbU8
         ZbDg==
X-Gm-Message-State: AOUpUlHWsoyT0ubBXpZdipmD0cQnPKrBR98JCdI/ZJbQ03+h1EZhF9Bp
        1nsGb4VumkF84mV+BvOIYeU=
X-Google-Smtp-Source: AAOMgpfpI/6zO87Rts1+DkAYBSlgL2S7u2giQoxWG203aPmldYlDWYGubcY5sJSqWeNw3XUsCzDAVw==
X-Received: by 2002:a63:1c13:: with SMTP id c19-v6mr868390pgc.332.1533177812955;
        Wed, 01 Aug 2018 19:43:32 -0700 (PDT)
Received: from localhost ([175.223.34.81])
        by smtp.gmail.com with ESMTPSA id i62-v6sm424898pge.66.2018.08.01.19.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 19:43:31 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:46:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [linux-next] DDC responded, but no EDID for %s errors
Message-ID: <20180802024648.GA499@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My dmesg is filled up with these errors

 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[..]
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
 nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[..]

Basically, a message every 10s or so. Any chance we can make them
go away?

	-ss
