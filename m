Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C2AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D316208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D316208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH0PQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeH0PQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D77A8AFA4;
        Mon, 27 Aug 2018 11:30:38 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id E723AA0C37; Mon, 27 Aug 2018 13:30:37 +0200 (CEST)
Date:   Mon, 27 Aug 2018 13:30:37 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: regression: broken ppc64le build with CONFIG_KERNEL_XZ=y
Message-ID: <20180827113037.gbtnbhcwebcwei57@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building 4.19-rc1 kernel with CONFIG_KERNEL_XZ=y fails with this error:

  BOOTCC  arch/powerpc/boot/decompress.o
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error: linux/crc32poly.h: No such file or directory
 #include <linux/crc32poly.h>
          ^~~~~~~~~~~~~~~~~~~

This is caused by commit faa16bc404d7 ("lib: Use existing define with
polynomial") which added include of <linux/crc32poly.h>; when compiling
arch/powerpc/boot/decompress.c, the include/ directory is not searched
so that the header file is not found.

The solution is probably adding -I directive to some place in
arch/powerpc/boot/Makefile but I don't dare to guess where.

Michal Kubecek
