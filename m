Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D972C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37112089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37112089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeGIPkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:40:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932628AbeGIPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 814C0401EF05;
        Mon,  9 Jul 2018 15:40:34 +0000 (UTC)
Received: from localhost (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D21C97C3D;
        Mon,  9 Jul 2018 15:40:30 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:40:29 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH] samples/bpf: Fix tc and ip path in xdp2skb_meta.sh
Message-ID: <20180709174029.3c05e750@redhat.com>
In-Reply-To: <20180709150418.32034-1-treeze.taeung@gmail.com>
References: <20180709150418.32034-1-treeze.taeung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 09 Jul 2018 15:40:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 09 Jul 2018 15:40:34 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'brouer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 00:04:18 +0900
Taeung Song <treeze.taeung@gmail.com> wrote:

> The below path error can occur:
> 
>   # ./xdp2skb_meta.sh --dev eth0 --list
>   ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
> 
>   # which tc
>   /sbin/tc
> 
> So use 'which' command instead of absolute path of tc and ip
> 
> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  samples/bpf/xdp2skb_meta.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
> index b9c9549c4c27..67cf7b5f336d 100755
> --- a/samples/bpf/xdp2skb_meta.sh
> +++ b/samples/bpf/xdp2skb_meta.sh
> @@ -16,8 +16,8 @@
>  BPF_FILE=xdp2skb_meta_kern.o
>  DIR=$(dirname $0)
>  
> -export TC=/usr/sbin/tc
> -export IP=/usr/sbin/ip
> +export TC=`which tc`
> +export IP=`which ip`

This is not a good solution, as 'which' can return something else.
E.g. on my system I've aliased 'tc' to 'sudo tc', and `which tc` returns:

$ which tc
alias tc='sudo tc'
	/usr/bin/sudo

The easiest solution is to simply do:

 export TC=tc
 export IP=ip

The more fancy solution is to allow callers to redefine $IP and $TC:

[ -z "$TC" ] && TC=tc
[ -z "$IP" ] && IP=ip

And then you should also fix the use of 'basename', see below patch...
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

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

