Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B48C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6290214DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5YeU5nqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6290214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLEBa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:30:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:30:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB51U6cU107783;
        Wed, 5 Dec 2018 01:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1xiN7I09VyO4c2+nC+ZscZSj1nC+2Out6RoPt9dywqU=;
 b=5YeU5nqFslsQPGJfj6k5pBtOPfIFFXRgMuXrRIgHM7twEESdlGg+mkrEbMg9vug0K1m6
 GyB7SjVZxkB97VFlad952TSpZAfP2TnGQRUloRpcNRVvsAsKLhEl3FM++Qvesyta5LaZ
 xFmijwFQrB5kUmrTZ3ej5Muq64PvGOnMg5IpAGQDN9XhCNWX3fJ+DBVesYlTq7s5200q
 nvp+9nn9M0Thcr7OSIyb8gZDOfJy0xRk/rR7juUeYbxYuQnqESYc6TgxFpAXoFEXnlEU
 XDUmILgafSNSkYfwkBlD9KJ7LYmY1kccqlfWtZpfBtxPJ/A0am7zU6bnzKNdlVM9c+Yl 7g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqtyrtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 01:30:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB51UCDO017511
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 01:30:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB51UA1M000354;
        Wed, 5 Dec 2018 01:30:10 GMT
Received: from [10.191.22.183] (/10.191.22.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 17:30:10 -0800
Subject: Re: Compiling with old gcc breaks when CONFIG_RETPOLINE is off
To:     Meelis Roos <mroos@linux.ee>, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, yamada.masahiro@socionext.com
References: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <3f72d5fa-cfed-e1a0-4f6c-90f8d1de1ace@oracle.com>
Date:   Wed, 5 Dec 2018 09:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meelis,

Could you try below change? It force syncconfig for  any 'make *config"

so that autoconf.h and auto.conf are always updated.

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 98e0c7a..802875b 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -38,7 +38,7 @@ enum input_mode {

  static int indent = 1;
  static int tty_stdio;
-static int sync_kconfig;
+static int sync_kconfig = 1;
  static int conf_cnt;
  static char line[PATH_MAX];
  static struct menu *rootEntry;
@@ -506,11 +506,11 @@ int main(int ac, char **av)
                          * Suppress distracting "configuration written 
to ..."
                          */
                         conf_set_message_callback(NULL);
-                       sync_kconfig = 1;
                         break;
                 case defconfig:
                 case savedefconfig:
                         defconfig_file = optarg;
+                       sync_kconfig = 0;
                         break;
                 case randconfig:
                 {
@@ -537,13 +537,15 @@ int main(int ac, char **av)
                         srand(seed);
                         break;
                 }
+               case listnewconfig:
+                       sync_kconfig = 0;
+                       /* fall through */
                 case oldaskconfig:
                 case oldconfig:
                 case allnoconfig:
                 case allyesconfig:
                 case allmodconfig:
                 case alldefconfig:
-               case listnewconfig:
                 case olddefconfig:
                         break;
                 case '?':

Thanks

Zhenzhong

On 2018/12/4 17:58, Meelis Roos wrote:
> Just tried 4.20-rc5 on an old K6-2 PC with gcc 5.3.1, got an error 
> about non-retpoline compiler,
> turned CONFIG_RETPOLINE off and retried.
>
> To my surprise, compilation still breaks with
> arch/x86/Makefile:224: *** You are building kernel with non-retpoline 
> compiler, please update your compiler..  Stop.
>
> As I read the Makefile, it should error only when CONFIG_RETPOLINE is 
> enabled, but it still breaks.
>
> $ grep -r CONFIG_RETPOLINE .config
> # CONFIG_RETPOLINE is not set
>
> $ grep -r CONFIG_RETPOLINE include/
> include/generated/autoconf.h:#define CONFIG_RETPOLINE 1
> include/config/auto.conf:CONFIG_RETPOLINE=y
>
> So the headers have not been updated yet, maybe?
>
