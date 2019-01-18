Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16256C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="eHmoKibS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfARXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:10:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfARXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:10:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so6987649plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=3NBLiWeI767q1TVxnrvkR8PYADKw1iZnw2EZwD82DSA=;
        b=eHmoKibS04ayzHt63FYwU1AkoNnz88eGi+J27StrTEiZqXql+oNLRoxT8u9H1IHwU2
         GIixmJUhW6PRTqSLWtX3CaLw/WCEkzEdwbH9DbXdGzw+aElhQLtRNBFge7jrolD8hk2Y
         ms/bf96YtA1d6fAZpJjrqQs3rYhKI2HqFDnK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=3NBLiWeI767q1TVxnrvkR8PYADKw1iZnw2EZwD82DSA=;
        b=INBDulLhfljglEy+Hftr9vCUcqI+n9VloIFBee1eFKPjZLpQ9+andRJXhUPLaeZtbP
         6CM0ENftjLvDK2Oj5Ih0BxxNtKrlZUrIPrwbsjZvpcSTKRNQGzXBJkQ8I6zsHsrDaEDA
         fAlgYv6Z5/mM4ii16ButfUGkIgIPCPwSOF+d7CUJWN8d64LiFijb8srNS6DzolioqbXV
         TXxMkpViCZaaOmDiBHUxfPgNXbqQuqwbj6Tlf2xCKaDShDztLylJa3ie/gclI/zyGrsq
         zGaD6Na7kpXdd87QM+d0aqDjPzJKwsckmlMjaON8IYYeeaVZdaTqR9uCR1ZdNnZcF85I
         OzHA==
X-Gm-Message-State: AJcUukf0k6UW0hW9ZNQaF95pFpRpjmrLSLo6V5DMVOpSxOAHVHk/UaIg
        nn6cjdj1s/IThOv/P6fxL+Y4ig==
X-Google-Smtp-Source: ALg8bN5Jb5CQZwH10Z5PoZW6o4uuDA/mj9s+5+G3aYKuIPZgUXyVQDqszzzM7yJ2T/qJgkSv5IQKpg==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr21211497plr.89.1547853042296;
        Fri, 18 Jan 2019 15:10:42 -0800 (PST)
Received: from jltm109.jaalam.net ([209.139.228.33])
        by smtp.gmail.com with ESMTPSA id p7sm8312963pfa.22.2019.01.18.15.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:10:41 -0800 (PST)
From:   Fred Klassen <fklassen@appneta.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH] ipmi: Prevent use-after-free in deliver_response
Message-Id: <09133030-238B-475F-94BC-B48827812714@appneta.com>
Date:   Fri, 18 Jan 2019 15:10:39 -0800
Cc:     stable@vger.kernel.org
To:     "Corey Minyard (supporter:IPMI SUBSYSTEM)" <minyard@acm.org>,
        "Arnd Bergmann (supporter:CHAR and MISC DRIVERS)" <arnd@arndb.de>,
        "Greg Kroah-Hartman (supporter:CHAR and MISC DRIVERS)" 
        <gregkh@linuxfoundation.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IPMI modules (e.g. ibmpex_msg_handler()) will have ipmi_usr_hdlr
handlers that call ipmi_free_recv_msg() directly. This will essentially
kfree(msg), leading to use-after-free.

This does not happen in the ipmi_devintf module, which will queue the
message and run ipmi_free_recv_msg() later.

 BUG: KASAN: use-after-free in deliver_response+0x12f/0x1b0
 Read of size 8 at addr ffff888a7bf20018 by task ksoftirqd/3/27
 CPU: 3 PID: 27 Comm: ksoftirqd/3 Tainted: G           O      =
4.19.11-amd64-ani99-debug #12.0.1.601133+pv
 Hardware name: AppNeta r1000/X11SPW-TF, BIOS 2.1a-AP 09/17/2018
 Call Trace:
  dump_stack+0x92/0xeb
  print_address_description+0x73/0x290
  kasan_report+0x258/0x380
  deliver_response+0x12f/0x1b0
  ? ipmi_free_recv_msg+0x50/0x50
  deliver_local_response+0xe/0x50
  handle_one_recv_msg+0x37a/0x21d0
  handle_new_recv_msgs+0x1ce/0x440
  ...

 Allocated by task 9885:
  kasan_kmalloc+0xa0/0xd0
  kmem_cache_alloc_trace+0x116/0x290
  ipmi_alloc_recv_msg+0x28/0x70
  i_ipmi_request+0xb4a/0x1640
  ipmi_request_settime+0x1b8/0x1e0
  ...

 Freed by task 27:
  __kasan_slab_free+0x12e/0x180
  kfree+0xe9/0x280
  deliver_response+0x122/0x1b0
  deliver_local_response+0xe/0x50
  handle_one_recv_msg+0x37a/0x21d0
  handle_new_recv_msgs+0x1ce/0x440
  tasklet_action_common.isra.19+0xc4/0x250
  __do_softirq+0x11f/0x51f

Fixes: e86ee2d44b4 ("ipmi: Rework locking and shutdown for hot remove")
Signed-off-by: Fred Klassen <fklassen@appneta.com>

---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c =
b/drivers/char/ipmi/ipmi_msghandler.c
index 7fc9612070a1..fbf93c2d6c05 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -883,7 +883,7 @@ static int deliver_response(struct ipmi_smi *intf, =
struct ipmi_recv_msg *msg)
=20
 		if (user) {
 			user->handler->ipmi_recv_hndl(msg, =
user->handler_data);
-			release_ipmi_user(msg->user, index);
+			release_ipmi_user(user, index);
 		} else {
 			/* User went away, give up. */
 			ipmi_free_recv_msg(msg);
--=20
2.11.0

