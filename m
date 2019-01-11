Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2BCC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1F921848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217236;
	bh=416zZtHYGukca7T4nFe1QEB9qtjTwUS1f7LoF1HlOJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQp/C4iaZljB33yKtOv9AvaZKJEWgvfdF6j80eWV+m2oEDaS6fTo3ymXOpxd1lTdG
	 FiIfwK3pmAOYuSvqzBKH8tCkzBHvcl2/E/jXprh8l+vi253hyge2jhfCNO9/oNIOsV
	 yQCjHG7PhYuE4yEnTdUix63GhUiDY9DBMRK+CkMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfAKOdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389739AbfAKOdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E782063F;
        Fri, 11 Jan 2019 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217232;
        bh=416zZtHYGukca7T4nFe1QEB9qtjTwUS1f7LoF1HlOJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9SNltnDUk+Wxn3AEu+eI/C+Ez6MN4uOeGZ8pi3k3JaTv7u9iL9SLIGvCPO6K37ni
         CUPWQQPGgP7mNemgxB5N1+LIW97YqTFCaOj2v93OCiy0UPB0ftFbp95yFYDysClC4o
         YPfvHUh+ARsxKKWwV47ToDSqAiSKgf9ntshy0I4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 091/105] selinux: policydb - fix byte order and alignment issues
Date:   Fri, 11 Jan 2019 15:15:02 +0100
Message-Id: <20190111131110.555207234@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit 5df275cd4cf51c86d49009f1397132f284ba515e upstream.

Do the LE conversions before doing the Infiniband-related range checks.
The incorrect checks are otherwise causing a failure to load any policy
with an ibendportcon rule on BE systems. This can be reproduced by
running (on e.g. ppc64):

cat >my_module.cil <<EOF
(type test_ibendport_t)
(roletype object_r test_ibendport_t)
(ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
EOF
semodule -i my_module.cil

Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
use a correctly aligned buffer.

Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
should be used instead.

Tested internally on a ppc64 machine with a RHEL 7 kernel with this
patch applied.

Cc: Daniel Jurgens <danielj@mellanox.com>
Cc: Eli Cohen <eli@mellanox.com>
Cc: James Morris <jmorris@namei.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: <stable@vger.kernel.org> # 4.13+
Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/policydb.c |   51 ++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2107,6 +2107,7 @@ static int ocontext_read(struct policydb
 {
 	int i, j, rc;
 	u32 nel, len;
+	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
 	u32 nodebuf[8];
@@ -2216,21 +2217,30 @@ static int ocontext_read(struct policydb
 					goto out;
 				break;
 			}
-			case OCON_IBPKEY:
-				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
+			case OCON_IBPKEY: {
+				u32 pkey_lo, pkey_hi;
+
+				rc = next_entry(prefixbuf, fp, sizeof(u64));
+				if (rc)
+					goto out;
+
+				/* we need to have subnet_prefix in CPU order */
+				c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
+
+				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
 					goto out;
 
-				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
+				pkey_lo = le32_to_cpu(buf[0]);
+				pkey_hi = le32_to_cpu(buf[1]);
 
-				if (nodebuf[2] > 0xffff ||
-				    nodebuf[3] > 0xffff) {
+				if (pkey_lo > U16_MAX || pkey_hi > U16_MAX) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
-				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
+				c->u.ibpkey.low_pkey  = pkey_lo;
+				c->u.ibpkey.high_pkey = pkey_hi;
 
 				rc = context_read_and_validate(&c->context[0],
 							       p,
@@ -2238,7 +2248,10 @@ static int ocontext_read(struct policydb
 				if (rc)
 					goto out;
 				break;
-			case OCON_IBENDPORT:
+			}
+			case OCON_IBENDPORT: {
+				u32 port;
+
 				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
 					goto out;
@@ -2248,12 +2261,13 @@ static int ocontext_read(struct policydb
 				if (rc)
 					goto out;
 
-				if (buf[1] > 0xff || buf[1] == 0) {
+				port = le32_to_cpu(buf[1]);
+				if (port > U8_MAX || port == 0) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibendport.port = le32_to_cpu(buf[1]);
+				c->u.ibendport.port = port;
 
 				rc = context_read_and_validate(&c->context[0],
 							       p,
@@ -2261,7 +2275,8 @@ static int ocontext_read(struct policydb
 				if (rc)
 					goto out;
 				break;
-			}
+			} /* end case */
+			} /* end switch */
 		}
 	}
 	rc = 0;
@@ -3104,6 +3119,7 @@ static int ocontext_write(struct policyd
 {
 	unsigned int i, j, rc;
 	size_t nel, len;
+	__be64 prefixbuf[1];
 	__le32 buf[3];
 	u32 nodebuf[8];
 	struct ocontext *c;
@@ -3191,12 +3207,17 @@ static int ocontext_write(struct policyd
 					return rc;
 				break;
 			case OCON_IBPKEY:
-				*((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
+				/* subnet_prefix is in CPU order */
+				prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
 
-				nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
-				nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
+				rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
+				if (rc)
+					return rc;
+
+				buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
+				buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
 
-				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
+				rc = put_entry(buf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
 				rc = context_write(p, &c->context[0], fp);


