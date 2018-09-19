Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C81F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AYCaXj4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C81F2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeISXFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:05:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44086 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeISXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:05:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so2981430plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QW6iusyzj9SrA42zFfqfwOsqr0tmO82bHZCWLBfBktY=;
        b=AYCaXj4qHAaF8UjbaXEdSSHf8Khlo+gIluii9MnDL0GwyxZ7gXfePX4VEKjmY6fvcp
         5fy/tZuM885s4D5AHNaD7l2CdYTHk6sXQa8JKoLywRYIJtuGSGm7UA0flxF0NnBYOJRI
         G8o9umRdzZWL7IGgLTnf7/F9amEvJ1HeyZtkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QW6iusyzj9SrA42zFfqfwOsqr0tmO82bHZCWLBfBktY=;
        b=WKW7Ud4ZAG74k0NTMYQbjtJQhoIsQcIjRvFFSVltE+EaminNs7h1YYq0BFLa+06WHI
         v+/aeyGXKa9tTVqpsfTMT/V/wX27Vz6rfBQ0suQBjC8cua3NSXiTbUuRXKzxomgY6DRd
         FDSDNc45zb2F9+SF4lwfWS5jKyBbIZcjIsa1Rd2McFDmdD1VOxKgw2zeSMGhQSxu0zyU
         C05fGxwzcEAMIbGgEwm/MU0d1sjujL79aZCbpgoBQCSIdepJDMMYJOglwn5F2E/NmOJM
         jmdSdukAgVQCrgPptEP2RDitCFdxJxEJrmiuj9ErX1z4VBdxX8np3/FVuyXuB0R18/Ef
         XTug==
X-Gm-Message-State: APzg51CsREskGLkriWYhXqsV/veJAXZ1LTpN2FCZCwOIEJWVV2jU6D4S
        iglxvbsTfBSZgGL1bFWrK4mfJA==
X-Google-Smtp-Source: ANB0VdbW5pAsjqBBdwFwFCB30TGo1DfxFkijKScjBZ9hGGd+TXrCceOCgcD3ijXzSsC3EIGqlybETw==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12-v6mr34832858plo.94.1537378009235;
        Wed, 19 Sep 2018 10:26:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8-v6sm26586603pfe.163.2018.09.19.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:26:48 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:26:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/1] Cold on & off support for Qualcomm BT chip wcn3990
Message-ID: <20180919172648.GR22824@google.com>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180919152113.7611-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nit: Not sure there is much value in a cover letter for a 'series'
with a single patch. The changelog and additional comments (if needed)
can be placed in the post with the patch below '---'.

On Wed, Sep 19, 2018 at 08:51:12PM +0530, Balakrishna Godavarthi wrote:
> This patch will power off regulators while hci0 down and turn on them 
> back on hci0 up. Every time we power off we call proto specific close
> function, so that we will free the memory of Qualcomm BT specific buffers.
> Will call proto open to assign the memory and turn on the regulators, before
> calling qualcomm setup.
> 
> v2:
>    * Removed vendor specific hdev->open and close functions.
>    * Added hdev->shutdown function to turn off the regs.	
> 	
> v1:
>    * initial patch.
> 
> Balakrishna Godavarthi (1):
>   Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
> 
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
