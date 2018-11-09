Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4982F20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THCQRQEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4982F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeKJFVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:21:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47000 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeKJFVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:21:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so2546969ljh.13;
        Fri, 09 Nov 2018 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDh4rF2dTRAERIw52px7BPAemUfss8lSofGxMxErZ1Q=;
        b=THCQRQEppnoHn/r34EnJ50OpURE9PegZnI6hEsCyADzaYeOopR85qkspTY3I096c/H
         vUvN3PM8+2Sr64zs1jD7k508QYQb4iPwyXaZtKMCSACLZnvcKnCcB/RGTTxmK1DThe2v
         G82OHcz5d/cHY8a0TC1ArSF0LqQwujzsy8RS2c2XYjv5mJZCrkicQ+b37CQV0NFY2jqP
         LTYpOeGh/e8MzrzS7aQFtA4AJecgPDtFGrrGnBihlq95QyH6AQBmEoX0q2tkOZZTRPFF
         +sWh9ZeskcdypymircS7sWCxWmSF+mNI07WWlxmaEV2ElyoIs0XSHDB4TVxaPJxqFN3p
         eGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDh4rF2dTRAERIw52px7BPAemUfss8lSofGxMxErZ1Q=;
        b=dNsMUutr4jYtp3vnhnpCYGCqhYsH9TN1ganRpFXMpsdwTS/8pc3MD1fY9Z1qxj3ZYP
         odcuEqdNNX1n8NdLBc8CnnSDbVB1hjni3JL9a84L/EpElq2lNYwapK6mQUBrEIOGUOGM
         zYriAyXVX3QHIeYuonlYSrHLz1S8DIABd5kBTbpsk/H4F79U9PeqxOVzuv+ogLmsK5wQ
         YZP53vhJ+hsEOcHj7TLJUs4UgetvgWtZBZfc/+mdNr5s/vbq7w3N0ZbvVXsL42zdfSAj
         qyP6tuho3YU8QJmSx8Pkp4rpuP5TFUakie/Phb43DehripNoaaOe754QmzHreggM0kPk
         NBuA==
X-Gm-Message-State: AGRZ1gKzDHpmlCmr+exrAsQKke24Qh0CVxV9L8mYNkHqxoqKVCoG1pc0
        p0ZpOCSA8CW7wZwW0cPMbi0=
X-Google-Smtp-Source: AJdET5e0noEWdOuCQNq0fBiLBvi1NomtHtgQemWT9h5oud3rcq5Tk4PIoM3scU2UDttRO1cdcTRjUg==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr6882342ljj.161.1541792378239;
        Fri, 09 Nov 2018 11:39:38 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1541302ljf.96.2018.11.09.11.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 11:39:37 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C02C64608DB; Fri,  9 Nov 2018 22:39:36 +0300 (MSK)
Date:   Fri, 9 Nov 2018 22:39:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181109193936.GP13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
 <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
 <20181109114850.GL13195@uranus.lan>
 <1541764873.3286172.1571234624.727F6284@webmail.messagingengine.com>
 <20181109180407.GO13195@uranus.lan>
 <1541789329.305173.1571657968.7229F301@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541789329.305173.1571657968.7229F301@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 04:48:49PM -0200, Rafael David Tinoco wrote:
> 
> let me see if I got this right.. the premise for this test is to have *at least*
> 2 vmas, so we can check if the symlink for the mem range, describing the mapped
> area, is correct in procfs files, correct ? if yes, then why to have a totally
> duplicated test... just to check if mmap(0, ... MAP_FIXED ...) would work ?
> 
> Wouldn't exist a better place to have such test ? like in
> tools/testing/selftests/vm/mmap-null.c or something like it ?  genuine
> curiosity.. thinking i'm missing something about this test...

Ah, I happen to miss that they are identical except nil address. Then
true, vm/ looks like more suitable place for that. Do you happen to
know which exactly archs reserve first page (together with x86)?
