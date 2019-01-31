Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3082087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGD/7t3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfAaWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:13:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33477 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfAaWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:13:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2126756plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcXvSDSPy9bgfIgUOH90Lcwdn7ixN1lGbyJwaRTlUHQ=;
        b=UGD/7t3D1sqs0Oxwzkugt+4GoJENoEhdkE18BCxu3b0cI4I8HAWmQTLcf9JCOR+KbN
         YHJrVVaixW/p7AliIQpmYaVsMrMzVsGZKaCBAnKnh1vxBLWug7VyP4ZBNiafbPq+mECp
         nEu4worV26FAaMW4F+XIGAnJX31wvNkBzgtGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcXvSDSPy9bgfIgUOH90Lcwdn7ixN1lGbyJwaRTlUHQ=;
        b=WC+prA8JzKxIeW4JCXjKxiY2+zKYNmW9Oj44kcQQwRUZfhPXO2mKOIv/7kuNwpdv7D
         d75Kq4BtQVzmnwnZz3rFmAcpFylp7NACzuzJTfr4etYVbAdkOca21hh6PTg6pkQlW3w8
         Vr1jKmiTbUvArdbFlnTpZnrfuvNxTTwoSf5Ud4k8fkDoBgJzQiNhCgK4ypXwFD9g1Da4
         MOdpcFHgFvUdjc7b81APgWDtdLPb+p7gNbqrPhYDkBwvOU9hW3VFIG25+tkMsdi9zGK4
         YgcBbZxLk+KqrItXiwEJzH+VcxSkDlm4m10j1L6Yq1qwWPbl6Zxh3uMJWnQX0avkb3aJ
         YBbA==
X-Gm-Message-State: AJcUukeKkaJuRKB3HWS+jVyUNT8TfOZdd/xclE0klP4B5VTWzrmb75ZQ
        RRlg+DALJGXd0CClPtSybeUnww==
X-Google-Smtp-Source: ALg8bN4Y4LTCygc9vt2/BX+K3QfXCkG+pjXFtGSxIJ5tI9AehBxJJj9uDvPFN4bg2iPrTbFIZxCf5A==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr36941880plc.108.1548972826464;
        Thu, 31 Jan 2019 14:13:46 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z10sm7961681pfg.120.2019.01.31.14.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 14:13:45 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/2] loop: Better discard for block devices
Date:   Thu, 31 Jan 2019 14:13:26 -0800
Message-Id: <20190131221328.85343-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support discard.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
discard capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does a discard operation on the
backing device. After this change, backing block devices that do support
discard will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support discard will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.



Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 75 ++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.20.1

