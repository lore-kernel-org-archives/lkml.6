Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B352218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfAAMeI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 07:34:08 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:36274 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfAAMeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 07:34:07 -0500
Received: from mail.corsac.net (unknown [78.194.244.226])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id DC7802003BE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jan 2019 13:34:02 +0100 (CET)
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20:6af7:28ff:fe8d:2119])
        by mail.corsac.net (Postfix) with ESMTPS id 69B2A91
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jan 2019 13:34:00 +0100 (CET)
Received: from corsac (uid 1000)
        (envelope-from corsac@corsac.net)
        id a02d0
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Tue, 01 Jan 2019 13:34:00 +0100
Message-ID: <80e6c45b77a512047ec59314a00b3199f9ca86fd.camel@corsac.net>
Subject: Stall during read() on CIFS with 4.19
From:   Yves-Alexis Perez <corsac@corsac.net>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Alcantara <palcantara@suse.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Date:   Tue, 01 Jan 2019 13:33:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with the upgrade to 4.19 in Debian sid, I experienced a regression with CIFS
filesystems.

The server is running Debian stretch with samba, the clients are running
Debian sid or stretch. With 4.18 kernels everything is fine, but with 4.19
while the mount succeeds, any read() syscall on a file open()ed from a share
just stalls.

I've tried to bisect between 4.18 and 4.19 and here are the results:

# bad: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect start 'v4.19' 'v4.18'
# bad: [db06f826ec12bf0701ea7fc0a3c0aa00b84417c8] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad db06f826ec12bf0701ea7fc0a3c0aa00b84417c8
# bad: [0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
git bisect bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
# bad: [958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 958f338e96f874a0d29442396d6adf9c1e17aa2d
# good: [85a0b791bc17f7a49280b33e2905d109c062a47b] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good 85a0b791bc17f7a49280b33e2905d109c062a47b
# good: [a1a4f841ec4585185c0e75bfae43a18b282dd316] Merge tag 'for-4.19-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good a1a4f841ec4585185c0e75bfae43a18b282dd316
# good: [0e93d3f43ec7d3308bff25ce1be81d46330168c9] xfs: repair the AGFL
git bisect good 0e93d3f43ec7d3308bff25ce1be81d46330168c9
# bad: [10f3e23f07cb0c20f9bcb77a5b5a7eb2a1b2a2fe] Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect bad 10f3e23f07cb0c20f9bcb77a5b5a7eb2a1b2a2fe
# bad: [c1777df1a5d541cda918ff0450c8adcc8b69c2fd] cifs: add missing support for ACLs in SMB 3.11
git bisect bad c1777df1a5d541cda918ff0450c8adcc8b69c2fd
# good: [bf1fdeb7899a86adfbe0b521bee5cf78bb870a14] smb3: add reconnect tracepoints
git bisect good bf1fdeb7899a86adfbe0b521bee5cf78bb870a14
# good: [d258650004617fbd5dfe97d77d26fb37187d06e9] smb3: fix minor debug output for CONFIG_CIFS_STATS
git bisect good d258650004617fbd5dfe97d77d26fb37187d06e9
# good: [296ecbae7fdf209b1e0fb08b8bd82e5e9b637439] cifs: add SMB2_query_info_[init|free]()
git bisect good 296ecbae7fdf209b1e0fb08b8bd82e5e9b637439
# bad: [b24df3e30cbf48255db866720fb71f14bf9d2f39] cifs: update receive_encrypted_standard to handle compounded responses
git bisect bad b24df3e30cbf48255db866720fb71f14bf9d2f39
# bad: [1eb9fb52040fc6e5656c277b562229f09467c9f8] cifs: create SMB2_open_init()/SMB2_open_free() helpers.
git bisect bad 1eb9fb52040fc6e5656c277b562229f09467c9f8
# first bad commit: [1eb9fb52040fc6e5656c277b562229f09467c9f8] cifs: create SMB2_open_init()/SMB2_open_free() helpers.

I'm a bit surprised since I'd assume introducing helpers would not change
anything feature-wise, but I didn't dig into the code (I don't know a lot
about cifs). Unfortunately I can't easily revert 1eb9fb52040f on top of 4.19
so I prefer reporting it first.

If you need more information or want me to experiment something, feel free to
ask.

Regards,
-- 
Yves-Alexis
