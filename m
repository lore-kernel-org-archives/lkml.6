Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E1CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4219220896
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570243;
	bh=OHwyZWV3YEB4/IFkaWdvZ2/weyRDMmnlak1lEjWMPrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pXb2yCAL6lLDdRDMCqvJKo92MaHIIIvZfR+a1b4cTkP9HKTepMkhRMDbp2uQi0nN
	 9cdTZ4rbkKdR3YkKco6zgnKQjpTha/YwNPCFVNpex57UAdJW6JlwJXylK3LIVLtjsA
	 jFt4THqH/FpHFxjl3jMWUmZTd4K05o65tR8k8eFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfAOQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbfAOQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF13120675;
        Tue, 15 Jan 2019 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570235;
        bh=OHwyZWV3YEB4/IFkaWdvZ2/weyRDMmnlak1lEjWMPrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J97lnhGLl7U7p+FIiNf4nXlqj/f8MKqT0DauB62xrQ0RdGd9YV7CTBw2XMyiAY4kR
         h7nwTePd1GOHBPqKbGhAH5MkKC0MmW7XoquUVHEiHLbuwGPNh1tPy2EQhTBGXpYenR
         or62ZL/xAiotNbRj6XXPLLEGQXj3qTWKOJ6NDICc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 06/51] Btrfs: fix em leak in find_first_block_group
Date:   Tue, 15 Jan 2019 17:35:02 +0100
Message-Id: <20190115154847.817939922@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit 187ee58c62c1d0d238d3dc4835869d33e1869906 upstream.

We need to call free_extent_map() on the em we look up.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9518,6 +9518,7 @@ static int find_first_block_group(struct
 			} else {
 				ret = 0;
 			}
+			free_extent_map(em);
 			goto out;
 		}
 		path->slots[0]++;


