Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F99C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106E20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeKJFx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:53:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeKJFx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:53:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD9FA3002061;
        Fri,  9 Nov 2018 20:11:48 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CD9A6B8C8;
        Fri,  9 Nov 2018 20:11:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v11 0/3] ipc: Increase IPCMNI limit & IPC id generation modes
Date:   Fri,  9 Nov 2018 15:11:29 -0500
Message-Id: <1541794292-19425-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 09 Nov 2018 20:11:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10->v11:
 - Remove the sysctl parameter. Now delete mode is the only way the
   sequence number is updated. The only choice users had to make is
   whether they need to specify ipcmni_extend in the boot command line
   or not.
 - Cyclical id allocation is enabled only in the ipcmni_extend mode.
 - Increase max # of ids in ipcmni_extend mode to 16M.

v8  patch: https://lkml.org/lkml/2018/6/18/706
v9  patch: https://lkml.org/lkml/2018/9/7/1141
v10 patch: https://lkml.org/lkml/2018/11/5/791

There are users out there requesting increase in the IPCMNI value to
more than 32k. This patchset does that by using a boot kernel parameter
"ipcmni_extend" to increase the IPCMNI limit from 32k to 16M when that
boot command line option is specified.

Patch 1 adds a "ipcmni_extend" boot command line parameter to extend
the IPCMNI limit from 32k to 16M.

Patch 2 changes how the sequence number within an id is being generated
by incrementing it only when one or more ids are deleted previously to
reduce the chance of id reuse whether "ipcmni_extend" is set or not.

Patch 3 makes identifier allocation go cyclical through the entire
24-bit id space with "ipcmni_extend" only to further reduce the chance
of id reuse, but probably with a slight memory and performance overhead.

The cyclical id allocation isn't done for non-ipcmni_extend mode as the
potential memory and performance overhead may be problematic on system
with slow CPU and little memory. Systems that run applications which need
more than 32k IPC identifiers can certainly afford the extra overhead.

Waiman Long (3):
  ipc: Allow boot time extension of IPCMNI from 32k to 16M
  ipc: Conserve sequence numbers in ipcmni_extend mode
  ipc: Do cyclic id allocation with ipcmni_extend mode

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++
 include/linux/ipc_namespace.h                   |  1 +
 ipc/ipc_sysctl.c                                | 14 +++++++-
 ipc/util.c                                      | 32 ++++++++++++-----
 ipc/util.h                                      | 46 ++++++++++++++++++++-----
 5 files changed, 80 insertions(+), 19 deletions(-)

-- 
1.8.3.1

