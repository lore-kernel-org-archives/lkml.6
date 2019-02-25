Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59292184E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130478;
	bh=uOEQX978tudZFHHnTTUDKSbQmu9e8XqWdfpsvOsVgtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Htqky8hLdla1kvFsOtCCN0C/NC21gSQn6pEGYlGekRA2OUzMJ6k9LKDKPCh8IRHY
	 Rom5OEMdkOlbInqIwLhZRKTtvae64jFqiJdlawGRSNQz5hv0LlmBiYXTOpVqVsRcQF
	 FOdHrclHbPrqZUaxZVT6Aqt+S20oURinn3kEAq0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfBYVeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732842AbfBYVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD1620578;
        Mon, 25 Feb 2019 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130472;
        bh=uOEQX978tudZFHHnTTUDKSbQmu9e8XqWdfpsvOsVgtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYKnJKreM7GAZPRX0M+zooZZAnXUx8DtohivNyZx0ML+WYdXKZcUHAXOFrOUutnex
         jrIwga9ykoLYkES3O8OJ/G/QaEcJ0k2lU+jxf+cNgM9+nHORPrzikZKVZ2V//IeKuK
         OePGaHk+KcwOTjFrDqXMCqLOitVuDlE/vEao0mek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 131/183] sctp: set stream ext to NULL after freeing it in sctp_stream_outq_migrate
Date:   Mon, 25 Feb 2019 22:11:44 +0100
Message-Id: <20190225195116.902590879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit af98c5a78517c04adb5fd68bb64b1ad6fe3d473f ]

In sctp_stream_init(), after sctp_stream_outq_migrate() freed the
surplus streams' ext, but sctp_stream_alloc_out() returns -ENOMEM,
stream->outcnt will not be set to 'outcnt'.

With the bigger value on stream->outcnt, when closing the assoc and
freeing its streams, the ext of those surplus streams will be freed
again since those stream exts were not set to NULL after freeing in
sctp_stream_outq_migrate(). Then the invalid-free issue reported by
syzbot would be triggered.

We fix it by simply setting them to NULL after freeing.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -144,8 +144,10 @@ static void sctp_stream_outq_migrate(str
 		}
 	}
 
-	for (i = outcnt; i < stream->outcnt; i++)
+	for (i = outcnt; i < stream->outcnt; i++) {
 		kfree(SCTP_SO(stream, i)->ext);
+		SCTP_SO(stream, i)->ext = NULL;
+	}
 }
 
 static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,


