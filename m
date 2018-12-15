Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315EC2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="kWOp+BS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeLOOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:39325
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeLOOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 1FE3E1430BAEE; Sat, 15 Dec 2018 15:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1544884483; bh=NNUPWcAu9yrDygZ63hknAzF8mD32Wb0kLGlCzaBq7tU=;
        h=From:To:Cc:Subject:Date:From;
        b=kWOp+BS9MUo1OohgTLoF6jVyGOn1jKGoDvsIMkmlUsYUZ/oMhEr3AEK3aim56Sh11
         ZyOkQdNnKxL3E/t642bmWHzHV0OFH+PA79QVMKzWX9L/xct2QPnOSIBoX8Ayfgh2cz
         /46ZcFmwPcGEkn108hQ8gz3DLIKSkKwREdqBZxOh5p6BF1Shu016mqi/1KT0rumgYj
         s6NnMXcdV2+Zl6jlNOkgS3mX7nBSAvuVJgLs5Yxk0iAnVXSjyafk+s2sw8AttSwxj1
         g7bgkDqeYbQAG0aFiTzOhMM/+iQYjXNIaWAn1tNAzaCWu3g2DlLSz/52RK+9gMeeW4
         91lFcreOMcHdA==
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>
Subject: vt: Improve CSI parsing
Date:   Sat, 15 Dec 2018 15:34:19 +0100
Message-Id: <20181215143423.4556-1-textshell@uchuujin.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves parsing of csi sequences to be more compliant
with current practice.

ECMA-64 defines the format of CSI sequences which allow more characters
than what the vt parser currently accepts. More importantly many of
these characters are used in sequences that more capable terminal
terminal implementations use.

Adjust the parsing of CSI sequences to match xterm* by ignoring all
unknown sequences of the form
   (ESC [)|CSI [\x20-\x3f]*[\x40-\x7e]

This avoids printing unwanted characters when application send valid
sequences not supported by linux either while querying the terminal for
it's identity or when applications print sequences without knowing what
terminal implementation they are connected to (e.g. when connected over
serial lines, android's adb, simple tcp connects, etc)

* and other common terminals
