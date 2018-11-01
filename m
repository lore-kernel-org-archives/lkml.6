Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEABC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574542081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LnQhnmNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574542081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeKBBUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:20:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKBBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:20:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so9168692pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hJzb4s2hKRO79UqIs4qwRGjIMZpjP+ft/ZmPMZJET5g=;
        b=LnQhnmNAAfjfhf5y9siGGTzvceRzASPS8cWzFvG5nWyAvIYnlDMc11le+8v+OH+ETE
         6gBZbBsjOgTKY7L231JlNe3BDbZ6GWDwcuVkN5Vez0pb35WUB8vqunQpMkI4kd7tbgjI
         NGDWyw23jZGGkqIOcVPCu9AZtWW0D0AorVLNQBXnwbmGcpohsEeUU4WBIVYyHeeoRAMx
         BnBM6zUl2gljWiE5OS3CjKUTxEnGSPa1fJSKHB7436TVvN/JQN2JNiNmS3jlUkirxXhl
         0pHB+6Vu/oyzx+sWoLj0ngG2cj3Don8BpP0RGdVm/tzQNrbwFpFiNpPI76uoIya5XcZr
         6EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hJzb4s2hKRO79UqIs4qwRGjIMZpjP+ft/ZmPMZJET5g=;
        b=UEWLuC0+zUzqt3V/ksaqUglKOtxb9r+ieTsQbmZBuJYWj9HCeN6JRcxcc0yCsdleiQ
         nJ336P75HLluSyAIlByJ7Q4g6TIsbDuAQY0TxcfyzE6Bj3mhihvzklUPNEBw4hRDTNnk
         ypnPGYtVNcCBCr3PsFpq02LdezYSdMzk65uQnzNU4WdZ3/GPId7PY4XmHrA6IfTLaby1
         CIoGq405KFye/plbP0jIeyx51obK0TjqunPpxQGAcgSs2PZ3bNLtI05qWoSx1gXE6OCb
         aKcQhBOFZ1AEp21z6UuwOFdTWtHKRKsgfVGDq3LLyhIvD1nFjy/cN5LWvhRhZXwGzzXS
         r3sQ==
X-Gm-Message-State: AGRZ1gKA4nH2pK7Urou9xSJCaiNjjonqUbQPq936KlL8i7jjpIQwRVS9
        psrQi1wSORT6QaCvC1FhEZ/mnw==
X-Google-Smtp-Source: AJdET5fshnB+8jEotlG1LfA74E132DDaea+6Rt/ub95sXq8dGm2emVzkvp06giypP2lBaVhlcS6sAg==
X-Received: by 2002:a17:902:7c0b:: with SMTP id x11-v6mr8143842pll.60.1541089037781;
        Thu, 01 Nov 2018 09:17:17 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v84-v6sm42169056pfk.12.2018.11.01.09.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:17:16 -0700 (PDT)
Date:   Thu, 01 Nov 2018 09:17:16 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Nov 2018 09:16:57 PDT (-0700)
Subject:     Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
In-Reply-To: <da34ca57-ea7b-7fb9-bc45-4b315513e43f@deltatee.com>
CC:     philip.li@intel.com, fengguang.wu@intel.com, aou@eecs.berkeley.edu,
        lkp@intel.com, kbuild@lists.01.org, zongbox@gmail.com,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-b2753147-e1db-4a2a-8dfb-710e71a38bed@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Nov 2018 08:43:15 PDT (-0700), logang@deltatee.com wrote:
>
>
> On 2018-10-31 8:19 p.m., Li, Philip wrote:
>>>> I think it would also be very nice to get the existing kbuild test robot
>>>> to start compile testing a few riscv configs. It already does most of
>> thanks Logan, the support to riscv and nds32 has been in our TODO list for
>> a while, but whole team is blocked by other effort. We will focus on this soon
>> to complete it within 2-3 weeks.
>
> Thanks! Glad to hear it.

We should probably at least have builds for rv32imac, rv32imafdc, rv64imac, and 
rv64imafdc.  It's probably also good to test SMP/non-SMP as well as 
medlow/medany, as I doubt those get regularly tested.  If you'd like I can 
write up the configs, just point me to something that describes what I should 
do.
