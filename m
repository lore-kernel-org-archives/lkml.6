Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912BE2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131882;
	bh=hjyFFjCljD06yYijLFBjofgSAzFVZGZMliP5BF2T9S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJlpbCnmHnxBfXUUyjwFjqW+BtlorXKIVi9iKAO4Xw7fIR+JC9w54cPiYk50bttCf
	 FFty1OHLIf1oeRPvIQBcK9DDhsjVfyuBwPB6+pZBmbwnWoDQmN/Ik9C9+hPdBiXcGW
	 JitWqgIYeUzzOcAYVgiDhT3DGGqUSB0vgWShmzFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfBYV6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbfBYVUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9DB21841;
        Mon, 25 Feb 2019 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129654;
        bh=hjyFFjCljD06yYijLFBjofgSAzFVZGZMliP5BF2T9S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTcJY1Xblh4BOOEGMVJZee9uq7VeA8Gj+v6AJJfK/hVo1CpXFYA5EtckC+Rmu8aji
         8DnW8H6UBKPUG5MeQNX2nF68Ra7qLPOoOEma6hodAdiuWhxM3ii+iZ+c+GNTqxy0EV
         /xjTQW99BxYtOhb9cD4WQ+ScWsNXNdBcavT/8IrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>
Subject: [PATCH 4.19 009/152] libceph: handle an empty authorize reply
Date:   Mon, 25 Feb 2019 22:10:01 +0100
Message-Id: <20190225195044.295934965@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 0fd3fd0a9bb0b02b6435bb7070e9f7b82a23f068 upstream.

The authorize reply can be empty, for example when the ticket used to
build the authorizer is too old and TAG_BADAUTHORIZER is returned from
the service.  Calling ->verify_authorizer_reply() results in an attempt
to decrypt and validate (somewhat) random data in au->buf (most likely
the signature block from calc_signature()), which fails and ends up in
con_fault_finish() with !con->auth_retry.  The ticket isn't invalidated
and the connection is retried again and again until a new ticket is
obtained from the monitor:

  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply
  libceph: osd2 192.168.122.1:6809 bad authorize reply

Let TAG_BADAUTHORIZER handler kick in and increment con->auth_retry.

Cc: stable@vger.kernel.org
Fixes: 5c056fdc5b47 ("libceph: verify authorize reply on connect")
Link: https://tracker.ceph.com/issues/20164
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/messenger.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2091,6 +2091,8 @@ static int process_connect(struct ceph_c
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
 	if (con->auth) {
+		int len = le32_to_cpu(con->in_reply.authorizer_len);
+
 		/*
 		 * Any connection that defines ->get_authorizer()
 		 * should also define ->add_authorizer_challenge() and
@@ -2100,8 +2102,7 @@ static int process_connect(struct ceph_c
 		 */
 		if (con->in_reply.tag == CEPH_MSGR_TAG_CHALLENGE_AUTHORIZER) {
 			ret = con->ops->add_authorizer_challenge(
-				    con, con->auth->authorizer_reply_buf,
-				    le32_to_cpu(con->in_reply.authorizer_len));
+				    con, con->auth->authorizer_reply_buf, len);
 			if (ret < 0)
 				return ret;
 
@@ -2111,10 +2112,12 @@ static int process_connect(struct ceph_c
 			return 0;
 		}
 
-		ret = con->ops->verify_authorizer_reply(con);
-		if (ret < 0) {
-			con->error_msg = "bad authorize reply";
-			return ret;
+		if (len) {
+			ret = con->ops->verify_authorizer_reply(con);
+			if (ret < 0) {
+				con->error_msg = "bad authorize reply";
+				return ret;
+			}
 		}
 	}
 


