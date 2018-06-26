Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD029C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9FD26462
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9FD26462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965302AbeFZCiz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:38:55 -0400
Received: from sauhun.de ([88.99.104.3]:48946 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965281AbeFZCix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:38:53 -0400
Received: from localhost (unknown [91.73.131.157])
        by pokefinder.org (Postfix) with ESMTPSA id 948EC5751AA;
        Tue, 26 Jun 2018 04:38:51 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:38:49 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 4/7] i2c: fsi: Add abort and hardware reset procedures
Message-ID: <20180626023849.op4rimmsnlv4rgwg@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528918579-27602-5-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:16PM -0500, Eddie James wrote:
> Add abort procedure for failed transfers. Add engine and bus reset
> procedures to recover from as many faults as possible.

I think this is a way too aggressive recovery. Your are doing the 9
pulse toggles basically on any error while this is only when the device
keeps SDA low and you want to recover from that. If SDA is not stuck
low, sending a STOP should do. Or do you have a known case where this is
not going to work?

Also, you implement the pulse toggling manually. Can't you just populate
{get|set}_{scl|sda} and use the generic routine we have in the core?

