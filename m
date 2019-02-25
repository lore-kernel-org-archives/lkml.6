Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9519A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131285;
	bh=HjVQCPjYxTxjqKm5w11IuV6/WOxfpkg82YyJfB4UgiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XZmzHfJemteB8iAPBS1cxW7pNOE7mZWBUJrbeTfcmsUWgOUbs8TX6NmFc2/wY26OD
	 6dqRVIzJEeiu30wPD0ECvB/Xtdhn83TIIpcqwxNcorkIVX8X6TcIdnSnYsIW+HQvWn
	 Keiq5UWzju/NBDRt6Ov3Y9I7aHDZnxmpZh39G/Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfBYVsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfBYV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287DB20C01;
        Mon, 25 Feb 2019 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130023;
        bh=HjVQCPjYxTxjqKm5w11IuV6/WOxfpkg82YyJfB4UgiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDwjOfoMzZFM1eDNWvUgv8ez3cPSzZqC0sZ7OQ2wZnvri/OC6Q7oxjQQvJ8HP7KGc
         32d5/Io7/1Orp+ZQ+Nz5VciyX/9IQ37oC3bDzvrbCMTyRwKQ8ulM8ToA9q7I+Ri6ol
         hpW6XwDb6BF6yvrjyKvSoLXe6f4SA/nj7j7AIxmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 107/152] sctp: set stream ext to NULL after freeing it in sctp_stream_outq_migrate
Date:   Mon, 25 Feb 2019 22:11:39 +0100
Message-Id: <20190225195050.289398595@linuxfoundation.org>
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


