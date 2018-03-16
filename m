Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221829-2-9063253148647575703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221829; b=DCR99wHUHM2G1t3MAbbJbcTfmK07V+D0fsONS6EWVzzPUZ3
    TRUibaVE6kguhbofS0A8vTit2a1M/kQtwt9pbxuuOM7GagMJHG4puOTQaGZTEBdQ
    NQLPYj5Z2h+J6I6iPywgyRPJJIZgrEq8/hCcIz0SscWWVqlR1kqdKJTWXsL+GVBs
    pzkBQC0MjrZIyONgHbWmKOOrWOaVvHgs8CQrwiA6FRJALiocFeO+k3wVzIkVE6EV
    L//Wlo/EbgpwwbIvwjwg/bf/EJLyjrbmMHknstLdkHguxdTrr0LPx+Dkzj8QXFcS
    diaOez41k+doVa5A73kjQkkz8xK0hwCwNtBoaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221829; bh=J10LuI0Zuex1aXkw+NfALIuE+q
    8KWEyPRMe1q8mEuE8=; b=bQRFBbuxU8sqD1DXCfRBmjPfKQM041SgTtjSUkrUJF
    I4LidZui+saPEH6EC+kZMBYr+/tHzts1jQzJ77I8GHGhaduf2OUtsHY5gimIVkS4
    UIxQaXR24G82VlEmsiDx1FZ0W50GNwgC0xZzhpgFjWR2aGEGJzLwDm8ROVEBY2rN
    af6mL/6vd+Kk4BEeWgiJzTjFkfuOdnOMPqg8dqpLOgM/2HW02BvhZrQwS6GYGieW
    3DAr28UPuS4Ea26EIf+V5152XiNK4qAs918KQOxvNI7BFfSln4116om8FuXlhkV2
    Fc0tSKHo8IM5JjWwh4t6N0f4hofcXokwXT2B4FQxJEcQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeCPRhG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:37:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeCPP0d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 14/25] scripts: recordmcount: break hardlinks
Date: Fri, 16 Mar 2018 16:23:01 +0100
Message-Id: <20180316152233.338632338@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@arm.linux.org.uk>

commit dd39a26538e37f6c6131e829a4a510787e43c783 upstream.

recordmcount edits the file in-place, which can cause problems when
using ccache in hardlink mode.  Arrange for recordmcount to break a
hardlinked object.

Link: http://lkml.kernel.org/r/E1a7MVT-0000et-62@rmk-PC.arm.linux.org.uk

Cc: stable@vger.kernel.org # 2.6.37+
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/recordmcount.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -201,6 +201,20 @@ static void *mmap_file(char const *fname
 		addr = umalloc(sb.st_size);
 		uread(fd_map, addr, sb.st_size);
 	}
+	if (sb.st_nlink != 1) {
+		/* file is hard-linked, break the hard link */
+		close(fd_map);
+		if (unlink(fname) < 0) {
+			perror(fname);
+			fail_file();
+		}
+		fd_map = open(fname, O_RDWR | O_CREAT, sb.st_mode);
+		if (fd_map < 0) {
+			perror(fname);
+			fail_file();
+		}
+		uwrite(fd_map, addr, sb.st_size);
+	}
 	return addr;
 }
 
