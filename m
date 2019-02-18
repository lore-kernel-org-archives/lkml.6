Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E28C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9E7218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SQwDlUXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfBRCnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:43:19 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52571 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfBRCnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:43:18 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7133A8025D;
        Mon, 18 Feb 2019 15:43:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1550457794;
        bh=QhS3cNjoVq9rVfpp4TmLvp2CiTfPnKI9tjWSUogn3s4=;
        h=From:To:Cc:Subject:Date;
        b=SQwDlUXfcH/CIOvj53A3x3DdfN5+GlOwiXpJjQB6qB8C1DyFsZ8GKj8sMRUcMxRam
         a9QeWcCjiGw5TrloB6KshCjDwqE/rGSNApTCU5vuvX1ncAbTTeNr1WScxnMKAIwPME
         ukrDJFoIs8S/smaaZ9z3yFYIjkajiqwdTiQP7htsVc6mzzvjvz94gpfu+mgvKlg9hw
         jty5tkJ1GYwTBJS6VqH8EkGr2TwKz98wfgIO7KWJyH9PFMOLG/y0c43As2sNwFdfY+
         BGtMnjcBuq9+RtefIpV08JncefpVcP/VKp/qucDxy3kxIxqzgo+b8IqcregWOEnK7e
         TaUNmjbJWcPVg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c6a1bc20000>; Mon, 18 Feb 2019 15:43:14 +1300
Received: from ashm-dl.ws.atlnz.lc (ashm-dl.ws.atlnz.lc [10.33.24.13])
        by smtp (Postfix) with ESMTP id 6F46913EEFC;
        Mon, 18 Feb 2019 15:43:14 +1300 (NZDT)
Received: by ashm-dl.ws.atlnz.lc (Postfix, from userid 1714)
        id 558E8369570; Mon, 18 Feb 2019 15:43:14 +1300 (NZDT)
From:   ash.millar@alliedtelesis.co.nz
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: neighbour entry incorrectly moved to NUD_REACHABLE
Message-Id: <20190218024314.558E8369570@ashm-dl.ws.atlnz.lc>
Date:   Mon, 18 Feb 2019 15:43:14 +1300 (NZDT)
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have encountered an issue resulting from commit 2724680bceee ("neigh: Keep neighbour cache entries if number of them is small enough."), which allows stale entries to remain in the neigh table indefinitely if the total number of entries is less than gc_thresh1.

This issue arises if:
- a stale entry has existed for a long time, so it has a sufficiently old neigh->confirmed value
- the neighbour itself has sinced change MAC address
- we then try to ping the neighbour

When we ping the neighbour, the entry moves into NUD_DELAY as expected. But then, within neigh_timer_handler(), an incorrect jiffie comparison causes time_before_eq(now, neigh->confirmed + NEIGH_VAR(neigh->parms, DELAY_PROBE_TIME)) to return true and the entry is erroneously moved to NUD_REACHABLE. The entry becomes stuck in this state, even though it is not actually reachable as the neighbour has since changed MAC address.

The necessary age of neigh->confirmed for this to occur depends on the platform. It occurs after approximitely 100 days on a 32-bit platform with 250HZ.

We have resolved this by setting gc_thresh1 = 0, which effectively undoes commit 2724680bceee.

I would like to know if anyone else has observed this or has an alternative solution.

Kind regards,
Ash
