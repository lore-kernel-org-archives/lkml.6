Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB1820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB1820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeKAELi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:11:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:47164 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAELi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:11:38 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvuW-0006Jx-QD; Wed, 31 Oct 2018 22:12:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/7] ext4 long-lived issues, part two
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Message-ID: <fc0fb5ab-2272-8cad-4852-a1c9532bafc5@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:12:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've found one more batch of long-lived ext4 issues,
most of them are lost brelse + two leaks on rollback in ext4_fill_super.

Oldest one was found in 2.6.23, last one -- in 4.18.

Vasily Averin (7):
  ext4: lost brelse in __ext4_read_dirblock()
  ext4: possible sbi->s_group_desc leak in ext4_fill_super
  ext4: lost release of s_journal_flag_rwsem on rollback in
    ext4_fill_super
  ext4: lost brelse in ext4_xattr_get_block()
  ext4: bs.bh cleanup before re-using in ext4_xattr_block_find()
  ext4: lost brelse in ext4_xattr_move_to_block()
  ext4: lost brelse in ext4_expand_extra_isize_ea()

 fs/ext4/namei.c |  1 +
 fs/ext4/super.c |  4 +++-
 fs/ext4/xattr.c | 15 ++++++++++++---
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.17.1

