Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D796C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380722177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfBRT3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:29:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43189 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBRT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:29:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so20450951qtc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=961V7UYAh1GEfzU6WcYKaQP4cRVDX+vKE7N6RSQWhyk=;
        b=jpAqaV8A0uQJeg4f9A41iul+7NK4x6K2lfm7qruxk9egx1qdQSeU7CJD2pKiSRSsWW
         0psXASAPva7SuT3L79r/hZJjw6hEQKLQoJXvPEqAIF72zkYRDfKgEaXqmfKDMc3CeV30
         Llyw/1AO+UoC7+W19+2BP3sk0qkrdLnZOgawqJj1kX7WS0rc+DHBKzMIKFMNOZN2PCFM
         H+22Knz2rcynDC1v1fvKv550RpYGQHfwinLHB63sgKgfxtbT3uTYDxrlMJVNmyfbD9Ln
         fLYPoCSd41uWk3o9kAgpfMJTq7Lva1P3GA+wOQHKM0bT3UMzj0nqYjoiHYjerKg43Mcx
         61uA==
X-Gm-Message-State: AHQUAuavNO2a9NojpqQyXisaEAL3T60+JWqZewjAkY9GJEtgCvwC/VFf
        +MfSiUwD5o/u+rsiprN43iCtKT9euno=
X-Google-Smtp-Source: AHgI3IY7CX1qncRpIpm8G5nEHzQR52wNSGB2BkIOel53KHqNUS2DZlPbmxdytoUV1vJfxEe+kPCp3A==
X-Received: by 2002:ac8:2b34:: with SMTP id 49mr19527360qtu.32.1550518190805;
        Mon, 18 Feb 2019 11:29:50 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id s41sm10157097qtc.38.2019.02.18.11.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:29:50 -0800 (PST)
To:     Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: panic with CONFIG_FAIL_MMC_REQUEST and cqhci
Message-ID: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
Date:   Mon, 18 Feb 2019 11:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got report of a panic when I accidentally left debugging enabled
on a build https://bugzilla.redhat.com/show_bug.cgi?id=1677438

It looks like a panic from code in CONFIG_FAIL_MMC_REQUEST from the
cqhci driver because there isn't a command (high level overview)

(gdb) list *(mmc_should_fail_request+0xa)
0x149a is in mmc_should_fail_request (drivers/mmc/core/core.c:98).
93		};
94	
95		if (!data)
96			return;
97	
98		if (cmd->error || data->error ||
99		    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
100			return;
101	
102		data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
(gdb)

(gdb) list *(mmc_cqe_request_done+0x1c)
0x2a6c is in mmc_cqe_request_done (drivers/mmc/core/core.c:505).
500	void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
501	{
502		mmc_should_fail_request(host, mrq);
503	
504		/* Flag re-tuning needed on CRC errors */
505		if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
506		    (mrq->data && mrq->data->error == -EILSEQ))
507			mmc_retune_needed(host);
508	
509		trace_mmc_request_done(host, mrq);


(gdb) list *(cqhci_irq+0x1d2)
0x1172 is in cqhci_irq (drivers/mmc/host/cqhci.c:747).
742				data->bytes_xfered = 0;
743			else
744				data->bytes_xfered = data->blksz * data->blocks;
745		}
746	
747		mmc_cqe_request_done(mmc, mrq);
748	}
749	
750	irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
751			      int data_error)

This can be worked around by turning off the option but it
seems like something to fix up.

Thanks,
Laura
