Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98186C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A06820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM3vD2T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A06820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJLD0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36047 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeJLD0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so9427275edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPqfM0TJiCQzZCU8iXip3BbHxdL/MhSQmsUydjA5Mnw=;
        b=FM3vD2T+ypJtJ2gR9VYsEYcClOXzXtBn/+ZVBiEPd9bPnDr1JRd7/nz34yz6Do7jxE
         AFrQ0cQBesyhUUAHfGTsL5qFVYIU9coIMMtjbkrT0Cue3UrOOguGr7gumBWIDtgRANIL
         N/6xJT9yjSyIiRIew/SDX/cgL8+uEszkCfp2t4AA1dpQzPvHoEzSi53MHUCmdj5jviMn
         pGYTlcKO344LqeoerqN4EO1vpPiXpccFaoamH/fjkBkL6ybxFaW6pgPz0s9k+DeMR5B8
         5uBMeinRNn7d6QAPiWbV/q7tou1YCaj9N8Y/LVO9zm6sNgN49asScsNTjuynool6LW46
         dRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPqfM0TJiCQzZCU8iXip3BbHxdL/MhSQmsUydjA5Mnw=;
        b=KuppX+zMNJaxWb3AcLGk7batMIGtZBBsTmLJm42xuiu4qVkziz/IHvIpFzEroZ3Gc2
         bnLIWbsxYS4eGazmcN5YJfgTkH8CSavSGKne5XyHNY1oVDV18Ob19AD5T0eANuGdxv0s
         Dxj86Cid9+JotQnuaZP7aK7yNqm4LS1/cu/R2crjxki5KWXHa0ljFuvsn02W+EuMhRgh
         GfF3c3kiGFIF8rYfiha4gDBPvQ8tFZi87rkuPeC3BTG0Cac7+KPwCFXYVJdYNAXHcxrt
         4Q0jmrNUodC5bg3DVfrrspa30q5s9BU2UJetWEQ+jYVG5Vl5RNW8S3WtxOAB58vk1td6
         lVdg==
X-Gm-Message-State: ABuFfoiNWwaePZfHjHIsNhJjugxlfdNqalyS+L0U7MUVUgTi/Z+9QMwQ
        /zXE7f5MftgZgGw+6PxSKVE=
X-Google-Smtp-Source: ACcGV61jyh8TKjlEIwJsiBtyGoF+596P8PaUripMBbw0TY5hJ7xBDP3LVpvOnyCQo4Iixl5+Kczr0w==
X-Received: by 2002:a17:906:a2c4:: with SMTP id by4-v6mr3896616ejb.86.1539287845943;
        Thu, 11 Oct 2018 12:57:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: rtl8188eu: cleanup style issues in rtw_xmit.c
Date:   Thu, 11 Oct 2018 21:57:04 +0200
Message-Id: <20181011195712.1472-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup style/checkpatch issues in the file core/rtw_xmit.c.

Michael Straube (8):
  staging: rtl8188eu: cleanup missing spaces around operators
  staging: rtl8188eu: use __func__ in qos_acm()
  staging: rtl8188eu: cleanup alignment issue
  staging: rtl8188eu: remove commented code
  staging: rtl8188eu: cleanup block comments
  staging: rtl8188eu: cleanup long lines in rtw_get_sta_pending()
  staging: rtl8188eu: cleanup long lines in stop_sta_xmit()
  staging: rtl8188eu: remove whitespace in qos_acm()

 drivers/staging/rtl8188eu/core/rtw_xmit.c | 148 ++++++++++++----------
 1 file changed, 79 insertions(+), 69 deletions(-)

-- 
2.19.1

