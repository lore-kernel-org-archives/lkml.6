Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4630DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E790A2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E790A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeH2AmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:42:03 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:47691 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727162AbeH2AmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:42:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7EC0618225657;
        Tue, 28 Aug 2018 20:48:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grain87_2e4ba5c233342
X-Filterd-Recvd-Size: 3673
Received: from XPS-9350 (unknown [172.56.41.215])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 20:48:37 +0000 (UTC)
Message-ID: <556a35cbccc36ef4f5a03a82e6f938d283046919.camel@perches.com>
Subject: Re: [PATCH 01/13] seq_file: rewrite seq_puts() in terms of
 seq_write()
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 13:48:35 -0700
In-Reply-To: <9229927125ab9d36bd38cf0c20fb5dfb45802fcb.camel@perches.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
         <9229927125ab9d36bd38cf0c20fb5dfb45802fcb.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 11:24 -0700, Joe Perches wrote:
> On Tue, 2018-08-28 at 02:14 +0300, Alexey Dobriyan wrote:
> > Space savings -- 42 bytes!
> > 
> > 	seq_puts	71      29     [-42]
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >  fs/seq_file.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index 1dea7a8a5255..0c282a88a896 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -653,14 +653,7 @@ EXPORT_SYMBOL(seq_putc);
> >  
> >  void seq_puts(struct seq_file *m, const char *s)
> >  {
> > -	int len = strlen(s);
> > -
> > -	if (m->count + len >= m->size) {
> > -		seq_set_overflow(m);
> > -		return;
> > -	}
> > -	memcpy(m->buf + m->count, s, len);
> > -	m->count += len;
> > +	seq_write(m, s, strlen(s));
> >  }
> >  EXPORT_SYMBOL(seq_puts);
> >  
> 
> If execution speed is really an issue, as
> almost all of the uses are for const strings,
> why not use a #define and avoid the runtime
> cost of strlen where possible.

fyi: an x86-64 defconfig increases < .5 kb and
presumably is faster for most all seq_puts uses

$ size vmlinux.new vmlinux.old
   text	   data	    bss	    dec	    hex	
filename
17342316	4982128	 999628	23324072	163e5a8	
vmlinux.new
17341857	4982128	 999628	23323613	163e3dd	
vmlinux.old

with
---
 fs/seq_file.c            | 13 -------------
 include/linux/seq_file.h |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8a5255..97d474b6788e 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -651,19 +651,6 @@ void seq_putc(struct seq_file *m, char c)
 }
 EXPORT_SYMBOL(seq_putc);
 
-void seq_puts(struct seq_file *m, const char *s)
-{
-	int len = strlen(s);
-
-	if (m->count + len >= m->size) {
-		seq_set_overflow(m);
-		return;
-	}
-	memcpy(m->buf + m->count, s, len);
-	m->count += len;
-}
-EXPORT_SYMBOL(seq_puts);
-
 /**
  * A helper routine for putting decimal numbers without rich format of printf().
  * only 'unsigned long long' is supported.
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index a121982af0f5..722028805df6 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -117,7 +117,7 @@ void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
 void seq_putc(struct seq_file *m, char c);
-void seq_puts(struct seq_file *m, const char *s);
+#define seq_puts(m, s) seq_write(m, s, strlen(s))
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
 			       unsigned long long num, unsigned int width);
 void seq_put_decimal_ull(struct seq_file *m, const char *delimiter,
