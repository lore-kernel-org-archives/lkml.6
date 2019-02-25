Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9573B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132046;
	bh=YODGbtDTufj6pmLjl6WuE3KMrp00pPS3VaI0ahSxZCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w30FLWuH0+waBUmJ2R5zjHkP6OvrEnzgbIVgSmOKi45C5tBib9i4BVjHEfVuYHEfu
	 y8B5UxSPBtgXuenrSG0HyMyMPkhgbu6A2x13GopLDIv49ypUiL8qA85vUPXoIK7xpx
	 S27L3ivo9uYxM25KPnOHKb57A+dSa6EbJnqb7pP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfBYWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbfBYVRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6BF2147C;
        Mon, 25 Feb 2019 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129461;
        bh=YODGbtDTufj6pmLjl6WuE3KMrp00pPS3VaI0ahSxZCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCDH5SoWOisHHU6Oe3qOqmjHsdpc7WMVH+d0d9bUYa31XDltyuzUizlDkDWyvHM1r
         i/kgtpwDebLgSPba52St4ZZURnVlbg3PZLjMOcFcw5Z5wwBujh2m4XLPZRR/F+hZIU
         DFHbXaNxE/cwKL4f5oIk7a0Xar7ZH/M71nVpavd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>
Subject: [PATCH 4.14 06/71] libceph: handle an empty authorize reply
Date:   Mon, 25 Feb 2019 22:11:08 +0100
Message-Id: <20190225195035.037891023@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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
@@ -2057,6 +2057,8 @@ static int process_connect(struct ceph_c
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
 	if (con->auth) {
+		int len = le32_to_cpu(con->in_reply.authorizer_len);
+
 		/*
 		 * Any connection that defines ->get_authorizer()
 		 * should also define ->add_authorizer_challenge() and
@@ -2066,8 +2068,7 @@ static int process_connect(struct ceph_c
 		 */
 		if (con->in_reply.tag == CEPH_MSGR_TAG_CHALLENGE_AUTHORIZER) {
 			ret = con->ops->add_authorizer_challenge(
-				    con, con->auth->authorizer_reply_buf,
-				    le32_to_cpu(con->in_reply.authorizer_len));
+				    con, con->auth->authorizer_reply_buf, len);
 			if (ret < 0)
 				return ret;
 
@@ -2077,10 +2078,12 @@ static int process_connect(struct ceph_c
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
 


