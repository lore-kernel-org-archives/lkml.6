Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A123C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD03621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="lgd6vJoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD03621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJJAtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44587 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJAtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:23 -0400
Received: by mail-io1-f67.google.com with SMTP id x26-v6so1781050iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id;
        bh=6bk6fi+4KzVXLSXd5DdI2K1vHs4zcg3JO/shIo6TjX0=;
        b=lgd6vJoiiP7akLlMZH5RwwreG+B1uYYtybnrIzvBo1VkFlKLIUEW4VOK7rc/XDc4Zk
         rsZLo75HvYPwpVmxTBhdFTeA81vt96igS8zqW5XrGpeMFp4ZAZr2Wmhnw0lFbERk1PU4
         FGCpTVN4FARV2QoUiNwQXSdR4oexfElfaVaZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id;
        bh=6bk6fi+4KzVXLSXd5DdI2K1vHs4zcg3JO/shIo6TjX0=;
        b=Bv3292QhHy7n3T/CT4v4k/MYvUWjYGUUpA5deJi7O+0uN1waEsX0eqhn2BzhVRgQW0
         /woR27VrgqdiUYVmizx2S5JP75yTuiY/nICpTAwb6EB27t/qNNTNJtKI5I0dHfPE8zUd
         r4llB3enxpLPAMidNpr3e0GYlskl7nk4MthUrwh8nj+gA7wyZRa6D2bqFjKDMNFDbEvU
         GSyfiuW54cricq9+MXJI+Y/lWL4PXTOZ76kybL2hoNLrPaV/gVB/D1yl5fGNKgFrDvef
         NL9NFw50CVPeeHavAzPU5Y7mQh/3xdjTKahIUuJtx/qzXp6QOPywuVVUM7BMWP3pg1vI
         8F6Q==
X-Gm-Message-State: ABuFfojB8k6hhHQSzHOt20C+DbfnjfeTEurtBNv4rQQ/avtuhQ9g2quE
        svfWhMRiiXRBj/ryeja3VEXr5jih8FU0sqEEUVp4vRPW2pYcENHVF9X7B7nxXav+JtMV4ct3AGT
        TrvMazycutXGZeKTZ
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV62PXC0xb5Je+ks8Ck9PgVFUTHWvyMJqq3WX5n7gsSGzq2dyG7iCSfuFgwP0NDk5RSXMC609jQ==
X-Received: by 2002:a6b:6814:: with SMTP id d20-v6mr19150498ioc.293.1539106280635;
        Tue, 09 Oct 2018 10:31:20 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:19 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] fix bugs in write_reliability and enh_area set commands + more extcsd parsing
Date:   Tue,  9 Oct 2018 13:31:04 -0400
Message-Id: <cover.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 1-3] just introduce further parsing and human-readable output of eMMC 5.0+ fields in the extcsd:
  mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
  mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
  mmc-utils: interpret DEVICE_VERSION when printing extcsd

[PATCH 4-5] are critical bug fixes for the current version. This addresses concerns previously raised in threads wrt write-reliability setting:
https://www.spinics.net/lists/linux-mmc/msg41952.html
https://www.spinics.net/lists/linux-mmc/msg43171.html

[PATCH 6] is a critical bug fix for the current version to allow setting of enhanced and extended attributes on multiple partitions.

[PATCH 7] is a version up-rev:
  mmc-utils: update version number to 0.2

James Nuss (7):
  mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
  mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
  mmc-utils: interpret DEVICE_VERSION when printing extcsd
  mmc-utils: Introduce write_reliability set_register command
  mmc-utils: remove write_reliability set command
  mmc-utils: discrete commands for enhanced and extended attribute
  mmc-utils: update version number to 0.2

 mmc.c      |  52 ++++++++++---
 mmc.h      |  14 +++-
 mmc_cmds.c | 243 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 mmc_cmds.h |   6 +-
 4 files changed, 235 insertions(+), 80 deletions(-)

-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
