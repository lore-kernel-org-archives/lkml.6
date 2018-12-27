Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD2C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA25214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="USV7Dnln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbeL0LT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:19:28 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:58821 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeL0LT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:19:27 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id ADB4880531;
        Thu, 27 Dec 2018 03:13:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net ADB4880531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1545909210;
        bh=XgNS7hfrYPqotyodC5gg1jp0+BpIKly8DPfH1qtjHMI=;
        h=From:To:Cc:Subject:Date:From;
        b=USV7DnlnOju4I8AcJ/opF2IwILWBswkUoGrk1SF2kRHPz5MkzEtE4oiPWUv3bjtoZ
         RRTD5iyAZq5VIjASIvFKw/ctnaEDzkYMuobANTNB5cZLqvE7U0vG5dHUA6FPMR62Qx
         O87mFutABlISp+DxZyc71k/P1TOYM8Lliyn0t/mE=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] sysctl: fix range-checking in do_proc_dointvec_minmax_conv()
Date:   Thu, 27 Dec 2018 05:12:28 -0600
Message-Id: <20181227111231.12912-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After being left with an unusable system after a typo executing
something like 'echo $((1<<24)) > /proc/sys/vm/max_map_count', I found
that do_proc_dointvec_minmax_conv() was missing a check to ensure that
the converted value actually fits in an int.

The first of the following patches enhances the sysctl selftest such
that it detects this problem; the second fixes it (wasn't entirely
sure if this would meet the criteria of something that should be sent
to -stable; input welcome).


Thanks,
Zev Weiss


