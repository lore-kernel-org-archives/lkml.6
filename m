Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A27C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F2620828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeL3Q3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:29:09 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:39382 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeL3Q3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:29:08 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-80-127-nat.elisa-mobile.fi [85.76.80.127])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 57BD7300BD;
        Sun, 30 Dec 2018 18:29:06 +0200 (EET)
Date:   Sun, 30 Dec 2018 18:29:06 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Bug report: unaligned access with ext4 encryption
Message-ID: <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When using ext4 encryption on SPARC, there's plenty of dmesg noise about
unaligned access:

[  167.269526] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
[  167.270152] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
[  181.087451] log_unaligned: 5 callbacks suppressed
[  181.087511] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
[  181.092435] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
[  181.095816] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120

And also seen on an ARM machine:

$ cat /proc/cpu/alignment
User:           0
System:         1028193 (find_and_lock_process_key+0x84/0x10c)
Skipped:        0
Half:           0
Word:           1028193
DWord:          0
Multi:          0
User faults:    0 (ignored)

Looks like user_key_payload layout is not optimal when data address
is used for fscrypt_key... I tried the below change and got rid of the
messages. Not sure what the proper fix should be?

A.

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index e098cbe27db5..6495ffcfe510 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -31,7 +31,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
+	char data[0] __aligned(4);	/* actual data */
 };
 
 extern struct key_type key_type_user;

