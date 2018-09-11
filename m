Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B101C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF57F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgaZvY+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF57F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIKPRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeIKPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:17:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7F520839;
        Tue, 11 Sep 2018 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536661149;
        bh=Vek34F+hQT8KcWbpUgGFC8O0ntZuyrIKsOKrbCxBYXM=;
        h=From:To:Cc:Subject:Date:From;
        b=rgaZvY+Ynh6zDjwkNes/L9evmYQ+/IauEWS2mmOkroP4oDTtXgobymjJwMPDU+pIY
         K2lPofQnIR/R+yYAA3T8yw5E4MevKv9zavaAT7bNyRstsVIUisza0yEm1OC9PZdMOy
         /yr0lJcDJ0vgYhrd6HbYi8tEc3pbtk4mdjmu93B4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v2 0/5] kprobes: Remove BUG_ON from kprobes
Date:   Tue, 11 Sep 2018 19:18:43 +0900
Message-Id: <153666112297.21306.4621579144717171778.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are v2 patches to remove BUG_ON from kprobes.

Since BUG_ON() kills the machine, it must not be used
for debugging or assertion. These patches remove
meaningless BUG_ON or replace it with return errors.

In this version, I updated 5/5 to use WARN_ON_ONCE()
for unusual case, according to Ingo's comment.

Thank you,

---

Masami Hiramatsu (5):
      kprobes: Remove meaningless BUG_ON from disarming process
      kprobes: Remove meaningless BUG_ON from add_new_kprobe
      kprobes: Remove meaningless BUG_ON from reuse_unused_kprobe
      kprobes: Return error if fail to reuse kprobe instead of BUG_ON
      kprobes: Don't call BUG_ON if there is a kprobe in use on free list


 kernel/kprobes.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
