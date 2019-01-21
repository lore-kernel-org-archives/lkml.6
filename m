Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7BC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464F21721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAIhZnp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAUSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:42:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfAUSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:42:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so10500385pfo.7;
        Mon, 21 Jan 2019 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tho6tTJTRW3eGHjW6h7SQd8J4U8YlHciARPw/Wk8/EQ=;
        b=IAIhZnp1ioya5yeXVnaly993vKDt902JVb3NTR5RLfQffQCkTfhJYGECNF4wLI0OZc
         P90Wbui8t5eYLLzvofZhzIw3rUZHsf86dVnUjwaLOxGTtbMa1nSvp4yt8DM04iClAG0L
         DlG9O1B22MI7Wfm8kQa2ylERaXann+KipUeP5m4WIGz+qnX3NEx52YyNhV/z1SB+O1jS
         ohl7XcHP4IEDTsPjAm2TJ15jDlEx3E0FWLS/+k1rydWgUps794KWguLvQa/dy21/ykAo
         NfqInkncxaHNIWJoHSpDnx17kkeF+15cTZ3EY2g6rnrw1m98HAlExKKVTqYUBrd1EIFE
         gqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tho6tTJTRW3eGHjW6h7SQd8J4U8YlHciARPw/Wk8/EQ=;
        b=QTjr2UNxm/kTz66cVW0xrcHuViFu0X79ZfnJ8ZyEDfPjFDitFi4sYDDnpj62aeeN3x
         Jsinahzdw13wY50DNC6HtJOaHAq2czc4mtVcTWQutuRspzTp81Fw2RdBAGonK2npnoLd
         P5Z+OqHkb+VyvksqaZSUh89HEg1RkmJoTjPZyFX9UqoXovX6vQba2qr04MPlXmk0oZ/F
         TsveS8/M5AxJPmWmQskOc2b5HJNmz08/pYKiOs0rCMonGe14BOkN1lV0ELJZUwpRXGa6
         giv/GuZsRDgdFtzZA9f+8eguq/1W0t/U+uPel65VMwsyZzKqnBYuo7c3F2uXGHVMACGv
         L8gQ==
X-Gm-Message-State: AJcUuke65uThwt1P0IB+2olFZm96hyjtzIoOU0ZdajRub8pjHCz/aU+u
        b6iU0vPoZEhXAH6xBjy7lxViG/Ex
X-Google-Smtp-Source: ALg8bN70AeU7Nb5zXcMFbI8AxXp6yB7Z7hKXao3yfNXP+0XMkcNUVmI0xZFvLmtGEu4y48UdcfPM3w==
X-Received: by 2002:a63:8441:: with SMTP id k62mr28995129pgd.392.1548096137151;
        Mon, 21 Jan 2019 10:42:17 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 184sm20686433pfe.106.2019.01.21.10.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:42:16 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: set chunk transport correctly when it's a new asoc
Date:   Tue, 22 Jan 2019 02:42:09 +0800
Message-Id: <d08f8708003363950333c0690960ce3d97897bd4.1548096129.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the paths:

  sctp_sf_do_unexpected_init() ->
    sctp_make_init_ack()
  sctp_sf_do_dupcook_a/b()() ->
    sctp_sf_do_5_1D_ce()

The new chunk 'retval' transport is set from the incoming chunk 'chunk'
transport. However, 'retval' transport belong to the new asoc, which
is a different one from 'chunk' transport's asoc.

It will cause that the 'retval' chunk gets set with a wrong transport.
Later when sending it and because of Commit b9fd683982c9 ("sctp: add
sctp_packet_singleton"), sctp_packet_singleton() will set some fields,
like vtag to 'retval' chunk from that wrong transport's asoc.

This patch is to fix it by setting 'retval' transport correctly which
belongs to the right asoc in sctp_make_init_ack() and
sctp_sf_do_5_1D_ce().

Fixes: b9fd683982c9 ("sctp: add sctp_packet_singleton")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index f4ac6c5..d05c576 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -495,7 +495,10 @@ struct sctp_chunk *sctp_make_init_ack(const struct sctp_association *asoc,
 	 *
 	 * [INIT ACK back to where the INIT came from.]
 	 */
-	retval->transport = chunk->transport;
+	if (chunk->transport)
+		retval->transport =
+			sctp_assoc_lookup_paddr(asoc,
+						&chunk->transport->ipaddr);
 
 	retval->subh.init_hdr =
 		sctp_addto_chunk(retval, sizeof(initack), &initack);
@@ -642,8 +645,10 @@ struct sctp_chunk *sctp_make_cookie_ack(const struct sctp_association *asoc,
 	 *
 	 * [COOKIE ACK back to where the COOKIE ECHO came from.]
 	 */
-	if (retval && chunk)
-		retval->transport = chunk->transport;
+	if (retval && chunk && chunk->transport)
+		retval->transport =
+			sctp_assoc_lookup_paddr(asoc,
+						&chunk->transport->ipaddr);
 
 	return retval;
 }
-- 
2.1.0

