Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5AAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7405218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="JWCTOOi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBHRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:06 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:55425 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfBHRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:05 -0500
Received: by mail-it1-f176.google.com with SMTP id m62so10632301ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sGjMwvpZz32ruSU1ne/N4Fl5RaqICe+TPszQCVxbI/8=;
        b=JWCTOOi+p+0VHLHDhz0fev2rPuAa5kmcax74SJuro7CMG8dGhuWJQrFAf1FYdrhmNd
         tk4uGfkY3cYgsuHKBmFea7i5Pg2LoTrmVjJB/gbjpe6PegBKWL6cASaFF/1Ly4LMcA4u
         c0V+/y21ULIe9PQ1C/D90u83TCqVizZczCU5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sGjMwvpZz32ruSU1ne/N4Fl5RaqICe+TPszQCVxbI/8=;
        b=P0Go5zKl82RevAa46uMZ7HHARSPz3tbEt1Vgts12e4WvOxMVPs5t6nhRADw9CiTVfz
         V6QvsduDJ2RZ4gBxJNQ3nOrNVmdTBDEXBEnmFoUXhTSnJdj26h7kLwwYaCIlzN0Gl0Zf
         PVyNYfOSZqyeT/zJi6VK5CYKq24xa1h0yZ4CkzunoIo+UaGnR/c/X1iNiHhYgwKr4ILg
         ndVBJ25cwYlWF9m/gwmrJQa+rkoOZPH3NOMYrfq2vT9dpaOOuiRw6pi2guNlA0SQtSIa
         Z4SPejHPAg7I6m1KhelAJDKRO2fmmhhLJwsstTH9HHeDVi9ySFjNgh5t2e+/nWeatVW4
         TR6Q==
X-Gm-Message-State: AHQUAuYQCG4DnJyMdXD/OkkQDhM+OX8P9kuBPGfDwNv4CKwqtbYOHpU1
        D378UOYV8cEgvjkAroBFxXluOTOUlSs=
X-Google-Smtp-Source: AHgI3IZ27q9XVhukW6eBu81AZF7VM7SVfcoH01LqDp+eAiy2mB2Ao8iQfatMok4gXMyeNx4Apj5I7w==
X-Received: by 2002:a02:9951:: with SMTP id d17mr12059830jak.134.1549647304544;
        Fri, 08 Feb 2019 09:35:04 -0800 (PST)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id k1sm1198861iob.2.2019.02.08.09.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:03 -0800 (PST)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] udf: Fix corrupt on-disk integrity descriptor following sync()
Date:   Fri,  8 Feb 2019 11:34:53 -0600
Message-Id: <20190208173455.20151-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where the next unique ID or file/directory count of the
in-core Logical Volume Integrity Descriptor have been updated,
a sync() causes a (corrupt) LVID with a stale CRC to be written to disk.

Ordinarily, this is corrected by an update of the on-disk LVID that occurs
when the filesystem is unmounted. However, if power is lost or the
filesystem resides on a device that is surprise-removed, the corrupt LVID
remains and can complicate later remounting or fsck/chkdsk.

