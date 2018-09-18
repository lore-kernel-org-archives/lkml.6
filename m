Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C0ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9721420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9721420C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeIRI3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:29:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:60411 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeIRI3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:29:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 885E2C009; Tue, 18 Sep 2018 04:58:52 +0200 (CEST)
Date:   Tue, 18 Sep 2018 04:58:37 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Miller <davem@davemloft.net>
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20180918025837.GA3548@nautica>
References: <20180918015723.GA26300@nautica>
 <20180917.194059.1970452340378032090.davem@davemloft.net>
 <20180918024536.GA2061@nautica>
 <20180917.195150.315319338322641005.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917.195150.315319338322641005.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote on Mon, Sep 17, 2018:
> > No, they can see it, so it's possible to make a KCM program that works
> > right now if you are careful (I'm not sure why the offset within bpf is
> > different from the offset in the kernel though, it looks like the bpf
> > program skips the qos part of the control buffer)
> 
> What helper is used in the BPF program to get this offset value?
> 
> (also good info to add to the commit message)

Dave defined one himself ; for a simple protocol where the offset is in
the first four bytes of the message.

The whole bpf program could look like this:

------
struct kcm_rx_msg { int full_len; int offset; };
static inline struct kcm_rx_msg *kcm_rx_msg(struct __sk_buff *skb) {
	return (struct kcm_rx_msg *)skb->cb;
}
int decode_framing(struct __sk_buff *skb) {
	return load_word(skb, kcm_rx_msg(skb)->offset);
}
------

If we go towards documenting it, adding a helper would be useful yes;
buf if we pull that becomes unnecessary.
(I'll add the example program in the commit message anyway at your
suggestion)

-- 
Dominique Martinet
