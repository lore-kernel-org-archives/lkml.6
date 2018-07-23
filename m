Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24D0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859720874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="As5YbshV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbeGWHVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbeGWHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:21:42 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1311020875;
        Mon, 23 Jul 2018 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532326926;
        bh=m+6n62gmOTioQDhxhCWakfUnqPOvz92fCyIRMk5O9JQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=As5YbshV/KsygjIU1NLUN/d0TCYaIxi6Z7JLuYKFRDT/qdYrgmBKzBCFVr1k6NDTX
         m+uynbIgC3GItreAyD/0B2+Dgi17tni8ldNSKuiQ8l3PZ+YaOAgocBTDAp2mZowsph
         n6b/Kj6fA46jqCqamoUJwjJz8JMt6rOzS9uZVBeM=
Received: by mail-wm0-f49.google.com with SMTP id l2-v6so8865427wme.1;
        Sun, 22 Jul 2018 23:22:05 -0700 (PDT)
X-Gm-Message-State: AOUpUlErPz7qCNO3q1DWCv3X/dCzT67eh2Bzsk2T6eJdrIFH9MN+dlcd
        PwZ3F4bA8DYgr0H+2zYCyWQAFwPeQyNVUCOeroM=
X-Google-Smtp-Source: AAOMgpfFIEguwkZ17STP4R8thlJQ/k/Ud2PD6KMpxp/BpkhI/eVYckQvIgJhegg+IQ0TKFObqvIN5R27bQ/6f8tNdvQ=
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr6324647wmb.118.1532326924572;
 Sun, 22 Jul 2018 23:22:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 23:22:04
 -0700 (PDT)
In-Reply-To: <20180722.143956.903331235259719609.davem@davemloft.net>
References: <20180722142636.31525-1-krzk@kernel.org> <20180722.143956.903331235259719609.davem@davemloft.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 23 Jul 2018 08:22:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPek2idb26VCazomT+kMgU_Ev9xCondigtOKd3-tMmRFDw@mail.gmail.com>
Message-ID: <CAJKOXPek2idb26VCazomT+kMgU_Ev9xCondigtOKd3-tMmRFDw@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: freescale: Use generic CRC32 implementation
To:     David Miller <davem@davemloft.net>
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 July 2018 at 23:39, David Miller <davem@davemloft.net> wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Date: Sun, 22 Jul 2018 16:26:36 +0200
>
>> +             crc = crc32_le(~0, ha->addr, ndev->addr_len);
>
> This is "ether_crc_le(ha->addr, ndev->addr_len)" :-)
>
> Please use it, thanks!

Sure, I'll fix it.

Best regards,
Krzysztof
