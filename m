Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929DA2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929DA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeH1WRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:17:31 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:34081 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbeH1WRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:17:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CABAC181D341D;
        Tue, 28 Aug 2018 18:24:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rub94_626d1bed7d363
X-Filterd-Recvd-Size: 1722
Received: from XPS-9350 (unknown [172.56.41.215])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 18:24:36 +0000 (UTC)
Message-ID: <9229927125ab9d36bd38cf0c20fb5dfb45802fcb.camel@perches.com>
Subject: Re: [PATCH 01/13] seq_file: rewrite seq_puts() in terms of
 seq_write()
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 11:24:34 -0700
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 02:14 +0300, Alexey Dobriyan wrote:
> Space savings -- 42 bytes!
> 
> 	seq_puts	71      29     [-42]
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  fs/seq_file.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 1dea7a8a5255..0c282a88a896 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -653,14 +653,7 @@ EXPORT_SYMBOL(seq_putc);
>  
>  void seq_puts(struct seq_file *m, const char *s)
>  {
> -	int len = strlen(s);
> -
> -	if (m->count + len >= m->size) {
> -		seq_set_overflow(m);
> -		return;
> -	}
> -	memcpy(m->buf + m->count, s, len);
> -	m->count += len;
> +	seq_write(m, s, strlen(s));
>  }
>  EXPORT_SYMBOL(seq_puts);
>  

If execution speed is really an issue, as
almost all of the uses are for const strings,
why not use a #define and avoid the runtime
cost of strlen where possible.

