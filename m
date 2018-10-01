Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922F52089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfJzutFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922F52089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeJAUD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:03:57 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46418 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeJAUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:03:56 -0400
Received: by mail-pf1-f180.google.com with SMTP id r64-v6so2807286pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n/rNsv6Ks/X3+cHeS+UjElVMJRmBM9c415nmcWDo8n4=;
        b=QfJzutFNWQ0IRfOpTLfHWNAWWbiApm/o1E4gor+PRjLKJmhxU0hadiwpFdi21ZLOPx
         hRAmC059UKNJ5c8+tV2vxDDQ5ZTx6XMEg0bvqQC1VgrDkykzYE7Z+PFU3qeSvtcK1IZ0
         BF/nNCyhK2oIFjGIiegkCgIGIn1caMGPmiqjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n/rNsv6Ks/X3+cHeS+UjElVMJRmBM9c415nmcWDo8n4=;
        b=PwDHBM1cDz4QaQH7elEmfhYTD04Q7HlynOqCtIas6Vm1hqH3ghi849cU3OxXxfhQPe
         kLtw8wTo8PKUJxsUJwgHxUdOtH7pWtAn4b3GrZ7iFPcjfPWFFu5/7g4x9AElVY+QJDQ+
         IiY3jpFXuJBZLUBhAyD5n5m1VCGnXtZTueHsQffHRi7LVCWgTV/683uQcbcP+BEC/UNC
         vRTfHaXD8Pcd9/qmP/onUVqRqi6U71QbGOX5SsqjtipqR9xRMyo6RO1gqcX8+8gdAjwF
         SDiiOGNqYDI7tEy4m9zwiNosIvE2QPI62GaD72foS+6azglubUJgn8g7x7qL5VQHI/dg
         7U3w==
X-Gm-Message-State: ABuFfoigihQGFDqqmVJkrIa1XSBljGOH0duLjwNmXNAo+3GT3dH830Mf
        XcOfbnZUcnu47QWS1eZDaxx6
X-Google-Smtp-Source: ACcGV61RRsTFTR0IqedrVqHPfUG22FkD3Y53tYq9hPb1NoHveb2cpjKDMqFAs/xAJ1jinKkW4+MIaA==
X-Received: by 2002:a17:902:8c90:: with SMTP id t16-v6mr11537174plo.251.1538400367453;
        Mon, 01 Oct 2018 06:26:07 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id c24-v6sm9533477pgn.60.2018.10.01.06.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:26:06 -0700 (PDT)
Date:   Mon, 1 Oct 2018 18:56:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: LED trigger for UFS device activity
Message-ID: <20181001132600.GA27931@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'm looking into adding LED trigger support for UFS device activity. This
essentially means a dedicated LED will blink upon the UFS device activity
like we have for ATA, MTD, NAND devices.

Currently, I'm not sure about the places where we have to insert this trigger.
My only choice so far is to add the trigger in `ufshcd_send_command` API,
which sends the SCSI/device management commands to the hardware.

Is there any other places where we should insert the trigger? Before that, is
this feature be acceptable?

Looking forward to the responses!

Thanks,
Mani
