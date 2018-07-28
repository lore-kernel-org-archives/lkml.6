Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49ACC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA120878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUJBNnR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeG2AnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:11 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45664 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbeG2AnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:11 -0400
Received: by mail-wr1-f50.google.com with SMTP id t13-v6so8672677wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=79UtRc+M1bf3ti2KNhtYK5LKM+IjJn0q8i4f+TkHPCM=;
        b=cUJBNnR6jsUlwAsN010sFPBlVEOVEgnoH1xyOJUKAtWp/aPL9dFez3EoDEXBv29y4g
         f6htKKBqpyEP3fY+hQ8GL1o+TGOuOqpwtCskSWTlg633tVJUJkNRKUnPSWeE3vJatrsh
         FHV2oGoD0DlMxQOJKp+FVmTIuvBwNHYyqQUuso/SK341x/M3hJrUX2X73c2lYPpqBqDv
         NZqZBfBA5FlgE6sJ7uuEq8ui1VQTp+7/E74gjrPkDJs3sYgFBH5NHo2anECmsv21imfh
         cSR9SgdvmMOnQnpRtlUoiFMWOEPCqMCxCAtl3ysCai80nlRVlIqUAeVWDRaoitRTrGlQ
         9J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=79UtRc+M1bf3ti2KNhtYK5LKM+IjJn0q8i4f+TkHPCM=;
        b=RKYcje0OlEH3JLND/td2y4Zt5wVJSrvFk4AEv/33QC/MtR4yViLvWz9mXocA84+jts
         FT1Ah5o0YOoWZu9RoQjbM0dKHmLwGw/G3vWkceRFRlaAD9lN71KeQtcfct/eSbaKOYHX
         Htu/xlZA0n0YsAl2NU2+sfSYk6SQTAjlfLciiCFaZtsp7uKBfVBf5qhfFgElzDpPWY2/
         oO7oJ56e1JKSkaeGI6pRaZBnr5d3M4T5F2sR++twO44R1GxI2gJm1vf4cuC6meGEwGcS
         yrfeZxusZmI7m66/KrlIw0sFYhRUv6Xq2hRod/vsnDnw1fJr+wI5/+XrFuUGowWj/x2T
         Nmwg==
X-Gm-Message-State: AOUpUlHibcR302xUcSv64pkMkaubfL0nCfdDuxmyQf+jcs3cGDsio0hh
        v5imB5QpxzyTIMxVabxc/ybQwkhg
X-Google-Smtp-Source: AAOMgpfOwcwqwZ1WmavYdY48WVjUVCU7541g1z77/El0go0VM8tNaalYMekfygF66WbnXMQLlx+T1w==
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr10478216wrr.278.1532819699349;
        Sat, 28 Jul 2018 16:14:59 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:14:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/08] staging:rtl8192u: cleanup of rtl819x_Qos.h - Style
Date:   Sun, 29 Jul 2018 00:14:44 +0100
Message-Id: <20180728231452.20107-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a few coding style changes to the file
drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
I had more patches in the list but had to dump some of the later
patches as I made a mistake. Thought I'd send these 8.

John Whitmore (8):
  staging:rtl8192u: Add spaces around operators - Style
  staging:rtl8192u: Rename ACI_AIFSN - Style
  staging:rtl8192u: Rename member variables - Style
  staging:rtl8192u: Remove unused  union AC_PARAM - Style
  staging:rtl8192u: Remove unused union ECW -Style
  staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
  staging:rtl8192u: Rename union QOS_TSINFO - Style
  staging:rtl8192u: Remove unused constants - Style

