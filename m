Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA992177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="R+TMSDQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfBRUPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:15:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45786 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBRUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:15:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so8973850pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9S1roozBhtfxLjQTxCHEWpyGhKQcR4X2KUsQI8j8/m0=;
        b=R+TMSDQdV+ptFc7vR5wBpE/1xq5P5xv51RgJRwljNj/v0xtoFJRO15wtZRtiCAG/YK
         vVwPdLOBfdmsZTVn80TpnVu31zqm4lkTL51p3pHozFL0CLhtWh8ygtjP6xdwJLIq2GLR
         Y62RNqyB+f2EmYlbjHLle6v9+qLgrO4ONvROqWzAMB0iufXqWKFUENO8WyLJN6qj2iJ2
         zxIS3ZvUE947r0rPSu9B/LF1PHi73+oAVJ7UZT3pV2s9VNyRpF4lDBxBDE2HTpu4RVlo
         WOwQ+YZV8rBc0G6zAYJKRARmuqPgDt3OE3frZl3LbxwDecrdBrHBVTSAsA+T7vY5gMT6
         Ty4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9S1roozBhtfxLjQTxCHEWpyGhKQcR4X2KUsQI8j8/m0=;
        b=YZyQmwtyQE6R5nvhX2eBx8kbISiHBXox0NneoWkjgi1r8MWp7nGrQv65B7LjTNN+CH
         ZVRb4HQfc6+2ghGytrZm9uOS70gOj720efNJsozOJ0IH0aDsnPFNl+1vBjtHMTTsrdyy
         smTGxUmhdKzNdrOec0EIlCrb8YZlG6EhHjMUzI0FBkOH+MnyH7rAX9bN5Wxb7wezsOaq
         Rxq5od+/LJt1c6BG1z0JQPBqTkT6gpfmoyqNlItsJzcQaOx88Vyy6GTpHRa0AfmPp14q
         8eqNW6OSHC7XWVgXngw3JqOUTbaXnmrT3VhtU+yTMULHTnpZwm1E3jQgzrRDhT1Xs/MS
         kqYg==
X-Gm-Message-State: AHQUAuaH5gADoiKyLkve2IOLxSwkTjG0jpjgukUthmyrU7LEo+ixe99U
        yPkTWbZ/kPfMgdJKvhDxpcpEHA==
X-Google-Smtp-Source: AHgI3IYMCYhL4Mocr+eAcJBzS9mQ40XSoHUX2Um+n58K4gililX8sehR9XYLIzUFdryAX+ABgAoCNg==
X-Received: by 2002:a63:aa46:: with SMTP id x6mr20614981pgo.452.1550520922764;
        Mon, 18 Feb 2019 12:15:22 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:1b7a::3])
        by smtp.gmail.com with ESMTPSA id d131sm23062273pfd.108.2019.02.18.12.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:15:22 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:15:17 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 04/21] ethtool: helper functions for
 netlink interface
Message-ID: <20190218121517.4d299f6e@cakuba.netronome.com>
In-Reply-To: <266b4ea3596de134329f8bbd5d13e282d1d27442.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <266b4ea3596de134329f8bbd5d13e282d1d27442.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:21:44 +0100 (CET), Michal Kubecek wrote:
> +/* create skb for a reply and fill device identification
> + * payload: payload length (without netlink and genetlink header)
> + * dev:     device the reply is about (may be null)
> + * cmd:     ETHNL_CMD_* command for reply
> + * info:    info for the received packet we respond to
> + * ehdrp:   place to store payload pointer returned by genlmsg_new()
> + * returns: skb or null on error
> + */

nit: why not correct kdoc?

> +struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
> +				 u16 dev_attrtype, struct genl_info *info,
> +				 void **ehdrp)
> +{
> +	void *ehdr;
> +	struct sk_buff *rskb;

nit: reverse xmas tree
