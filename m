Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C771D21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="MqCI7AvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:34:58 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:33180 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:34:58 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 11CA680536;
        Thu,  7 Feb 2019 04:34:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 11CA680536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549542897;
        bh=iVVdBPB4buMko/wiWiNAdqOJ8++SSUTl7HSeYmTaiAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqCI7AvDgYubDWODLHynmuGdzA2tG9Ify1AC294b++da7Pbx+xfHAklBkqUNsvORu
         k1P2v22gHmRyafYhGe5HJc6rExNQc/chdpaxj0NV6dFdGF1sc2RXlwN3sm2GW5FheY
         xJDEYsBjN/NKMZkNPhUnGDdqxQ5dfPnBe4fI44BY=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com
Subject: [PATCH v2 0/3] sysctl: fix range-checking in do_proc_dointvec_minmax_conv()
Date:   Thu,  7 Feb 2019 06:34:23 -0600
Message-Id: <20190207123426.9202-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206195807.GG11489@garbanzo.do-not-panic.com>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
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
that it detects this problem; the second provides a minimal fix
(suitable for -stable) such that the selftest passes.  The third patch
then performs a more thorough refactoring to eliminate the code
duplication that led to the bug in the first place (maintaining the
passing status of the selftest).


Changes in v2:
 - Rearranged selftest to also test negative values and provide more
   info in comments
 - Added intermediate patch as a minimal fix for -stable without the
   refactoring


Thanks,
Zev Weiss


