Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E61208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E61208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeGPKgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:36:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbeGPKgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A88CF402315B;
        Mon, 16 Jul 2018 10:09:23 +0000 (UTC)
Received: from epycfail (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8228C1C589;
        Mon, 16 Jul 2018 10:09:20 +0000 (UTC)
Date:   Mon, 16 Jul 2018 12:09:15 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Ursula Braun <ubraun@linux.ibm.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com,
        lifeasageek@gmail.com
Subject: Re: [PATCH net 1/4] net/smc: take sock lock in smc_ioctl()
Message-ID: <20180716120915.09d35dc0@epycfail>
In-Reply-To: <20180716100101.79272-1-ubraun@linux.ibm.com>
References: <20180716100101.79272-1-ubraun@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 10:09:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 10:09:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sbrivio@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 12:01:01 +0200
Ursula Braun <ubraun@linux.ibm.com> wrote:

> From: Ursula Braun <ursula.braun@linux.ibm.com>
> 
> SMC ioctl processing requires the sock lock to work properly in
> all thinkable scenarios.
> Problem has been found with RaceFuzzer and fixes:
>    KASAN: null-ptr-deref Read in smc_ioctl
> 
> Reported-by: Byoungyoung Lee <lifeasageek@gmail.com>
> Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  net/smc/af_smc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 5334157f5065..a4381b38a521 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1524,6 +1524,7 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
>  			return -EBADF;
>  		return smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
>  	}
> +	lock_sock(&smc->sk);
>  	switch (cmd) {
>  	case SIOCINQ: /* same as FIONREAD */
>  		if (smc->sk.sk_state == SMC_LISTEN)

                        return -EINVAL;

you should also unlock here, and:

        case SIOCOUTQ:
                /* output queue size (not send + not acked) */
                if (smc->sk.sk_state == SMC_LISTEN)
                        return -EINVAL;

here, and:

        case SIOCOUTQNSD:
                /* output queue size (not send only) */
                if (smc->sk.sk_state == SMC_LISTEN)
                        return -EINVAL;

here, and:

        case SIOCATMARK:
                if (smc->sk.sk_state == SMC_LISTEN)
                        return -EINVAL;

here.

-- 
Stefano
