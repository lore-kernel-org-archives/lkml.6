Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCDC20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="01NbdXRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAQDzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:55:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46073 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfAQDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:55:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so3788138pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNpIrJXdubyKYg+3xTQmvx3lQNMlIqDJenVq1e/d15E=;
        b=01NbdXRq5QO4VIn1li6HotnXMemAmibFKF7XHFtQHahEmKlu7ptPJCr7pu9rFrgjZb
         D3l7RgwpRaBialMo+D1EK1ecrIXkPhrUrL+JR2kbuPLBecicvIZi/OYsSQt4gE2NfAF1
         SsWBIg0WHcJcn+NhY0HEqA6MoqGrzOir5g7k+FKLRbuedtHE8HEF9y2R9bYS95BI5Bfb
         BhH4rQxYZMgRRad/ELXhJ5iSZ443nJZnS0aTQfE1+Lpru6UTP7sun91WXLdJ400Nh0Ny
         S1XxJjBtLvT2LYEU4a1k9ebOlX6xPJ1AtAhZvvvID1Co+8ZqJ5z0mvaCtvQV7i/rNZ+C
         zmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNpIrJXdubyKYg+3xTQmvx3lQNMlIqDJenVq1e/d15E=;
        b=d/VZ0B+aIyzKcXKJwKQJBDi9z8DsvsBuMu2RNmkrue7ea51izcsFxgt/v8zE9sliap
         6LOcAMfLpLorREJZYEAFNwLAkedfVNknAXtuLQvfqrbpA10WWbyHFzVM5D617GqxivYF
         TP6Eqg4Mr7QkFCqakAOQldE/Fb1Quc8TyLPLc3sFWLiXIhohqlrlMapzp38Dm5YjFFyB
         9hjWEgeqkpecKYd/KuYaCiktHkHeXV7+MIcBW4GP88YjeEi9xzTxKEYNyUZ+AvIAYhf5
         SGs/FH+byjpIR34aJpfr5Ttcz1anp94XyO5xipTYatK7u3GKoMhI0rD4ROjIFDIvU6Yz
         uRYQ==
X-Gm-Message-State: AJcUukdS9edOdWbuvZplHRH2PJzBFB5vCK1r3DS6hKkUuGoq8Ad3qPWJ
        0QupPHZdI3EBvJ1QtKFHoq+RsQ==
X-Google-Smtp-Source: ALg8bN5K76DqT0jl1E4XsO2RpvEYxeZvl++/OY+qJZ/GE3YnGvcb4t63sIVCbyEwKD9j2M+CLLXI7Q==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr12116716pga.312.1547697332418;
        Wed, 16 Jan 2019 19:55:32 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id i184sm348760pfc.41.2019.01.16.19.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 19:55:31 -0800 (PST)
Subject: [PATCH 0/3] scsi: arcmsr: Fix suspend/resume of ACB_ADAPTER_TYPE_B
 part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 11:55:24 +0800
Message-ID: <1547697324.4339.27.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are against to mkp's 5.1/scsi-queue.

1. Due to dma_zalloc_coherent will be phase out, so use dma_alloc_coherent to replace
 it.
2. Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
3. Update driver version to v1.40.00.10-20190116
---

