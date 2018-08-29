Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1414C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BC42083A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BC42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeH2NpT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:45:19 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:24323 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbeH2NpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:45:18 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-175-YWswC5VRM12jMnmKf5s2Jg-1; Wed, 29 Aug 2018 10:49:11 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 29 Aug 2018 10:50:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 Aug 2018 10:50:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/13] proc: convert /proc/self to _print_integer()
Thread-Topic: [PATCH 06/13] proc: convert /proc/self to _print_integer()
Thread-Index: AQHUPlw0h/REFtLLZEK6DODn8qrvQaTWfgDA
Date:   Wed, 29 Aug 2018 09:50:50 +0000
Message-ID: <54cb86c6d96b47bc8017a69be124c105@AcuMS.aculab.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-6-adobriyan@gmail.com>
In-Reply-To: <20180827231503.26899-6-adobriyan@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: YWswC5VRM12jMnmKf5s2Jg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan
> Sent: 28 August 2018 00:15
> ---
>  fs/proc/self.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/self.c b/fs/proc/self.c
> index 127265e5c55f..b2279412237b 100644
> --- a/fs/proc/self.c
> +++ b/fs/proc/self.c
> @@ -14,6 +14,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
>  {
>  	struct pid_namespace *ns = proc_pid_ns(inode);
>  	pid_t tgid = task_tgid_nr_ns(current, ns);
> +	char buf[10], *p = buf + sizeof(buf);
>  	char *name;
> 
>  	if (!tgid)
> @@ -22,7 +23,11 @@ static const char *proc_self_get_link(struct dentry *dentry,
>  	name = kmalloc(10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
>  	if (unlikely(!name))
>  		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
> -	sprintf(name, "%u", tgid);
> +

Best not to 'hide' the initialisation of 'p' at the top of the function.
Much easier to see what is going on if it is moved here.

> +	p = _print_integer_u32(p, tgid);

or just:
	p = _print_integer(buf + sizeof(buf), tgid);

(What a horrid interface ...)

> +	memcpy(name, p, buf + sizeof(buf) - p);
> +	name[buf + sizeof(buf) - p] = '\0';
> +
>  	set_delayed_call(done, kfree_link, name);
>  	return name;
>  }
> --
> 2.16.4

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

