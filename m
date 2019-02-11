Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57432C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2204020821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="WWeelDSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBKJyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:54:52 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:34804 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1549878890; x=1581414890;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=SRGMiX4BisMsZwfW11LNhXADnyz/poW/UmEH4oEwa3w=;
  b=WWeelDSnY2HkW41EjQIu059OlYhfZzT5eP1VzjX+OQlwCRKtHcvIBNNH
   yTqoTaKeeAifJ0k2+qkGQKrW8EH80VsJdR4r9NYgXZQBySRBo1PPcX+I1
   GDTI35fqeYWxV7mUE4BEYSr+h4UPm6i52bZp4//rBfM66jP64eGfCVJeO
   E=;
X-IronPort-AV: E=Sophos;i="5.58,358,1544486400"; 
   d="scan'208";a="717209159"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2019 09:54:47 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x1B9sdEG077869
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Mon, 11 Feb 2019 09:54:41 GMT
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Julian Stecklina <js@alien8.de>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <jschoenh@amazon.de>
Subject: Re: [PATCH 1/2] x86/boot: fix KASL when memmap range manipulation is used
References: <1548866403-13390-1-git-send-email-js@alien8.de>
        <20190211090931.GA2501@localhost>
Date:   Mon, 11 Feb 2019 10:54:39 +0100
In-Reply-To: <20190211090931.GA2501@localhost> (Baoquan He's message of "Mon,
        11 Feb 2019 17:09:31 +0800")
Message-ID: <ciirm8zhr2ira8.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 01/30/19 at 05:40pm, Julian Stecklina wrote:
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 9ed9709..5657e34 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -155,6 +155,12 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
>>  	case '#':
>>  	case '$':
>>  	case '!':
>> +		/*
>> +		 * % would need some more complex parsing, because regions might
>> +		 * actually become usable for KASLR, but the simple way of
>> +		 * ignoring anything that is mentioned in % works for now.
>> +		 */
>
> This seems to make thing more complicated even though have to. One
> concern is whether we need to check the oldtype|newtype , e.g
> oldtype=reserverd, newtype=RAM, is it possible to set like that?

With the above patch the boot code will avoid using any region targeted
by % for KASLR. This does mean regions that are changed to be usable via
% are not taken into account.

Julian
