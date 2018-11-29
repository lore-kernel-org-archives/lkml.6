Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F5BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A562147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV874xA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A562147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeK3Be4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbeK3Bez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0702147D;
        Thu, 29 Nov 2018 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501762;
        bh=bU6Vy8ucRqXrdSCg84k56V7d9j2G7NihYWmrdUQ0tI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HV874xA3WgDXEO64ObxM6znlnzJXdf9uDmf0KxhEWQm802lfMe5i2WyYBAVduSzgw
         Ytjz9AemyBE3KBiYIFjEHUFHZQyfwUk6OlkmLZl8Ri5419A6sqrzXHAoGg9I68J8SP
         40UAMHr3eeb2FGDTGEuqpbMC6RqiU+2HP2jk7KYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 031/110] selinux: Add __GFP_NOWARN to allocation at str_read()
Date:   Thu, 29 Nov 2018 15:12:02 +0100
Message-Id: <20181129135922.528897978@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

commit 4458bba09788e70e8fb39ad003f087cd9dfbd6ac upstream.

syzbot is hitting warning at str_read() [1] because len parameter can
become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
this case.

[1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/policydb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t f
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
-	str = kmalloc(len + 1, flags);
+	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
 


