Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957A21A05
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4oF3fBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A957A21A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHQUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:34:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeHQUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:34:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so8273036wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MaDjePSzOpJK3+vfEgQUvXMoh7tAGftFZ2lOW91TTSg=;
        b=E4oF3fBLknKx4dbvA1JoV7+4Xk0aSx6pCHljOpjuCQQZdmpUXXRAOmHkBxClMHVBDH
         dLzT4PrG07VTqV8iV8MiCU5S/NjX/Edrj93TaCEzi2n/0h1/JWveSoHgenA9QspfhYzT
         oqHPw5eAWWr98G7p5ROFkqdD5qPCxC0aPsFKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MaDjePSzOpJK3+vfEgQUvXMoh7tAGftFZ2lOW91TTSg=;
        b=Uk9pEw0uExNXwOzL8vXo3bJ0ftwPfLzNIuiHbjTRFhVfqgJnFVmoI3O5aoMMqT3dLB
         N55ZQrrabdu36nzn8qd+OGaKka7tc7lA/nG4V5CY+RbKowWbgFSGMyKSZh+/tAFXk284
         uQuMLATOG1tQhfn9wLm9CYtUREnU1pR9HxnVBToNYEMPXyjKk9oa0MMHnLjlnVGCE1hw
         zE0+mIy0hTOQG8r2Zdy9IkV+m7QV5DhtMemc0Eqn7byhtoh+geKW0TIEhG6TSJr83sTs
         erDnanrSKi9A9vstwk3j0ejqDq0CoAInNpZirR5NHQTVuH/UUONZrgbSEfWrYZ0s5kLE
         qEbA==
X-Gm-Message-State: AOUpUlHn0A14l7LoZJRxPhejhLgcX1OXu8/UDj9/bkY3ofak+xZuCmdJ
        l1wBNlNMCt67UNd+pD8NU+vd3A==
X-Google-Smtp-Source: AA+uWPz1+rXsZrkrNXI6fGjrNluSngP+zx+5wYbPJQ6/fabAt1hBWkSLTHhMilUiZw1IuGOnsziYcA==
X-Received: by 2002:a1c:64d5:: with SMTP id y204-v6mr19009686wmb.14.1534527013981;
        Fri, 17 Aug 2018 10:30:13 -0700 (PDT)
Received: from [192.168.0.100] (146-241-23-108.dyn.eolo.it. [146.241.23.108])
        by smtp.gmail.com with ESMTPSA id d12-v6sm4538594wru.36.2018.08.17.10.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:30:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] cfq: clear queue pointers from cfqg after unpinning them
 in cfq_pd_offline
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ba086112-65b1-c20f-0694-35d1ca0415d9@maciej.szmigiero.name>
Date:   Fri, 17 Aug 2018 19:30:11 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, jiufei.xue@linux.alibaba.com,
        Caspar Zhang <caspar@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FF39F18-108B-43BD-85A2-A09DB7755865@linaro.org>
References: <ba086112-65b1-c20f-0694-35d1ca0415d9@maciej.szmigiero.name>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 17 ago 2018, alle ore 19:28, Maciej S. Szmigiero =
<mail@maciej.szmigiero.name> ha scritto:
>=20
> The current linux-block, 4.18 and 4.17 can reliably be crashed within =
few
> minutes by running the following bash snippet:
>=20
> mkfs.ext4 -v /dev/sda3 && mount /dev/sda3 /mnt/test/ -t ext4;
> while true; do
> 	mkdir /sys/fs/cgroup/unified/test/;
> 	echo $$ >/sys/fs/cgroup/unified/test/cgroup.procs;
> 	dd if=3D/dev/zero of=3D/mnt/test/test-$(( RANDOM * 10 / 32768 )) =
bs=3D1M count=3D1024 &
> 	echo $$ >/sys/fs/cgroup/unified/cgroup.procs;
> 	sleep 1;
> 	kill -KILL $!; wait $!;
> 	rmdir /sys/fs/cgroup/unified/test;
> done
>=20
> # cat /sys/block/sda/queue/scheduler
> noop [cfq]
> # cat /sys/block/sda/queue/rotational
> 1
> # cat /sys/fs/cgroup/unified/cgroup.subtree_control
> cpu io memory pids
>=20
> The backtraces vary but often they are NULL pointer dereferences due =
to
> various cfqq fields being NULL.
> Or BUG_ON(cfqq->ref <=3D 0) in cfq_put_queue() triggers due to cfqq =
reference
> count being zero.
>=20
> Bisection points at
> commit 4c6994806f70 ("blk-throttle: fix race between =
blkcg_bio_issue_check() and cgroup_rmdir()").
> The prime suspect looked like .pd_offline_fn() method being called =
multiple
> times, but from analyzing the mentioned commit this didn't seem =
possible
> and runtime trials have confirmed that.
>=20
> However, CFQ's cfq_pd_offline() implementation of the above method =
were
> leaving queue pointers intact in cfqg after unpinning them.
> After making sure that they are cleared to NULL in this function I can =
no
> longer reproduce the crash.
>=20

By chance, did you check whether is BFQ is ok in this respect?

Thanks,
Paolo

> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Fixes: 4c6994806f70 ("blk-throttle: fix race between =
blkcg_bio_issue_check() and cgroup_rmdir()").
> Cc: stable@vger.kernel.org
> ---
> block/cfq-iosched.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 2eb87444b157..ed41aa978c4a 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1644,14 +1644,20 @@ static void cfq_pd_offline(struct =
blkg_policy_data *pd)
> 	int i;
>=20
> 	for (i =3D 0; i < IOPRIO_BE_NR; i++) {
> -		if (cfqg->async_cfqq[0][i])
> +		if (cfqg->async_cfqq[0][i]) {
> 			cfq_put_queue(cfqg->async_cfqq[0][i]);
> -		if (cfqg->async_cfqq[1][i])
> +			cfqg->async_cfqq[0][i] =3D NULL;
> +		}
> +		if (cfqg->async_cfqq[1][i]) {
> 			cfq_put_queue(cfqg->async_cfqq[1][i]);
> +			cfqg->async_cfqq[1][i] =3D NULL;
> +		}
> 	}
>=20
> -	if (cfqg->async_idle_cfqq)
> +	if (cfqg->async_idle_cfqq) {
> 		cfq_put_queue(cfqg->async_idle_cfqq);
> +		cfqg->async_idle_cfqq =3D NULL;
> +	}
>=20
> 	/*
> 	 * @blkg is going offline and will be ignored by

