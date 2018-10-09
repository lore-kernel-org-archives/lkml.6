Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3667C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56704214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtUB/58d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56704214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJITWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:22:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45201 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJITWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:22:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so701356pgd.12;
        Tue, 09 Oct 2018 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i4hFoDfOEmyea7w1gI9LOj+BjWZfDbB04SxDU9ssUeo=;
        b=KtUB/58dFr4Xu2tgRNyisrLvLyf/FvRVmo7KcaBRrvS7ISpts6J6A1baKNHTJuNjgR
         uUoCSrsoRAPyOfODRqRL3vasd0rraMJfmHuRiTCuvDwhmLnfTVfuBCtKoyXxwoXX0lQC
         cWat0N7adoJYp0cxnAVrc2irDtc0c0ONQ6qhCEpn6Yetzfs/ieMpmtgu+zxNe6xszu2E
         QD3zf72DFUuqtmLYmLN0iXhAgGW26ETEUEMcBtzAsuD1jJV0wv62dJ98ta6eHPF3AWs7
         1T3nPvrtuJr9eM+fTESdcBaNC5X9paGWTfk7p0gdF+jG2Z/V0dSKI86wcpYDxqa7kNsN
         BXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i4hFoDfOEmyea7w1gI9LOj+BjWZfDbB04SxDU9ssUeo=;
        b=HLB2qTeMWUAdi6fKWK1GPvUEGNHnsyXL+g7Z7tJl/w9RLikSIWmyx/OfsJaEE1wCoQ
         hjLLJrkpAVvChj2YqPbp1jWLsfgyn1FyKXoWolBZy03r6+hRLa8FI8VR/xc8QSnh1C8u
         tvMp4JQfn7prBck0xmnVrE5pAKJrtTsbL4EnogDWv8LnfJ1+9SebTGeBLmhNs00J5uE/
         f0HFqHYp17y9K8Juf1kDzslvi6eoLjsOe7vLGmiy1RSWer1bk8wI2cGN85kCfydWnsXH
         8zrDg/YNDXvGaAw0yPF1KKbylcck0qrHFMiYoJOs2ILAV5LABFeXUzX4ZtaWOBWQc7hD
         Tejg==
X-Gm-Message-State: ABuFfojfNlzYH0ZRZJTIflbTi6qEBlNBQigtwV+p/hnAJYybU8mHxUoz
        obgebPBaENaBG7UQ/QG6SB8=
X-Google-Smtp-Source: ACcGV60XNkXvslZoVvDPQHfZTi5Pe705aCpyyfCq7VYagjBh54XvngiJ5COGrrIlfySySCmojU+Y8w==
X-Received: by 2002:a63:cc:: with SMTP id 195-v6mr24911604pga.44.1539086744779;
        Tue, 09 Oct 2018 05:05:44 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m11-v6sm23517239pgn.39.2018.10.09.05.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 05:05:44 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 net-next] inet: remove redundant backlog setting in listen(2)
Date:   Tue,  9 Oct 2018 20:05:17 +0800
Message-Id: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sk_max_ack_backlog will be set in the caller inet_listen() and
dccp_listen_start(), so it is redundant to set it in
inet_csk_listen_start().
Just remove this setting.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dfd5009..cdd5c95 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -871,7 +871,6 @@ int inet_csk_listen_start(struct sock *sk, int backlog)
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
-	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	inet_csk_delack_init(sk);
 
-- 
1.8.3.1

