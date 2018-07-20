Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47231ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E334120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="M6hyYpbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E334120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeGTUwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:52:45 -0400
Received: from services.gouders.net ([141.101.32.176]:39509 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeGTUwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:52:45 -0400
Received: from localhost (ltea-047-066-036-141.pools.arcor-ip.net [47.66.36.141])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6KJvYpn012324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 21:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1532116655; bh=XnG6fMeuH0WpeglFBaQF2+1Yh+4SwSfFuO4ngDNlleQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=M6hyYpbkSVhqN9C4Ue41Mzwh7Ay82POXUSdR2PXOp5CON7ldIxXIdan3cn/dFradY
         HNIzBIqw7eoo3//toLCCbBkOHAbfYV+PueEiL8RkzcqK/VJGNhsBXRWN1tPQTOcOUd
         +I8u7HEaZWIrdOhWIxPW7pmpNqT5aIF+3ZygGCTc=
From:   Dirk Gouders <dirk@gouders.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level Kconfig
In-Reply-To: <20180719131149.GA12480@lst.de> (Christoph Hellwig's message of
        "Thu, 19 Jul 2018 15:11:49 +0200")
References: <20180708152004.21679-1-hch@lst.de>
        <20180708152004.21679-5-hch@lst.de>
        <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
        <17c45e87-d9be-8453-1bce-18753e0a68b9@infradead.org>
        <20180719131149.GA12480@lst.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Fri, 20 Jul 2018 21:57:36 +0200
Message-ID: <ghzhyl7k9b.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Jul 18, 2018 at 12:06:26AM -0700, Randy Dunlap wrote:
>> All $ARCH look equivalent except for microblaze and nios2.
>> For those, the config SWAP in init/Kconfig (line 221) comes before (and
>> hence takes precedence) over arch/$(SRCARCH)/Kconfig settings, which is
>> def_bool n for both microblaze and nios2.
>
> Both of those are NOMMU architectures, so the default SWAP
> decaration should do the right thing.
>
> I wish the kconfig tools could warn about duplicate symbols, as they
> are basically always bogus or at least very problematic.

Your wish is our command ;-)

A big but: duplicate symbol definitions are explicitely allowed by the
kconfig language, so you find most of those duplicates are actually just
varying dependencies or default values.  At least, it is interesting to
see how "duplicate" symbol definitions are used and perhaps this helps
you with your reordering.

This is just a prototype, that hopefully helps with your current task,
so I did not pay too much attention to make it beautiful.  Please let me
know if anything is missing.

Anyway, apply the patch and then invoke "make symcheckconfig" at the
top-level directory.

Dirk

> I've update the kconfig-cleanup branch in git with the fixes, but
> I didn't have time to do anything but a trivial x86 test yet.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=-=-=
Content-Disposition: inline; filename=symcheckconfig.patch
Content-Description: symcheckconfig target

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index a3ac2c91331c..52a0ee0637e9 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -222,3 +222,8 @@ $(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
 	$(call filechk,conf_cfg)
 
 clean-files += .*conf-cfg
+
+PHONY += symcheckconfig
+
+symcheckconfig: $(obj)/conf
+	$< $(silent) --$@ $(Kconfig)
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 671ff5364497..1083ddcdd05e 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -33,6 +33,7 @@ enum input_mode {
 	savedefconfig,
 	listnewconfig,
 	olddefconfig,
+	symcheckconfig,
 };
 static enum input_mode input_mode = oldaskconfig;
 
@@ -466,6 +467,7 @@ static struct option long_opts[] = {
 	 * value but not 'n') with the counter-intuitive name.
 	 */
 	{"oldnoconfig",     no_argument,       NULL, olddefconfig},
+	{"symcheckconfig",     no_argument,       NULL, symcheckconfig},
 	{NULL, 0, NULL, 0}
 };
 
@@ -490,6 +492,31 @@ static void conf_usage(const char *progname)
 	printf("  --randconfig            New config with random answer to all options\n");
 }
 
+static void find_sym_dups(void)
+{
+	struct symbol *sym;
+	struct property *prop;
+	int i;
+	int cnt = 0;
+	char *file;
+	int lineno;
+
+	for_all_symbols(i, sym) {
+		for_all_properties(sym, prop, P_SYMBOL) {
+			if (cnt == 1) {
+				printf("Duplicate symbol %s\n\t(%s:%d):\n", sym->name, file, lineno);
+			}
+			if (cnt)
+				printf("\t(%s:%d)\n", prop->file->name, prop->lineno);
+
+			cnt += 1;
+			file = (char *)prop->file->name;
+			lineno = prop->lineno;
+		}
+		cnt = 0;
+	}
+}
+
 int main(int ac, char **av)
 {
 	const char *progname = av[0];
@@ -560,6 +587,12 @@ int main(int ac, char **av)
 	}
 	name = av[optind];
 	conf_parse(name);
+
+	if (input_mode == symcheckconfig) {
+		find_sym_dups();
+		exit(0);
+	}
+
 	//zconfdump(stdout);
 	if (sync_kconfig) {
 		name = conf_get_configname();

--=-=-=--
