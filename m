Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FE1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086FC2198F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OZ9N2LG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086FC2198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeFURyN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:54:13 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36914 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeFURyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:54:12 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 453E75C019E;
        Thu, 21 Jun 2018 19:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529603651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50HStILxW46beYBu9MTv1byQnvUb3xFG5UYQIqyzMuI=;
        b=OZ9N2LG5FhGsPWCpc9VZuIxNTGA26jQOaOmlOAkRTHezfqsvvu5I94EwyEi6xn49NiBMt3
        5zmzILTCZ5ILklhDEQ1y7C9YlQHfXf5pWN/ND33VpfxLvAZihzlxQzxOB8EE2lp+hM+3Us
        B2TfUBOE2UTsn3pzoiP0czkzIEht8iI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jun 2018 19:54:10 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        abelvesa@linux.com, Abhishek Sagar <sagar.abhishek@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ARM: ftrace: Only set kernel memory back to read-only
 after boot
In-Reply-To: <20180621125025.25b70bb9@gandalf.local.home>
References: <20180621124710.453ee0ae@gandalf.local.home>
 <20180621125025.25b70bb9@gandalf.local.home>
Message-ID: <704c501ac97ff4ca0d469183b293e0b5@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.55 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.45)[97.51%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2018 18:50, Steven Rostedt wrote:
> On Thu, 21 Jun 2018 12:47:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
>> Dynamic ftrace requires modifying the code segments that are usually
>> set to read-only. To do this, a per arch function is called both before
>> and after the ftrace modifications are performed. The "before" function
>> will set kernel code text to read-write to allow for ftrace to make the
>> modifications, and the "after" function will set the kernel code text
>> back to "read-only" to keep the kernel code text protected.
>>
>> The issue happens when dynamic ftrace is tested at boot up. The test is
>> done before the kernel code text has been set to read-only. But the
>> "before" and "after" calls are still performed. The "after" call will
>> change the kernel code text to read-only prematurely, and other boot
>> code that expects this code to be read-write will fail.
>>
>> The solution is to add a variable that is set when the kernel code text
>> is expected to be converted to read-only, and make the ftrace "before"
>> and "after" calls do nothing if that variable is not yet set. This is
>> similar to the x86 solution from commit 162396309745 ("ftrace, x86:
>> make kernel text writable only for conversions").
>>
>> Reported-by: Stefan Agner <stefan@agner.ch>
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Link: http://lkml.kernel.org/r/20180620212906.24b7b66e@vmware.local.home
>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> ---
> 
> Perhaps I should have Cc'd stable too?
> 

As it is self tests only which are broken probably not super important.
But then, the fix is also rather clean and safe IMHO, so why not.

--
Stefan
