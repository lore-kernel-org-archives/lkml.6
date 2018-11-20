Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CF9C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE75213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI4hiP15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE75213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeKUHKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:10:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43262 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeKUHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:10:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1983843plb.10;
        Tue, 20 Nov 2018 12:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GWBwIlQcNDGKkMHj9b/EZZxERwImk1LewNYtpvHe/4c=;
        b=RI4hiP153fj/ITFczt/uCRsGxaPfsN25kU8GXDiR509Q5RBN4S/h6S4If/0RW858U6
         imF037poGNAMOx3h8CUps+E3Y61EAfQXo/Bnw3idXSryMpFpxxrnc7CXKe5pwLUpsolo
         rnqff95pXOqleag5xs9QCme8GdxZ9WM7OGzCW0N6nEg+ueOCnCluLKDsuoWZHO3kiI7S
         Rhxz0UyD9ZR2rN9YkhsPPPGsN5UfP5WNgdMGf7IM1VOKfh5803/rNaghfiPMBOwhF2l9
         ZehXquTw2t8TpOm6z/tTzKGx1Rnzvm/u3tx7UbPJLoBN6CcUdRzKrg6CCdu+JQNVg0nx
         VhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWBwIlQcNDGKkMHj9b/EZZxERwImk1LewNYtpvHe/4c=;
        b=eUpQ+sKPa5xPjvu3pg7Pjq62h+TAVGkzMPOumYCFnYXL9pxldxd9g6rcW5Pkn4trXp
         1XajMiqo0d0LtuKSFcazvQ0j4818MXPccq4epZHuxJVVnqFUhfN0iFxpN50ZCe+wkOAx
         SYiB1Sd7ymyYpnsFqle2JT/vkKeHG4PnPdv9VERattfT9Zpceect+YlN2gT0j3PXuLGm
         oBEusbcot/b8z8FSdDWhRDNZ8k0YS3sAJIfmWNR1qXSD1EuIpY368gGp7+p/GAKuSH/m
         nZ3MYCSntpjA/zyKgXwuqKPac5wHG13ZrTJrF8W1nocLbUmorAwgvpVN5aak3AFw16al
         O2GA==
X-Gm-Message-State: AGRZ1gKLFNApDfWO34JIe4C8OsZ91phHWsoGkGI1yikTtqx8BaZIVNay
        0V502Wl8hXJoVs9Oy6W/bMg=
X-Google-Smtp-Source: AJdET5dy4qoV18VPAwCD/OOhR8m/smrD47qzK6VNhMydL/Dk5NrJIhpAUyxCyBeycMfFPoPfEUo5Uw==
X-Received: by 2002:a62:6c89:: with SMTP id h131-v6mr3759611pfc.12.1542746341823;
        Tue, 20 Nov 2018 12:39:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm46009350pgr.79.2018.11.20.12.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:39:01 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:39:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/160] 4.4.164-stable review
Message-ID: <20181120203900.GB19385@roeck-us.net>
References: <20181119162630.031306128@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:27:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.164 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 262 pass: 262 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
