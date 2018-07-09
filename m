Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F112C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F9220871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLi3bX8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F9220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeGIRvc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:51:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36381 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeGIRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:51:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so14177701pfh.3;
        Mon, 09 Jul 2018 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hW1IQUa9XOL1Qfkgap14X+CyFZl8YayNmPJPvKVxkdw=;
        b=bLi3bX8gREDCrKQeWj/HfuFSvxg/1ELQO1XLcfPvk3JWKwPRbZki+UuUFvBKziWM80
         H2Dl30hL6IlyFJN2EvYm4M6YeeBEQysoKWT3+BvgIS2/XaXwgfaJ7116QDtT1dtVqnk+
         J6Rc3xWV4F7FPGAtRwesEPvo85Uw4Rpz1GrdyikCDJO9SjN4EA0hFlQlX2lShCuYAlut
         aT9b4Ys9NZM7vJKxmCVb2Iyy8TjARpRJW075JjXMqUXbfSwRoEaapXqwnmvv2vwz+NHZ
         S9b+g85/cw1zckBAKj3mwl4eGBRMMVo3RFf0w+AAiHCiiyVGls/W7cpri9MMpP7CGCm9
         WvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hW1IQUa9XOL1Qfkgap14X+CyFZl8YayNmPJPvKVxkdw=;
        b=jssuYrERzSA1ec2hTuc3eKpR8iBQZgKqLzojJN5k7FojMfL/XFkf6Tch0oELjZx/mR
         i0JDHYFX1hhjQndIDCPYDBCSiVeW5RaV2loe2RYx2KjOiT7m2FfOmJHSfkDYUMd6STBn
         G5Psrts4VluLH0hxVh5nevFMBX8wbXiRd9uvP9lxw3L6ixTZ8oScQn/jQKd7VV5JxWSp
         KIn7eHQlBKXgQcuHnCcZm/oJza/SFgTfIRmSodMp1LQo2kcD8shy27WXLdW73niLmS6O
         AbBLC55PjHxlW80th57jwtNHYOLT0YzN7VCrhG3HE5c6TzIxikqMzeEPn5mfWyMugvL1
         s7Bw==
X-Gm-Message-State: APt69E2PA2MQjmvGhAv/9Vk7zedqx93eeuglxo9j/CMpngb+RepUle/m
        A7LcBT2kT9W3plEDpeRdkV0=
X-Google-Smtp-Source: AAOMgpcC5hOfTKTRhEa7T1X4yGtp5nm4erPkWjd3DCpCGUFpE4TVPzYwVvLsPT7V/McQ48RAJdRXLw==
X-Received: by 2002:a63:7f16:: with SMTP id a22-v6mr19720262pgd.255.1531158690393;
        Mon, 09 Jul 2018 10:51:30 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id y13-v6sm14926862pfi.131.2018.07.09.10.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:51:29 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2] samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh
Date:   Tue, 10 Jul 2018 02:51:21 +0900
Message-Id: <20180709175121.3355-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below path error can occur:

  # ./xdp2skb_meta.sh --dev eth0 --list
  ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory

So just use command names instead of absolute paths of tc and ip.
In addition, it allow callers to redefine $TC and $IP paths

Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/xdp2skb_meta.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
index b9c9549c4c27..4bde9d066c46 100755
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
-- 
2.17.1

