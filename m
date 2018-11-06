Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A860C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346B92085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c16fS6gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346B92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbeKFX6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:58:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44111 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbeKFX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:58:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so5882289pgs.11;
        Tue, 06 Nov 2018 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AnFs2TkY5mLKqb7/FpVKODm3xN3gu/ye0hFME6VO/f8=;
        b=c16fS6ghjk4/Avx4KgDZbjrrMeCxqz6OEHWt51ewmP12PVkm6NAXE66CZmT9o7AKs9
         nS0XzCOGG1hUR0wFKkBrKWUFGh0OaX0lMIhWg6p1UWvx3G06gLMyOdKu2Zu5PXC6tkd5
         k84cw2v/S+CQ8Ue+PqqPcwKDvZROB4l+GkISFnb8i3Xr6zBIMg15cUJ49QQ3OP6ccYhp
         46A0DUbuN+5JLGRceGh8Vq3bkbYsZ17e3NDOEejxKjxCRWVDhwXAKMyoijnaeo/V8uqP
         81cDUu6ecx9h8dR8sTjfpaAibunQ5yOC4hZP6sePeyYxxXJ3XoNBJ/CatLuAgmNzvvRk
         EzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AnFs2TkY5mLKqb7/FpVKODm3xN3gu/ye0hFME6VO/f8=;
        b=VBOMDkEhiyrRpdm81W8AKwbE1MYYkr3AwmP8NRD3pxbvYgttYsneB1O5zrOs8DwjR8
         m83/hxh2RkSx2+4s/mtrXGl4QjyewNyG2YReJSFXFpJGLgoR6PrGvlJW3hyn4mdR3IZD
         Lz9IejJz8OJtvZIEX0PiUUhDYUEY4gv9Ugzqkz8e++UhxbasJstYl6iafvil0EUGTHB4
         f2xk9AywS9Y/BbnjBatbWKwOcZa8tPUJd0Na+O5o64z2OE4BXB086ALs3G7PFuRL9qjZ
         dx95amiHFvtTlcQNQMYizj7biMW7V3UXYj7Wq+WAyBFb85RkTle/kJ9Qs1ef/IpjVad4
         10nA==
X-Gm-Message-State: AGRZ1gLh/vaKlQezyas7IqMwsvZgC/p8ZSS/fKquCx0N2F8hirAf1tDh
        R0ozWB2xuV5Kc2VLzTsv2mY=
X-Google-Smtp-Source: AJdET5dIGsDrVgPUUkUWLT0P8UJsHbwU2DjD9IkSaN2XINzlgMLo6S8yRN0izWpbsLDL72RmztCNvw==
X-Received: by 2002:a62:2ec3:: with SMTP id u186-v6mr26392963pfu.189.1541514754774;
        Tue, 06 Nov 2018 06:32:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q134-v6sm10871312pfc.88.2018.11.06.06.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:32:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] apparmor: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:32:27 -0500
Message-Id: <20181106143227.8287-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 security/apparmor/apparmorfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index e09fe4d7307c..0e80ea4a3f6b 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -977,7 +977,7 @@ static const struct file_operations aa_sfs_access = {
 	.llseek		= generic_file_llseek,
 };
 
-static int aa_sfs_seq_show(struct seq_file *seq, void *v)
+static int aa_sfs_seq_file_show(struct seq_file *seq, void *v)
 {
 	struct aa_sfs_entry *fs_file = seq->private;
 
@@ -1002,18 +1002,7 @@ static int aa_sfs_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_sfs_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aa_sfs_seq_show, inode->i_private);
-}
-
-const struct file_operations aa_sfs_seq_file_ops = {
-	.owner		= THIS_MODULE,
-	.open		= aa_sfs_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(aa_sfs_seq_file);
 
 /*
  * profile based file operations
-- 
2.17.0

