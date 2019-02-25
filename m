Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC821850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130412;
	bh=a6z4D3lJOvollvnXBprlIdpC+R3x+q9IbwNb1bOQD+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TYkvyHdsOHJYwWvbqZhc9N1yNKXxLi0DQA12Z4mtv2cQojHjheF+ZmjkWb5gt5t4g
	 aUDK6hWFSmegZlIYqoPG8/CoiJyCoNedmrvq9N3+FYgkGCvV8t+PG4K06NK0Rnrw0K
	 rHFUeuuXQrSd6q9H3hjhSJ2TtD4MRxb1qAPUVLfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfBYVdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732392AbfBYVd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9958F2184D;
        Mon, 25 Feb 2019 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130407;
        bh=a6z4D3lJOvollvnXBprlIdpC+R3x+q9IbwNb1bOQD+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jROvST7E+bsGhyTQR4EFBgR9ITp/6IFEbcz02Wrpab+yAjTJIkNwkVeK2JFQKqymC
         CyamC2lXPtjSvOud9XV3/MON3sVMRW6DmEEvd3dURX2ZzmLEPFHUVImklBFG5n1yo0
         QS0NILCndSaOsufPHDQPVH22ZwFIM4LoRRF7b3HQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Peter Oskolkov <posk@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 112/183] bpf: bpf_setsockopt: reset sock dst on SO_MARK changes
Date:   Mon, 25 Feb 2019 22:11:25 +0100
Message-Id: <20190225195113.542965529@linuxfoundation.org>
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

[ Upstream commit f4924f24da8c7ef64195096817f3cde324091d97 ]

In sock_setsockopt() (net/core/sock.h), when SO_MARK option is used
to change sk_mark, sk_dst_reset(sk) is called. The same should be
done in bpf_setsockopt().

Fixes: 8c4b4c7e9ff0 ("bpf: Add setsockopt helper function to bpf")
Reported-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fa9452406f214..e176b335ddc09 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3948,7 +3948,10 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			sk->sk_rcvlowat = val ? : 1;
 			break;
 		case SO_MARK:
-			sk->sk_mark = val;
+			if (sk->sk_mark != val) {
+				sk->sk_mark = val;
+				sk_dst_reset(sk);
+			}
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.19.1



