Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E5C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE64E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE64E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeINCX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:23:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54384 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:23:56 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 360DF133FBF08;
        Thu, 13 Sep 2018 14:12:42 -0700 (PDT)
Date:   Thu, 13 Sep 2018 14:12:39 -0700 (PDT)
Message-Id: <20180913.141239.123063658850697631.davem@davemloft.net>
To:     fw@strlen.de
Cc:     linux@stwm.de, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
References: <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
        <20180913.102305.939671149040995911.davem@davemloft.net>
        <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 14:12:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Thu, 13 Sep 2018 23:03:25 +0200

> I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
> but can't figure out how to configure that away from the
> 'no hashing for prefixed policies' default or why we even have
> policy_inexact in first place :/
> 
> I'll look at this again tomorrow.

The inexact list exists to handle prefixed input keys.

At the time that I wrote all of the control plane hash table
stuff, configurations I could find consisted of:

1) Entires with non-prefixed keys, which are easy to hash.
   The number of entries could be large (e.g. cell phone
   network)

2) A very small number of prefixed policies.

So hashing, when possible, falling back to the linked list
for prefixed stuff.

Beforehand we only had the linked list :-)
