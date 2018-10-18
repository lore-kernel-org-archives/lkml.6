Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D104E2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUZFRWZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D104E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJSE0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbeJSE0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:26:49 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3562145D;
        Thu, 18 Oct 2018 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894248;
        bh=LTwHb6qAp8DzV3RHvYbcFRsDFqxvFRxWfnzX10e382Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kUZFRWZ/yLBSs3H8uiy7DPjQqb2iKMV8LjAO7ODJDVVamqyTm2qhrUA4ww1suw90M
         6PJKRiM3NGXJ+n3GGgCE5rUmtHneTt/Xx2QJ8FABzNnR4rliJrKt8f74VyuovLiy0f
         LBnGOctFW0ZOo4QEB6qxOfraOgVC6Ar2H4gGq+Us=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alan Tull <atull@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <1467735814-23518-1-git-send-email-ricardo.ribalda@gmail.com>
 <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com>
 <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
Message-ID: <153989424794.53599.4926915592056818669@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 8/8] clk: fixed-rate: Convert into a module platform driver
Date:   Thu, 18 Oct 2018 13:24:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Tull (2018-10-18 12:20:58)
> On Tue, Jul 5, 2016 at 11:45 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> =

> I've stumbled across a of_node_get/put imbalance that happens when the
> fixed rate clock is added and deleted using device tree.  The cause is
> that this driver calls of_clk_add_provider() when probed, but doesn't
> call of_clk_del_provider() when removed.
> =

> It looks like a lot of clock drivers share that issue:
> =

> $ cd drivers/clk/
> $ git grep -l of_clk_add_provider * | xargs grep -L of_clk_del_provider |=
 wc -l
> 131
> =

> It should be a one line fix, but for many files.
> =

> I'm not a clock subsystem expert, so please let me know whether I'm
> missing something here.
> =


Patches welcome. Please include Fixes: tags for backports. Probably
drivers don't care because clk devices are almost never removed. That
isn't to say it shouldn't be fixed, but just giving some background on
why nobody has fixed it.

