Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30DECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25136214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NexYSTfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25136214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeIYChV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIYChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:37:21 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3E0214AB;
        Mon, 24 Sep 2018 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537821202;
        bh=6EAC9BSE1MmXIgQk0z/7pipBBBVJZJVcRVbV/B67lEM=;
        h=From:Date:Subject:To:Cc:From;
        b=NexYSTfLnbnTX0uFfANZZmRk0vfg0TCHOuEzrOyAHNfvqdaQBeAjBJdLHPGB1j51+
         36vYoqs2Yq/25J83gmgV/lBOFsXb+B9EFRVrS/YpY3spBtmm42UjeqWOG+nqMWreQi
         xiHvAl0xQtgzyjaXJTUVV3faBtvw2pB4vACy776U=
Received: by mail-ed1-f51.google.com with SMTP id e25so8979055edv.1;
        Mon, 24 Sep 2018 13:33:22 -0700 (PDT)
X-Gm-Message-State: ABuFfoiFSEIH9vh9s5iHLLNqJhywGec+ZXI4HgcjPQ25QuyFnM19TYUA
        vTjl2XfcUwzvWssVq6amr/H1l2okSeygHjcftHs=
X-Google-Smtp-Source: ACcGV60C4etwXWDAyPLOQ8/7cam0O84VW8TvlG3ABvATZ/2XIMS3uqmPuFSmsMSBP69tMRB4BmQpqwDCNyj/xAbTUoY=
X-Received: by 2002:a50:a166:: with SMTP id 93-v6mr4444931edj.184.1537821200789;
 Mon, 24 Sep 2018 13:33:20 -0700 (PDT)
MIME-Version: 1.0
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 24 Sep 2018 15:32:44 -0500
X-Gmail-Original-Message-ID: <CANk1AXQY14NHHoDUKNShvDQCFP-bw7ndU=W9a5G8C1d-p4tDUQ@mail.gmail.com>
Message-ID: <CANk1AXQY14NHHoDUKNShvDQCFP-bw7ndU=W9a5G8C1d-p4tDUQ@mail.gmail.com>
Subject: Portable DT Connectors with regard to FPGAs
To:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My interest here was in having some discussion on whether connectors
are a good match for handling FPGAs.

The relevant use model is where a user applies a DT overlay targeting
an FPGA region after the kernel has booted.  That overlay initiates
FPGA programming and then adds nodes for the new FPGA hardware. This
is discussed more completely in the FPGA manager DT binding document
[1].  The main deal here is that I'd like to be able to add nodes
in/below a FPGA region node to support devices in the FPGA (and be
able also to remove them if we are going to reconfigure the FPGA.)

Previous discussions about DT connectors focused on the types of
things likely to be on a physical connector. GPIO and SPI got named as
good examples for discussion while MMIO specifically was dismissed
[2].  That's problematic for embedded FPGAs for example since the FPGA
is on a mmio bus and hardware that is programmed into the FPGA lives
on that mmio bus similar to any embedded peripherals.  So there's a
question - are mmio busses intended to be left un-connectorizable?

Alan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/fpga/fpga-region.txt

[2] https://lkml.org/lkml/2016/7/20/560
