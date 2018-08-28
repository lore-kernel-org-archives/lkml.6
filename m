Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A63C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A6F20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LV9YdzBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A6F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeH1UxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:53:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeH1UxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6OQe5umM4vsr3Ys6LjksuDKcG4Lt0oy+o0PtgpiBdXk=; b=LV9YdzBA8nGqdjbplg1km5UU2f
        zT6hRSD9j4URp48w8+eJASDOsIUGMToMr2CZ0EzkJ4C17VPyLWbB/Vx9LCmmAHqxPmFNI8lPY9R9D
        W2w+E6i9K6oBOBZC7+7XVYbUvcn8OFuiwuvxjo94fN8pv/kwWvtLn3Pdiyo0l7yQo4zpueCirMgE5
        fl0UButOJ/5of4lPX7zkNscZPA+o5FtxKfjqtLYR81Xi45ww7OKt3iE9YCzyphc0c1/Bs7N2tyGpM
        cOmXSpTQpoiZse4bg3pMwCgSXUbv2T8530rtI9KWSR2p1uWir56/IGPl+3IAL2wYGxY6DtBTRA0t0
        CJCBNHHw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuhLw-0001xQ-LC; Tue, 28 Aug 2018 17:00:28 +0000
Subject: Re: Bug in /drivers/scsi/3w-9xxx.h
To:     Frank Kammer <frank.kammer@mni.thm.de>,
        linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <491de4ae-0ba3-0fce-a400-3ebb41e21ac4@mni.thm.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e79d43eb-38cb-8975-08c9-c3937a1276c2@infradead.org>
Date:   Tue, 28 Aug 2018 10:00:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <491de4ae-0ba3-0fce-a400-3ebb41e21ac4@mni.thm.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-scsi list]

On 08/28/2018 05:23 AM, Frank Kammer wrote:
> Hello,
> 
> I have a 3ware 9650SE RAID-Controller with 20 LUNs. Using an unpachted
> kernel (no matter which version, e.g., 4.12.14) , only 17 LUNs are shown.
> 
> The problem is that the driver was once written for a 3ware 9550SE
> RAID-Controlle that supports only 16 LUNs.
> There are some changes in driver to allow 32 LUNs, but one change is
> forgotten: 
> 
> In drivers/scsi/3w-9xxx.h, one must replace the following:
> 
> 467c467
> < #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 16)
> ---
>> #define TW_MAX_LUNS(srl) (srl < TW_FW_SRL_LUNS_SUPPORTED ? 1 : 32)
> 
> Best regards,
> Frank Kammer
> 


-- 
~Randy
