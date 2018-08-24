Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1476C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EC4208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvNSsY3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EC4208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeHYBXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:23:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeHYBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:23:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7OLd97l152884;
        Fri, 24 Aug 2018 21:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ORU+yIvUntIEDM52lIK3kWseF3WoFNqF9okZ3+clss0=;
 b=YvNSsY3mlDYk267wSZ2O6QM8y0w9E/E+ldnT5AHFAeYeFBKPjDq+kxbj8mXfaqvgNQrR
 9HzoVQcdC8DU5RIbv8WHcsVmzyH/ffWzLFhOI9CG8XO/U3UinKWiT5vb1VO51udZgvBk
 S/gui+iNjY2AwFdKAkcEbGnHk3mzRGmSQGd7qGwuQINOMzNSsnXeatmrqPvIrh59VhC2
 rDbzwcXqyNpCpZPc/gjg2sZAfsqZBVecvkK+X9Ezd4zzWY6zdL3NgtoAwSid+yuXB6AD
 Unfeey7vKzGKebw9bndIvejnzsMJ5pjAOBIZuEMmlDkjrLqH345OYC6PVY9H86+QArXk +w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3ra8wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 21:46:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7OLkK99029691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 21:46:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7OLkJXf012859;
        Fri, 24 Aug 2018 21:46:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 14:46:18 -0700
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto\@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert\@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen\@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
        <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com>
        <20180822062016.GA10356@infradead.org>
        <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
        <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
        <yq1a7pb9196.fsf@oracle.com>
        <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
Date:   Fri, 24 Aug 2018 17:46:15 -0400
In-Reply-To: <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
        (Ard Biesheuvel's message of "Fri, 24 Aug 2018 18:38:36 +0100")
Message-ID: <yq1tvnj780o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ard,

> I'd prefer to handle this without help from userland.
>
> It shouldn't be too difficult to register a module notifier that only
> sets a flag (or the static key, even?), and to free and re-allocate
> the crc_t10dif transform if the flag is set.

Something like this proof of concept?

diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 1ad33e555805..87d0e8f0794a 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -15,10 +15,50 @@
 #include <linux/init.h>
 #include <crypto/hash.h>
 #include <linux/static_key.h>
+#include <linux/notifier.h>
 
 static struct crypto_shash *crct10dif_tfm;
 static struct static_key crct10dif_fallback __read_mostly;
 
+static void crc_t10dif_print(void)
+{
+	if (static_key_false(&crct10dif_fallback))
+		pr_info("CRC T10 DIF calculated using library function\n");
+	else
+		pr_info("CRC T10 DIF calculated using crypto hash %s\n",
+			crypto_tfm_alg_driver_name(crypto_shash_tfm(crct10dif_tfm)));
+}
+
+static int crc_t10dif_rehash(struct notifier_block *self, unsigned long val, void *data)
+{
+#ifdef CONFIG_MODULES
+	struct module *mod = data;
+
+	if (val != MODULE_STATE_LIVE ||
+	    strncmp(mod->name, "crct10dif", strlen("crct10dif")))
+		return 0;
+
+	/* Fall back to library function while we replace the tfm */
+	static_key_slow_inc(&crct10dif_fallback);
+
+	crypto_free_shash(crct10dif_tfm);
+	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
+	if (IS_ERR(crct10dif_tfm)) {
+		crct10dif_tfm = NULL;
+		goto out;
+	}
+
+	static_key_slow_dec(&crct10dif_fallback);
+out:
+	crc_t10dif_print();
+	return 0;
+#endif /* CONFIG_MODULES */
+}
+
+static struct notifier_block crc_t10dif_nb = {
+	.notifier_call = crc_t10dif_rehash,
+};
+
 __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 {
 	struct {
@@ -49,16 +90,21 @@ EXPORT_SYMBOL(crc_t10dif);
 
 static int __init crc_t10dif_mod_init(void)
 {
+	register_module_notifier(&crc_t10dif_nb);
+
 	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
 	if (IS_ERR(crct10dif_tfm)) {
 		static_key_slow_inc(&crct10dif_fallback);
 		crct10dif_tfm = NULL;
 	}
+
+	crc_t10dif_print();
 	return 0;
 }
 
 static void __exit crc_t10dif_mod_fini(void)
 {
+	unregister_module_notifier(&crc_t10dif_nb);
 	crypto_free_shash(crct10dif_tfm);
 }
 
