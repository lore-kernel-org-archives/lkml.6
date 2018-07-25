Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CF820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CF820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.bg
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeGYHEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:04:15 -0400
Received: from ja.ssi.bg ([178.16.129.10]:60856 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbeGYHEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:04:14 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id w6P5rhSV003122;
        Wed, 25 Jul 2018 08:53:43 +0300
Date:   Wed, 25 Jul 2018 08:53:43 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Tan Hu <tan.hu@zte.com.cn>
cc:     wensong@linux-vs.org, horms@verge.net.au, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        jiang.biao2@zte.com.cn
Subject: Re: [PATCH v2] ipvs: fix race between ip_vs_conn_new() and
 ip_vs_del_dest()
In-Reply-To: <1532486980-17844-1-git-send-email-tan.hu@zte.com.cn>
Message-ID: <alpine.LFD.2.20.1807250849100.2794@ja.home.ssi.bg>
References: <1532486980-17844-1-git-send-email-tan.hu@zte.com.cn>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 25 Jul 2018, Tan Hu wrote:

> We came across infinite loop in ipvs when using ipvs in docker
> env.
> 
> When ipvs receives new packets and cannot find an ipvs connection,
> it will create a new connection, then if the dest is unavailable
> (i.e. IP_VS_DEST_F_AVAILABLE), the packet will be dropped sliently.
> 
> But if the dropped packet is the first packet of this connection,
> the connection control timer never has a chance to start and the
> ipvs connection cannot be released. This will lead to memory leak, or
> infinite loop in cleanup_net() when net namespace is released like
> this:
> 
>     ip_vs_conn_net_cleanup at ffffffffa0a9f31a [ip_vs]
>     __ip_vs_cleanup at ffffffffa0a9f60a [ip_vs]
>     ops_exit_list at ffffffff81567a49
>     cleanup_net at ffffffff81568b40
>     process_one_work at ffffffff810a851b
>     worker_thread at ffffffff810a9356
>     kthread at ffffffff810b0b6f
>     ret_from_fork at ffffffff81697a18
> 
> race condition:
>     CPU1                           CPU2
>     ip_vs_in()
>       ip_vs_conn_new()
>                                    ip_vs_del_dest()
>                                      __ip_vs_unlink_dest()
>                                        ~IP_VS_DEST_F_AVAILABLE
>       cp->dest && !IP_VS_DEST_F_AVAILABLE
>       __ip_vs_conn_put
>     ...
>     cleanup_net  ---> infinite looping
> 
> Fix this by checking whether the timer already started.
> 
> Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
> v2: fix use-after-free in CONN_ONE_PACKET case suggested by Julian Anastasov
> 
>  net/netfilter/ipvs/ip_vs_core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index 0679dd1..a17104f 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -1972,13 +1972,20 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
>  	if (cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
>  		/* the destination server is not available */
>  
> -		if (sysctl_expire_nodest_conn(ipvs)) {
> +		__u32 flags = cp->flags; 

	Ops, now scripts/checkpatch.pl --strict /tmp/file.patch
is complaining about extra trailing space in above line.
You can also remove the empty line above the new code...

Regards

--
Julian Anastasov <ja@ssi.bg>
