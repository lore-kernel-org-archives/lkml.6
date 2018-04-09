Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbeDIQSl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:18:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753393AbeDIQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:18:25 -0400
Date: Mon, 9 Apr 2018 18:18:16 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Kees Cook <keescook@chromium.org>
cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on
 s390
In-Reply-To: <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi>  <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18040916-0044-0000-0000-000005452C4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040916-0045-0000-0000-00002885588B
Message-Id: <alpine.LFD.2.21.1804091809310.1698@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018, Kees Cook wrote:
> On Fri, Apr 6, 2018 at 2:47 AM, Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:
> > Today's kernel oopsed on s390. Bisect points to:
> > 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> >
> > [    1.898277] dasd-eckd 0.0.3304: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
> > [    1.898308] ------------[ cut here ]------------
> > [    1.898310] kernel BUG at block/bio.c:1798!
> 
> Well that's extremely bad. :(

What happened is that the bio build by the partition detection code was
attempted to be split by the block layer because the block queue had a
max_sector setting of 0. blk_queue_max_hw_sectors uses min_not_zero.

Both of the following return 0 on my machine:
+       pr_warn("%u\n", min_not_zero(100, 1000));
+       pr_warn("%u\n", min_not_zero(1000, 100));

So, we now know what failed...the question is why?

Sebastian
