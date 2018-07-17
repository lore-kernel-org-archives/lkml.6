Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92344ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2331520877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktQUVAn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2331520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGQQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:31:01 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:42670 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:31:01 -0400
Received: by mail-yw0-f172.google.com with SMTP id y203-v6so563215ywd.9;
        Tue, 17 Jul 2018 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4sExYVc44yL99uS2OarcCcbwXMg3T9dUbeLuViEUuo=;
        b=ktQUVAn3Yv+BXq2zN65uuSldkvbBtAj6j5Uiw8bTmBUFL83hKsJMxdVBSEPXZuuO5o
         USwjTAOxu9BwLIpOM8Yw+a2F8SHaZURgXAvecE4baeRF2/leY49GBxiO1OiNK10RtKOi
         2L3tt0jkdv0pBDUIQcfYjmE5K4+Z4wWBlzw6WRTFxJRohEmfDIJwmbt51QNmQ8DSGbKB
         fTWDhKCA9o+1YjF3KURVWpgCh/z8g2JNouJ97edfoeVnU9XBJYblGNDovOq7irklkg28
         q7ullbdgrwwUOt+Gc4YT62AMzdIfCldoTj01UfKnQDh5GmUwkjUUHM89DGii2DOylwOu
         T4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4sExYVc44yL99uS2OarcCcbwXMg3T9dUbeLuViEUuo=;
        b=NvWq9T7axsbpXtp/hpiiUpEl0/WKHEhkJMbQtBQFwOYMlO7PPbuzpNTvBdPsONgY5G
         S6KTCUB/6N0rUuMB+LRqy3aog/absyVFG/pLu+OW9p9aximj31p6s1kTX0zGHm1pa8W1
         G6j3BTgIQBbDnUa7Sp7rx6pCPL/Vn/f+uV7go6TAvtrDeNp6HCOF/o5Ue4vqYJD6dlJX
         q5alU/wVywSXRKX4R79BUbzych3DrjgTCT3m0JTbChzVeEgS7eR/ADDhxDuCVFbVcXu0
         u7qZ7DY2s8wUUQUodA4QHzHEpFYSVTLyKS2AjeByNtCyIjWqcXS/F3vE8EZ1tvEKNQzo
         Mg8Q==
X-Gm-Message-State: AOUpUlG7RAavoX8INT3ne354nkfvMC4PLGZ1FdL+hIZgYIpQuETxB+wj
        uWy0VPtT6O1VvIv2vbOPKitucq3J
X-Google-Smtp-Source: AAOMgpd9uiBxn2zZaB4gw/nT+Sr0S+bF4P8aUn7kk1Fo/1cSuVQbU6X3jlR+Z1QiBx6hlwnMCu1HNw==
X-Received: by 2002:a81:780e:: with SMTP id t14-v6mr1156155ywc.317.1531843062647;
        Tue, 17 Jul 2018 08:57:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:7178])
        by smtp.gmail.com with ESMTPSA id r3-v6sm682302ywr.80.2018.07.17.08.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 08:57:41 -0700 (PDT)
Date:   Tue, 17 Jul 2018 08:57:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v2] block: Separating discards from writes in Linux IO
 statistics
Message-ID: <20180717155740.GP72677@devbig577.frc2.facebook.com>
References: <20180605180120.2726113-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605180120.2726113-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, ping.

Thanks.

-- 
tejun
