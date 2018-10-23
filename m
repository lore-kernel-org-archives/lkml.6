Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E36C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED00220813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="B/xHNwey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED00220813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeJXDkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:40:42 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:10832 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbeJXDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:40:42 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 39AF5440B42;
        Tue, 23 Oct 2018 21:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540322157;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mZvIWY97PYxAGksc4zPpe9nDMMxnfdXlQCXOPR7sOtE=;
        b=B/xHNweycL2V4cDyjw/Qv+SOhTy9eZGqX+MjMy1TOQQGJAhF8dPi31+dpr+mcIlrlIJYkl
        BzrJj0vM7K2AEtNapQJZIqKoBJtgiOhyz7RD7F1F8fS6jzc01MbEx4dPh235ppToKjjR+L
        NrLB+vZcw7xovtyaboPKcWOpJwFomnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 39AF5440B42
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Oct 2018 21:15:57 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: NULL pointer dereference in SMB2_close_free() with v4.19
Message-ID: <c9fcc9109bf55574dba526e1bdab2d6f@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540322157;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mZvIWY97PYxAGksc4zPpe9nDMMxnfdXlQCXOPR7sOtE=;
        b=OfmVpICxm9gvo79NdPlaervB+XzUCJFOHDK8MRFWqQrGGa9AIlMZ/WAUUuWoeAhaj76/rL
        KyqQFJht5Xfw5umaAEpvvJN9TsJvfoX4mx7/yhWZKguqdZz9Qi8stpzJbZwlRqSiqi3kYt
        efeMwLlO9A59KJ1JtfiRjZXTFjtziiQ=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540322157; a=rsa-sha256;
        cv=none;
        b=KmYCzAWGkBVynTKEA3byiwlDGPsbE3F6XmAErQQJTXmy0icSeF7pjBzBqcJ19l9Ah9xnvd32pt0dvjkTFjs/gE6v6pncxWw6QYUep/xQv44mXSiPKOqAqeRyLlBOob0P3dqpH+S5IxcgpnUlEsZKdtDFoCyPvV6ug49+bWCOYG4=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

After upgrading to v4.19 I've noticed the following in my dmesg:

===
[10287.637871] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000000
[10287.637886] PGD 0 P4D 0
[10287.637900] Oops: 0000 [#1] PREEMPT SMP PTI
[10287.637909] CPU: 3 PID: 9321 Comm: file.so Not tainted 4.19.0-pf1 #1
[10287.637914] Hardware name: Dell Inc.          Vostro 3360/0F5DWF, 
BIOS A18 09/25/2013
[10287.637980] RIP: 0010:SMB2_close_free+0x8/0x10 [cifs]
[10287.637987] Code: 65 48 33 1c 25 28 00 00 00 75 09 48 83 c4 18 5b 5d 
41 5c c3 e8 d9 d3 8d f9 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 
07 <48> 8b 38 e9 70 42 fe ff 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49
[10287.637993] RSP: 0018:ffffa5d589213bb8 EFLAGS: 00010246
[10287.638000] RAX: 0000000000000000 RBX: ffff990ed85d2800 RCX: 
0000000000000000
[10287.638006] RDX: 00000000ffffff90 RSI: 0000000000000206 RDI: 
ffffa5d589213d68
[10287.638010] RBP: ffffa5d589213df0 R08: 0000000000021070 R09: 
0000000000000001
[10287.638015] R10: 0000000000001553 R11: 0000000000000005 R12: 
ffffa5d589213c50
[10287.638020] R13: ffff990ea821e800 R14: ffff990ed2e93800 R15: 
0000000000000000
[10287.638027] FS:  00007fb0cef22640(0000) GS:ffff990eef0c0000(0000) 
knlGS:0000000000000000
[10287.638036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10287.638043] CR2: 0000000000000000 CR3: 000000028fd5a001 CR4: 
00000000001606e0
[10287.638050] Call Trace:
[10287.638112]  smb2_queryfs+0x15b/0x360 [cifs]
[10287.638130]  ? lookup_fast+0xc8/0x2f0
[10287.638138]  ? walk_component+0x48/0x2d0
[10287.638145]  ? legitimize_path.isra.9+0x2d/0x60
[10287.638151]  ? unlazy_walk+0x50/0xb0
[10287.638194]  ? cifs_statfs+0xb1/0x300 [cifs]
[10287.638243]  cifs_statfs+0xb1/0x300 [cifs]
[10287.638259]  statfs_by_dentry+0x4c/0x70
[10287.638268]  vfs_statfs+0x16/0xc0
[10287.638276]  user_statfs+0x54/0xa0
[10287.638285]  __se_sys_statfs+0x25/0x60
[10287.638300]  do_syscall_64+0x5b/0x170
[10287.638310]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
===

This is the SMB client having 2 mountpoints like this:

===
//1.2.3.4/share on /mnt/share type cifs 
(rw,nosuid,nodev,relatime,vers=3.0,cache=strict,username=guest,uid=1000,forceuid,gid=1000,forcegid,addr=1.2.3.4,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)
===

The printout repeats several times, and the call trace is consistent, 
although ATM I don't know what triggers it. Any ideas on this would be 
appreciated.

I'm going to try reproduce it locally on some VM reliably, but if it is 
something that is already known, or if there's some patch you'd like me 
to test, please let me know.

Thanks.

P.S. Please CC me if answering, I'm not subscribed to the CIFS list.

-- 
   Oleksandr Natalenko (post-factum)
