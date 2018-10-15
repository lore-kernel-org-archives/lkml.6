Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE2DC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7B62086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7B62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeJOHp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 03:45:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43244 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 03:45:58 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBqLm-0008Kf-C3; Mon, 15 Oct 2018 00:03:10 +0000
Date:   Mon, 15 Oct 2018 01:03:10 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
Message-ID: <20181015000310.GX32577@ZenIV.linux.org.uk>
References: <20181014132510.25943-1-christian@brauner.io>
 <20181014132510.25943-2-christian@brauner.io>
 <20181014171855.GW32577@ZenIV.linux.org.uk>
 <20181014185345.o6uokigiytqugg6v@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014185345.o6uokigiytqugg6v@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 08:53:46PM +0200, Christian Brauner wrote:

> > Yecchh...  First of all, the cast back to unsigned long long is completely
> > pointless.  What's more,
> 
> Sorry, seriously asking: why? This was meant to handle the case where
> sizeof(unsigned long long) != sizeof(unsigned long) and I just looked at
> _kstrtoul() which does the same:
> 
> int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
> {
> 	unsigned long long tmp;
> 	int rv;
> 
> 	rv = kstrtoull(s, base, &tmp);
> 	if (rv < 0)
> 		return rv;
> 	if (tmp != (unsigned long long)(unsigned long)tmp)
> 		return -ERANGE;
> 	*res = tmp;
> 	return 0;
> }
> 
> Sorry, if I'm being dense here.

C quiz:
	given that type of e1 is unsigned long long and type of e2 -
unsigned long, what conversions are going to happen in e1 == e2?

[relevant part of C standard: 6.5.9 (Equality operators),
6.3.1.8 (Usual arithmetic conversions)]
