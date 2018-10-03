Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB37C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E920E20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL4/SJCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E920E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCTwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:52:01 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46329 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCTwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:52:01 -0400
Received: by mail-pf1-f178.google.com with SMTP id r64-v6so1645410pfb.13;
        Wed, 03 Oct 2018 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=rWhdGl6k2vZJFKamBX2V73eoPTv3cre/LnPYdWw2PWQ=;
        b=sL4/SJCdkoZNAixm980EM2mFiFaRhviJHMILacOXk40dH8h4s+BU5sTYyifSPkWEso
         ZeRnRkr4XiP4cSaohE58cQFBjJg8QyQAGoBUH/iU9a02mkHx5COD65K5IgN58qBAIehi
         1BG8n/rfvgJSGiWdkqZM/kcJ3GksnuPzjMonLmYzprDg1vl8VX+vPzPqmA2aS/OON21n
         RiFbNFX3W4Z7cuDwS0EMO0ZXivjWTjZ59ciOD+LFOGyWvlY5Y7U/+oniInZul5RFUz5S
         UFhDGdXxyAFMcEE7SbthIU8WzRgvhQx3PCmi1GRvq7PMNwNznKWD3uRqeaRbxz/5JvUh
         rGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=rWhdGl6k2vZJFKamBX2V73eoPTv3cre/LnPYdWw2PWQ=;
        b=WiDt8GOGKHf2bPMdYf1hR+PIto4sOBn/4tkELngYHirHQ38sPoGWdyNlIM/+Z6p8+K
         0z2VUzu+5isYXk2tC80cEirVaC+TloFQa3Y8vPqj6fQ7jKb1axHLg8d7syZ4eaXdbfSs
         11ATZ6zprwRNi7kaNHsA0CKC8DpO172JpPbekOKan7571QlPqq6s03zciHv04vQ/2ZQB
         /30PNQ/sJcgLFs1VQ84u+iPyYHVdfXolV8Kdjj5JYoUYjrnJhZSg3vSO9sE6z/HKZjN4
         aHJs92sIrUxNY5bxU/o4PFDmX8zEpIaRVHHZefiOynbm/IUsQgW0Olf33I+IOjZ0xjHU
         lOnw==
X-Gm-Message-State: ABuFfojeWXBGnp+5Kpe3nl9vgBoJ3uj/ZO/KuFdvQ2HQrdVFZeDma30X
        IfbwV07ZAAOJwvDf2x7cruHUM7XI
X-Google-Smtp-Source: ACcGV61TceTA0X9RHHsZTbtfmltiXyl7n8ixp4xN56GxNGimiBLJ066349coPjuJRw7lfRGu+Maczg==
X-Received: by 2002:a63:34c7:: with SMTP id b190-v6mr1287044pga.184.1538571822379;
        Wed, 03 Oct 2018 06:03:42 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2676253pfc.77.2018.10.03.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:03:41 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [REPORT] net: e100: possible data races
To:     jeffrey.t.kirsher@intel.com, davem@davemloft.net
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <8b3eba57-bdf3-3c0d-1889-12a971f277d1@gmail.com>
Date:   Wed, 3 Oct 2018 21:03:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU0:
e100_set_multicast_list
   e100_exec_cb
     line 854: spin_lock_irqsave()
     line 866: e100_configure (function pointer)
       line 1114: nic->flags [READ]
       line 1123: nic->flags [READ]

CPU1:
e100_watchdog
   line 1731: nic->flags [WRITE]
   line 1733: nic->flags [WRITE]

As for nic->flags, the WRITE operations in CPU0 are performed
with holding a spinlock, but the READ operations in CPU1 are performed
without holding this spinlock, so there may exist data races.

These possible races are detected by a runtime testing.
I do not find a good way to fix these races, so I only report them.


Best wishes,
Jia-Ju Bai
