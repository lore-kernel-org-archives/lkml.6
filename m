Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79501C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF99217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182502;
	bh=jKIOtHtYIjNVoYDv9/gqoG/CLObhDNxU4rM5+lRqT/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lBZDY8BHBtMZD2ZScyD8JHYwjfgqYWPLRcc1oEJPVWP1ku96nNPhfAIGE5IBOvLKD
	 6HzLmuz0nKqUFtD8PmJvQNCEq+D+ViMBL8UcIRV2YvqeywwiveUg10mu3stX/G4Hvs
	 wcPAVwFadePJBBZeXhwxdpEjsxi78P4LlJZK0bXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAVSll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfAVSlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:41:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C6B21726;
        Tue, 22 Jan 2019 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182499;
        bh=jKIOtHtYIjNVoYDv9/gqoG/CLObhDNxU4rM5+lRqT/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCilTL59ZqpNDxrrHUebgi77y1kczgOwIMNwf1eAMvzsTfz18mFnVSAgMoLdbSS+M
         3Umf3ucPGkPM5T4KLcOr4lhEHdggmbExEq5KDmClncgGHRAjLTc8cxVdxvmWkG++yq
         /gnvCcbTvqRuYFe54FmMg75CaBf70wvxx4nhWR90=
Date:   Tue, 22 Jan 2019 19:41:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rafael@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2] PM / EM: Expose the Energy Model in debugfs
Message-ID: <20190122184136.GD31777@kroah.com>
References: <20190122164247.19439-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122164247.19439-1-quentin.perret@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:42:47PM +0000, Quentin Perret wrote:
> The recently introduced Energy Model (EM) framework manages power cost
> tables of CPUs. These tables are currently only visible from kernel
> space. However, in order to debug the behaviour of subsystems that use
> the EM (EAS for example), it is often required to know what the power
> costs are from userspace.
> 
> For this reason, introduce under /sys/kernel/debug/energy_model a set of
> directories representing the performance domains of the system. Each
> performance domain contains a set of sub-directories representing the
> different capacity states (cs) and their attributes, as well as a file
> exposing the related CPUs.
> 
> The resulting hierarchy is as follows on Arm juno r0 for example:
> 
>     /sys/kernel/debug/energy_model
>     ├── pd0
>     │   ├── cpus
>     │   ├── cs:450000
>     │   │   ├── cost
>     │   │   ├── frequency
>     │   │   └── power
>     │   ├── cs:575000
>     │   │   ├── cost
>     │   │   ├── frequency
>     │   │   └── power
>     │   ├── cs:700000
>     │   │   ├── cost
>     │   │   ├── frequency
>     │   │   └── power
>     │   ├── cs:775000
>     │   │   ├── cost
>     │   │   ├── frequency
>     │   │   └── power
>     │   └── cs:850000
>     │       ├── cost
>     │       ├── frequency
>     │       └── power
>     └── pd1
>         ├── cpus
>         ├── cs:1100000
>         │   ├── cost
>         │   ├── frequency
>         │   └── power
>         ├── cs:450000
>         │   ├── cost
>         │   ├── frequency
>         │   └── power
>         ├── cs:625000
>         │   ├── cost
>         │   ├── frequency
>         │   └── power
>         ├── cs:800000
>         │   ├── cost
>         │   ├── frequency
>         │   └── power
>         └── cs:950000
>             ├── cost
>             ├── frequency
>             └── power
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> ---
> 
> V2: removed check on return value of debugfs_create_* (Greg KH)
> ---
>  kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
