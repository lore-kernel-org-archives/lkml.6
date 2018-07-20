Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9E320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELyErQJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9E320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeGTVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50502 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeGTVLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so10584652wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LxReN1aTMfgcqwA/cyyliSgZLcLPHRYT4MB07oS+Erg=;
        b=ELyErQJKLry+I06l+JR/UFkb5BSuI0ZBzenR0LlsbW9AlMSf/T53DuWcR3ssM+tZoB
         FcaTSp/+rlRJiMbg51t1ruRIOeJuve1aWmpJ8CKwj3lyjY6T/jYvlHGxSwt3eGhv1syc
         8Hujjo9CT5jxijqDsm2th8kkWn3RskyLb4fEU3+6MbmxMJmrTe9Uuy+hS9y4+Z/0+y3M
         P/TCSJhMbWkMJY75NYOmBMxAlY1eG2YjP2QFWMwd02Fe0opWp+xqnkW1TfzOSgVWnydO
         VeGZ+Ia9rdj3PA7yeSHt7N8fWbvmyvDwj92ucK0ZvZxdepbO3O+DPel9guxTvSCbAG5W
         kOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LxReN1aTMfgcqwA/cyyliSgZLcLPHRYT4MB07oS+Erg=;
        b=bOrpuEu8uxDOPaAnMTVQWpU4mX/L4Dg16mgh67l7FpCR9qFaqI5tiQA/CwiU8H3equ
         D3IEmKD2dg6PQxA0lbXRlNGkv6DX9CvrdC8hIjcKASFM/roDvY6UJd7ZMq1STwnG84AO
         b1lx8zVdXQeKmMghMJCPOWhsxAftR3FIRL2v5T1UCyWGGWzCLoEj5AOzP+Az4I0cFkVA
         Wdg8ueBnYUsdmWStCtD4nTiYs9BHGqyK3dnXJAvXPjrm2AIvF1UOSvk0HMXB8p6xt9tx
         qQm20CTCJkP9rv/nsos534oJ8mndxXGl/1WZfrirEmMNCRm+MiL1F8gNC8d6ymlSFFEL
         JeMw==
X-Gm-Message-State: AOUpUlGNpW41uF+29UveeEWhM9Mo9goBWklDl3Vkrx3rGwSeQ6M3uaoc
        DR35IwK0Rb+YI3UCf3TPV24YWA8cAoU=
X-Google-Smtp-Source: AAOMgpcP5ZJdafu8yN5qH1xXGAXV9n5GKha+EMMcH5IZ9rNlMHLO+OD4/YKHIlPeee4TkoL4VZvGCA==
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr2310662wmi.16.1532118116809;
        Fri, 20 Jul 2018 13:21:56 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:21:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/14] staging:rtl8192u: Coding style changes
Date:   Fri, 20 Jul 2018 21:21:28 +0100
Message-Id: <20180720202142.26312-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of simple coding style chages to clear checkpatch
issues in the file drivers/staging/rtl8192u/ieee80211/dot11d.h

John Whitmore (14):
  staging:rtl8192u: Remove multiple blank lines - Style
  staging:rtl8192u: Remove typedef from structure - Style
  staging:rtl8192u: Rename structure member FirstChnl - Style
  staging:rtl8192u: Rename variable NumChnls - Style
  staging:rtl8192u: Rename variable MaxTxPowerInDbm - Style
  staging:rtl8192u: Remove typedef and rename DOT11D_STATE - Style
  staging:rtl8192u: Remove typedef and rename struct RT_DOT11D_INFO -
    Style
  staging:rtl8192u: Rename bEnabled > enabled - Style
  staging:rtl8192u: Rename CountryIeLen > country_ie_len - Style
  staging:rtl8192u: Rename CountryIeBuf > country_ie_buf - Style
  staging:rtl8192u: Rename CountryIeSrcAddr > country_ie_src_addr -
    Style
  staging:rtl8192u: Rename CountryIeWatchdog > country_ie_watchdog -
    Style
  staging:rtl8192u: Rename MaxTxPwrDbmList > max_tx_pwr_dbm_list - Style
  staging:rtl8192u: Rename variable State > state - Style

 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 60 +++++++++----------
 drivers/staging/rtl8192u/ieee80211/dot11d.h   | 55 +++++++++--------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c        |  2 +-
 4 files changed, 59 insertions(+), 60 deletions(-)

-- 
2.18.0

