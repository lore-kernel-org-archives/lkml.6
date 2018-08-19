Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7CCC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E85208D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 11:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E85208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeHSO0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 10:26:30 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:54021 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeHSO0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 10:26:30 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id D41859002A;
        Sun, 19 Aug 2018 14:15:21 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id C1C3D220906; Sun, 19 Aug 2018 14:15:19 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id C40AA220206;
        Sun, 19 Aug 2018 14:15:19 +0300 (EEST)
Date:   Sun, 19 Aug 2018 14:15:19 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: make *config regression: pkg-build
Message-ID: <alpine.LRH.2.21.1808191406030.12334@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried to run 'make menuconfig' on v4.18-10568-g08b5fa819970 and 
found a bad surprise:

'make *config' requires 'pkg-config'. Please install it.
make[1]: *** [scripts/kconfig/Makefile:219: scripts/kconfig/.mconf-cfg] Error 1

This is clearly a regression - I have libncurses devele pakcage 
installed in the default system location (as do 99%+ on actuall 
develeopers proobably) and in this case, pkg-config is useless. 
pkg-config is needed only when libraries and headers are installed in 
non-default locations but it is bad to require installation of 
pkg-config on all the machines where make menuconfig would be possibly 
run (for example, I have a aboult 100 machine kernel testbed with 
self-hosted kernel compilation and machine-specific kernel 
configurations that ocassionally need tweaking).

I notice 4.18 complained it can not find pkg-config but still worked. 
This is clearly better than now.

If we want to support developers with libraries in non-default 
locations, why not - but the common case of system include path should 
work without any trouble or warnings. For exaple, test if compilation 
against ncurses works, and if not retry it with pkg-config (and error 
out if it does not give working result).

-- 
Meelis Roos (mroos@linux.ee)
