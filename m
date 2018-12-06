Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10385C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB552082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107700;
	bh=5Kuv+ugKVoOn13978xUTDMl3/Fzt5q7FRaEiILsF33M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o4EZdFiHSzCZ+hOuC49gMYoudTNoz0hxImK2YjjC/fNA+g2nDLvGuWQmG15sl0k9v
	 wjggacZpfNgpm6BhZJonK58ZflJoGBsfk8bm7/JttzjT+JDBcJoQt5GEu06+XrCmus
	 PYm/YyZ1C35vJzudksnbep6/oQg6M1ASe41dkEwM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB552082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeLFOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbeLFOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:48:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7AB2146D;
        Thu,  6 Dec 2018 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107692;
        bh=5Kuv+ugKVoOn13978xUTDMl3/Fzt5q7FRaEiILsF33M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prjx2EEuQJlkEV86BPWF5+A+gpSFbugomqXJ9FPCnbDMl2ttgBmwjbvrDWbGCWp3N
         M4WHFfnfiauDO53WeWI7NDJFrztvewzt5ZsvO+sHVinUrZ1bHrrKqEdrnmHn3uqkhU
         MBk1qUFxVDEnbtiF35NNjjpP3YIWWcol9NXlq75M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 076/101] btrfs: tree-checker: use %zu format string for size_t
Date:   Thu,  6 Dec 2018 15:39:15 +0100
Message-Id: <20181206143016.481137012@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 7cfad65297bfe0aa2996cd72d21c898aa84436d9 upstream.

The return value of sizeof() is of type size_t, so we must print it
using the %z format modifier rather than %l to avoid this warning
on some architectures:

fs/btrfs/tree-checker.c: In function 'check_dir_item':
fs/btrfs/tree-checker.c:273:50: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'u32' {aka 'unsigned int'} [-Werror=format=]

Fixes: 005887f2e3e0 ("btrfs: tree-checker: Add checker for dir item")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -223,7 +223,7 @@ static int check_dir_item(struct btrfs_r
 		/* header itself should not cross item boundary */
 		if (cur + sizeof(*di) > item_size) {
 			dir_item_err(root, leaf, slot,
-		"dir item header crosses item boundary, have %lu boundary %u",
+		"dir item header crosses item boundary, have %zu boundary %u",
 				cur + sizeof(*di), item_size);
 			return -EUCLEAN;
 		}


