Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F0E208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeKPP5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:57:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37026 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeKPP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:57:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so10100027pge.4;
        Thu, 15 Nov 2018 21:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcCpK4fE82SvTimDYO0+SWB4Yz9p7NwID675NICkXZM=;
        b=lWFFptgsXU9bNSY4FTOyWsYnnNTTHPfC7eifDL3L/lA89D8leY1+udt5yfJw0+yAJ+
         oryxbkaJZFEFCmAM4UMZY1gjcVimywuLXDDWm9t/XCcqf9CsJON4QiXVfE/D4T0HcxCd
         PJZB+M02Q6Vc3FyYWSzd14Zsz3/1H8d0Gpv+ma8xMjKeN0VM8VzRIWaB/bPuGSG9q15V
         BguzF06YzUsMZYXN3PWD2Qd/X6bOBzYgvwrV1u18D8/YKsjtuDY3hoBROUD8T/C+pf7p
         v7UJCX502GdlflXcC72K2kr8lCDHa1cE2gK1CPK6+X92m9o4oksUhbVw1aa9/a2BJ/qu
         bJmg==
X-Gm-Message-State: AGRZ1gJt4/gbkgf4LxJU5HChm3uXmjpi5J9Ctkxjhwvx8Ymlue4T/fKd
        HLV2q9+AOiYU6ErRHEz5Oxc=
X-Google-Smtp-Source: AJdET5cSiiRP/JNXzWfw499Pb2ZVJ1Ru1c0AvSefXYrVxh66NORExxUO25be410PvuWMquxkdWM4ig==
X-Received: by 2002:a63:8441:: with SMTP id k62mr8661164pgd.392.1542347166593;
        Thu, 15 Nov 2018 21:46:06 -0800 (PST)
Received: from [192.168.40.151] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id y9-v6sm31434697pfe.152.2018.11.15.21.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 21:46:05 -0800 (PST)
Message-ID: <1542347164.100259.32.camel@acm.org>
Subject: Re: [PATCH 3/3] block: add back command filter modification via
 sysfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Thu, 15 Nov 2018 21:46:04 -0800
In-Reply-To: <1541867733-7836-4-git-send-email-pbonzini@redhat.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
         <1541867733-7836-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-10 at 17:35 +-0100, Paolo Bonzini wrote:
+AD4 +-sgio+AF8-read+AF8-filter (RW)
+AD4 +----------------------
+AD4 +-When read, this file will display a list of SCSI commands (i.e. values of
+AD4 +-the first byte of a CDB) that are always available for unprivileged users
+AD4 +-via /dev/bsg, /dev/sgNN, or ioctls such as SG+AF8-IO and CDROM+AF8-SEND+AF8-PACKET.
+AD4 +-When written, the list of commands will be modified.  The default filter
+AD4 +-can be restored by writing +ACI-default+ACI to the file+ADs otherwise the input should
+AD4 +-be a list of byte values or ranges such as +ACI-0x00-0xff+ACI.  In the latter case,
+AD4 +-instead of replacing the filter completely you can add to the commands,
+AD4 +-by writing a string that begins with '+-', or remove them by writing a
+AD4 +-string that begins with '-'.
+AD4 +-
+AD4 +-sgio+AF8-write+AF8-filter (RW)
+AD4 +-----------------------
+AD4 +-When read, this file will display a list of SCSI commands (i.e. values of
+AD4 +-the first byte of a CDB) that are available for unprivileged users
+AD4 +-when the block device is open for writing.  Writing to this file behaves
+AD4 +-as for sgio+AF8-read+AF8-filter.

This seems like an unfortunate API choice to me. Let's have a look at the
following SBC commands:
+ACo READ(6)+ADs  opcode 08h.
+ACo READ(10)+ADs opcode 28h.
+ACo READ(12)+ADs opcode A8h.
+ACo READ(16)+ADs opcode 88h.
+ACo READ(32)+ADs opcode 7fh+ADs service action 0009h.

I do not know any application for which it would be useful to allow some but
not all of these commands. With the proposed interface however users will
have to examine all SCSI opcodes and for each opcode they will have to decide
whether or not it should be allowed. Additionally, for opcodes like 7fh that
represent multiple commands, users will have to decide whether they want to
allow all these commands or none. That's why I think that filtering SCSI
commands based on their CDB is an unfortunate choice. Would it be sufficient
for the use cases you are looking at to group SCSI commands as follows and to
enable/disable these commands per group:
+ACo SCSI command that read information from the medium (e.g. READ) or from the
  controller (e.g. READ CAPACITY).
+ACo SCSI commands that modify information on the medium (e.g. WRITE).
+ACo SCSI commands that modify controller settings (e.g. MODE SELECT or SET
  TARGET PORT GROUPS).

Bart.
