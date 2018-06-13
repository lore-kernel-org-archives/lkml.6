Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D499CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C9208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C9208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeFMSqF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935043AbeFMSqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:46:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF45E208CD;
        Wed, 13 Jun 2018 18:46:02 +0000 (UTC)
Date:   Wed, 13 Jun 2018 14:46:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180613144601.54855796@gandalf.local.home>
In-Reply-To: <1528763954-27731-5-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
        <1528763954-27731-5-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 10:39:14 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:


> +/* Make pointers available for printing early in the boot sequence. */
> +static int debug_boot_weak_hash __ro_after_init;
> +EXPORT_SYMBOL(debug_boot_weak_hash);
> +
> +static int __init debug_boot_weak_hash_enable(char *str)
> +{
> +	debug_boot_weak_hash = 1;
> +	pr_info("debug_boot_weak_hash enabled\n");
> +	return 0;
> +}
> +early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> +
>  static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
>  static siphash_key_t ptr_key __read_mostly;
>  
> @@ -1703,6 +1715,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
>  	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
>  	unsigned long hashval;
>  
> +	/* When debugging early boot use non-cryptographically secure hash */
> +	if (unlikely(debug_boot_weak_hash)) {

I was hoping to find a way to make the debug_boot_weak_hash into a
static_branch, but its setting is too early to have for a jump label.

I toyed with nesting this inside a static_branch too, but it seems too
much overkill.

Hence, I'll just punt and accept this patch as is ;-)

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +		hashval = hash_long((unsigned long)ptr, 32);
> +		return pointer_string(buf, end, (const void *)hashval, spec);
> +	}
> +
>  	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
>  		spec.field_width = 2 * sizeof(ptr);
>  		/* string length must be less than default_width */

