Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36302C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94B820685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hZ2Kv2QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94B820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeKDICq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:02:46 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:42829 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:02:46 -0500
Received: by mail-qk1-f172.google.com with SMTP id u68so8938047qkg.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F+I8S7OpRxG6iAZAERu2twGJqQ3pbbYPaBYrB5yOYiM=;
        b=hZ2Kv2QI591E1pYJ8QnwBvheKbmyqSo7otAwxruOg1rLW2TIyigMdk36Y/+Mx/1Svh
         876DnjZ8DeSCedZ8GjEZX1eM+f5dywTSoGHfSMvkcUB2+9if+oXy1tCNx6HFGk6a1Hrw
         dwh6fqbHwk9sV2Rwcqq4rh8cTWxfBU/qt48ZEhIQJPWVIGV4or03U1h/zz3geuU1ZyaK
         XRtiP/pAWFpHjHJv4oqjEDZe5Ttiy3GgmmiQ20PxWrYs2ac4RO2+3aC8IhxqDAYH63/7
         rDoJVEjFA1dCBd+TDECQMlo/dpbVzLz+y0YCP5mDPadbKbbhkFjG3gYsJBgjotl4vjvM
         iawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F+I8S7OpRxG6iAZAERu2twGJqQ3pbbYPaBYrB5yOYiM=;
        b=kKA0YwyIujE5WDlV5KPkAFXzYQHjHwObZ2BXhZKA3/bwB1QlZ4bDP/xh3cyNubNI4K
         CpNSFXqscSl6oMge6cwIkNn+dC8pbIDDbqcFPV3O0dbkKJDPypF0/5Fh+9KwrlBfn70s
         MPn85A5QbWDOm2bwcjtqlnHwiEsJZgyiCADbYTgeEp2eWzuKPBP9Uh6snxicmdhYPeXC
         6FGMlLtT2Mn2SLEdjHy2G5Q8FiPh8jNMspZtnYsULnyqim4sfmWo8ACVMT6LFoeq0+AC
         76hRclbkB1ZIYG6KZjGrYr1IX/ARMc0I8u8buht9gLtxudqOJcWs5nmpYinDs6j1zTbc
         czYw==
X-Gm-Message-State: AGRZ1gLqfSP6FAB8QKAUZJ8aHsPZ/WwkIrwMijbBvPLBx1Fvj13mZaLP
        biTnt3uSgpcA2ZJxlnExe+hwMQ==
X-Google-Smtp-Source: AJdET5d6saIB71lKJnNTLAUwDwtgry2RESdrO+KBUksBvnTL3liH0yGUm3RZuGHrippixhdlhbOOwQ==
X-Received: by 2002:a37:b881:: with SMTP id i123-v6mr16151283qkf.290.1541285405132;
        Sat, 03 Nov 2018 15:50:05 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:04 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 0/6] staging:iio:ad2s90: Add scale info and improve error handling
Date:   Sat,  3 Nov 2018 19:49:42 -0300
Message-Id: <20181103224948.31014-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds scale info to ad2s90's single channel, improve
error handling in it's functions and fix a possible race condition
issue.

The goal with this patch set is to address the points discussed in the
mailing list in an effort to move ad2s90.c out of staging.

Changes in v3:
 - Removed unconnected change in patch 1 (whitespace tidying up).
 - Added comment to patch 2's description regarding a code block that
was moved in patch 4.
 - Corrected scale in patch 5, from 2Pi/(2^12 - 1) to 2Pi/2^12 and
using IIO_VAL_FRACTIONAL_LOG2.

Changes in v2:
 - Added my S-o-B in patch 5. 

Matheus Tavares (5):
  staging:iio:ad2s90: Make read_raw return spi_read's error code
  staging:iio:ad2s90: Make probe handle spi_setup failure
  staging:iio:ad2s90: Remove always overwritten assignment
  staging:iio:ad2s90: Move device registration to the end of probe
  staging:iio:ad2s90: Check channel type at read_raw

Victor Colombo (1):
  staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
    read_raw

 drivers/staging/iio/resolver/ad2s90.c | 53 ++++++++++++++++++---------
 1 file changed, 35 insertions(+), 18 deletions(-)

-- 
2.18.0

