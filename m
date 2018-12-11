Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F15EC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCB120811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLKSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:48:20 -0500
Received: from namei.org ([65.99.196.166]:58982 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeLKSsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:48:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBBIlw8s012640;
        Tue, 11 Dec 2018 18:47:58 GMT
Date:   Wed, 12 Dec 2018 05:47:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Nayna Jain <nayna@linux.ibm.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH v2 5/7] efi: Import certificates from UEFI Secure Boot
In-Reply-To: <20181208202705.18673-6-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120547110.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-6-nayna@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018, Nayna Jain wrote:

> +/*
> + * Blacklist an X509 TBS hash.
> + */
> +static __init void uefi_blacklist_x509_tbs(const char *source,
> +					   const void *data, size_t len)
> +{
> +	char *hash, *p;
> +
> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +	p = memcpy(hash, "tbs:", 4);
> +	p += 4;
> +	bin2hex(p, data, len);
> +	p += len * 2;
> +	*p = 0;
> +
> +	mark_hash_blacklisted(hash);
> +	kfree(hash);
> +}
> +
> +/*
> + * Blacklist the hash of an executable.
> + */
> +static __init void uefi_blacklist_binary(const char *source,
> +					 const void *data, size_t len)
> +{
> +	char *hash, *p;
> +
> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +	p = memcpy(hash, "bin:", 4);
> +	p += 4;
> +	bin2hex(p, data, len);
> +	p += len * 2;
> +	*p = 0;
> +
> +	mark_hash_blacklisted(hash);
> +	kfree(hash);
> +}
> 

These could be refactored into one function.


-- 
James Morris
<jmorris@namei.org>

