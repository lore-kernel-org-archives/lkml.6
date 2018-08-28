Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB9F2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeH1UvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:51:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeH1UvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CABAE4000783;
        Tue, 28 Aug 2018 16:58:30 +0000 (UTC)
Received: from treble (ovpn-124-230.rdu2.redhat.com [10.10.124.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8967710DCF48;
        Tue, 28 Aug 2018 16:58:30 +0000 (UTC)
Date:   Tue, 28 Aug 2018 11:58:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: Support multiple rodata sections.
Message-ID: <20180828165829.woylt7lgoj3qz5up@treble>
References: <20180803184040.15372-1-allan.x.xavier@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803184040.15372-1-allan.x.xavier@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 16:58:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 16:58:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:40:40PM +0100, Allan Xavier wrote:
> +static void mark_rodata(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	bool found = false;
> +	static const char *str1 = ".str1.";
> +	const int str1len = strlen(str1) + 1;
> +

A comment here would help, explaining that this looks for both .rodata
and .rodata.func_name sections (when using -fdata-sections).

> +	for_each_sec(file, sec) {
> +		if (strstr(sec->name, ".rodata") == sec->name) {
> +			char *str1pos = sec->name + strlen(sec->name) - str1len;
> +
> +			/* Skips over .rodata.str1.1 and .rodata.str.1.8 */
> +			if (strstr(sec->name, str1) != str1pos) {
> +				sec->rodata = true;
> +				found = true;
> +			}
> +		}
> +	}


This could be simplified and made more readable with something like:

	for_each_sec(file, sec) {
		if (!strncmp(sec->name, ".rodata", 7) &&
		    !strstr(sec->name, ".str1.") {
		    	sec->rodata = true;
			found = true;
		}
	}

-- 
Josh
