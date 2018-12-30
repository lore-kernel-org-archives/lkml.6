Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B561C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F221019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJvDFSES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeL3KR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:17:58 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:32789 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeL3KR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 05:17:57 -0500
Received: by mail-lj1-f171.google.com with SMTP id v1-v6so21912524ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5VTSRqosN2p9pLhoq9yGM90OXpRmfrewiM/uv6FDgk8=;
        b=tJvDFSESkCt7pP8PNJHMDXwmhMrfNdedPJEAUeS0Z3lzgC0iX27PTNDHTu/mO2KuL0
         fGzufTk913O2CU2CTonq19RXxxh75PwMY+OzSyGhUoZhTYG+z5b7DIYedcu+bkbxGr9T
         iA19QBgMDX2qAQIUAcPzhz23WVQ0pzbZBrVyxW88bZMv8fbT6XX7VHmPoHQxBmh9lzLg
         sZyudqXaH/mMbboBKU68CJZxGeGW0voM8qIEsc3GDRFPYz9dWHhs8RAPOfU4yOfv0Sg9
         DAqFC2rrOg+BTV+pEMwWZbupp+kwY0GCCp+A5S+J7D0cVF4Y5mlkaoFC1Yl4+5gxaDyY
         CcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5VTSRqosN2p9pLhoq9yGM90OXpRmfrewiM/uv6FDgk8=;
        b=RpJM0sXRiITp3FccU9t7kVD1K3wwbU/e5t2JF7hyYsSDuykDITLM6mU5bCmxUMPz6t
         Ah1EDUIvxTssF0YJxTbusq4PUgM/wy7IzLQN00VndfDCqniMEmTAJqM+u3bWzaeQ4omx
         QdvHsnx2JkgIMCLoYR2vwn8oiOUxDL/QqNMpIBk51b8ptRwxNZvFsP86Iepcgh4tnI6z
         SPnJI0nCEpbX7ts0Z7vOmMWjeCUNCVOuEARHuZD6QVjeu5M1rOYHqmx/G1dX4eeRxpls
         lMcbzo4IOYTMUxZVdLiZeKY4BNpQttjVkIK196J5vo1d1HitMFnzI+UhJsq4hZ3uuxZ/
         LLSA==
X-Gm-Message-State: AJcUukehJb+4IVgeGUtSLE44sjmvhpjt3k5S/W0p+yDy/9/S8LjAQlFv
        1s8ogIGJIKuaeLsMG/4xkJ10d+IE98nxQXjhv5jBfVLsCA==
X-Google-Smtp-Source: ALg8bN5g99Cst64Uad9FGmgexHAD8YFUsBXs5dXmwq1dX1H2J0ARx3MY9PDB/grmatQR2EL2zhbGyE38/awr3XO12nk=
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr16489970ljo.10.1546165075266;
 Sun, 30 Dec 2018 02:17:55 -0800 (PST)
MIME-Version: 1.0
From:   Yi Qingliang <niqingliang2003@gmail.com>
Date:   Sun, 30 Dec 2018 18:17:44 +0800
Message-ID: <CADwFkYe1Z7C_993xdKKeOg3F1O40L1o+K9GyF2JKG0HUUPv7SA@mail.gmail.com>
Subject: epoll and vb2_poll: can't wake_up
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I encountered a "can't wake_up" problem when use camera on imx6.

if delay some time after 'streamon' the /dev/video0, then add fd
through epoll_ctl, then the process can't be waken_up after some time.

I checked both the epoll / vb2_poll(videobuf2_core.c) code.

epoll will pass 'poll_table' structure to vb2_poll, but it only
contain valid function pointer when inserting fd.

in vb2_poll, if found new data in done list, it will not call 'poll_wait'.
after that, every call to vb2_poll will not contain valid poll_table,
which will result in all calling to poll_wait will not work.

so if app can process frames quickly, and found frame data when
inserting fd (i.e. poll_wait will not be called or not contain valid
function pointer), it will not found valid frame in 'vb2_poll' finally
at some time, then call 'poll_wait' to expect be waken up at following
vb2_buffer_done, but no good luck.

I also checked the 'videobuf-core.c', there is no this problem.

of course, both epoll and vb2_poll are right by itself side, but the
result is we can't get new frames.

I think by epoll's implementation, the user should always call poll_wait.

and it's better to split the two actions: 'wait' and 'poll' both for
epoll framework and all epoll users, for example, v4l2.

am I right?
