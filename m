Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C14720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C14720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeLEL1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:27:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:27:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so12460387wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6xSobTS4/I/ly2Cl9N8o3ul8wORyRBSidBYmcB7Z90=;
        b=D63IumnYp1XBJv0uAhVxEtJv8HdxSITswu9fz1PdEViBqIZdWFFDR6+2Fp7A20cvl0
         QeGUEmUzN6ARf6fGF/jAqC5gBlKxFmsaSAejI0J59YkLNOMNaAnsydNjNQ45lNIGx4en
         Nmnmd19NLvNFjdG+enyfj/+tlUmSImrAqhFVCfMooqz5+TByrxcRFbz4LwAKELeD5PWF
         ts8OCWn9BYGNE7/FyERgWFyb93/3WJiJf1+sO5k1uXbpIK+ef236Lq7djRsld8Ivt7Cz
         aHQdXy+Xo88ixPIDj92n7XpAblplFuPFz717o/aDuK5KOQP5HrRQ8BR2T0KZyBgAKemJ
         soRQ==
X-Gm-Message-State: AA+aEWaEwR8BmSjNNlZsvegnLQdRHypK/+Kl10+CkhLAdUPzXgEGzWkS
        iKitBL8nUgg+fZPvv4zIO88S4w==
X-Google-Smtp-Source: AFSGD/U9rrpD7XpULBWaR5hGcvsBGeQtEf03pALke18p7PMC/enzl2tqR63+7C8Hb57M31j7NZYgNw==
X-Received: by 2002:a1c:7a16:: with SMTP id v22mr5288818wmc.131.1544009270650;
        Wed, 05 Dec 2018 03:27:50 -0800 (PST)
Received: from alatyr.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d2sm14535027wrs.97.2018.12.05.03.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:27:50 -0800 (PST)
From:   Peter Rajnoha <prajnoha@redhat.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: [PATCH 0/2] Fix return code and improve feature check for synthetic uevents
Date:   Wed,  5 Dec 2018 12:27:43 +0100
Message-Id: <20181205112745.12276-1-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small patches to aid handling of synthetic uevents back in userspace:

  - Return error code back to userspace on /sys/.../uevent file write
    failure so userspace knows and it can act accordingly.

  - Add new 'kernel/uevent_features' sysfs file to make it possible for
    userspace to check that the extended synthetic uevent arguments are
    supported without relying on kernel version check only.

Peter Rajnoha (2):
  kobject: return error code if writing /sys/.../uevent fails
  kobject: add kernel/uevent_features sysfs file

 drivers/base/bus.c  | 12 ++++++++----
 drivers/base/core.c |  8 +++++++-
 kernel/ksysfs.c     |  8 ++++++++
 kernel/module.c     |  6 ++++--
 4 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.19.2

