Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C5BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1084F218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLRc/o3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfAAOER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:04:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33539 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfAAOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:04:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so13595742pgu.0;
        Tue, 01 Jan 2019 06:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wTbIRGXnplu0V0rucdMJVUoO9mdEyF612KcyI5DJ8AY=;
        b=BLRc/o3dWWSvEKPe4jq59fhDSY+OfvElmkKUGBqHn8hofHP0e6bEQPxi+kcNXHY1U+
         LavKmGVzDEcaDvYDuthfJYFjLxxhBE2QbB5QuHNqwJbX1aoMYPIUW2eKJEK3zYugV1Zk
         auB7F0J10r5JgosBzKVArUIgkgbsL5ASzAbFEFfcY90kGFff09wsmf1oKGw6Y4BOS0/V
         GBT7q1DADex+veOZanI/YnTqh6c8u3lEDfdB63og4+cvMQln0Op7k2jtIkbJuPBGs1nh
         Y5T+LCDMAz94cVX2tQlODHUds2ecuTfa/CkyYIDwIu8xEoLYGqIWDOyrkLM2kcW8e064
         LxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wTbIRGXnplu0V0rucdMJVUoO9mdEyF612KcyI5DJ8AY=;
        b=AIzQszhNlgAMU0NVxMaH1l+fObRe+jIglE7jLFepsjJstC6R57qQrYsazIizjdcwDN
         dqrmM69HM21NmzRwvvHnBNUo/sKOuvvqqRJyX2lWvq3Uj9yaQApJ7dPp+YLX9G8pT0SB
         /g1VdWdwwtJNM5GS1n8EqIz8zHXvQscXqXO8L8xwGbF8i1Td3tAUI7j2NfYFoeGk2b4S
         7ab/sEVrcl0Jlp+11R0OOHtuCZSul4Z1Oi/wR1LBV5lVvhWEOnk5Ded8U6yz+w0La33B
         iLq4aKfbvN6tTw1W0NseJCzVeKriWaZHJ0SxoTog7kndVazRPRfsOFhV+25fiHHVgqtI
         5DXw==
X-Gm-Message-State: AJcUukcO1unzPVauCyQWPjPWW0dH+/HfKfKxqSTbajdsK0kTXMXtpjH6
        O5IClOz/nwOR1ANnNbPdGA==
X-Google-Smtp-Source: ALg8bN6bmHR62EAu/+g3V9ywop65oukxqOBbPfqR1SxKCSUUHO+PD/oFoZ+hMS6a5zPbJmg/6N8tsw==
X-Received: by 2002:a65:4142:: with SMTP id x2mr10348501pgp.356.1546351456389;
        Tue, 01 Jan 2019 06:04:16 -0800 (PST)
Received: from localhost.localdomain (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id v14sm121117477pgf.3.2019.01.01.06.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 06:04:15 -0800 (PST)
From:   Junchang Wang <junchangwang@gmail.com>
To:     dave@stgolabs.net, paulmck@linux.ibm.com, josh@joshtriplett.org,
        corbet@lwn.net, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH 0/2] Documentation/RCU: Update documents
Date:   Tue,  1 Jan 2019 22:03:18 +0800
Message-Id: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

This patch set updates a few outdated links/sections in the documents of RCU.
Please take a look.

--
Junchang Wang (2):
  whatisRCU.txt: correct outdated links
  torture.txt: update the list of supported torture types

 Documentation/RCU/torture.txt   | 15 +++++++--------
 Documentation/RCU/whatisRCU.txt |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.7.4

