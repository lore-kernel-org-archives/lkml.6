Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF06AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A58E269EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+4dyRWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58E269EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFZR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:29:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40292 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeFZR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:22 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so3521959plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oxc1JG3STTd2/kFzXCEW8CuE7K08PC2fHX/mSgoiSkg=;
        b=G+4dyRWtJWzmY1/v/qm2NHDnfhm6gpZxUYm95rzxiOp5PN6qonQ3aLW3TQfbf3MykS
         OBwQd9JLQj9v7PR/A5zA+AYVz0TzmSYFduRcfUlTDXxy8aZ0EwIxyJo/oHj+hAp9W4dO
         E014/RuYHTfARRd+hQ6bQ4k+E5PhcKCd/veog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oxc1JG3STTd2/kFzXCEW8CuE7K08PC2fHX/mSgoiSkg=;
        b=YnZGIEQVvc0dhreJErV1CjxJ19bpHwDJZ4KskMHfQsFeuCAg9F3PI1nkfaZNWdgwG5
         stNBPGcS5LpIs4M24xjM04ZcTjqJhCMJRRp4FvKsnvYF2R2IbFei2ZJL7w4lqBgDazlt
         /nur1zwerBXXnDMXxlAWoLpKQVhjZtU2Rx+8bYB0gnSfJBQ4C8lh0oLsOeqDnDk9RgQ4
         yy95dPLBPxIAqOfWfGGC9otYm0cSDVHBrjCtFCGr4ZRU/xFGKjBXBrOINRsuc0cQO+QL
         fRvq36BpUltO2j0vPhA6y3Q/fDLCaEKKeZ4+6HxpVRY5dBlANBYiZLg2fQbhCNlSoFun
         8v9w==
X-Gm-Message-State: APt69E0V/narNo3DZCzGQWQkFO8azFIici2ZsARqUi4K4V+XCQzHh8lH
        cFbRP+mRIfwd7wlGp0OOVkiD0Q==
X-Google-Smtp-Source: ADUXVKIY8WEru0JQ/ly3+ImvjgltDbe7W4ENmEnWX4wEO9xTtkUaMCQbwOjyCpC1Dm0PbMU3j4qJQA==
X-Received: by 2002:a17:902:2809:: with SMTP id e9-v6mr2529374plb.89.1530034161973;
        Tue, 26 Jun 2018 10:29:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v15-v6sm7127564pfk.12.2018.06.26.10.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:29:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] NTFS: Remove VLA usage
Date:   Tue, 26 Jun 2018 10:29:06 -0700
Message-Id: <20180626172909.41453-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this series
removes all the VLAs in use in fs/ntfs/. A couple strategies are used,
and are detailed in the individual patches.

As far as I can tell, -mm was the last place to take NTFS-specific
patches, so I'm aiming this series at Andrew and hoping Anton can
review/ack/etc. :)

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Kees Cook (3):
  NTFS: aops: Remove VLA usage
  NTFS: decompress: Remove VLA usage
  NTFS: mft: Remove VLA usage

 fs/ntfs/aops.c     |  5 ++++-
 fs/ntfs/compress.c | 28 ++++++++++++++++------------
 fs/ntfs/mft.c      | 12 ++++++++++--
 3 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.17.1

