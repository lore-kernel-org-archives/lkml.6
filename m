Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEE3ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1821471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZOKrFsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC1821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeIRTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:39:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39739 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeIRTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:39:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so1065065plp.6;
        Tue, 18 Sep 2018 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EqGTw5VlQC4sXFlC4ADXCrpnP4pKxK9Sbd5coQ2ibQk=;
        b=nZOKrFsB+Na1aszcollO8h6XodKw5aWc4MpaHT9odxdDDtiFC+FO/aKwmZGp487Oi9
         FMGf5xvRedS/yfjxPHMT7sgsCPaPrYt51Z3sDMyO8hZ2EyKZlD6ayBeKyGmEWtigXj6s
         2ku//+/0eteU246b7ZjgFhyA0mlkda+Bz+WDwf6WDYGVdDuEyqzF6AMm2Iqn4sidIhVF
         pSGDOIpvgzyodZ5mzdbpgGj6YW/V/CgYJNApSmq/1IvC2Pn6womaTGgQnAmfHtrI2KTX
         UiIOa297bLIGASWobaITuFlD6NEpsxVXXbuKTh0elZe7dZ6m9O/NGG5quRav5zfUx/zS
         Y06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EqGTw5VlQC4sXFlC4ADXCrpnP4pKxK9Sbd5coQ2ibQk=;
        b=k7nsnbJk3rusxla75zkp9UqOvNvkvAZjFQ9TC1j5t/8h29vIF0iRc2QAbSqHnOlwcc
         NNmllbyayG5eZbcCBK9E2bZDYO68ubfzM1aV5ffgABa1SwXnycfiPKqeIkxneexo/PiR
         fLwmzJ/Xyfy9uWtQKLYEbdAbTnMQWynVNWf++qLnotVjHJAVMhvp9HwAAvndzwC3fOhG
         UK1pJfkSlhCHpeiq35Pb1JEbboQrKpeG3cexKZ1Ir1BTg88dihtt+8jv/MKxMyBKMcBh
         gbWLVKY/ZGUzwPfnJmtBP6TspdnPT3nFH/Q+jyY6B3BtQFiYC8+LWwg/UUwMr8SyrOC0
         Xeig==
X-Gm-Message-State: APzg51Dqi1FlG0dnpxpvqh8gwt8TCtIGsu8zhX+N9xGqEe7oxh/bwuhU
        BSgiYxOM5E0tA0MF3IG50Aw6fmoN
X-Google-Smtp-Source: ANB0VdaZ027lOL9WTULP6P9UCTaG3H2UHkHTISjQd1VynI7rjRB+4k/DHliBjCE0bsZM48NKNKsc4w==
X-Received: by 2002:a17:902:b189:: with SMTP id s9-v6mr29654195plr.188.1537279620748;
        Tue, 18 Sep 2018 07:07:00 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u43-v6sm26573239pgn.81.2018.09.18.07.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 07:06:59 -0700 (PDT)
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
 <20180911235403.GA10107@roeck-us.net> <20180918090722.GA463@jagdpanzerIV>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <80eb1ec0-7b61-debe-9e93-0176d3e2c76a@roeck-us.net>
Date:   Tue, 18 Sep 2018 07:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918090722.GA463@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 02:07 AM, Sergey Senozhatsky wrote:
> Hi,
> 
> On (09/11/18 16:54), Guenter Roeck wrote:
>> On Wed, Sep 12, 2018 at 12:17:35AM +0100, David Howells wrote:
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> [    8.507672] RIP: 0010:reconfigure_super+0x47/0x210
>>>
>>> Can you tell me the file and line this corresponds to?
>>>
>> I don't know, but some debugging shows that fc->ops == NULL.
> 
> This NULL derefs linux-next.
> 
> Emergency (sysrq remount/reboot):
> 
> emergency_remount()
>   do_emergency_remount()
>    do_emergency_remount_callback()
>     reconfigure_super()
> 
> At fc->ops dereference:
> 
>   981         if (fc->ops->reconfigure) {
> 		^^^^^^^^^
>   982                 retval = fc->ops->reconfigure(fc);
>   983                 if (retval == 0) {
>   984                         security_sb_reconfigure(fc);
> 
> 
> So the check either better be
> 
> 	if (fc->ops && fc->ops->reconfigure)
> 

Since there are multiple instances of fs_context where fc->ops isn't set,
this check would be needed wherever fc->ops is dereferenced.

Guenter

> Or, we need to set ->ops properly. But I'm not sure if invoking
> ->init_fs_context() from emergency-reboot path is going to work
> well all the time.
> 
> ---
> 
>   fs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index efb0567c8389..e2e03c47c817 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1017,6 +1017,7 @@ int reconfigure_super(struct fs_context *fc)
>   static void do_emergency_remount_callback(struct super_block *sb)
>   {
>   	struct fs_context fc = {
> +		.ops		= &legacy_fs_context_ops,
>   		.purpose	= FS_CONTEXT_FOR_EMERGENCY_RO,
>   		.fs_type	= sb->s_type,
>   		.root		= sb->s_root,
> 
> ---
> 
> 	-ss
> 

