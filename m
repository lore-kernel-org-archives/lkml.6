Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC28C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8484121104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUG1hV21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbeKTDB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeKTDB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:01:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96A921104;
        Mon, 19 Nov 2018 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645467;
        bh=u2dnqUcwtfYkOvzTQCW/nIOci65/Dc21DTmrS0xr2fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUG1hV21HkUEWlDeDC1WwG4CaVyreZIQGOsZhLLEwcCALMVJayJGK5WLsRYqJkXjc
         K4JtHe2kzLEXzqVv/U2uG3bFt9SmQqB7WcV/+QAol2H792xSBxpDm6FQ5lqjexXBgE
         qqjAXllea/vB+oQXK2ezVUvdFjdEsiZW9kcgZLXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.19 146/205] ext4: fix buffer leak in __ext4_read_dirblock() on error path
Date:   Mon, 19 Nov 2018 17:27:33 +0100
Message-Id: <20181119162638.275105354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit de59fae0043f07de5d25e02ca360f7d57bfa5866 upstream.

Fixes: dc6982ff4db1 ("ext4: refactor code to read directory blocks ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.9
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -126,6 +126,7 @@ static struct buffer_head *__ext4_read_d
 	if (!is_dx_block && type == INDEX) {
 		ext4_error_inode(inode, func, line, block,
 		       "directory leaf block found instead of index block");
+		brelse(bh);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!ext4_has_metadata_csum(inode->i_sb) ||


