Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EADA219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EADA219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeHFHc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:32:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeHFHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:32:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w765OGsZ002140
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 01:25:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpanj0qwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:25:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 6 Aug 2018 06:25:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 06:24:57 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w765OuhY16187532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 05:24:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C6611C054;
        Mon,  6 Aug 2018 08:25:04 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D320311C04C;
        Mon,  6 Aug 2018 08:25:03 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.57.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 08:25:03 +0100 (BST)
Date:   Mon, 6 Aug 2018 07:24:54 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     heiko.carstens@de.ibm.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        tony.luck@intel.com, fenghua.yu@intel.com, msalter@redhat.com,
        jacquiot.aurelien@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Pirama Arumuga Nainar <pirama@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, sparclinux@vger.kernel.org
Subject: Re: Getting the instruction pointer on a per arch basis
In-Reply-To: <CAKwvOdnAzsF_vXH4UQiQd9HwjUju_sU9R4523zxqJSphuut-7Q@mail.gmail.com>
References: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
        <CAKwvOdn1Ri2VP9hNfKwQ3WMzL278e7-3DGusZc1cwQZbk9H6nw@mail.gmail.com>
        <20180801074051.11fa62b3@mschwideX1>
        <CAKwvOdnAzsF_vXH4UQiQd9HwjUju_sU9R4523zxqJSphuut-7Q@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18080605-0012-0000-0000-000002956BD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080605-0013-0000-0000-000020C770D6
Message-Id: <20180806072454.6efb5973@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 11:21:13 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Jul 31, 2018 at 10:41 PM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > On Tue, 31 Jul 2018 16:09:06 -0700
> > Nick Desaulniers <ndesaulniers@google.com> wrote:
> >  
> > > + More maintainers and lists for visibility
> > >
> > > On Tue, Jul 31, 2018 at 3:32 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:  
> > > >
> > > > I'm currently looking into cleaning up the code duplication between
> > > > current_text_addr() and _THIS_IP_, virtually every implementation of
> > > > current_text_addr() and _THIS_IP_ itself are basically:
> > > >
> > > > #define _THIS_IP_ ({ __label__ _l; _l: &&_l; })
> > > >
> > > > For a few arch's, they have inline assembly instead (for
> > > > current_text_addr()).  Examples:
> > > > * s390
> > > > * sh
> > > > * ia64
> > > > * x86 (um and 32b)
> > > > * c6x
> > > > * sparc
> > > >
> > > > I have a patch that cuts down on the duplication, but I don't
> > > > understand why the few arch specific implementations are necessary.  I
> > > > could reduce the duplication further if it's ok to just use the
> > > > statement expression.
> > > >
> > > > Does anyone know why this is the case?  
> >
> > For s390 it is just that we did not know about the label trick when we
> > introduced the define. The inline has an advantage though, the code
> > generated with the label trick is using a LARL instruction which is
> > 4 bytes, the inline assembly uses a BASR which is 2 bytes.
> >
> > If I use the label method in current_text_addr() the size of vmlinux
> > increases by a small amount:
> >
> > add/remove: 33/13 grow/shrink: 101/48 up/down: 11941/-8887 (3054)  
> 
> Thanks for the measurements.  Was this output produced by a utility?

Yes, ./scripts/bloat-o-meter

> > This is acceptable though, I would not mind if _THIS_IP_ and
> > current_text_addr use a common definition using labels.  
> 
> Thank you for this feedback Martin, I appreciate it.  Patches soon.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

