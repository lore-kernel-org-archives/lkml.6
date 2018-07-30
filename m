Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED0FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095C20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B56xcSwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeG3Itc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:49:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeG3Itb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2MYcXBHRJTtyWcXUkj9lphUllD1qz8kGW8lFngzGIKw=; b=B56xcSwUauZB2KVJ6GS/++tNO
        309iEGJHbviHUdLGmoPX3grfjZIePIEVPLWv2a+4ZFc/HA6Y7calcAcZ21afGvrQWVoVMYFIqtK/w
        uSFf8U9s79qUUr0gtNEGhCFBElim/BcUuE4H4+x/DxCMb9OE/ufFFxrI9jevDkIaKbevHT8+08UDW
        5xWNs2JdyFJpA+CaRrKm7JXS+uEiMydYd1B3tN0Ea7nUf5j8UzCfANDSxdIAqWtmDPEFqOeGo1Ci+
        c56NifKCp4Y8vPc0j9LhLMLC2BMPq0/hM0srH8HwR6PVO5RvNi8BTUMZTiUPE/klhwS90VZRRX2wK
        W45jx1auw==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2PG-0007Zd-Kv; Mon, 30 Jul 2018 07:15:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll and a new in-kernel poll API V21 (aka 2.0)
Date:   Mon, 30 Jul 2018 09:15:40 +0200
Message-Id: <20180730071544.23998-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series adds support for the IOCB_CMD_POLL operation to poll for the
readyness of file descriptors using the aio subsystem.  The API is based
on patches that existed in RHAS2.1 and RHEL3, which means it already is
supported by libaio.

As our dear leader didn't like the ->poll_mask method this tries to
implement the behavior using plain old ->poll which is rather painful.
For one we only support ->poll instances with a single wait queue behind
them and reject the request otherwise, which isn't really different from
the previous ->poll_mask requirement, just implemented in a rathet
awkward way.
Second we had to implement a refcount on struct aio_iocb (although it
is kept as a no-op for non-poll commands) so that we can safely handle
the case of ->poll returning a mask after it got a wakeup.  This
also means there is a lot of open coded magic for the waitqueue
removals and dealing with ki_list to deal with these cases.
Last but not least to avoid a guaranteed context switch on every wakeup
we trust keyed wakeups, which from an audit of the users seems to be
good.  The only thing it loses is batching of multiple wakeups in
a short time period into a single result.

The changes were sponsored by Scylladb.

    git://git.infradead.org/users/hch/vfs.git aio-poll.21

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.21

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes:

    https://github.com/avikivity/seastar/commits/aio

Changes since v20:
 - use a refcount_t instead of an atomic_t for ki_refcnt

Changes since v13:
 - rewritten to use ->poll

Changes since v12:
 - remove iocb from ki_list only after ki_cancel has completed
 - fix __poll_t annotations
 - turn __poll_t sparse checkin on by default
 - call fput after aio_complete
 - only add the iocb to active_reqs if we wait for it

Changes since v11:
 - simplify cancellation by completion poll requests from a workqueue
   if we can't take the ctx_lock

Changes since v10:
 - fixed a mismerge that let a sock_rps_record_flow sneak into
   tcp_poll_mask
 - remove the now unused struct proto_ops get_poll_head method

Changes since v9:
 - add to the delayed_cancel_reqs earlier to avoid a race
 - get rid of POLL_TO_PTR magic

Changes since v8:
 - make delayed cancellation conditional again
 - add a cancel_kiocb file operation to split delayed vs normal cancel

Changes since v7:
 - make delayed cancellation safe and unconditional

Changes since v6:
 - reworked cancellation

Changes since v5:
 - small changelog updates
 - rebased on top of the aio-fsync changes

Changes since v4:
 - rebased ontop of Linux 4.16-rc4

Changes since v3:
 - remove the pre-sleep ->poll_mask call in vfs_poll,
   allow ->get_poll_head to return POLL* values.

Changes since v2:
 - removed a double initialization
 - new vfs_get_poll_head helper
 - document that ->get_poll_head can return NULL
 - call ->poll_mask before sleeping
 - various ACKs
 - add conversion of random to ->poll_mask
 - add conversion of af_alg to ->poll_mask
 - lacking ->poll_mask support now returns -EINVAL for IOCB_CMD_POLL
 - reshuffled the series so that prep patches and everything not
   requiring the new in-kernel poll API is in the beginning

Changes since v1:
 - handle the NULL ->poll case in vfs_poll
 - dropped the file argument to the ->poll_mask socket operation
 - replace the ->pre_poll socket operation with ->get_poll_head as
   in the file operations
