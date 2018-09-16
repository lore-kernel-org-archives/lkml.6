Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D1ECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C0B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C0B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeIPXCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:02:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59598 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIPXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:02:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b0l-0007hJ-Q4; Sun, 16 Sep 2018 11:39:07 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1b0k-0001la-M2; Sun, 16 Sep 2018 11:39:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
Date:   Sun, 16 Sep 2018 19:38:55 +0200
In-Reply-To: <20180914105310.6454-1-jlayton@kernel.org> (Jeff Layton's message
        of "Fri, 14 Sep 2018 06:53:07 -0400")
Message-ID: <87a7ohs5ow.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1b0k-0001la-M2;;;mid=<87a7ohs5ow.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19vPSK2a6meOUuzTdLwYY5JgcUwODXF5IE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 0/3] exec: Moving unshare_files_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paired with Oleg's patch to reduce the number of callers of
get_files_struct it looks like we can simplify the basic idea of moving
unshare_files in exec by quite a bit so that in net we have fewer lines
of code.

The big simplification from Jeff's verion is that we take advantage
of calling unshare_files past the point of no return.  Which removes
the need for cleanup, and restoring ->files.  Which removes the
need for blocking clone and unshare.

Oleg's patch to remove get_files_struct from proc means we don't need
two counts in files_struct.

Which leaves us with the question of what are the races in fs/exec.c
with respect to accessing files.  Semantically I don't think we care
but we do need to be certain the implementation of exec is still robust.

These patches are still rough and ready and only compile tested but I
believe they demonstrate what is possible.

Eric W. Biederman (3):
      exec: Move unshare_files down to avoid locks being dropped on exec.
      exec: Simplify unshare_files
      exec: Remove reset_files_struct

 fs/coredump.c           |  5 +----
 fs/exec.c               | 16 +++++-----------
 fs/file.c               | 12 ------------
 include/linux/fdtable.h |  3 +--
 kernel/fork.c           | 12 ++++++------
 5 files changed, 13 insertions(+), 35 deletions(-)

Eric
