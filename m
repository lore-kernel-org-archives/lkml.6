Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3918FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AD320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwJZbRdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AD320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeJXASv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:18:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44560 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJXASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:18:50 -0400
Received: by mail-yw1-f67.google.com with SMTP id t78-v6so741778ywg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eB44pFr93Pg/BsnzblNKoRKhLz1bfoUZZ5SPqh/m12s=;
        b=QwJZbRdR9bEh8yUjlDOXsWj/oCjJDeC5Dd1XGDYj6M2GCT/qTHijhzZhagVyyz3mO/
         oa1Qscx3hs3MGKIVRpijilaUC817YKrdfvnfZvl1AzIa7BRLtzqkss5rJbmvyZhSlyaA
         bvGkdQ9KQP8DSEzMwQL0QkZAjX4ch6ngV9vfKEJFadMLeYVNlhWZH4e0qAPzaJi5RZ+x
         WoLML92dizYWxvX6tIHc5e2tEQOekkq6Xwgl6yaQpvoy2+j+92LDStDJljHQS6h1Qu41
         sdxxH6OvSXPKUL4rKfZrXFu/JwTgIrNSV0rKk7O9mad5lS3c8gMs9aHpMeX4ULxNKipF
         JohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eB44pFr93Pg/BsnzblNKoRKhLz1bfoUZZ5SPqh/m12s=;
        b=lWCTIkugYl6U8+RfkRLC1K2+k56qjucWkNdITsUTYSI/9PX21ShekcvGWedhQA3txa
         TmDrX53c0k4vVHn1oNAIGD9lMJKX4SJAl/jc76kPJO5uvj23nroeKXcpMVvtKbX/wue1
         4CelgSdcI5kZeaYgUspIIZkeitS9qJ4gby2AJZ8w0rkYBSYyUDSGAna8Yv00dfSOgUd6
         OsMy/YySSKXawGAtlv0eGe2OPkvhOBdUFm86awWuFf3iLlMHmJOWnUYUwJpfrSBFMva9
         8gPrKBepP70D9m6khiKiWtPM0gPaqMek58ql6Q5hiDGan+UZSo1UIxTq0n6HVGewXJNz
         dxBQ==
X-Gm-Message-State: ABuFfohxpseZPxYzuJ6WyDhgwpmivD5yR70eQbtOY1MbWZYjGKC8llaq
        GPxyuDGQexznrQy/huhowDMaLmadu2luuckMmgDCDQ==
X-Google-Smtp-Source: ACcGV633nveGvBue5ndrH1xMxjgchEquYhum1iZga0IGMHQjJRDp4b7h/2HDG+IFTPGQ6k7pfI7Rw3yhpnMuPOq7Ie0=
X-Received: by 2002:a0d:c4c5:: with SMTP id g188-v6mr36859661ywd.355.1540310091528;
 Tue, 23 Oct 2018 08:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5094:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 08:54:31
 -0700 (PDT)
In-Reply-To: <20181023152924.24033-1-mk.singh@oracle.com>
References: <20181023152924.24033-1-mk.singh@oracle.com>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Tue, 23 Oct 2018 08:54:31 -0700
Message-ID: <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
Subject: Re: [PATCH] bonding:avoid repeated display of same link status change
To:     mk.singh@oracle.com
Cc:     linux-netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 8:29 AM,  <mk.singh@oracle.com> wrote:
> From: Manish Kumar Singh <mk.singh@oracle.com>
>
> When link status change needs to be committed and rtnl lock couldn't be
> taken, avoid redisplay of same link status change message.
>
> Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 ++++--
>  include/net/bonding.h           | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 2b01180be834..af9ef889a429 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2096,7 +2096,7 @@ static int bond_miimon_inspect(struct bonding *bond)
>                         bond_propose_link_state(slave, BOND_LINK_FAIL);
>                         commit++;
>                         slave->delay = bond->params.downdelay;
> -                       if (slave->delay) {
> +                       if (slave->delay && !atomic_read(&bond->rtnl_needed)) {
Atomic operations are expensive (on certain architectures) and miimon
runs quite frequently. Is the added cost of these atomic operations
even worth just to avoid *duplicate info* messages? This seems like a
overkill!

>                                 netdev_info(bond->dev, "link status down for %sinterface %s, disabling it in %d ms\n",
>                                             (BOND_MODE(bond) ==
>                                              BOND_MODE_ACTIVEBACKUP) ?
> @@ -2136,7 +2136,7 @@ static int bond_miimon_inspect(struct bonding *bond)
>                         commit++;
>                         slave->delay = bond->params.updelay;
>
> -                       if (slave->delay) {
> +                       if (slave->delay && !atomic_read(&bond->rtnl_needed)) {
>                                 netdev_info(bond->dev, "link status up for interface %s, enabling it in %d ms\n",
>                                             slave->dev->name,
>                                             ignore_updelay ? 0 :
> @@ -2310,9 +2310,11 @@ static void bond_mii_monitor(struct work_struct *work)
>                 if (!rtnl_trylock()) {
>                         delay = 1;
>                         should_notify_peers = false;
> +                       atomic_set(&bond->rtnl_needed, 1);
>                         goto re_arm;
>                 }
>
> +               atomic_set(&bond->rtnl_needed, 0);
>                 bond_for_each_slave(bond, slave, iter) {
>                         bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
>                 }
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index a4f116f06c50..a4353506bb4f 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -229,6 +229,7 @@ struct bonding {
>         struct   dentry *debug_dir;
>  #endif /* CONFIG_DEBUG_FS */
>         struct rtnl_link_stats64 bond_stats;
> +       atomic_t rtnl_needed;
>  };
>
>  #define bond_slave_get_rcu(dev) \
> --
> 2.14.1
>
