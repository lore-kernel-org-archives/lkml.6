Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26185C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBD214DC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n8Ko9l2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFBD214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeHQE7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:59:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46284 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeHQE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:59:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so2807068pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6gqsvwalt8gEkd2QonKP8r4uTaPxABeMG2/1QtznoQ=;
        b=n8Ko9l2bxCI6Uf6TOi80mqRoSG2tebBnSe4kBND/UWLM2+ZXDY+Hs5MrnItTMe+iib
         HuwK6M0Hm6ZfXxTQ1U9Lj8ZBGZ+kT8iiF7mr9O9EsuSZ3V6OOwv6ucIRJ0VP3fJ2wZFi
         G2kooBNhnubRc5c8XqCmXOmKFlfCkmrSPUPDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6gqsvwalt8gEkd2QonKP8r4uTaPxABeMG2/1QtznoQ=;
        b=omZeax8PwCiFS1RUwR5hu7QRDx1xON01e4uvjFbzRILxQ81zBylziWZLIRS6aA18Uu
         dLVk2xWTKDjwnzcRqt/w2Cr12PVpUhta2KRnq9fVaNGE8aP+bG2kyUdJg2+x+b/3BxTp
         8pWTa+ACyCK9/3uT+QTntDLA7Ejem9d5irF7d7OSujQBSWcy07CI4IcMpRouVPQU9o7H
         jw30S3E3D9bRBof8G5aEqpn4azr2329UrXCpbLWCRkr1iHOzhRL+AA8LJwZ+Y7aQkkoI
         RSMi8a3N32RLyTG85TdrEPhVwdXrcizrTjWC8pG3Xsn7U1x5XrwzpZLrnagj6YnMFYin
         tZYQ==
X-Gm-Message-State: AOUpUlHDzG71eCwbCccivlbMcUav7MFLPLasv0DbfM+DLXcpxdSGhFmD
        UnFHnMDhqtbdHPtdbU/96N9Sbg==
X-Google-Smtp-Source: AA+uWPxolJxxXJbxQGn9u7XDu71vjPkII1VidevtNuuOY5W1CLgp2nIXL1QXmqKMFl6/pFy41UqNzA==
X-Received: by 2002:a62:ad1:: with SMTP id 78-v6mr34699837pfk.57.1534471062754;
        Thu, 16 Aug 2018 18:57:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id n12-v6sm751508pfh.146.2018.08.16.18.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 18:57:41 -0700 (PDT)
Date:   Thu, 16 Aug 2018 18:57:41 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org,
        tkjos@google.com
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Message-ID: <20180817015741.GA3039@joelaf.mtv.corp.google.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:17:38AM +0100, Morten Rasmussen wrote:
> On asymmetric cpu capacity systems (e.g. Arm big.LITTLE) it is crucial
> for performance that cpu intensive tasks are aggressively migrated to
> high capacity cpus as soon as those become available. The capacity
> awareness tweaks already in the wake-up path can't handle this as such
> tasks might run or be runnable forever. If they happen to be placed on a
> low capacity cpu from the beginning they are stuck there forever while
> high capacity cpus may have become available in the meantime.
> 
> To address this issue this patch set introduces a new "misfit"
> load-balancing scenario in periodic/nohz/newly idle balance which tweaks
> the load-balance conditions to ignore load per capacity in certain
> cases. Since misfit tasks are commonly running alone on a cpu, more
> aggressive active load-balancing is needed too.
> 
> The fundamental idea of this patch set has been in Android kernels for a
> long time and is absolutely essential for consistent performance on
> asymmetric cpu capacity systems.
> 
> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
> 

Thanks for posting these, we have been carrying it in the Android Common
Kernel for some time. They have been useful for Android systems.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

