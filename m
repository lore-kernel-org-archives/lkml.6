Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B785C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D525534
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlIocv7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66D525534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeGBUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:21:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44172 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeGBUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:21:54 -0400
Received: by mail-yb0-f194.google.com with SMTP id a2-v6so5560725ybe.11;
        Mon, 02 Jul 2018 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KyA6ERUrQi2t2FjssBoQE7hY9B4Uye4FUZD8AuhFbUk=;
        b=mlIocv7xd7WpBixG8FRt5kB81fOGYBR1CSbiYRNcyTEgSPmiXWZracIHS1h02iCLY7
         MUO1itFLSAF+la3tWsXpYDXzdmsNpFyIwwQZISNp5TtFCYMdD7tsjV38IF+O7w92i4oh
         OpgnZpJFMFxTcvqm4UvuVfzhMGnrypsiS+hsAQjRynO/6NEO2gk2diwvAla3BYM38Kq7
         1xOQ93E9OPxiUa5OvBg9MKIbJ5FnneFBSADJnl1Itfaomn/027Pqgz/18ZLjIKWevhmV
         GkFvbRPsNpOnOBCCYUwyNIvGqZvuHlFjRut5NIRgOlQ0u2P1RcFYaUr+2yb/cUYUn8X0
         tArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KyA6ERUrQi2t2FjssBoQE7hY9B4Uye4FUZD8AuhFbUk=;
        b=QKE+tNFd200Zcu8n/c7BUPTvGJQU1rhQDKxBdJbKFevdetwbLL4AZluOhvjAtVIore
         nSNVzn1/3IlLLLBZ7mRQN399CiRnA9cu7MC+zq7B/pr5D3C7W4OBrN+jGKIpQBCToppS
         bHS9dz26tSzaely/jO/YFBR3cADRg3dPriAV+RSqM3Vypi+T4g+uHpY4b+yO+QwYAAyI
         VoxVtT2yyP6e+MHDaw/FHLFyseM4DcQU3ykfnn5YR6t8J0H9YljMYWhoCoE7e3z8zTdh
         kqFhZt0fKllxwVGA5habdFe3jozZFLRnfIVyAFmXhd7Dyo+KJHVFcprqhDaqcLZ8RvJ6
         BylQ==
X-Gm-Message-State: APt69E21t3GZhst3TltZyKsT7DhKlJFhGj2dCxkMLD/o0pEvocL9GIbd
        rjHz2NvtAVYJycrFySHqWdWx68VD
X-Google-Smtp-Source: AAOMgpeYjzhWtcxFKRaA7/Bgc9Tfi+RkfM2qAHKGs+7knC3PE0CFBsd1yfiLkx26L/kW7I5zGC3KZQ==
X-Received: by 2002:a25:bdd3:: with SMTP id g19-v6mr9972466ybk.134.1530562913556;
        Mon, 02 Jul 2018 13:21:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id u126-v6sm6363186ywa.99.2018.07.02.13.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:21:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:21:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Message-ID: <20180702202151.GK533219@devbig577.frc2.facebook.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada wrote:
> From: Srinivas <srinivas.pandruvada@linux.intel.com>
> 
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> 
> Several of these system don't have traditional ACPI S3, so it is
> important that they enter SLP_S0 state, to avoid draining battery even
> during suspend even with out of the box Linux installation.
> 
> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
> user has to either use scsi-host sysfs or tools like powertop to set
> the sata-host link_power_management_policy to min_power.
> 
> This change sets by default link power management policy to min_power
> for some platforms.  To avoid regressions, the following conditions
> are used:
> - The kernel config is already set to use med_power_with_dipm or deeper
> - System is a modern standby system using ACPI low power idle flag
> - The platform is not blacklisted for Suspend to Idle and suspend
> to idle is used instead of S3
> This combination will make sure that systems are fairly recent and
> since getting shipped with modern standby standby, the DEVSLP function
> is already validated.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Seems sane to me.  Hans, what do you think?

Thanks.

-- 
tejun
