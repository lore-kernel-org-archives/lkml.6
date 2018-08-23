Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C889208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C889208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbeHWM3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeHWM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:08 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D994ECC8;
        Thu, 23 Aug 2018 09:00:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 233/324] samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh
Date:   Thu, 23 Aug 2018 09:54:59 +0200
Message-Id: <20180823075007.790027887@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taeung Song <treeze.taeung@gmail.com>

[ Upstream commit b9626f45abccd044f8048269c67720f0719f2d4e ]

The below path error can occur:

  # ./xdp2skb_meta.sh --dev eth0 --list
  ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory

So just use command names instead of absolute paths of tc and ip.
In addition, it allow callers to redefine $TC and $IP paths

Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/bpf/xdp2skb_meta.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/samples/bpf/xdp2skb_meta.sh
+++ b/samples/bpf/xdp2skb_meta.sh
@@ -16,8 +16,8 @@
 BPF_FILE=xdp2skb_meta_kern.o
 DIR=$(dirname $0)
 
-export TC=/usr/sbin/tc
-export IP=/usr/sbin/ip
+[ -z "$TC" ] && TC=tc
+[ -z "$IP" ] && IP=ip
 
 function usage() {
     echo ""
@@ -53,7 +53,7 @@ function _call_cmd() {
     local allow_fail="$2"
     shift 2
     if [[ -n "$VERBOSE" ]]; then
-	echo "$(basename $cmd) $@"
+	echo "$cmd $@"
     fi
     if [[ -n "$DRYRUN" ]]; then
 	return


