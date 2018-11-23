Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC6BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlFbyGf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAE220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeKXFKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:10:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKXFKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:10:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wANIJHSE099613;
        Fri, 23 Nov 2018 18:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PH5qArTPuHVr3qoxZ69X+loyht2mK7KKOcWlvJS6ZVc=;
 b=AlFbyGf6IX2edv0zsXXXgIbTxR6kxq2i9AOcTX9ZSqsr8oMtAYT4zuhUBiNZje+npqBO
 5NsO3tWImeaLj+a1D6LvBxVZ+cbPzfkyokNontmYbpHoywjeynQ7OHE8BvmcnDlb6omq
 JTxWL8G6vLaoWlZnbxk8FBo0wPN7/qJU+xAw/DzSHuLsM1L0Lb4iNahykPtay9kENeue
 A7N1NU7dy9gnrExjyonipO8IGeJOHvuobuf/i11dhZuzSQSYiEI9SZ00wHzwG7fR5mWv
 fJXz+MovXkjnYn/fPEA+Ed39HSLbMiMgBFeHJOnZZ8uKYCHIViejXQbv5IlG2Tj53ZR1 Cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ntaxqktwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 18:24:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wANIOPRk014122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 18:24:25 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wANIOO0P025342;
        Fri, 23 Nov 2018 18:24:24 GMT
MIME-Version: 1.0
Message-ID: <3f427959-a41f-4ff4-b095-ef8af11665c9@default>
Date:   Fri, 23 Nov 2018 10:24:21 -0800 (PST)
From:   Eric Saint Etienne <eric.saint.etienne@oracle.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: RE: [PATCH] perf symbols: Cannot disassemble some routines when
 debuginfo present
References: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
 <20181123160337.GA5575@krava>
In-Reply-To: <20181123160337.GA5575@krava>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 15.0.5085.0 (x64)]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9086 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811230153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +=09=09/*
> > +=09=09 * When using -ffunction-sections, only .text gets loaded by
> > +=09=09 * map_groups__find() into al->map. Consequently al->map address
> > +=09=09 * range encompass the whole code.
> > +=09=09 *
> > +=09=09 * But map__load() has just loaded many function maps by
> > +=09=09 * splitting al->map, which reduced al->map range drastically.
> > +=09=09 * Very likely the target address is now in one of those newly
> > +=09=09 * created function maps, so we need to lookup the map again
> > +=09=09 * to find that new map.
> > +=09=09 */
>=20
> hum, so map__load actualy can split the map to create new maps?
>=20
> cold you please point me to that code? I haven't touch this area for some
> time and I can't find it

The split happens in dso_process_kernel_symbol() in symbol-elf.c where we
call map_groups__find_by_name() to find an existing map, but with
-ffunction-sections and a symbol belonging to new (function) map, such map
doesn't exist yet so we end up creating one and adjusting existing maps
accordingly because adjust_kernel_syms is set. Makes sense?

As of 4.20-rc3 the call chain is as follows:
event:c:1573=09   map__load()
map.c:315=09   dso__load()
symobl.c:1528=09   dso__load_kernel_sym()
symbol.c:1896=09   dso__load_vmlinux_path()
=09=09   (or we directly call dso__load_vmlinux() at line 1892)
symbol.c:1744=09   dso__load_vmlinux()
symbol.c:1719=09   dso__load_sym()
symbol-elf.c:1090  dso_process_kernel_symbol()

-eric
