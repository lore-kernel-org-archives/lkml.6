Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA375ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B65D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhFchaRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B65D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeGLURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:17:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43863 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGLURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:17:23 -0400
Received: by mail-yb0-f195.google.com with SMTP id x10-v6so11884776ybl.10;
        Thu, 12 Jul 2018 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y39yJZG85Pi3vFzIbIKeyVWfq409KDQTEBZQnFve2Ww=;
        b=KhFchaRMIsyEbkDTf2QKLFSAGassw9VOBS/JuLsfaIEU8dsdj9GGhMFqq+IyA2Bl1O
         5IRN2tz+ioTehuwY6LtOi2ctzhryLri+/AQ2SyDHwwgpnaUWTjC9In32QoB2HmUr1Qk8
         WJmsNpTPUVwl/9c/zYark9dVDvTWVdIFsa4zLkOltzoPLC5QeCyScG0BdczWPXLjORBQ
         NQWtyIP4jfWRPeIWf/ChK26ldVrwkjbr4tHzCLCqNZRsGXcUR8vywfqKk/w/KBZCHqVn
         2DybPidFHJXj8LG6PoH1CQ0UCJySrPHZuWgVaS6CRwqinQYnnHq4b3hTW5D3KFsqIOm2
         U6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y39yJZG85Pi3vFzIbIKeyVWfq409KDQTEBZQnFve2Ww=;
        b=ZVWrQBzRk0u3WRwDBmBdqxOL1OHktyUzQjPltYNbhCP8fU0TMQ3NIQy4JGwVJc55ro
         tkruLveRaxEcw4PnDC7TAMO7oBTqnr2zVY/Bth0z8SlKRn+Wckzn0T8yE2f0Jbe4OY7w
         DX0UOOdnr+AX6uFZJ2bdgA7KptBsC6GJoM1yEj4IO33KMAas1dy7VzAGZp2qNLlg3cfZ
         NxC4pircbjJL140//OJa5sDBDl3Lps9hWqT5q34XpeFhT+ZyglHsNwemQB/8dp4vjmdI
         bK0NWWsRpNqnmc2L3EK3y5NpCGAxPIyzi4H6dL9VdyZ7k+qKMeZYEg5ff+7hx+bLMp2E
         FUDQ==
X-Gm-Message-State: AOUpUlFXYvfgk/Hc9GfzgSy0Wf+WEVhuUnfF/WwRxce8rQRpjIVqVFfE
        5PB1LBRnMc0cNjqmWD79iGg=
X-Google-Smtp-Source: AAOMgpfCB+Ob/tKiYCjVpdQ2ufSw+hI9dEmYVyVUZm3BNQFWjqLqy8+salXhgQAIvCY8WZh/It5reA==
X-Received: by 2002:a25:aa0a:: with SMTP id s10-v6mr1974921ybi.63.1531425976961;
        Thu, 12 Jul 2018 13:06:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:a01e])
        by smtp.gmail.com with ESMTPSA id d11-v6sm10189341ywd.1.2018.07.12.13.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:06:16 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:06:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: Guard ata_scsi_dump_cdb() by ATA_VERBOSE_DEBUG
Message-ID: <20180712200614.GL72677@devbig577.frc2.facebook.com>
References: <fb36a7b0-74f6-2a0e-0826-fd1561ec7790@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb36a7b0-74f6-2a0e-0826-fd1561ec7790@molgen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:29:44PM +0200, Paul Menzel wrote:
> Date: Sun, 8 Jul 2018 09:11:34 +0200
> 
> Defining `ATA_DEBUG` nothing can be really seen, as the log is spammed
> with CDB messages.
> 
> Therefore, guard the print by `ATA_VERBOSE_DEBUG`.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to libata/for-4.19.

Thanks.

-- 
tejun
