Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D390C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F86421738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIkprkLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAJAsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:48:36 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37101 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfAJAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:48:35 -0500
Received: by mail-lf1-f41.google.com with SMTP id y11so7065918lfj.4;
        Wed, 09 Jan 2019 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mflB1soHoVBBXWMcJ8FoEowlzUk5Hn/TsWZzOjsw/w4=;
        b=UIkprkLkRZho9Ne8FWKdK3jnZ2NFs/ut2cQROiFRZkiJoNgr63AMovmJvH/NOJpZli
         fuPQ5dymmvQ49giJzncQtT42HS+zDSMyuFVB/SAddHuo4mDkVDwje4bmGd0Kvkh9nXPW
         +H2MzYzg7M3Jiee1fsV0dOJWFusAWpF1jwmD+BRcmw0hxyqtcJNprzZcBpO99d3U6XXk
         2hOIZMWN+YY2a+qzf1vhhMnS2MfgLb+NuT9C4JROKiEUZTXC00+mKndxIwLNAei11qqJ
         phrUtWd3HnyvcCkx/UlEqd2SccXrhSr0Mq8rhL8y8MYOyNUgtDLwuZr4E+mPEUimbuWu
         rzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mflB1soHoVBBXWMcJ8FoEowlzUk5Hn/TsWZzOjsw/w4=;
        b=DXexO74WJ4RjvV5IDnMvNU+oAUwUIS6mZfCzbeKIRW64Bj41r+FfrPyitZllCOHocg
         FKVCiLtFxmUCUBAe5/K/OsRJIWFSNM/0OnF5NklZ0wrk86oPiSu+jOICTXpimnXxwCbT
         K+nAzIeuXYoC3lmhsaioBFGjrjDK7XQwJ/nm8egHa3SVrb49ppVdJanmFyMg0rKfTX8a
         0fsXqJqepeamlUNK5HKZQEipDuCCdljol9c67xsxzsEq8rEPf6zQlwS/GOllo6kNmfOJ
         /MeOxXssBj7phKsmXY0BzBo3TjvALsJ2yOagK4e0TgnLLC9h2ct4zJKR7rMY+VVUf1Rk
         jmGg==
X-Gm-Message-State: AJcUuke6siP3eiCN8y+LjqJP+/6RxxJcTM+h7geiUhHRSNUDlDDk7FCR
        Qio7LbzLUq/bNy168W3SjSJ7vttry9xOE6uYkIA=
X-Google-Smtp-Source: ALg8bN7IXkeUf12JslbyX6qY9etajoITQh3jn31x4YDVi19GaKkkIW6qjDyg+ITlG0cUftZ9ii79axijWjNVmxS4Drs=
X-Received: by 2002:a19:a60c:: with SMTP id p12mr4953141lfe.63.1547081313494;
 Wed, 09 Jan 2019 16:48:33 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 10 Jan 2019 01:48:22 +0100
Message-ID: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
Subject: [BUG] moving fq back to clock monotonic breaks my setup
To:     edumazet@google.com
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just been trough ~5+ hours of bisecting and eventually actually found
the culprit =)

commit fb420d5d91c1274d5966917725e71f27ed092a85 (refs/bisect/bad)
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 28 10:28:44 2018 -0700

    tcp/fq: move back to CLOCK_MONOTONIC

[--8<--]

So this might be because my setup might be "odd".

Basically I have a firewall with four nics that uses two of those nics
to handle my normal
internet connection (firewall/MASQ/NAT) and the other two are assigned
to one bridge each.

The firewall is also my local caching DNS server and DHCP server,
which is also used by the VM:s...
But with 4.20 DHCP replies disappeared before entering the bridge - i
couldn't even see them in
tcpdump! (all nics are ixgbe on a atom soc)

I'm currently running a kernel with that patch reversed but I'm also
wondering about possible ways
forward since I'm reverting a fix from someone else...
