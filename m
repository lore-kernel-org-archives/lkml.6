Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9195920872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPz20AKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9195920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbeKLIXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404025AbeKLIXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DED21780;
        Sun, 11 Nov 2018 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975584;
        bh=w0rh7rXrmXe34tb3XyDidYO/71hIPKuwaeDG9KwI9oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPz20AKK2yLh+7bJ6pMtPG6PbXKwvvpJIeafTqoN1RptvKmIDJxf78/uImelHRm76
         x/g4Ni3QWfhppUWFwErLz/f5ZFWlvC/CJxJKKHiHjXmm4maN1ctN1SYbBbVbReGFAR
         3GAocvl3G8GFdVx8F1Fdjn1my//vY33eWgUrHeI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 185/222] media: tvp5150: avoid going past array on v4l2_querymenu()
Date:   Sun, 11 Nov 2018 14:24:42 -0800
Message-Id: <20181111221703.549853153@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit 5c4c4505b716cb782ad7263091edc466c4d1fbd4 upstream.

The parameters of v4l2_ctrl_new_std_menu_items() are tricky: instead of
the number of possible values, it requires the number of the maximum
value. In other words, the ARRAY_SIZE() value should be decremented,
otherwise it will go past the array bounds, as warned by KASAN:

[  279.839688] BUG: KASAN: global-out-of-bounds in v4l2_querymenu+0x10d/0x180 [videodev]
[  279.839709] Read of size 8 at addr ffffffffc10a4cb0 by task v4l2-compliance/16676

[  279.839736] CPU: 1 PID: 16676 Comm: v4l2-compliance Not tainted 4.18.0-rc2+ #120
[  279.839741] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
[  279.839743] Call Trace:
[  279.839758]  dump_stack+0x71/0xab
[  279.839807]  ? v4l2_querymenu+0x10d/0x180 [videodev]
[  279.839817]  print_address_description+0x1c9/0x270
[  279.839863]  ? v4l2_querymenu+0x10d/0x180 [videodev]
[  279.839871]  kasan_report+0x237/0x360
[  279.839918]  v4l2_querymenu+0x10d/0x180 [videodev]
[  279.839964]  __video_do_ioctl+0x2c8/0x590 [videodev]
[  279.840011]  ? copy_overflow+0x20/0x20 [videodev]
[  279.840020]  ? avc_ss_reset+0xa0/0xa0
[  279.840028]  ? check_stack_object+0x21/0x60
[  279.840036]  ? __check_object_size+0xe7/0x240
[  279.840080]  video_usercopy+0xed/0x730 [videodev]
[  279.840123]  ? copy_overflow+0x20/0x20 [videodev]
[  279.840167]  ? v4l_enumstd+0x40/0x40 [videodev]
[  279.840177]  ? __handle_mm_fault+0x9f9/0x1ba0
[  279.840186]  ? __pmd_alloc+0x2c0/0x2c0
[  279.840193]  ? __vfs_write+0xb6/0x350
[  279.840200]  ? kernel_read+0xa0/0xa0
[  279.840244]  ? video_usercopy+0x730/0x730 [videodev]
[  279.840284]  v4l2_ioctl+0xa1/0xb0 [videodev]
[  279.840295]  do_vfs_ioctl+0x117/0x8a0
[  279.840303]  ? selinux_file_ioctl+0x211/0x2f0
[  279.840313]  ? ioctl_preallocate+0x120/0x120
[  279.840319]  ? selinux_capable+0x20/0x20
[  279.840332]  ksys_ioctl+0x70/0x80
[  279.840342]  __x64_sys_ioctl+0x3d/0x50
[  279.840351]  do_syscall_64+0x6d/0x1c0
[  279.840361]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  279.840367] RIP: 0033:0x7fdfb46275d7
[  279.840369] Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 f7 d8 64 89 01 48
[  279.840474] RSP: 002b:00007ffee1179038 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  279.840483] RAX: ffffffffffffffda RBX: 00007ffee1179180 RCX: 00007fdfb46275d7
[  279.840488] RDX: 00007ffee11790c0 RSI: 00000000c02c5625 RDI: 0000000000000003
[  279.840493] RBP: 0000000000000002 R08: 0000000000000020 R09: 00000000009f0902
[  279.840497] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffee117a5a0
[  279.840501] R13: 00007ffee11790c0 R14: 0000000000000002 R15: 0000000000000000

[  279.840515] The buggy address belongs to the variable:
[  279.840535]  tvp5150_test_patterns+0x10/0xffffffffffffe360 [tvp5150]

Fixes: c43875f66140 ("[media] tvp5150: replace MEDIA_ENT_F_CONN_TEST by a control")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tvp5150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -1530,7 +1530,7 @@ static int tvp5150_probe(struct i2c_clie
 			27000000, 1, 27000000);
 	v4l2_ctrl_new_std_menu_items(&core->hdl, &tvp5150_ctrl_ops,
 				     V4L2_CID_TEST_PATTERN,
-				     ARRAY_SIZE(tvp5150_test_patterns),
+				     ARRAY_SIZE(tvp5150_test_patterns) - 1,
 				     0, 0, tvp5150_test_patterns);
 	sd->ctrl_handler = &core->hdl;
 	if (core->hdl.error) {


