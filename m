Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C883C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F3820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F3820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeIMTEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbeIMTEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01299D1D;
        Thu, 13 Sep 2018 13:54:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 068/197] samples/bpf: all XDP samples should unload xdp/bpf prog on SIGTERM
Date:   Thu, 13 Sep 2018 15:30:17 +0200
Message-Id: <20180913131844.238179718@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 817b89beb9d8876450fcde9155e17425c329569d ]

It is common XDP practice to unload/deattach the XDP bpf program,
when the XDP sample program is Ctrl-C interrupted (SIGINT) or
killed (SIGTERM).

The samples/bpf programs xdp_redirect_cpu and xdp_rxq_info,
forgot to trap signal SIGTERM (which is the default signal used
by the kill command).

This was discovered by Red Hat QA, which automated scripts depend
on killing the XDP sample program after a timeout period.

Fixes: fad3917e361b ("samples/bpf: add cpumap sample program xdp_redirect_cpu")
Fixes: 0fca931a6f21 ("samples/bpf: program demonstrating access to xdp_rxq_info")
Reported-by: Jean-Tsung Hsiao <jhsiao@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/bpf/xdp_redirect_cpu_user.c |    3 ++-
 samples/bpf/xdp_rxq_info_user.c     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -679,8 +679,9 @@ int main(int argc, char **argv)
 		return EXIT_FAIL_OPTION;
 	}
 
-	/* Remove XDP program when program is interrupted */
+	/* Remove XDP program when program is interrupted or killed */
 	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
 
 	if (bpf_set_link_xdp_fd(ifindex, prog_fd[prog_num], xdp_flags) < 0) {
 		fprintf(stderr, "link set xdp fd failed\n");
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -534,8 +534,9 @@ int main(int argc, char **argv)
 		exit(EXIT_FAIL_BPF);
 	}
 
-	/* Remove XDP program when program is interrupted */
+	/* Remove XDP program when program is interrupted or killed */
 	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
 
 	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
 		fprintf(stderr, "link set xdp fd failed\n");


