Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F512085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="vSMTyvRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfAOF1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:27:15 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45356 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOF1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:27:15 -0500
Received: by mail-lf1-f42.google.com with SMTP id b20so1025428lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=uT5KAFMzctly29GQkRXTYCvUKUtrYWMIfYMelAjLtm8=;
        b=vSMTyvRfGIr0bapWBILhiZYGFidak3VX8PzWNQBl+Njjkuag2y78Y8DJ6VgRXYqv5p
         xm5XEz1xLwlxjtVKwjjnl8q2PcY2pvpPizL+fF9i3i9AW6tezS7h3l7+q0XEfcE1TazJ
         LxBjOh4jVg/FRXOFLLO/RmjQifqGsGNU+G+A7MTUjt6r0ruLHJIezmh/82AEj/qrbRg9
         JkaYm3jNWFyakC1U5AXiHGsUWT2+8OR1t/qrkpE/0M3qHF2hW/59bTd5+RMWDSYABcz+
         TqyipokcqL78NHxdii/Zz3vg7TAFrER4RVY1VljVRKbyTJBBGR4Bd7r1dh/UT9gkLIz7
         vLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uT5KAFMzctly29GQkRXTYCvUKUtrYWMIfYMelAjLtm8=;
        b=H3i+4AyybhjhstCF9k+FIQS8e/V6q63Gc1kC4bywq3myyr44WKvZGgwGF614EM/N8g
         h8Sps7v3OGlcA8gua+yAKX0VFe8QXuX+I/zmxPYlPXhKojwLDqwy3zNETaoz/OWeCwPf
         T6ZAxQtEcVih0b1Xb4KJe4GDgZSC+e3iTTZVuVjMuwf742qgGgrug7A2qAqtyCCBMEpw
         OzNloTDcRrfzyBPa68LyuehiWbH4sGNVV5Zxny69JJm/gBWV/dTqo6hrE2bmVM38TPcj
         UoQ9l0tJo13sv3p6nssVUf9iELagOh1rPI7HB7YrCZ3qlrZwSzkcbOWe0GXlbfk/BFs2
         ZMcg==
X-Gm-Message-State: AJcUukeX/7Y2hkiUnpbJx7V9M7Ho7WxWi1IZyziosYoXnaLSSYbJJ4O6
        Lw/yQ4E3h22VynsQAN9U4nIWRUOMqEEfZ/CTVq0qJDgA
X-Google-Smtp-Source: ALg8bN5O3u1dLK6BAvYGdIMLNu+0Yb+TskY4a6FIajLr9tS4mpJdF1xUb3P8kdBFICPOR7aWwYBHEN7xa5hrxe/ca5s=
X-Received: by 2002:a19:df41:: with SMTP id q1mr1485770lfj.25.1547530032785;
 Mon, 14 Jan 2019 21:27:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Tue, 15 Jan 2019 18:27:00 +1300
Message-ID: <CAOp6jLa8rRw2ZQN9yWYZv_USrZw98D+U2rnk9V7M2EVY7O=VpQ@mail.gmail.com>
Subject: Regression in 32-bit-compat TIOCGPTPEER ioctl due to 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit refactored the implementation of TIOCGPTPEER, moving "case
TIOCGPTPEER" from pty_unix98_ioctl() to tty_ioctl().
pty_unix98_ioctl() is called by pty_unix98_compat_ioctl(), so before
the commit, TIOCGPTPEER worked for 32-bit userspace. Unfortunately
tty_compat_ioctl() does not call tty_ioctl() so after the commit,
TIOCGPTPEER from 32-bit userspace fails with ENOTTY.

Testcase in https://bugzilla.kernel.org/show_bug.cgi?id=202271.

I found this bug running the rr test suite.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
