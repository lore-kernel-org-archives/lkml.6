Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803824-2-10162863458061718856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803823; b=WfMiUmUCWYK9yNYF+Iucbt7KwRhNspHZDagGU9aLxKzn0KY
    XNWcPhp8fg1sLhM1wRhVBWU4r8ZhXkPTUWiVmLAOZgH3L6XQ5JMjsVA3EkeZCADg
    GDm5g/PkcijdlPA+apQD9SPm0Zk9kPBqPAbBR7kO/UYMJsTcK5NCg9fWr6qUC98a
    ai46pm38QHy+7LQ9TtV+unBBJeD+xNpB/PVcdxR53vdsE9aKlSKbWdW1S8kvysll
    5TmjbEbSRZdwkhpiB9KD8VbqwaYJyHlfZknUo6dAcQ6M2kCk5eyiGMxAMIziN95p
    Bo8powWCV7fxjbRW0Nf+WWxaKnMpvHJP4EY57bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803823; bh=mU2SE8eC6bBvKT1gXQEiEVOGYn
    0v/1lJ1fqjq1Y+V0Q=; b=ZAPpTlQz/WDLAeuS6MsyHPhALPr0xkLfU2Dadx4R4W
    gPZBXF1uwyynJV7IZhJT+st2GFM5r28Kmjzr3dsCnydRhIiXRzGRLktTYcIqN9Ul
    eYa6Oll4Dw/52npXquTVFd1Q3aWglG52N4Hnjqyp2K8Fl4+j9C+CYqecCD1S2wII
    PXaYp18sCcfwfZVoRrTXpG/zTMWCeD/t7YyZQhA6iaFWllyPU6VDUbhWlXIq4zBR
    K3XrRE0Wafoys4xkdD/vY3G2uVH4XJInJk3aHa1fJBWyoePzRldqNh3iyi5ebZ7P
    TUbBdvT00adTYnbhhYFlJbLVx0wreKgIdeCWMhXN0XPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeCWKJg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeCWKJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 119/177] tcm_fileio: Prevent information leak for short reads
Date: Fri, 23 Mar 2018 10:54:07 +0100
Message-Id: <20180323094210.510511343@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Monakhov <dmonakhov@openvz.org>


[ Upstream commit f11b55d13563e9428c88c873f4f03a6bef11ec0a ]

If we failed to read data from backing file (probably because some one
truncate file under us), we must zerofill cmd's data, otherwise it will
be returned as is. Most likely cmd's data are unitialized pages from
page cache. This result in information leak.

(Change BUG_ON into -EINVAL se_cmd failure - nab)

testcase: https://github.com/dmonakhov/xfstests/commit/e11a1b7b907ca67b1be51a1594025600767366d5
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_file.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -276,12 +276,11 @@ static int fd_do_rw(struct se_cmd *cmd,
 	else
 		ret = vfs_iter_read(fd, &iter, &pos);
 
-	kfree(bvec);
-
 	if (is_write) {
 		if (ret < 0 || ret != data_length) {
 			pr_err("%s() write returned %d\n", __func__, ret);
-			return (ret < 0 ? ret : -EINVAL);
+			if (ret >= 0)
+				ret = -EINVAL;
 		}
 	} else {
 		/*
@@ -294,17 +293,29 @@ static int fd_do_rw(struct se_cmd *cmd,
 				pr_err("%s() returned %d, expecting %u for "
 						"S_ISBLK\n", __func__, ret,
 						data_length);
-				return (ret < 0 ? ret : -EINVAL);
+				if (ret >= 0)
+					ret = -EINVAL;
 			}
 		} else {
 			if (ret < 0) {
 				pr_err("%s() returned %d for non S_ISBLK\n",
 						__func__, ret);
-				return ret;
+			} else if (ret != data_length) {
+				/*
+				 * Short read case:
+				 * Probably some one truncate file under us.
+				 * We must explicitly zero sg-pages to prevent
+				 * expose uninizialized pages to userspace.
+				 */
+				if (ret < data_length)
+					ret += iov_iter_zero(data_length - ret, &iter);
+				else
+					ret = -EINVAL;
 			}
 		}
 	}
-	return 1;
+	kfree(bvec);
+	return ret;
 }
 
 static sense_reason_t
