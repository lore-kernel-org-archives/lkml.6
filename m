Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A0CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840F208EC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SXjzkGpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2840F208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeF2NpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:45:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49522 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965409AbeF2NpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:45:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TDcgMA105643;
        Fri, 29 Jun 2018 13:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=IYnfXID1scputwOuPyQwoT7N16OKsKGAjw0dZIx9kKk=;
 b=SXjzkGplFiSMl2Deo9Q1oHPovy+vsI2ybWnFVg/S7TaKU9o15C8fepenZ69PW6aBQh8U
 +0HeSaOHgWiteM1ySKp+TFvZ1DReRKhIHrexsvQd1odAWaP9Npu/Z9CLptVgAvWltNl0
 atbTd9Qr3MTPnJEtPQLMg3+Ufus1LW1+cEkPYtEEvoAhZzXf2FW3vNUZ3k67k+GxlKgJ
 wTBHmEowWLvoh8BsFW1RR5yxyZdERpm7u/YMOmoPkbZxt0d4KiGC4f1564jQnN4Sp9JZ
 8p0F+l79Vvuon2hAicTN4qpZvPRZbP8eKk6EfwLEitKChMJSuZA2MuSKs4m1U6nohSS7 GA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jukmu6n9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 13:43:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TDhQqj013812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 13:43:26 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5TDhNvV004644;
        Fri, 29 Jun 2018 13:43:23 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 06:43:22 -0700
Date:   Fri, 29 Jun 2018 16:42:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Lawrence <paullawrence@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-sparse@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        smatch@vger.kernel.org
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-ID: <20180629134257.ci5ninozkh2ni6wd@mwanda>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
 <20180629112613.7i4xesjyxolc63gu@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629112613.7i4xesjyxolc63gu@ltop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=601
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:26:14PM +0200, Luc Van Oostenryck wrote:
> On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
> > 
> > Can sparse be hacked to identify pointer subtractions where the pointers
> > are cannot be statically proved to point into the same allocation?
> 
> sparse only see the (deatils of) the function it analyses and all
> visible declarations, nothing more.
> 
> It would be more a job for smatch which do global analysis.
> But to identify such subtractions yu must already have a (good)
> pointer alias analysis which I don't think smatch do (but I can
> be wrong, Dan & smatch's ml added in CC).

That would be hard to manage.  Maybe in a year from now...

Pointer math errors tend to get caught pretty quick because they're on
the success path so I don't imagine there are huge numbers of bugs.

regards,
dan carpenter

