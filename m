Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D112152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D112152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIZWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:02:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42682 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeIZWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:02:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11-v6so11343402wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNoivGD5d+RGTdwkL/JBe8KG+pjlDFKnPHaFUQ8Xs0U=;
        b=BShcFOPHZxPkwKVAWsJpRy7KSpG3WnXehWExMw7J4UNnd5ww5lMbXccVu5ZpYU9xQe
         bSofq2acynfspv/exiJiPFuZOpSybSOTAvbJkz8u8XEnrc666cCkjgjJDxqNHRg40zKk
         Xpk6O7AkGX0XzQVQbILBxDx09fgkDRa+/MIDvqLQihSwG6kSQ1bOndmM4Pg3I86gnYPM
         5AfF/rZUIxDpBEG2AKhAnndwGL+WmGTFH65XcnAHYS4wBFcpMJOv3KTckbiN6571NA6c
         nhdXpE3feOIl/OWeO9yoq5F3eRynXbSJVOVhIej32Bc1C53QkZEMlZLVeDt2aiH76Cby
         pENg==
X-Gm-Message-State: ABuFfogHMx9hm7VzIoE73JWIy+U5INlvIWyOW8Qhwz4q+QD1zv3toXad
        FDVNGuh4CK16F/JweW4Tos5j7w==
X-Google-Smtp-Source: ACcGV635e8c8fGJtVbS1Gy+fI/DxcYX93BrAJySSmURRBFTE/cfqToSPrvPqvZSUaeDFECkSbPVrTg==
X-Received: by 2002:adf:a185:: with SMTP id u5-v6mr5749006wru.50.1537976931926;
        Wed, 26 Sep 2018 08:48:51 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d6-v6sm5111012wmd.2.2018.09.26.08.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:48:51 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:48:49 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt76: fix building without CONFIG_MT76x0U
Message-ID: <20180926154848.GB3153@localhost.localdomain>
References: <20180926125356.2026635-1-arnd@arndb.de>
 <20180926140627.GA9265@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926140627.GA9265@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 26, 2018 at 02:51:59PM +0200, Arnd Bergmann wrote:
> > The recent rework of the mt76 driver caused build failures in
> > configurations that leave the mt76x0u support disabled:
> > 
> > ERROR: "mt76u_mcu_deinit" [drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.ko] undefined!
> > ERROR: "mt76x02u_set_txinfo" [drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.ko] undefined!
> > ERROR: "mt76u_queues_deinit" [drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.ko] undefined!
> > ERROR: "mt76u_stop_stat_wk" [drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0-common.ko] undefined!
> > 
> 
> I think there not yet posted Lorenzo patches that fix this build
> problem.

Hi Arnd,

adding mt76x0e hw initialization I have already fixed
mt76u_mcu_deinit, mt76u_queues_deinit and mt76u_stop_stat_wk
(I have not posted the patchset yet, I will send it later today
or tomorrow). mt76x02u_set_txinfo needs to be fixed since
I have not worked on mt76x0e tx path yet, but it is on my
ToDo list.

Regards,
Lorenzo

> 
> Regards
> Stanislaw
> 
