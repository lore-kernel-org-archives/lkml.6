Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05639C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CA20869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3aZuUAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIGCNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:13:52 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39555 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeIGCNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:13:51 -0400
Received: by mail-pg1-f174.google.com with SMTP id i190-v6so5877552pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=shK8xQOV0iZA0Hl6ygjlS8pbGTgNYNHtaw3+bWJpi+U=;
        b=A3aZuUAXYs602tgIE3w+3FyhLYyly5VS3Gv89ZLr01cnvBFU/b6I99F5AVc6nMYJwy
         IPmfTvMuPjqCKWr2AdZ835YPWc6hxIVR7oTgqWjYddOmUPu0BhrCKnDcqrXyiYy9Kt73
         /e2tV76WUIqCnYMX3tdxD8x+GOgtaSz2b6+UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=shK8xQOV0iZA0Hl6ygjlS8pbGTgNYNHtaw3+bWJpi+U=;
        b=OsKlb44gvRYaJOkFUut62Mp+U+QYMDpaP8GN3y+ik0Vo8wx1Epu/5n33k6JhJJT3qq
         QzoEtQjmfcNZ2LuPp6hRXA6XRs0+hF7fGcKoVfhneN8WK5NGOPsDtr1ze4nW7iMWrXCB
         r+JvA2PI6uHlgOFuu2qHSnfl/LSRv/4L/hwe71wqVTtetktRiiaOAch2kjG8e41f3XfV
         xyPWBU6Pg8MiPJrlF4mLWO8dFEz4BcdU4AC2GLlZMzsQIoAbX80aDPgF1CdQNcqZChi5
         atOqHKze2rPWvPa3J16rrbsw3cdePbylziG+kFEizIwqOHO/Pn1piSkY/MZqoEDgsTW/
         4xSQ==
X-Gm-Message-State: APzg51BUcMESbVfZIAZ8WAwGFtUT3H9xadWiTcCJabNefgh62dI3QmsA
        rldEc85vJuLaEkWmKHirTWN9fQ==
X-Google-Smtp-Source: ANB0Vda/QQbMivu5f06loRKJNrYE1A5xl5rvMS162y5CTjlLAJfZ8uZ6RQ6My6LAnNqT6nKdbJcUjg==
X-Received: by 2002:a63:1e0b:: with SMTP id e11-v6mr4983963pge.44.1536269785808;
        Thu, 06 Sep 2018 14:36:25 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id i185-v6sm8544067pfg.89.2018.09.06.14.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:36:24 -0700 (PDT)
Date:   Thu, 6 Sep 2018 14:36:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org
Subject: [for -stable] commit "c82919888064 ath10k: fix scan crash due to
 incorrect length calculation"
Message-ID: <20180906213620.GA72542@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg / stable maintainer(s),

IIUC, this commit is a good candidate for -stable. I just hit the bug on
4.14, because of new vendor firmware that noticed the mismatched length
(an internal "assert"), but it seems like this is equally problematic
from the kernel side for as long as this code existed [1]:

commit c8291988806407e02a01b4b15b4504eafbcc04e0
Author: Zhi Chen <zhichen@codeaurora.org>
Date:   Mon Jun 18 17:00:39 2018 +0300

    ath10k: fix scan crash due to incorrect length calculation

Thanks,
Brian

[1] I guess that would be:

Fixes: ca996ec56608 ("ath10k: implement wmi-tlv backend")

which was in v4.0.
